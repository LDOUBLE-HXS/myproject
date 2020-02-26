$(function(){
	var customerId;
	var discount;
	var mydate = new Date();
	var checkRangeStart=null;//预定开始时间
	var checkRangeEnd=null;//预定离开时间
	var checkRangeStartDate=null;//Date格式化开始时间
	var checkRangeEndDate=null;////Date格式化离开时间
	var arr=new Array();//数组
	//初始化入住时间为今日，离开时间为明日
	var month,date;
	if((mydate.getMonth()+1)<10){
		month="0"+(mydate.getMonth()+1);
	}else{
		month=(mydate.getMonth()+1);
	}
	if(mydate.getDate()<10){
		date="0"+mydate.getDate();
	}else{
		date=mydate.getDate();
	}
	//当前时间
	checkRangeStart=mydate.getFullYear() + "-";
	checkRangeStart += month + "-";
	checkRangeStart += date;
	var today = new Date().getTime();
	var thatDay = new Date( today + (24*60*60*1000) ).toLocaleString().substr(0,9);
	//明天
	if(thatDay.substr(5,1)<10){
		month="0"+thatDay.substr(5,1);
	}else{
		month=thatDay.substr(5,1);
	}
	if(thatDay.substr(7,2)<10){
		date="0"+thatDay.substr(7,2);
	}else{
		date=thatDay.substr(7,2);
	}
	checkRangeEnd=thatDay.substr(0,4) + "-";
	checkRangeEnd += month + "-";
	checkRangeEnd += date;
	checkRangeStartDate=new Date(checkRangeStart);
	checkRangeEndDate=new Date(checkRangeEnd);
	var dayNum = Math.abs(parseInt((checkRangeEndDate-checkRangeStartDate)/1000/3600/24));
	//入住离店时间(默认显示今明两天)
	layui.use('laydate', function(){
		var laydate = layui.laydate;
		var checkRangeTime=laydate.render({
			elem:'#checkRangeTime', //指定元素
			min:0,//预定时间今日开始
			theme: 'grid',//格子主题
			range: '~',
			value:checkRangeStart+' ~ '+checkRangeEnd,
			done: function(value, date, endDate){
				//可以用字符或字符串分割
				arr=value.split('~');
				for(var i=0;i<arr.length;i++)
				{
					checkRangeStart=arr[0];
					checkRangeEnd =arr[1];
				}
				checkRangeStartDate=new Date(checkRangeStart);
				checkRangeEndDate=new Date(checkRangeEnd);
				dayNum = Math.abs(parseInt((checkRangeEndDate-checkRangeStartDate)/1000/3600/24));
			}
		});
	});
	layui.use('layer', function(){
		var layer = layui.layer;
		//选择房型自动刷新房间
		$("#roomType").change(function(){
			//如果房型为请选择
			if($(this).val()=="0"){
				$("#room option[value='0']").attr("selected","selected");
			}
			//每次更改值得时候先将上一次得房型房号集合删除
			$("#room").children("option:not(:first-child)").remove();
			//获取roomTypeId
			var roomTypeId=$(this).val();
			//选择房间
			$.ajax({
				type:"POST",
				url:path+"/room/selRoomByRoomTypeIdAjax",
				data:{roomTypeId:roomTypeId},
				dataType:"json",
				success:function(data){
					if(data!=null){
						for(var i=0;i<data.length;i++){
							$("#room").append("<option value='"+data[i].id+"'>"+data[i].roomFloor+":"+data[i].roomCode+"</option>");
		                }
					}
				}
			});
		});
		//判断会员是否存在
		$("#userCode").on('blur',function(){
			if($("#userCode").val()!=null||$("#userCode").val()!=""){
				$.ajax({
					type:"GET",//请求类型
					url:path+"/user/userCodeExist",//请求的url
					data:{userCode:$("#userCode").val()},//请求参数
					dataType:"json",//ajax接口（请求url）返回的数据类型
					success:function(data){//data：返回数据（json对象）
						if(data.userCode == "true"){
							validateTip($("#userCode").next(),{"color":"green"},"",true);
							$.ajax({
								type:"POST",//请求类型
								url:path+"/user/selCustomerByUserCodeAjax",//请求的url
								data:{userCode:$("#userCode").val()},//请求参数
								dataType:"json",//ajax接口（请求url）返回的数据类型
								success:function(customer){//data：返回数据（json对象）
									customerId=customer.id;
									if(customer.member.discount.toFixed(2)!="1.00"){
										discount=customer.member.discount
									}
								}
							});
						}else if(data.userCode == "false"){
							validateTip($("#userCode").next(),{"color":"red"},imgNo+ " 该账号不存在",false);
						}
					}
				});
			}
		});
		$(".addCheckIn").on('click',function(){
			if($("#userCode").val()==null||$("#userCode").val()==""){
				layer.msg('账号不能为空！',{
		            offset: '200px',
		            time: 1000,
		            shade: [0.3, '#393D49'],
		            icon:7
				});
			}else if($("#userCode").attr("validateStatus") != "true"){
				layer.msg('账号格式不正确！',{
		            offset: '200px',
		            icon:2,
		            shade: [0.3, '#393D49'],
		            time: 1000
				});
			}else if($("#roomType option:selected").val()==0){
				layer.msg('请选择房间类型！',{
		            offset: '200px',
		            icon:7,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else if($("#room option:selected").val()==0){
				layer.msg('请选择房间号！',{
		            offset: '200px',
		            icon:7,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else{
				var price=(discount*dayNum*$("#roomType option:selected").attr("typePrice")).toFixed(2);
				layer.msg('请用户支付'+price+'元！',{
		            offset: '200px',
		            icon:7,
		            time: 100000000,
		            shade: [0.3, '#393D49'],
		            btn:['已支付','取消办理'],
		            yes:function(){
		            	//先添加入订单表
						$.ajax({
							type:"POST",//请求类型
							url:path+"/order/addOrderByManager",//请求的url
							data:{customerId:customerId,roomTypeId:$("#roomType option:selected").val(),checkInTime:$.trim(checkRangeStart)+" 14:00:00",checkOutTime:$.trim(checkRangeEnd)+" 12:00:00",orderState:"1",settlement:price,orderDesc:"",orderRoomNum:"1"},//请求参数
							dataType:"json",//ajax接口（请求url）返回的数据类型
							success:function(addOrder){//data：返回数据（json对象）
								if(addOrder.result=="true"){
									$.ajax({
										type:"POST",
										url:path+"/order/selOrder_ByCheckRangeTimeAjax",
										data:{checkInTime:$.trim(checkRangeStart)+" 14:00:00",checkOutTime:$.trim(checkRangeEnd)+" 12:00:00"},
										dataType:"json",
										success:function(selOrder){
											//如果有两条订单，选择最新的订单，也就是管理员添加的订单
											//添加入住表
											$.ajax({
												type:"POST",
												url:path+"/manager/editOrderAjax",
												data:{orderId:selOrder[selOrder.length-1].id,roomId:$("#room option:selected").val()},
												dataType:"json",
												success:function(data){
													if(data.result=="true"){
														layer.msg('入住成功！请到房间管理中查看',{
															offset: '200px',
															time: 3000,
															icon:1,
															shade: [0.3, '#393D49']
														});
														//延时事件
														setTimeout(function(){
															layer.closeAll();
															window.location.reload();//刷新
														},2000);
													}else if(data.result=="false"){
														layer.msg('入住失败！请重新入住',{
											            offset: '200px',
											            time: 3000,
											            icon:2,
											            shade: [0.3, '#393D49']
														});
													}
												}
											});
										}
									});
								}else{
									layer.msg('新加订单错误！',{
							            offset: '200px',
							            icon:2,
							            time: 1000,
							            shade: [0.3, '#393D49']
									});
								}
							}
						});
		            },
		            btn2:function(){
		            	layer.msg('已取消办理！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
		            	//延时事件
						setTimeout(function(){
							 window.location.reload();//刷新
							},500);
		            }
				});
			}
		});
	});
});
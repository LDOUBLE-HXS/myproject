$(function(){
	//5分钟定时器
	window.setInterval(
		function() {
			//5分钟刷新一次重新查询一次 处理一次房间状态
			layer.msg('页面即将刷新,是否刷新？',{
				btn: ['现在刷新','待会刷新'],
				offset: '100px',// 离上100px水平居中
				icon:7,
				time:100000000,
	            shade: [0.3, '#393D49'],
	            yes:function(){
	            	window.location.reload();//刷新
	            }
			});
		}
	,300000);
	$("#roomImg").hide();//隐藏房型图片
	var now=Date.parse(new Date()); //现在的时间戳
	layui.use('layer', function(){
		var layer = layui.layer;
		$(".roomCodeDiv").each(function(index, element){//对已入住的房间渲染
			var li=$(this);
			//房间id
			var roomId=li.attr("roomId");
			//查询已入住的房间
			$.ajax({
				type:"GET",
				url:path+"/room/selRoomByIdAjax",
				data:{roomId:roomId},
				dataType:"json",
				success:function(data){
					for(var i=0;i<data.length;i++){
						//入住离店时间小于现在的时间则更改状态为离店（入住时间到期）
						if(Date.parse(new Date(data[i].order.checkOutTime))<now){
							$.ajax({
								type:"GET",
								url:path+"/room/modifyCheckStateByIdAjax",
								data:{checkId:data[i].id,checkState:"2"},
								dataType:"json",
								success:function(data){
									if(data.result=="true"){
										li.css({"background-color":"#679997"});//对离店的顾客渲染方块背景
										li.removeAttr("orderId");//删除离店的方块房间的订单编号
									}
								}
							});
						}
						//对对应方块渲染入住颜色
						if(data[i].room.roomCode==li.children(".roomCode").html()){
							li.css({"background-color":"#DF9B35"});//对入住的顾客渲染方块背景
							li.attr("orderId",data[i].orderId);//给入住的方块房间注入订单编号
						}
	                }
				}
			});
			li.on('click',function(){//查看入住详情状态
				if(li.attr("orderId")!=null){
					layer.open({
						content:$("#selOrderDiv"), //内容
						area:'320px',
						resize:false,// 不允许拉伸
						btn: '关闭',
						btnAlign: 'c',
						anim: 1,// 显示风格
						title: ['入住详情', 'font-size:18px;'],// 标题
						type: 1, 
						offset: '10px',// 离上100px水平居中
						success: function(layero, index){
							$.ajax({
								type:"GET",
								url:path+"/order/selOrderAjax",
								data:{orderId:li.attr("orderId")},
								dataType:"json",
								success:function(result){
									layero.children(".layui-layer-content").children().children().children().children("#orderId").html(result.id);
									layero.children(".layui-layer-content").children().children().children().next().children("#roomImg").attr("src",result.roomtype.roomImg);
									layero.children(".layui-layer-content").children().children().children().next().children("#roomTypeName").html(result.roomtype.roomTypeName);
									layero.children(".layui-layer-content").children().children().children().next().next().children("#orderRoomNum").html(result.orderRoomNum+" 间");
									layero.children(".layui-layer-content").children().children().children().next().next().next().children("#memberLevel").html(result.customer.member.memberType);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().children("#userName").html(result.customer.userName);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().children("#userPhone").html(result.customer.userPhone);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().children("#orderTime").html(result.orderTime);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().children("#checkInTime").html(result.checkInTime);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().next().children("#checkOutTime").html(result.checkOutTime);
									layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().next().next().children("#totalPrice").html(result.settlement.toFixed(2));
								}
							});
						}
					});
				}
			});
		});
		//图片显示隐藏
		$("#roomA").on('mouseover',function(){
			$("#roomImg").fadeIn(500);
		}).on('mouseout',function(){
			$("#roomImg").fadeOut(500);
		});
		//添加房间
		$(".addRoom").on('click',function(){
			layer.open({
				content:$("#roomOpenDiv"), //内容
				area:'320px',
				resize:false,// 不允许拉伸
				btn: '添加',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['添加房间、', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					//房间号
					layero.children(".layui-layer-content").
					children().children().
					children().children("#roomCode").html("");
					//房间楼层
					layero.children(".layui-layer-content").
					children().children().
					children().children("#roomFloor").html("");
					//房间状态
					layero.children(".layui-layer-content").
					children().children().
					children().children("#roomState").children("option[value='0']").attr("selected","selected");
					//房间类型
					layero.children(".layui-layer-content").
					children().children().
					children().children("#roomType").children("option[value='0']").attr("selected","selected");
				},
				yes:function(){
					$.ajax({
						type:"GET",
						url:path+"/room/selRoomCodeAjax",
						data:{roomCode:$("#roomCode").val()},
						dataType:"json",
						success:function(data){
							if(data.result=="true"){
								layer.msg('房间号已存在！',{
						            offset: '200px',
						            time: 1000,
						            shade: [0.3, '#393D49'],
						            icon:7
								});
								$("#roomCode").val("");
							}
						}
					});
					if($("#roomCode").val()==null||$("#roomCode").val()==""){
						layer.msg('请输入房间号！',{
				            offset: '200px',
				            time: 1000,
				            shade: [0.3, '#393D49'],
				            icon:7
						});
					}else if($("#roomFloor").val()==null||$("#roomFloor").val()==""){
						layer.msg('请输入房间楼层！',{
				            offset: '200px',
				            time: 1000,
				            shade: [0.3, '#393D49'],
				            icon:7
						});
					}else if($("#roomState option:selected").val()==0){
						layer.msg('请选择房间状态！',{
				            offset: '200px',
				            time: 1000,
				            shade: [0.3, '#393D49'],
				            icon:7
						});
					}else if($("#roomType option:selected").val()==0){
						layer.msg('请选择房间类型！',{
				            offset: '200px',
				            time: 1000,
				            shade: [0.3, '#393D49'],
				            icon:7
						});
					}else{
						$.ajax({
							type:"POST",
							url:path+"/room/addRoomAjax",
							data:{roomCode:$("#roomCode").val(),roomFloor:$("#roomFloor").val(),roomState:$("#roomState option:selected").val(),roomTypeId:$("#roomType option:selected").val()},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('添加成功！',{
							            offset: '100px',
							            icon:1,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
									//延时事件
									setTimeout(function(){
										 window.location.reload();//刷新
										},1000);
								}else if(data.result=="false"){
									layer.msg('添加失败！',{
							            offset: '100px',
							            icon:2,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
								}
							}
						});
					}
				}
			});
		});
		//对房间进行不同的操作
		$(".roomCodeDiv").on('click',function(){
			var id=$(this).attr("roomId");
			var roomCode=$(this).attr("roomCode");
			if($(this).attr("orderId")==null){
				layer.msg('对'+roomCode+'房间进行下面哪种操作？',{
					btn: ['修改该房间信息','删除该房间','取消'],
					offset: '100px',// 离上100px水平居中
					icon:7,
					time:100000000,
		            shade: [0.3, '#393D49'],
					yes:function(index, layero){
						//修改页面
						layer.open({
							content:$("#roomOpenDiv"), //内容
							area:'320px',
							resize:false,// 不允许拉伸
							btn: '修改',
							btnAlign: 'c',
							anim: 1,// 显示风格
							title: ['修改房间信息', 'font-size:18px;'],// 标题
							type: 1, 
							offset: '100px',// 离上100px水平居中
							success: function(layero, index){
								$.ajax({
									type:"GET",
									url:path+"/room/selRoomAjax",
									data:{roomId:id},
									dataType:"json",
									success:function(result){
										//房间号
										layero.children(".layui-layer-content").
										children().children().
										children().children("#roomCode").val(result.roomCode);
										//房间楼层
										layero.children(".layui-layer-content").
										children().children().
										children().children("#roomFloor").val(result.roomFloor);
										//房间状态
										layero.children(".layui-layer-content").
										children().children().
										children().children("#roomState").children("option[value='"+result.roomState+"']").attr("selected","selected");
										//房间类型
										layero.children(".layui-layer-content").
										children().children().
										children().children("#roomType").children("option[value='"+result.roomTypeId+"']").attr("selected","selected");
									}
								});
							},yes:function(){
								$.ajax({
									type:"POST",
									url:path+"/room/modifyRoomAjax",
									data:{roomId:id,roomCode:$("#roomCode").val(),roomFloor:$("#roomFloor").val(),roomState:$("#roomState option:selected").val(),roomTypeId:$("#roomType option:selected").val()},
									dataType:"json",
									success:function(data){
										if(data.result=="true"){
											layer.msg('修改成功！',{
									            offset: '100px',
									            icon:1,
									            time: 2000,
									            shade: [0.3, '#393D49']
											});
											//延时事件
											setTimeout(function(){
												 window.location.reload();//刷新
												},1000);
										}else if(data.result=="false"){
											layer.msg('修改成功！',{
									            offset: '100px',
									            icon:1,
									            time: 2000,
									            shade: [0.3, '#393D49']
											});
										}
									}
								});
							},
							cancel:function(){
								 window.location.reload();//刷新
							}
						});
					},
					btn2:function(index, layero){
						$.ajax({
							type:"GET",
							url:path+"/room/delRoomAjax",
							data:{roomId:id},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('删除成功！',{
							            offset: '100px',
							            icon:1,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
									//延时事件
									setTimeout(function(){
										 window.location.reload();//刷新
										},1000);
								}else if(data.result=="false"){
									layer.msg('删除失败！',{
							            offset: '100px',
							            icon:2,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
								}
							}
						});
						return false;
					}
				});
			}
		});
	});
});
$(function(){
	var mydate = new Date();
	var checkRangeStart=null;//预定开始时间
	var checkRangeEnd=null;//预定离开时间
	var checkRangeStartDate=null;//Date格式化开始时间
	var checkRangeEndDate=null;////Date格式化离开时间
	var arr=new Array();//数组
	var dayNum=0;//预定计算天数
	var discount=$("#discount").val();
	var roomTypeId=0;//房间类型id
	var typePrice =0;//房间单价
	var roomDescribe=null;//房间详情
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
	//日期
	layui.use('laydate', function(){
		  var laydate = layui.laydate;
		  //入住时间
		  var startTime=laydate.render({
			  elem:'#checkInTime', //指定元素
			  min:0,//入住时间在今天开始
			  theme: 'grid',//格子主题
			  value:checkRangeStart,
			  done: function(value, date, endDate){
					leaveTime.config.min={
							year:date.year,
			    	    	month:date.month-1,//关键
			                date:date.date+1
					};
					var before=new Date($("#checkInTime").val()).getTime();
					var after=new Date($("#checkOutTime").val()).getTime();
					if(before>after){//入住时间不能大于离开时间
						layui.use('layer', function(){
							var layer = layui.layer;
							layer.msg('入住时间不能大于离开时间',{
					            offset: '200px',
					            time: 1000,
					            icon:7,
					            shade: [0.3, '#393D49']
							});
						});
						$("#checkOutTime").val("");
					}
			  }
		  });
		  //离开时间
		 var leaveTime= laydate.render({
			  value:checkRangeEnd,
			  elem:'#checkOutTime', //指定元素
			  theme: 'grid',//格子主题
			  min:1,
			  done: function(value, date, endDate){
				  startTime.config.max={
							year:date.year,
			    	    	month:date.month-1,//关键
			                date:date.date-1
				  };
			  }
		  });	 
	});
	// 查看个人信息
	$("#selInformation").click(function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			$.ajax({
				type:"GET",
				url:path+"/user/selMyInformation",
				data:{},
				dataType:"json",
				success:function(result){
					layer.open({
						area:'360px',
						resize:false,// 不允许拉伸
						btn: '关闭',
						btnAlign: 'c',
						anim: 1,// 显示风格
						title: ['个人信息', 'font-size:18px;'],// 标题
						type: 1, 
						offset: '100px',// 离上100px水平居中
			  	  		content:'<div id="selInformationOpen"><ul><li><label>用户名:</label>'+result.userCode+
			  	  				'</li><li><label>真实姓名:</label>'+result.userName+
			  	  				'</li><li><label>手机号码:</label>'+result.userPhone+
			  	  				'</li><li><label>身份证:</label>'+result.userCard+
			  	  				'</li><li><label>会员等级:</label>'+result.member.memberType+
			  	  				'</li><li><label>会员积分:</label>'+result.integral+
			  	  				'</li><li><label>注册时间:</label>'+result.creationDate+'</li></ul></div>', 
					});
				}
			});
		});
	});
	// 修改个人信息
	$("#modifyInformation").click(function(){
		$.ajax({
			type:"GET",
			url:path+"/user/selMyInformation",
			data:{},
			dataType:"json",
			success:function(result){
				layui.use('layer', function(){
					var layer = layui.layer;
					layer.open({
						content:'<table style="margin:20px 40px;" >'+
									'<tr>'+
										'<td style="padding: 10px">登录名:</td>'+
										'<td style="padding: 10px"><input readonly="readonly" id="userCode" name="userCode" type="text" value="'+result.userCode+'"></td>'+
									'</tr>'+
										'<td style="padding: 10px">手机号码:</td>'+
										'<td style="padding: 10px"><input id="userPhone" name="userPhone" type="text" value="'+result.userPhone+'"></td>'+				
									'</tr>'+
								'</table>', //内容
						btn: ['保存','取消']
					  ,yes: function(){
						  var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
						  if($("#userPhone").val().match(patrn)){
							  $.ajax({
									type:"POST",//请求类型
									url:path+"/user/modifyInformation",//请求的url
									data:{userCode:$("#userCode").val(),userPhone:$("#userPhone").val()},//请求参数
									dataType:"json",//ajax接口（请求url）返回的数据类型
									success:function(data){//data：返回数据（json对象）
										if(data.result == "true"){
											layer.msg('修改成功',{
									            offset: '200px',
									            time: 1000,
									            icon:1,
									            shade: [0.3, '#393D49']
											});
											//延时事件
											 setTimeout(function(){
													layer.closeAll();
													location.reload();//页面重新加载
												},1000);
										}else if(data.result == "false"){
											layer.msg('修改失败',{
									            offset: '200px',
									            time: 2000,
									            icon:2,
									            shade: [0.3, '#393D49']
											});
										}
									}
								});
						  }else{
							  layer.msg('请输入正确的手机格式!',{
								  offset:'200px',
								  time:2000,
								  icon:7,
								  shade: [0.3, '#393D49']
							  });
						  }
					  },
						area: '420px',// 宽
						resize:false,// 不允许拉伸
						anim: 1,// 弹出风格
						title: ['修改个人信息', 'font-size:18px;'],// 标题
						type: 1, 
						offset: '100px',// 离上100px水平居中
					});
				});
			}
		});
	});
	//修改密码
	$("#modifyPassword").click(function(){
		//初始化
		$("#oldUserPassword").val("");
		$("#userPassword").val("");
		$("#userPasswordAgain").val("");
		validateTip($("#oldUserPassword").next(),{"color":"red"},"",false);
		validateTip($("#userPassword").next(),{"color":"red"},"",false);
		validateTip($("#userPasswordAgain").next(),{"color":"red"},"",false);
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:$("#modifyPasswordDiv"), //内容
				btn: ['保存','取消']
			  	,yes: function(){
			  		$.ajax({
						type:"POST",//请求类型
						url:path+"/user/modifyPassword",//请求的url
						data:{userPassword:$("#userPassword").val()},//请求参数
						dataType:"json",//ajax接口（请求url）返回的数据类型
						success:function(data){//data：返回数据（json对象）
							if(data.result == "true"){
								layer.msg('修改成功,请重新登陆',{
						            offset: '200px',
						            time: 2000,
						            icon:1,
						            shade: [0.3, '#393D49']
								});
								//延迟事件
								setTimeout(function(){
									layer.closeAll();
									window.location.href =path+"/user/login";
								},2000);
							}else if(data.result == "false"){
								layer.msg('修改失败',{
						            offset: '200px',
						            time: 2000,
						            icon:2,
						            shade: [0.3, '#393D49']
								});
							}
						}
					});
			  },
				area: '550px',// 宽
				resize:false,// 不允许拉伸
				anim: 1,// 弹出风格
				title: ['修改密码', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
			});
		});
		$("#oldUserPassword").on("focus",function(){
			validateTip($("#oldUserPassword").next(),{"color":"#666666"},"* 请输入原密码",false);
		}).on("blur",function(){
			if($("#oldUserPassword").val() != null && $("#oldUserPassword").val() != ""){
				if($("#oldUserPassword").val().length==6&&$("#oldUserPassword").val().length<=18){
					$.ajax({
						type:"GET",//请求类型
						url:path+"/user/oldPasswordAjax",//请求的url
						data:{oldUserPassword:$("#oldUserPassword").val()},//请求参数
						dataType:"json",//ajax接口（请求url）返回的数据类型
						success:function(data){//data：返回数据（json对象）
							if(data.oldUserPassword == "true"){
								validateTip($("#oldUserPassword").next(),{"color":"green"},imgYes+ "",true);
							}else if(data.oldUserPassword == "false"){
								validateTip($("#oldUserPassword").next(),{"color":"red"},imgNo+" 原密码错误",false);
							}
						},
						error:function(data){//当访问时候，404，500 等非200的错误状态码
							validateTip($("#oldUserPassword").next(),{"color":"red"},imgNo+" 您访问的页面不存在",false);
						}
					});
				}else{
					validateTip($("#oldUserPassword").next(),{"color":"red"},imgNo+" 原密码应在6-18位",false);
				}
			}else{
				validateTip($("#oldUserPassword").next(),{"color":"red"},imgNo+" 原密码为空",false);
			}
		});
		/*密码校验*/
		$("#userPassword").on("focus",function(){
			validateTip($("#userPassword").next(),{"color":"#666666"},"* 请输入6-18位密码",false);
		}).on("blur",function(){
			if($("#userPassword").val() != null && $("#userPassword").val() != ""){
				if($("#userPassword").val().length>=6&&$("#userPassword").val().length<=18){
					if($("#userPassword").val()==$("#oldUserPassword").val()){
						validateTip($("#userPassword").next(),{"color":"red"},imgNo+" 不可与原密码相同",false);
					}else{
						validateTip($("#userPassword").next(),{"color":"green"},imgYes+"",true);
					}
				}else{
					validateTip($("#userPassword").next(),{"color":"red"},imgNo+" 密码应在6-18位",false);
				}
			}else{
				validateTip($("#userPassword").next(),{"color":"red"},imgNo+" 密码为空",false);
			}
		});
		/*重复密码校验*/
		$("#userPasswordAgain").on("focus",function(){
			validateTip($("#userPasswordAgain").next(),{"color":"#666666"},"* 请再次输入相同密码",false);
		}).on("blur",function(){
			if($("#userPasswordAgain").val() != null && $("#userPasswordAgain").val() != ""){
				if($("#userPassword").val()==$("#userPasswordAgain").val()){
					validateTip($("#userPasswordAgain").next(),{"color":"green"},imgYes+"",true);
				}else{
					validateTip($("#userPasswordAgain").next(),{"color":"red"},imgNo+" 密码输入不一致",false);
				}
			}else{
				validateTip($("#userPasswordAgain").next(),{"color":"red"},imgNo+" 确认密码为空",false);
			}
		});
	});
	//房间类型预定时间
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
				$("#totalPrice").html(($("#roomUnitPrice").html()*dayNum*$("#inp").val()*discount).toFixed(1));
			}
		});
	});
	//详细选择房间选择时间预定
	$("#checkRoom").click(function(){
		$("#inp").val(1);//房间数默认为1
		$("#roomDesc textarea").val("");
		checkRangeTime.value=$('#checkInTime').val()+" ~ "+$('#checkOutTime').val();//预定时间范围
		layui.use('layer', function(){
			var layer = layui.layer;
			if($('#selectRoom option:selected').attr('id')==null){
				layer.msg('请选择房间',{
		            offset: '200px',
		            time: 1000,
		            icon:7,
		            shade: [0.3, '#393D49']
				});
			}else if($('#checkInTime').val()==""){
				layer.msg('请选择入住时间',{
		            offset: '200px',
		            time: 1000,
		            icon:7,
		            shade: [0.3, '#393D49']
				});
			}else if($('#checkOutTime').val()==""){
				layer.msg('请选择离开时间',{
		            offset: '200px',
		            time: 1000,
		            icon:7,
		            shade: [0.3, '#393D49']
				});
			}else{
				roomTypeId=$('#selectRoom option:selected').attr('id');
				layer.open({
					content:$("#roomDetail"), //内容
					area:'850px',
					resize:false,// 不允许拉伸
					anim: 1,// 弹出风格
					title: ['房间类型', 'font-size:18px;'],// 标题
					type: 1, 
					offset: '100px',// 离上100px水平居中
					success: function(layero, index){
						$.ajax({
							type:"GET",//请求类型
							url:path+"/room/selRoomTypeById",//请求的url
							data:{roomTypeId:roomTypeId},//请求参数
							dataType:"json",//ajax接口（请求url）返回的数据类型
							success:function(data){//data：返回数据（json对象）
								if(data!=null){
									arr=$("#checkRangeTime").val().split('~');
									for(var i=0;i<arr.length;i++)
									{
										checkRangeStart=arr[0];
										checkRangeEnd =arr[1];
									}
									checkRangeStartDate=new Date(checkRangeStart);
									checkRangeEndDate=new Date(checkRangeEnd);
									dayNum = Math.abs(parseInt((checkRangeEndDate-checkRangeStartDate)/1000/3600/24));
									typePrice=data.typePrice;
									roomDescribe=data.describe;
									layero.children(".layui-layer-content").children("#roomDetail").children("#roomTypeImg").attr("src",data.roomImg);
									layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomTypeNameH3").html(data.roomTypeName);
									layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomUnitPrice").html(data.typePrice.toFixed(1));
									layero.children(".layui-layer-content").children("#roomDetail").children("#roomPrice").children().children("#totalPrice").html((dayNum*data.typePrice*$("#inp").val()*discount).toFixed(1));
								}
							}
						});
						//房间数量
						$.ajax({
							type:"GET",//请求类型
							url:path+"/room/selRoomCountByType",//请求的url
							data:{roomTypeId:roomTypeId},//请求参数
							dataType:"json",//ajax接口（请求url）返回的数据类型
							success:function(data){//data：返回数据（json对象）
								$.ajax({
									type:"GET",//请求类型
									url:path+"/order/selUntreatedOrderRoomNumAjax",//请求的url
									data:{roomTypeId:roomTypeId},//请求参数
									dataType:"json",//ajax接口（请求url）返回的数据类型
									success:function(result){
										if(result!=null){
											var num=0;//订单中该房型数量
											for(var i=0;i<result.length;i++){
												num=result[i]+num;//多个订单累加
											}
											//实际还有的房间数量为：未住的房间-订单中已付款的房间
											layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomSurplus").html(data-num);
										}else{
											layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomSurplus").html(data-2);
										}
									}
								});
								
							}
						});
					  }
				});
			}
		});
	});
	//预定房间
	$('.roomClick').on('click',function(){
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
		$("#inp").val(1);//房间数默认为1
		$("#roomDesc textarea").val("");//清空描述
		checkRangeTime.value=checkRangeStart+" ~ "+checkRangeEnd;
		roomTypeId=$(this).attr("id");
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:$("#roomDetail"), //内容
				area:'850px',
				resize:false,// 不允许拉伸
				anim: 1,// 弹出风格
				title: ['房间类型', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",//请求类型
						url:path+"/room/selRoomTypeById",//请求的url
						data:{roomTypeId:roomTypeId},//请求参数
						dataType:"json",//ajax接口（请求url）返回的数据类型
						success:function(data){//data：返回数据（json对象）
							if(data!=null){
								arr=$("#checkRangeTime").val().split('~');
								for(var i=0;i<arr.length;i++)
								{
									checkRangeStart=arr[0];
									checkRangeEnd =arr[1];
								}
								checkRangeStartDate=new Date(checkRangeStart);
								checkRangeEndDate=new Date(checkRangeEnd);
								dayNum = Math.abs(parseInt((checkRangeEndDate-checkRangeStartDate)/1000/3600/24));
								typePrice=data.typePrice;
								roomDescribe=data.describe;
								layero.children(".layui-layer-content").children("#roomDetail").children("#roomTypeImg").attr("src",data.roomImg);
								layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomTypeNameH3").html(data.roomTypeName);
								layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomUnitPrice").html(data.typePrice.toFixed(1));
								layero.children(".layui-layer-content").children("#roomDetail").children("#roomPrice").children().children("#totalPrice").html((dayNum*data.typePrice*$("#inp").val()*discount).toFixed(1));
							}
						}
					});
					//房间数量
					$.ajax({
						type:"GET",//请求类型
						url:path+"/room/selRoomCountByType",//请求的url
						data:{roomTypeId:roomTypeId},//请求参数
						dataType:"json",//ajax接口（请求url）返回的数据类型
						success:function(data){//data：返回数据（json对象）
							$.ajax({
								type:"GET",//请求类型
								url:path+"/order/selUntreatedOrderRoomNumAjax",//请求的url
								data:{roomTypeId:roomTypeId},//请求参数
								dataType:"json",//ajax接口（请求url）返回的数据类型
								success:function(result){
									if(result!=null){
										var num=0;//订单中该房型数量
										for(var i=0;i<result.length;i++){
											num=result[i]+num;//多个订单累加
										}
										//实际还有的房间数量为：未住的房间-订单中已付款的房间
										layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomSurplus").html(data-num);
									}else{
										layero.children(".layui-layer-content").children("#roomDetail").children("#roomType").children("#roomSurplus").html(data);
									}
								}
							});
							
						}
					});
				  }
			});
		});
	});
	//费用明细
	$("#priceDec").mouseover(function (){
		if(discount==1.0){
			layer.msg('房间单价:'+typePrice+' RMB<br>住房天数:'+dayNum+' 天<br>房间数量:'+$("#inp").val()+' 间<br>无折扣<br>总金额=单价*天数*房间数',{
	        	offset: '250px',
	        	area: '350px',
	        	time: 1000000000,
	        });  
		}else{
			layer.msg('房间单价:'+typePrice+' RMB<br>住房天数:'+dayNum+' 天<br>房间数量:'+$("#inp").val()+' 间<br>折扣:'+discount+'<br>总金额=单价*天数*房间数*折扣',{
	        	offset: '250px',
	        	area: '350px',
	        	time: 1000000000,
	        });
		}
    }).mouseout(function (){ 
    	layer.close(layer.index);
    });
	//房间详情,预定详情
	$("#roomDesc_a").mouseover(function (){ 
        layer.msg(roomDescribe,{
        	offset: '170px',
        	area: '550px',
        	time: 1000000000,
        });  
    }).mouseout(function (){
    	layer.close(layer.index);
    });  
	$("#roomRule").mouseover(function (){ 
        layer.msg('预定保留时间：下午15:00点（周一至周四）下午18:00点（周五至周日）<br>入住时间：下午14:00点 离店时间：中午12:00点',{
        	offset: '170px',
        	area: '550px',
        	time: 1000000000,
        });  
    }).mouseout(function (){ 
    	layer.close(layer.index);
    });  
	//房间数量
		function getRandom(n){
	        return Math.floor(Math.random()*n+1)
	    }
		var inputp={
			indexInput:0,
			addNew:function(obj,stepNum){
				this.initNew(obj,stepNum);
				this.indexInput++;
			},
			getDigit:function(val,num){
				var digitNum=0;
				if(num.toString().split(".")[1]){
					digitNum=num.toString().split(".")[1].length;
				}
				 
				if(digitNum>0){
			 		val=val.toFixed(digitNum);
				}
				return val;
				
			},
			initNew:function(obj,stepNum){
				var width=obj.width();
				var height=obj.height();
				var height1=height;
				var _root = this;
			 	width+=3;
				//height+=0; 
				obj.css("border-style","none");
				obj.css("border-width","0px");
				obj.css("width",width-height1*2-7);
				obj.css("text-align","center");
				obj.css("outline","none");
				obj.css("vertical-align","middle");
				obj.css("line-height",height+"px");
				obj.wrap("<div id='"+obj.attr('id')+"T' style='overflow:hidden;width:"+width+"px;height:"+height+"px;border: 1px solid #CCC;'></div>");
				obj.before("<div id='"+obj.attr('id')+"l'  onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:"+height1+"px;height:"+height1+"px;line-height:"+height1+"px;border-right-width: 1px;border-right-style: solid;border-right-color: #CCC;float:left'>-</div>");
				obj.after("<div id='"+obj.attr('id')+"r'  onselectstart='return false;' style='-moz-user-select:none;cursor:pointer;text-align:center;width:"+height1+"px;height:"+height1+"px;line-height:"+height1+"px;border-left-width: 1px;border-left-style: solid;border-left-color: #CCC;float:right'>+</div>");
				$("#"+obj.attr('id')+"l").click(function(){
					_root.leftDo(obj,stepNum);
				});
				$("#"+obj.attr('id')+"r").click(function(){
					_root.rightDos(obj,stepNum);
				});
			},
			leftDo:function(obj,stepNum){//减房
				var val=this.formatNum(obj.val());
				val=Math.abs(val);
				val-=stepNum;
				val=this.getDigit(val,stepNum);
				if(val<0){
					val=0;
					obj.val(0);
				}else{
					this.moveDo(obj,val,true,stepNum);
				};
				$("#totalPrice").html(($("#roomUnitPrice").html()*dayNum*val*discount).toFixed(1));
			},
			rightDos:function(obj,stepNum){//加房
				var val=this.formatNum(obj.val());
				val=Math.abs(val);
				val+=stepNum;
				if(val>$("#roomSurplus").html()){
					val=$("#roomSurplus").html();
					obj.val($("#roomSurplus").html());
				}
				val=this.getDigit(val,stepNum);
				this.moveDo(obj,val,false,stepNum);
				//房间数更改后
				$("#totalPrice").html(($("#roomUnitPrice").html()*dayNum*val*discount).toFixed(1));
			},
			moveDo:function(obj,num,isup,stepNum){
				var startTop=0;
				var endTop=0;
				if(stepNum>=1){
					if(num.toString().split(".")[1]){
						 num=num.toString().split(".")[0];
						 obj.val(num);
					}
				}
				var num1=num;
				var lens1=num.toString().length;
				var divwidth=parseFloat(obj.css("font-size"))/2;
			 	if(isup){
					obj.val(num1);
					var isDecimal=false;
				 	for(i=lens1-1;i>=0;i--){
						var s=num.toString();
						var s1=s.substr(i,1);
						var s1num=parseFloat(s1);
						if(s1num!=9||isNaN(s1num)){
							if(isNaN(s1num)){
								//num=parseFloat(s.substr(i-1,lens1-i));
//								num++;
//								num=this.getDigit(num,stepNum);
							}else{
								num=parseFloat(s.substr(i,lens1-i));
								num++;
								break;
							}
							
						}
					}
					//num=this.getDigit(num,stepNum)
					startTop=0;
					endTop=-40;
				}else{
					var isDecimal=false;
				 	for(i=lens1-1;i>=0;i--){
						var s=num.toString();
						var s1=s.substr(i,1);
						var s1num=parseFloat(s1);
					 	if(s1num!=0||isNaN(s1num)){
							
							if(isNaN(s1num)){
								//num=parseFloat(s.substr(i-1,lens1-i));
//								num=this.getDigit(num,stepNum);
								isDecimal=true;
							}else{
								num=parseFloat(s.substr(i,lens1-i));
								break;
							}
						}
					}
					if(isDecimal){
						num=this.getDigit(num,stepNum);
					}
					startTop=40;
					endTop=0;
				}
				if($("#"+obj.attr('id')+"Num").length <1){
					//background-color:#fff;
					var numstr=num.toString();
					var widths=divwidth*numstr.length;
					var stri="<div id='"+obj.attr('id')+"sy' style='position:relative;width:0px;height:0px'><div id='"+obj.attr('id')+"Num' style='width:"+widths+"px;z-index:100;position:absolute;height:"+obj.height()+"px;top:"+startTop+"px; line-height:"+obj.height()+"px;font-family: "+obj.css("font-family")+";font-size:"+obj.css("font-size")+";'>";
					for(i=0;i<numstr.length;i++){
						var nums=numstr.substr(i,1);
						if(nums=="."){
							stri+="<div style='float:left;width:"+divwidth+"px;'>&nbsp;";
						}else{
							stri+="<div style='float:left;width:"+divwidth+"px;background-color:#fff'>";
							stri+=nums;
						}
						stri+="</div>";
					}
					stri+="</div></div>";
					 
					$("#"+obj.attr('id')+"T").prepend(stri);
				 	var leftOff=0;
					if(num1.toString().length-num.toString().length>0){
						leftOff=(divwidth*(num1.toString().length-num.toString().length))/2;
					}
					var pz=0;
					if(/msie/.test(navigator.userAgent.toLowerCase())){
						pz=1; 
					}
	     			if(/firefox/.test(navigator.userAgent.toLowerCase())){
						pz=1; 
					}
					if(/webkit/.test(navigator.userAgent.toLowerCase())){
						 
					}    
				 	if(/opera/.test(navigator.userAgent.toLowerCase())){
						pz=1;
					} 
					var leftpx=(obj.width()/2)+obj.height()-($("#"+obj.attr('id')+"Num").width()/2)+1+leftOff+pz;
				 	$("#"+obj.attr('id')+"Num").css("left",leftpx);
					$("#"+obj.attr('id')+"Num").animate({ 
						top:endTop+'px'
						//,opacity:0.4
					},  
					300,  
					function(){  
						$("#"+obj.attr('id')+"sy").remove();
						if(isup){
						}else{
							obj.val(num1);
						}
					});  
				}		
			},
			formatNum:function(val){
				var val=parseFloat(val);
				if(isNaN(val)){ 
					val=0;
				}
				return val;	
			},
		};
	    $(function(){
			inputp.addNew($("#inp"),1);
			});
	    // 把16进制颜色转换成rgb格式
	    //支付模板
		//出现浮动层
		$(".ljzf_but").click(function(){
			$(".ftc_wzsf").show();
		});
		//关闭浮动
		$(".close").click(function(){
			$(".ftc_wzsf").hide();
			$(".mm_box li").removeClass("mmdd");
			$(".mm_box li").attr("data","");
			i = 0;
		});
		//数字显示隐藏
		$(".xiaq_tb").click(function(){
			$(".numb_box").slideUp(500);
		});
		$(".mm_box").click(function(){
			$(".numb_box").slideDown(500);
		});
	//预定按钮
	$("#reserveBtn").on("click",function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			if($("#loginName").text()=="登陆"){//登陆了才能预定
				layer.msg("请先登陆再进行预定",{
					offset: '270px',
					time:2000,
					icon:7,
					shade: [0.3, '#393D49']
				});
				//延时事件
				setTimeout(function(){
					layer.closeAll();
					window.location.href =path+"/user/login";
				},2000);
			}else if($("#selBank").html()==null){
				layer.msg("请先绑卡再预定！",{
					time:2000,
					offset: '250px',
					icon: 7,
					shade: [0.3, '#393D49']
				});
				//延时事件
				setTimeout(function(){
					layer.closeAll();
					location.reload();//页面重新加载
				},1000);
			}else if(checkRangeStart==null||checkRangeEnd==null){//绑定了银行卡才能预定
					layer.msg("请选择日期再进行预定",{
						offset: '270px',
						time:2000,
						icon:7,
						shade: [0.3, '#393D49']
					});
			}else if($("#inp").val()==0){//绑定了银行卡才能预定
				layer.msg("请选择房间数再进行预定",{
					offset: '270px',
					time:2000,
					icon:7,
					shade: [0.3, '#393D49']
				});
			}else{
				layer.msg('确认预定吗？',{
					offset: '270px',
					icon: 3,
					icon:3,
					shade: [0.3, '#393D49'],
					btn: ['确定', '取消'],
					time:10000000,
					shade: [0.3, '#393D49'],
					yes: function(index, layero){
						$.ajax({
							type:"GET",
							url:path+"/user/selMyInformation",
							data:{},
							dataType:"json",
							success:function(result){
								layer.msg('预定成功,是否立即付款',{
									offset: '270px',
									icon: 1,
									shade: [0.3, '#393D49'],
									btn: ['立即支付', '稍后支付'],
									time:10000000,
									yes: function(index, layero){
										layer.open({
											content:$("#payFor"), //内容
											area:'360px',
											resize:false,// 不允许拉伸
											anim: 1,// 显示风格
											title: ['支付界面', 'font-size:18px;'],// 标题
											type: 1, 
											offset: '180px',// 离上180px水平居中
											cancel: function(index, layero){ 
												layer.msg('您已取消支付',{
													icon:2,
													time:2000,
													offset: '260px',
													shade: [0.3, '#393D49']
												});
											},
											success: function(layero, index){
												layero.children(".layui-layer-content")
												.children("#payFor")
												.children(".wenx_xx")
												.children(".zhifu_price").html("￥"+$("#totalPrice").html());
												layero.children(".layui-layer-content")
												.children("#payFor")
												.children(".ftc_wzsf")
												.children(".srzfmm_box")
												.children(".zfmmxx_shop")
												.children(".zhifu_price").html("￥"+$("#totalPrice").html());
												layero.children(".layui-layer-content")
												.children("#payFor")
												.children(".ftc_wzsf")
												.children(".srzfmm_box")
												.children(".zfmmxx_shop")
												.children(".mz").html($("#roomTypeNameH3").html());
												//密码校验
												var i = 0;//数字框索引
												$(".nub_ggg li .zf_num").click(function(){
													if(i<6){
														$(".mm_box li").eq(i).addClass("mmdd");
														$(".mm_box li").eq(i).attr("data",$(this).text());
														i++
														if (i==6) {
														  setTimeout(function(){
															var data = "";
																$(".mm_box li").each(function(){
																data += $(this).attr("data");
															});
															if(data!=result.bank.bankPassword){
																//清空密码
																$(".mm_box li").removeClass("mmdd");
																$(".mm_box li").attr("data","");
																i=0;
																layer.msg("支付密码错误",{
																	time:3000,
																	offset: '180px',
																	icon: 2,
																	shade: [0.3, '#393D49']
																});
															}else{
																if(result.bank.balance<$("#totalPrice").html()){
																	//清空密码
																	$(".mm_box li").removeClass("mmdd");
																	$(".mm_box li").attr("data","");
																	i=0;
																	layer.msg("您的余额不足！支付失败",{
																		time:3000,
																		offset: '180px',
																		icon: 2,
																		shade: [0.3, '#393D49']
																	});
																	setTimeout(function(){
																		 layer.closeAll();
																		 location.reload();//页面重新加载
																	},3000);
																}else{//支付成功后1.先将余额扣除
																	$.ajax({
																		type:"GET",//请求类型
																		url:path+"/bank/payForOrderAjax",//请求的url
																		data:{balance:result.bank.balance-$("#totalPrice").html()},//请求参数
																		dataType:"json",//ajax接口（请求url）返回的数据类型
																		success:function(payFor){//data：返回数据（json对象）
																			if(payFor.result=="true"){
																				//2.添加会员积分
																				$.ajax({
																					type:"GET",//请求类型
																					url:path+"/user/modifyIntegralAjax",//请求的url
																					data:{integral:parseInt($("#totalPrice").html())+result.integral},//请求参数
																					dataType:"json",//ajax接口（请求url）返回的数据类型
																					success:function(addIntegral){//data：返回数据（json对象）
																						if(addIntegral.result=="true"){
																							//3.然后再添加到订单表
																							$.ajax({
																								type:"POST",//请求类型
																								url:path+"/order/addOrder",//请求的url
																								data:{roomTypeId:roomTypeId,checkInTime:$.trim(checkRangeStart)+" 14:00:00",checkOutTime:$.trim(checkRangeEnd)+" 12:00:00",orderState:"1",settlement:$("#totalPrice").html(),orderDesc:$("#roomDesc textarea").val(),orderRoomNum:$("#inp").val()},//请求参数
																								dataType:"json",//ajax接口（请求url）返回的数据类型
																								success:function(addOrder){//data：返回数据（json对象）
																									if(addOrder.result=="true"){
																										layer.msg("支付成功!请在订单中心中查看",{
																											time:3000,
																											offset: '250px',
																											icon: 1,
																											shade: [0.3, '#393D49']
																										});
																										setTimeout(function(){
																											//清空密码
																											$(".mm_box li").removeClass("mmdd");
																											$(".mm_box li").attr("data","");
																											i=0;
																											location.reload();//页面重新加载
																										},3000);
																									}else{
																										layer.msg("支付异常，请稍后再试！",{
																											time:3000,
																											offset: '180px',
																											icon: 2,
																											shade: [0.3, '#393D49']
																										});
																									}
																								}
																							});
																						}else{
																							layer.msg("支付异常，请稍后再试！",{
																								time:3000,
																								offset: '180px',
																								icon: 2,
																								shade: [0.3, '#393D49']
																							});
																						}
																					}
																				});
																			}else{
																				layer.msg("支付异常，请稍后再试！",{
																					time:3000,
																					offset: '180px',
																					icon: 2,
																					shade: [0.3, '#393D49'],
																				});
																			}
																		}
																	});
																}
															}
														  },100);
														};
													}
												});
												//删除前一个密码数
												$(".nub_ggg li .zf_del").click(function(){
													if(i>0){
														i--
														$(".mm_box li").eq(i).removeClass("mmdd");
														$(".mm_box li").eq(i).attr("data","");
													}
												});
												//重新输入密码
												$(".nub_ggg li .zf_empty").click(function(){
													$(".mm_box li").removeClass("mmdd");
													$(".mm_box li").attr("data","");
													i = 0;
												});
											}
										});
									},
									btn2:function(){
											//未支付的预定
											$.ajax({
												type:"POST",//请求类型
												url:path+"/order/addOrder",//请求的url
												data:{roomTypeId:roomTypeId,checkInTime:$.trim(checkRangeStart)+" 14:00:00",checkOutTime:$.trim(checkRangeEnd)+" 12:00:00",orderState:"2",settlement:$("#totalPrice").html(),orderDesc:$("#roomDesc textarea").val(),orderRoomNum:$("#inp").val()},//请求参数
												dataType:"json",//ajax接口（请求url）返回的数据类型
												success:function(addOrder){//data：返回数据（json对象）
													if(addOrder.result=="true"){
														layer.msg("您有15分钟的支付时间<br>请跳至我的订单➡支付订单中支付",{
															time:3000,
															offset: '180px',
															icon: 1,
															shade: [0.3, '#393D49']
														});
														setTimeout(function(){
															layer.closeAll();
															location.reload();//页面重新加载
														},3000);
													}
												}
											});
									}
								});
							}
						});
					}
				});
			}
		});
	});
	//绑卡
	$("#bindCard").click(function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:$("#bindCardDiv"), //内容
				area:'360px',
				resize:false,// 不允许拉伸
				btn: '确定绑定',
				yes: function(index, layero){
					var patrn=/([\d]{4})([\d]{4})([\d]{4})([\d]{4})([\d]{0,})?/;
					if($("#bankNameInp").val()==""){
						layer.msg('卡名为空!',{
							  offset:'200px',
							  time:2000,
							  icon:7,
							  shade: [0.3, '#393D49']
						  });
					}else if(!$("#bankCardInp").val().match(patrn)){
						layer.msg('请输入正确的卡号格式!',{
							  offset:'200px',
							  time:2000,
							  icon:7,
							  shade: [0.3, '#393D49']
						  });
					}else if($("#bankPasswordInp").val().length!=6){
						layer.msg('请输入正确的支付密码!',{
							  offset:'200px',
							  time:2000,
							  icon:7,
							  shade: [0.3, '#393D49']
						  });
					}else if($("#bankBalanceInp").val()==""){
						layer.msg('余额为空!',{
							  offset:'200px',
							  time:2000,
							  icon:7,
							  shade: [0.3, '#393D49']
						  });
					}else{
						$.ajax({
							type:"POST",//请求类型
							url:path+"/bank/bindBankCard",//请求的url
							data:{bankName:$("#bankNameInp").val(),bankCard:$("#bankCardInp").val(),bankPassword:$("#bankPasswordInp").val(),balance:$("#bankBalanceInp").val()},//请求参数
							dataType:"json",//ajax接口（请求url）返回的数据类型
							success:function(data){//data：返回数据（json对象）
								if(data.bind=="true"){
									layer.msg('绑定成功',{
							            offset: '200px',
							            time: 1000,
							            icon:1,
							            shade: [0.3, '#393D49']
									});
									//延时事件
									setTimeout(function(){
										 window.location.reload();//刷新页面
									},1000);
								}else{
									layer.msg('绑定失败',{
							            offset: '200px',
							            time: 2000,
							            icon:2,
							            shade: [0.3, '#393D49']
									});
								}
							}
						});
					}
				},
				anim: 1,// 显示风格
				title: ['绑定银行卡', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
			});
		});
	});
	//银行卡信息
	$("#selBank").click(function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:$("#selBankDiv"), //内容
				area:'360px',
				resize:false,// 不允许拉伸
				btn: '关闭',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['银行卡信息', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/bank/selBankInfById",
						data:{},
						dataType:"json",
						success:function(result){
							layero.children(".layui-layer-content").children().children().children().children("#bankName").html(result.bankName);
							layero.children(".layui-layer-content").children().children().children().next().children("#bankCard").html(result.bankCard);
							layero.children(".layui-layer-content").children().children().children().next().next().children("#bankBalance").html(result.balance+' RMB');
						}
					});
				}
			});
		});
	});
	//查看订单
	$("#selReserve").on("click",function(){
		//解决页面传值乱码
		var msg = $("#loginName").html();
		msg=encodeURI(encodeURI(msg));
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:path+'/user/toMyOrder?userName='+msg, //内容
				anim: 1,// 显示风格
				area:['1000px','450px'],
				title: ['我的订单', 'font-size:18px;'],// 标题
				type: 2, 
				offset: '100px',// 离上100px水平居中
			});
		});
	});
	//支付订单
	$("#payForOrder").on('click',function(){
		var customerId = $("#loginName").attr("customerId");
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:path+'/user/UntreatedOrder?customerId='+customerId, //内容
				anim: 1,// 显示风格
				area:['1100px','300px'],
				title: ['支付订单', 'font-size:18px;'],// 标题
				type: 2, 
				offset: '100px',// 离上100px水平居中
			});
		});
	});
	//查看我的房间
	$("#selMyRoom").on('click',function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:path+'/user/selMyCheckIn', //内容
				anim: 1,// 显示风格
				area:['1100px','350px'],
				title: ['入住查询', 'font-size:18px;'],// 标题
				type: 2, 
				offset: '100px',// 离上100px水平居中
			});
		});
	});
	//查看我的评论
	$("#selMyComment").on('click',function(){
		layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				content:path+'/user/selMyComment', //内容
				anim: 1,// 显示风格
				area:['1300px','500px'],
				title: ['我的评论', 'font-size:18px;'],// 标题
				type: 2, 
				offset: '50px',// 离上100px水平居中
			});
		});
	});
	//购买会员卡
	$(".member").on('click',function(){
		//获得当前元素
		var li=$(this);
		//获取会员卡编号
		var memberId=$(this).attr("memberId");
		//价格
		var memberPrice=li.children(".discount").children(".memberPrice").html();
		//卡内容
		var memberType=li.children(".memberType").html();
		layui.use('layer', function(){
			var layer = layui.layer;
			//获取当前元素
			if($("#loginName").html()=="登陆"){
				layer.msg('请先登陆再购卡！',{
					offset: '200px',
					time: 2000,
					icon:7,
					shade: [0.3, '#393D49']
				});
				setTimeout(function(){
					layer.closeAll();
					window.location.href =path+"/user/login";
				},1000);
			}else{
				$.ajax({
				type:"GET",
				url:path+"/user/selMyInformation",
				data:{},
				dataType:"json",
				success:function(result){
					//支付会员卡
					layer.open({
						content:$("#payFor"), //内容
						area:'360px',
						resize:false,// 不允许拉伸
						anim: 1,// 显示风格
						title: ['支付界面', 'font-size:18px;'],// 标题
						type: 1, 
						offset: '180px',// 离上180px水平居中
						cancel: function(index, layero){ 
							layer.msg('您已取消支付',{
								icon:2,
								time:3000,
								offset: '260px',
								shade: [0.3, '#393D49']
							});
						},
						success: function(layero, index){
							layero.children(".layui-layer-content")
							.children("#payFor")
							.children(".wenx_xx")
							.children(".zhifu_price").html("￥"+memberPrice);
							layero.children(".layui-layer-content")
							.children("#payFor")
							.children(".ftc_wzsf")
							.children(".srzfmm_box")
							.children(".zfmmxx_shop")
							.children(".zhifu_price").html("￥"+memberPrice);
							layero.children(".layui-layer-content")
							.children("#payFor")
							.children(".ftc_wzsf")
							.children(".srzfmm_box")
							.children(".zfmmxx_shop")
							.children(".mz").html(memberType);
							//密码校验
							var i = 0;//数字框索引
							$(".nub_ggg li .zf_num").click(function(){
								if(i<6){
									$(".mm_box li").eq(i).addClass("mmdd");
									$(".mm_box li").eq(i).attr("data",$(this).text());
									i++
									if (i==6) {
									  setTimeout(function(){
										var data = "";
											$(".mm_box li").each(function(){
											data += $(this).attr("data");
										});
										if(data!=result.bank.bankPassword){
											//清空密码
											$(".mm_box li").removeClass("mmdd");
											$(".mm_box li").attr("data","");
											i=0;
											layer.msg("支付密码错误",{
												time:3000,
												offset: '180px',
												icon: 2,
												shade: [0.3, '#393D49']
											});
										}else{
											if(result.bank.balance<memberPrice){
												//清空密码
												$(".mm_box li").removeClass("mmdd");
												$(".mm_box li").attr("data","");
												i=0;
												layer.msg("您的余额不足！支付失败",{
													time:3000,
													offset: '180px',
													icon: 2,
													shade: [0.3, '#393D49']
												});
												setTimeout(function(){
													 layer.closeAll();
													 window.location.reload();
												},3000);
											}else{//支付成功后1.先将余额扣除
												$.ajax({
													type:"GET",//请求类型
													url:path+"/bank/payForOrderAjax",//请求的url
													data:{balance:result.bank.balance-memberPrice},//请求参数
													dataType:"json",//ajax接口（请求url）返回的数据类型
													success:function(payFor){//data：返回数据（json对象）
														if(payFor.result=="true"){
															//2.添加会员积分
															$.ajax({
																type:"GET",//请求类型
																url:path+"/user/modifyIntegralAjax",//请求的url
																data:{integral:parseInt(memberPrice)+result.integral},//请求参数
																dataType:"json",//ajax接口（请求url）返回的数据类型
																success:function(addIntegral){//data：返回数据（json对象）
																	if(addIntegral.result=="true"){
																		//3.然后再添加到订单表
																		$.ajax({
																			type:"POST",//请求类型
																			url:path+"/order/addMemberOrderAjax",//请求的url
																			data:{memberId:memberId,orderPrice:memberPrice},//请求参数
																			dataType:"json",//ajax接口（请求url）返回的数据类型
																			success:function(addOrder){//data：返回数据（json对象）
																				if(addOrder.result=="true"){
																					//更改会员等级
																					$.ajax({
																						type:"POST",//请求类型
																						url:path+"/user/modifyUserMemberIdAjax",//请求的url
																						data:{memberId:memberId,orderPrice:memberPrice},//请求参数
																						dataType:"json",//ajax接口（请求url）返回的数据类型
																						success:function(modifyMember){//data：返回数据（json对象）
																							if(modifyMember.result=="true"){
																								layer.msg("支付成功!您已获得"+memberType,{
																									time:3000,
																									offset: '250px',
																									icon: 1,
																									shade: [0.3, '#393D49']
																								});
																								setTimeout(function(){
																									//清空密码
																									$(".mm_box li").removeClass("mmdd");
																									$(".mm_box li").attr("data","");
																									i=0;
																									location.reload();//页面重新加载
																								},3000);
																							}else{
																								layer.msg("更改会员失败!",{
																									time:3000,
																									offset: '250px',
																									icon: 2,
																									shade: [0.3, '#393D49']
																								});
																							}
																						}
																					});
																				}else{
																					layer.msg("支付异常，请稍后再试！",{
																						time:3000,
																						offset: '180px',
																						icon: 2,
																						shade: [0.3, '#393D49']
																					});
																				}
																			}
																		});
																	}else{
																		layer.msg("支付异常，请稍后再试！",{
																			time:3000,
																			offset: '180px',
																			icon: 2,
																			shade: [0.3, '#393D49']
																		});
																	}
																}
															});
														}else{
															layer.msg("支付异常，请稍后再试！",{
																time:3000,
																offset: '180px',
																icon: 2,
																shade: [0.3, '#393D49'],
															});
														}
													}
												});
											}
										}
									  },100);
									};
								}
							});
							//删除前一个密码数
							$(".nub_ggg li .zf_del").click(function(){
								if(i>0){
									i--
									$(".mm_box li").eq(i).removeClass("mmdd");
									$(".mm_box li").eq(i).attr("data","");
								}
							});
							//重新输入密码
							$(".nub_ggg li .zf_empty").click(function(){
								$(".mm_box li").removeClass("mmdd");
								$(".mm_box li").attr("data","");
								i = 0;
							});
						}
						});
					}
				});
			}
		});
	});
});
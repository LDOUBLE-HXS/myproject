$(function(){
	//1分钟定时器
	window.setInterval(
		function() {
			//1分钟刷新一次重新查询一次订单 处理订单
			 window.location.reload();//刷新
		}
	,60000);
	var now=Date.parse(new Date()); 
	layui.use('layer', function(){
		var layer = layui.layer;
		$(".checkOutTime").each(function(index, element){//对过期的订单行经行渲染
			var li=$(this);
			var checkOutTime=Date.parse(new Date(li.html())); 
		    if(checkOutTime<now){
		    	li.parent().css({"background-color":"#ED1B24"});
		    	li.parent().children().css({"border-right":"0px","color":"white"});
		    	li.parent().children().children("font").css({"color":"white"});
		    	li.parent().children().children(".del_btn").children("span").html("回收订单");
		    	li.parent().children().children(".edit_btn").css({"display":"none"});
		    }
		});
		//处理订单，办理入住
		$(".edit_btn").on('click',function(){
			var editLi=$(this);
			//初始请选择
			$("#room").append("<option value='0'>请选择</option>");
			layer.open({
				content:$("#editOrderDiv"), //内容
				area:'300px',
				resize:false,// 不允许拉伸
				btn: '入住',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['办理入住', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					//订单
					$.ajax({
						type:"GET",
						url:path+"/order/selOrderAjax",
						data:{orderId:editLi.attr("orderId")},
						dataType:"json",
						success:function(result){
							layero.children(".layui-layer-content").children().children().children().children("#orderId").html(result.id);
						}
					});
					//用户
					$.ajax({
						type:"GET",
						url:path+"/manager/selCustomerAjax",
						data:{id:editLi.attr("customerId")},
						dataType:"json",
						success:function(result){
							layero.children(".layui-layer-content").children().children().children().next().children("#customerId").html(result.userName);
						}
					});
					//房间类型
					$.ajax({
						type:"GET",
						url:path+"/room/selRoomTypeById",
						data:{roomTypeId:editLi.attr("roomTypeId")},
						dataType:"json",
						success:function(result){
							layero.children(".layui-layer-content").children().children().children().next().next().children("#roomTypeId").html(result.roomTypeName);
						}
					});
					//选择房间
					$.ajax({
						type:"POST",
						url:path+"/room/selRoomByRoomTypeIdAjax",
						data:{roomTypeId:editLi.attr("roomTypeId")},
						dataType:"json",
						success:function(data){
							for(var i=0;i<data.length;i++){
								layero.children(".layui-layer-content").children().children().children().next().next().next().children("#room").append("<option value='"+data[i].id+"'>"+data[i].roomFloor+":"+data[i].roomCode+"</option>");
			                }
						}
					});
				},
				yes:function(){//入住处理
					if($("#room option:selected").val()==0){
						layer.msg('请选择房间！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else{
						$.ajax({
							type:"POST",
							url:path+"/manager/editOrderAjax",
							data:{orderId:editLi.attr("orderId"),roomId:$("#room option:selected").val()},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('入住成功！请到房间管理中查看',{
										offset: '150px',
										time: 3000,
										icon:1,
										shade: [0.3, '#393D49']
									});
									//延时事件
									setTimeout(function(){
										layer.closeAll();
										window.location.reload();//刷新
									},1000);
								}else if(data.result=="false"){
									layer.msg('入住失败！请重新入住',{
						            offset: '150px',
						            time: 3000,
						            icon:2,
						            shade: [0.3, '#393D49']
									});
								}
							}
						});
					}
				},
				cancel: function(index, layero){ 
					//清除添加的房间
					$("#room").children().remove();
				}
			});
		});
		//进行退单，或回收订单
		$(".del_btn").on('click',function(){
			var delLi=$(this);
			/*
			 *	处理两种情况：
			 *	1.顾客在离店时间之前想要退单，可退回费用给顾客(收10%的手续费)
			 *	2.顾客在离店时间之后仍未到酒店前台办理入住或电话确定入住，订单进行回收 更改订单状态为过期
			 */
			if(delLi.children("span").html().trim()=="退单"){
				layer.msg('确定退单吗?',{
					offset: '150px',
					time: 1000000000,
					icon:3,
					shade: [0.3, '#393D49'],
					btn:["确定","取消"],
					yes:function(){
						//查询订单信息
						$.ajax({
							type:"GET",
							url:path+"/order/selOrderAjax",
							data:{orderId:delLi.attr("orderId")},
							dataType:"json",
							success:function(data){
								if(data!=null){
									//退回金额给用户银行
									$.ajax({
										type:"GET",
										url:path+"/bank/payForOrderAjax",
										data:{balance:(data.settlement-(data.settlement/10)+data.customer.bank.balance).toFixed(2),customerId:data.userId},
										dataType:"json",
										success:function(balanceData){
											if(balanceData.result=="true"){//成功退回余额
												//回扣会员积分
												$.ajax({
													type:"GET",
													url:path+"/user/modifyIntegralAjax",
													data:{integral:data.customer.integral-parseInt(data.settlement),customerId:data.userId},
													dataType:"json",
													success:function(integralData){
														if(integralData.result=="true"){
															$.ajax({
																type:"GET",
																url:path+"/order/returnOrderAjax",
																data:{orderId:delLi.attr("orderId")},
																dataType:"json",
																success:function(stateData){
																	if(stateData.result=="true"){//更改订单状态为已退单
																		layer.msg('订单已成功退单！',{
																            offset: '150px',
																            time: 3000,
																            icon:1,
																            shade: [0.3, '#393D49']
																		});
																		//延迟事件
																		setTimeout(function(){
																			layer.closeAll();
																			window.location.reload();//刷新
																		}, 1000);
																	}else if(stateData.result=="false"){
																		layer.msg('订单状态更改出错！',{
																            offset: '150px',
																            time: 3000,
																            icon:2,
																            shade: [0.3, '#393D49']
																		});
																	}
																}
															});
														}else if(integralData.result=="false"){
															layer.msg('回扣积分出错！',{
													            offset: '150px',
													            time: 3000,
													            icon:2,
													            shade: [0.3, '#393D49']
															});
														}
													}
												});
											}else if(balanceData.result=="false"){
												layer.msg('退回余额出错！',{
										            offset: '150px',
										            time: 3000,
										            icon:2,
										            shade: [0.3, '#393D49']
												});
											}
										}
									});
								}
							}
						});
					}
				});
			}else if(delLi.children("span").html().trim()=="回收订单"){
				$.ajax({
					type:"GET",
					url:path+"/order/recoverOrderAjax",
					data:{orderId:delLi.attr("orderId")},
					dataType:"json",
					success:function(recoverData){
						if(recoverData.result=="true"){
							layer.msg('回收成功，订单已更改为过期状态！',{
								offset: '150px',
								time: 3000,
								icon:1,
								shade: [0.3, '#393D49']
							});
							//延迟事件
							setTimeout(function(){
								layer.closeAll();
								window.location.reload();//刷新
							}, 1000);
						}else if(recoverData.result=="false"){
							layer.msg('回收失败！',{
								offset: '150px',
								time: 3000,
								icon:1,
								shade: [0.3, '#393D49']
							});
						}
					}
				});
			}
		});
	});
});
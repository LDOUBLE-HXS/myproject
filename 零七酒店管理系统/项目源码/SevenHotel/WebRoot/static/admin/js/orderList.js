$(function(){
	$("#roomImg").hide();//隐藏房型图片
	var now=Date.parse(new Date()); //现在的时间戳
	layui.use('layer', function(){
		var layer = layui.layer;
			//根据id查用户信息
		$(".viewOrder").on('click',function(){
			var id=$(this).attr("orderid");
			layer.open({
				content:$("#selOrderDiv"), //内容
				area:'320px',
				resize:false,// 不允许拉伸
				btn: '关闭',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['订单详情', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '10px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/order/selOrderAjax",
						data:{orderId:id},
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
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().next().next().children("#payForWay").html(result.customer.bank.bankName);
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().next().next().next().children("#totalPrice").html(result.settlement.toFixed(2));
						}
					});
				}
			});
		});
		$("#roomA").on('mouseover',function(){
			$("#roomImg").fadeIn(500);
		}).on('mouseout',function(){
			$("#roomImg").fadeOut(500);
		});
		//删除订单
		$(".delOrder").on('click',function(){
			//本条订单离开时间
			var checkOutTime=$(this).attr("checkOutTime");
			//本条订单订单状态
			var orderState=$(this).attr("orderState");
			//订单id
			var id=$(this).attr("orderId");
			if(Date.parse(new Date(checkOutTime))>now&&orderState=="1"){
				layer.msg('该订单还未彻底结算！',{
		            offset: '150px',
		            icon:2,
		            time: 2000,
		            shade: [0.3, '#393D49']
				});
			}else{
				layer.msg('确定删除该订单吗？',{
		            offset: '100px',
		            icon:3,
		            time: 10000000,
		            shade: [0.3, '#393D49'],
		            btn:["确定","取消"],
		            yes:function(){
		            	$.ajax({
							type:"GET",
							url:path+"/order/deleteOrderAjax",
							data:{orderId:id},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('删除成功！',{
							            offset: '200px',
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
							            offset: '200px',
							            icon:2,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
								}
							}
		            	});
		            }
				});
			}
		});
	});
});
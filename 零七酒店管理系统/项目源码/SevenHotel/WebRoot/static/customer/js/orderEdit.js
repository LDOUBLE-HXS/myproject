$(function() {
	layui.use('layer', function() {
		var layer = layui.layer;
		// 渲染倒计时
		$(".orderTime").each(
				function(index, element) {// 对过期的订单行经行渲染
					var li = $(this);// 获得当前行
					// 下单时间
					var orderTime = li.html();
					var start = new Date();
					var end = new Date(orderTime);
					var startTime = start.getTime();
					var endTime = end.getTime();
					var intDiff = Math
							.abs(parseInt((startTime - endTime) / 1000));
					if (intDiff > 900) {// 订单过期
						intDiff = 0;
						li.parent().children(".payForOrderTd").children(
								".payForOrder").css({
							"background-color" : "gray"
						});
						li.parent().children(".payForOrderTd").children(
								".payForOrder").attr("class", "overOrder");
					} else {
						intDiff = 900 - intDiff;// 未过期则进行倒时15分钟
					}
					// 定时器设置开始倒计时
					window.setInterval(
							function() {
								var day = 0, hour = 0, minute = 0, second = 0;// 时间默认值
								if (intDiff > 0) {
									day = Math.floor(intDiff / (60 * 60 * 24));
									hour = Math.floor(intDiff / (60 * 60))
											- (day * 24);
									minute = Math.floor(intDiff / 60)
											- (day * 24 * 60) - (hour * 60);
									second = Math.floor(intDiff)
											- (day * 24 * 60 * 60)
											- (hour * 60 * 60) - (minute * 60);
								}
								if (minute <= 9)
									minute = '0' + minute;
								if (second <= 9)
									second = '0' + second;
								li.parent().children(".payForTime").children(
										".time-item").children('.minute_show')
										.html('<s></s>' + minute + '分');
								li.parent().children(".payForTime").children(
										".time-item").children('.second_show')
										.html('<s></s>' + second + '秒');
								intDiff--;
								if (intDiff == 0) {
									li.parent().children(".payForOrderTd")
											.children(".payForOrder").css({
												"background-color" : "gray"
											});
									li.parent().children(".payForOrderTd")
											.children(".payForOrder").attr(
													"class", "overOrder");
								}
							}, 1000);
				});
		// 过期订单删除变化特效
		$(".overOrder").on('mouseover', function() {
			$(this).children("span").html("删除订单");
			$(this).css({
				"background-color" : "red"
			});
		}).on('mouseout', function() {
			$(this).children("span").html("支付订单");
			$(this).css({
				"background-color" : "gray"
			});
		});
		// 删除
		$(".overOrder").on('click', function() {
			var orderId = $(this).attr("orderId");
			layer.msg('该订单已失效,确定删除该订单吗？', {
				offset : '50px',
				icon : 3,
				time : 10000000,
				btn : [ "确定", "取消" ],
				shade: [0.3, '#393D49'],
				yes : function() {
					$.ajax({
						type : "GET",
						url : path + "/order/deleteOrderAjax",
						data : {
							orderId : orderId
						},
						dataType : "json",
						success : function(data) {
							if (data.result == "true") {
								layer.msg('删除成功！', {
									offset : '50px',
									icon : 1,
									time : 2000,
									shade: [0.3, '#393D49']
								});
								// 延时事件
								setTimeout(function() {
									window.location.reload();// 刷新
								}, 1000);
							} else if (data.result == "false") {
								layer.msg('删除失败！', {
									offset : '50px',
									icon : 2,
									time : 2000,
									shade: [0.3, '#393D49']
								});
							}
						}
					});
				}
			});
		});
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
		//支付
		$(".payForOrder").on('click',function(){
			//房间类型
			var roomTypeName=$(this).parent().parent().children(".roomTypeName").html();
			//总价格
			var totalPrice=$(this).parent().parent().children(".totalPrice").children("font").html();
			//订单id
			var orderId=$(this).attr("orderId");
			$.ajax({
				type:"GET",
				url:path+"/user/selMyInformation",
				data:{},
				dataType:"json",
				success:function(result){
							layer.open({
								content:$("#payFor"), //内容
								area:'360px',
								resize:false,// 不允许拉伸
								anim: 1,// 显示风格
								title: ['支付界面', 'font-size:18px;'],// 标题
								type: 1, 
								offset: '10px',// 离上10px水平居中
								cancel: function(index, layero){ 
									layer.msg('您已取消支付',{
										icon:2,
										time:3000,
										offset: '40px',
										shade: [0.3, '#393D49']
									});
								},
								success: function(layero, index){
									layero.children(".layui-layer-content")
									.children("#payFor")
									.children(".wenx_xx")
									.children(".zhifu_price").html("￥"+totalPrice);
									layero.children(".layui-layer-content")
									.children("#payFor")
									.children(".ftc_wzsf")
									.children(".srzfmm_box")
									.children(".zfmmxx_shop")
									.children(".zhifu_price").html("￥"+totalPrice);
									layero.children(".layui-layer-content")
									.children("#payFor")
									.children(".ftc_wzsf")
									.children(".srzfmm_box")
									.children(".zfmmxx_shop")
									.children(".mz").html(roomTypeName);
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
														offset: '40px',
														icon: 2,
														shade: [0.3, '#393D49']
													});
												}else{
													if(result.bank.balance<totalPrice){
														//清空密码
														$(".mm_box li").removeClass("mmdd");
														$(".mm_box li").attr("data","");
														i=0;
														layer.msg("您的余额不足！支付失败",{
															time:3000,
															offset: '40px',
															icon: 2,
															shade: [0.3, '#393D49']
														});
														setTimeout(function(){
															 layer.closeAll();
														},3000);
													}else{//支付成功后1.先将余额扣除
														$.ajax({
															type:"GET",//请求类型
															url:path+"/bank/payForOrderAjax",//请求的url
															data:{balance:result.bank.balance-totalPrice},//请求参数
															dataType:"json",//ajax接口（请求url）返回的数据类型
															success:function(payFor){//data：返回数据（json对象）
																if(payFor.result=="true"){
																	//2.添加会员积分
																	$.ajax({
																		type:"GET",//请求类型
																		url:path+"/user/modifyIntegralAjax",//请求的url
																		data:{integral:parseInt(totalPrice)+result.integral},//请求参数
																		dataType:"json",//ajax接口（请求url）返回的数据类型
																		success:function(addIntegral){//data：返回数据（json对象）
																			if(addIntegral.result=="true"){
																				//3.将改订单状态改为已付款
																				$.ajax({
																					type:"GET",//请求类型
																					url:path+"/order/payForUntreatedOrderAjax",//请求的url
																					data:{orderId:orderId},//请求参数
																					dataType:"json",//ajax接口（请求url）返回的数据类型
																					success:function(addOrder){//data：返回数据（json对象）
																						if(addOrder.result=="true"){
																							layer.msg("支付成功!请在订单中心中查看",{
																								time:3000,
																								offset: '40px',
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
																								offset: '40px',
																								icon: 2,
																								shade: [0.3, '#393D49']
																							});
																						}
																					}
																				});
																			}else{
																				layer.msg("支付异常，请稍后再试！",{
																					time:3000,
																					offset: '40px',
																					icon: 2,
																					shade: [0.3, '#393D49']
																				});
																			}
																		}
																	});
																}else{
																	layer.msg("支付异常，请稍后再试！",{
																		time:3000,
																		offset: '40px',
																		icon: 2,
																		shade: [0.3, '#393D49']
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
					});
		});
	});
});
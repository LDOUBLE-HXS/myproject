$(function(){
	layui.use('layer', function(){
		var layer = layui.layer;
		//根据id查用户信息
		$(".viewCustomer").on('click',function(){
			var id=$(this).attr("customerid");
			layer.open({
				content:$("#selCustomerDiv"), //内容
				area:'320px',
				resize:false,// 不允许拉伸
				btn: '关闭',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['会员信息', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/manager/selCustomerAjax",
						data:{id:id},
						dataType:"json",
						success:function(result){
							layero.children(".layui-layer-content").children().children().children().children("#userCodeSpan").html(result.userCode);
							layero.children(".layui-layer-content").children().children().children().next().children("#userNameSpan").html(result.userName);
							layero.children(".layui-layer-content").children().children().children().next().next().children("#userPhoneSpan").html(result.userPhone);
							layero.children(".layui-layer-content").children().children().children().next().next().next().children("#userCardSpan").html(result.userCard);
							if(result.bank.bankName!=null){
								layero.children(".layui-layer-content").children().children().children().next().next().next().next().children("#bankNameSpan").html(result.bank.bankName);
							}else{
								layero.children(".layui-layer-content").children().children().children().next().next().next().next().children("#bankNameSpan").html("暂无绑定");
							}
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().children("#creationDateSpan").html(result.creationDate);
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().children("#userMemberSpan").html(result.member.memberType);
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().next().next().children("#integralSpan").html(result.integral);
						}
					});
				}
			});
		});
		//根据id修改信息
		$(".modifyCustomer").on('click',function(){
			var id=$(this).attr("customerid");
			layer.open({
				content:$("#modifyCustomerDiv"), //内容
				area:'340px',
				resize:false,// 不允许拉伸
				btn: ['保存','取消'],
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['会员信息修改', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/manager/selCustomerAjax",
						data:{id:id},
						dataType:"json",
						success:function(result){
							//校验userCode
							$("#userCodeInput").on('blur',function(){
								if($("#userCodeInput").val()!=result.userCode){
									$.ajax({
										type:"GET",//请求类型
										url:path+"/user/userCodeExist",//请求的url
										data:{userCode:$("#userCodeInput").val()},//请求参数
										dataType:"json",//ajax接口（请求url）返回的数据类型
										success:function(dataCode){//data：返回数据（json对象）
											if(dataCode.userCode == "true"){
												layer.msg('该账号存在，不可用！',{
										            offset: '200px',
										            time: 1000,
										            icon:2,
										            shade: [0.3, '#393D49']
												});
												layero.children(".layui-layer-content").children().children().children().children("#userCodeInput").val(result.userCode);
											}
										}
									});
								}
							});
							layero.children(".layui-layer-content").children().children().children().children("#userCodeInput").val(result.userCode);
							layero.children(".layui-layer-content").children().children().children().next().children("#userNameInput").val(result.userName);
							layero.children(".layui-layer-content").children().children().children().next().next().children("#userPhoneInput").val(result.userPhone);
							layero.children(".layui-layer-content").children().children().children().next().next().next().children("#userCardInput").val(result.userCard);
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().children("#userMemberIdInput").children("option[value='"+result.userMemberId+"']").attr("selected","selected");
							layero.children(".layui-layer-content").children().children().children().next().next().next().next().next().children("#integralInput").val(result.integral);
						}
					});
				},
				yes:function(){
					var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
					var patrn18=/^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
					var patrn15=/^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$/;
					if($("#userCodeInput").val()==null||$("#userCodeInput").val()==""){
						layer.msg('账号不能为空！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else if($("#userNameInput").val()==null||$("#userNameInput").val()==""){
						layer.msg('真实姓名不能为空！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else if(!$("#userPhoneInput").val().match(patrn)){
						layer.msg('手机号格式不正确！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else if(!$("#userCardInput").val().match(patrn18)&&!$("#userCardInput").val().match(patrn15)){
						layer.msg('身份证格式不正确！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else if($("#userMemberIdInput option:selected").val()==0){
						layer.msg('请选择会员等级！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else if($("#integralInput").val()==null||$("#integralInput").val()==""){
						layer.msg('请输入会员积分！',{
				            offset: '200px',
				            icon:7,
				            time: 1000,
				            shade: [0.3, '#393D49']
						});
					}else{
						//下一步：实行修改会员信息
						$.ajax({
							type:"POST",
							url:path+"/manager/modifyCustomerAjax",
							data:{id:id,userCode:$("#userCodeInput").val(),userName:$("#userNameInput").val(),userPhone:$("#userPhoneInput").val(),userCard:$("#userCardInput").val(),userMemberId:$("#userMemberIdInput option:selected").val(),integral:$("#integralInput").val()},
							dataType:"json",
							success:function(data){
								if(data.result == "true"){
									layer.msg('修改成功',{
							            offset: '200px',
							            icon:1,
							            time: 1000,
							            shade: [0.3, '#393D49']
									});
									//延时事件
									 setTimeout(function(){
										 window.location.reload();//刷新
										},1000);
								}else if(data.result == "false"){
									layer.msg('修改失败',{
							            offset: '200px',
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
		//删除会员
		$(".deleteCustomer").on('click',function(){
			var id=$(this).attr("customerid");
			layer.msg('确认删除吗？',{
	            offset: '200px',
	            icon:3,
	            time: 1000000,
	            btn:["确定","取消"],
	            yes:function(){
	            	$.ajax({
						type:"GET",
						url:path+"/manager/deleteCustomerAjax",
						data:{id:id},
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
		});
	});
});
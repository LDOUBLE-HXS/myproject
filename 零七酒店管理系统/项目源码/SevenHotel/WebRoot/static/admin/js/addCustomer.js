$(function(){
	layui.use('layer', function(){
		var layer = layui.layer;
		$("#userCode").on('blur',function(){
			if($("#userCode").val()!=null||$("#userCode").val()!=""){
				$.ajax({
					type:"GET",//请求类型
					url:path+"/user/userCodeExist",//请求的url
					data:{userCode:$("#userCode").val()},//请求参数
					dataType:"json",//ajax接口（请求url）返回的数据类型
					success:function(data){//data：返回数据（json对象）
						if(data.userCode == "true"){
							validateTip($("#userCode").next(),{"color":"red"},imgNo+ " 该账号存在，不可用",false);
						}else if(data.userCode == "false"){
							validateTip($("#userCode").next(),{"color":"green"},"",true);
						}
					}
				});
			}
		});
		var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
		var patrn18=/^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
		var patrn15=/^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$/;
		$("#addBtn").on('click',function(){
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
			}else if($("#userName").val()==null||$("#userName").val()==""){
				layer.msg('真实姓名不能为空！',{
		            offset: '200px',
		            icon:7,
		            shade: [0.3, '#393D49'],
		            time: 1000
				});
			}else if(!$("#userPhone").val().match(patrn)){
				layer.msg('手机号格式不正确！',{
		            offset: '200px',
		            icon:2,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else if(!$("#userCard").val().match(patrn18)&&!$("#userCard").val().match(patrn15)){
				layer.msg('身份证格式不正确！',{
		            offset: '200px',
		            icon:2,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else if($("#userMemberId option:selected").val()==0){
				layer.msg('请选择会员等级！',{
		            offset: '200px',
		            icon:7,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else if($("#integral").val()==null||$("#integral").val()==""){
				layer.msg('请输入会员积分！',{
		            offset: '200px',
		            icon:7,
		            time: 1000,
		            shade: [0.3, '#393D49']
				});
			}else{
				$("#addCustomerForm").submit();
			}
		});
	});
});
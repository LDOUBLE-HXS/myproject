$(function(){
	$("#manPassword").next().hide();
	$("#manPassword").hide();
	$("#loginBtn").hide();
	//保存数据
	$.ajax({
		type:"POST",//请求类型
		url:path+"/manager/manCodeAjax",//请求的url
		data:{manCode:$("#manCode").val()},//请求参数
		dataType:"json",//ajax接口（请求url）返回的数据类型
		success:function(data){//data：返回数据（json对象）
			if(data!=null){
				$('#workPic').attr('src',data.workPicPath);
				$("#manPassword").next().show();
				$("#manPassword").show();
				$("#loginBtn").show();
			}
		}
	});
	$("#manCode").on("focus",function(){
		validateTip($("#manCode").next(),{"color":"#666666"},"* 请输入管理员登入账号",false);
	}).on("blur",function(){
		if($("#manCode").val() != null && $("#manCode").val() != ""){
			$.ajax({
				type:"POST",//请求类型
				url:path+"/manager/manCodeAjax",//请求的url
				data:{manCode:$("#manCode").val()},//请求参数
				dataType:"json",//ajax接口（请求url）返回的数据类型
				success:function(data){//data：返回数据（json对象）
					if(data!=null){
						validateTip($("#manCode").next(),{"color":"green"},"",true);
						$('#workPic').attr('src',data.workPicPath);
						$("#manPassword").next().fadeIn(1000);
						$("#manPassword").fadeIn(1000);
						$("#loginBtn").fadeIn(3000);
					}
				},
				error:function(data){//当访问时候，404，500 等非200的错误状态码
					$('#workPic').attr('src','static/admin/images/login_logo.png');
					$("#manPassword").next().fadeOut();
					$("#manPassword").fadeOut();
					$("#loginBtn").fadeOut();
					validateTip($("#manCode").next(),{"color":"red"},imgNo+" 无该管理员",false);
				}
			});
		}else{
			$("#workPic").attr('src','static/admin/images/login_logo.png');
			$("#manPassword").fadeOut();
			$("#loginBtn").fadeOut();
			validateTip($("#manCode").next(),{"color":"red"},imgNo+" 账号为空",false);
		}
	});
	$("#manPassword").on("focus",function(){
		validateTip($("#manPassword").next(),{"color":"#666666"},"* 请输入管理员登入密码",false);
	}).on("blur",function(){
		if($("#manPassword").val() != null && $("#manCode").val() != ""){
			validateTip($("#manPassword").next(),{"color":"red"},"",true);
		}else{
			validateTip($("#manPassword").next(),{"color":"red"},imgNo+" 密码为空",false);
		}
	});
	//表单验证
	$("#loginBtn").bind("click",function(){
		if($("#manCode").attr("validateStatus") != "true"){
			$("#manCode").blur();
			alert("账号格式不正确 ");
		}else if($("#manPassword").attr("validateStatus") != "true"){
			$("#manPassword").blur();
			alert("密码格式不正确");
		}else{
			$("#loginForm").submit();
		}
	});
	
});
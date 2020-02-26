var userCode = null;
var userName = null;
var userPassword=null;
var reUserPassword=null;
var userCard=null;
var userPhone=null;
var addBtn=null;
var register_wrap=null;
var logo=null;


$(function(){
	//输入框效果
	$('.form_text_ipt input').focus(function(){
		$(this).parent().css({
			'box-shadow':'0 0 3px #bbb',
		});
	});
	$('.form_text_ipt input').blur(function(){
		$(this).parent().css({
			'box-shadow':'none',
		});
		//$(this).parent().next().hide();
	});
	
	userCode=$("#userCode");
	userName=$("#userName");
	userPassword=$("#userPassword");
	reUserPassword=$("#reUserPassword");
	userCard=$("#userCard");
	userPhone=$("#userPhone");
	addBtn=$("#add");
	register_wrap=$(".register_wrap");
	logo=$(".logo");
	register_wrap.css({"background":"url('"+path+"/static/customer/images/logo_bg.jpg') no-repeat center"});
	logo.css({"background":"url('"+path+"/static/customer/images/logowz.png') no-repeat center"});
	/*注册账号判空以及ajax验证*/
	userCode.on("focus",function(){
		validateTip(userCode.next(),{"color":"#666666"},"* 请输入注册账号",false);
	}).on("blur",function(){
		if(userCode.val() != null && userCode.val() != ""){
			$.ajax({
				type:"GET",//请求类型
				url:path+"/user/userCodeExist",//请求的url
				data:{userCode:userCode.val()},//请求参数
				dataType:"json",//ajax接口（请求url）返回的数据类型
				success:function(data){//data：返回数据（json对象）
					if(data.userCode == "true"){
						validateTip(userCode.next(),{"color":"red"},imgNo+ " 该账号存在，不可用",false);
					}else if(data.userCode == "false"){
						validateTip(userCode.next(),{"color":"green"},imgYes+" 该账号可用",true);
					}
				},
				error:function(data){//当访问时候，404，500 等非200的错误状态码
					validateTip(userCode.next(),{"color":"red"},imgNo+" 您访问的页面不存在",false);
				}
			});
		}else{
			validateTip(userCode.next(),{"color":"red"},imgNo+" 注册账号不能为空，请输入",false);
		}
	});
	/*真实姓名判空*/
	userName.on("focus",function(){
		validateTip(userName.next(),{"color":"#666666"},"* 请输入真实姓名",false);
	}).on("blur",function(){
		if(userName.val() != null && userName.val() != ""){
			validateTip(userName.next(),{"color":"green"},imgYes+" 真实姓名输入格式正确",true);
		}else{
			validateTip(userName.next(),{"color":"red"},imgNo+" 真实姓名不能为空，请重新输入",false);
		}
	});
	/*密码校验*/
	userPassword.on("focus",function(){
		validateTip(userPassword.next(),{"color":"#666666"},"* 请输入6-18位密码",false);
	}).on("blur",function(){
		if(userPassword.val() != null && userPassword.val() != ""){
			if(userPassword.val().length>=6&&userPassword.val().length<=18){
				validateTip(userPassword.next(),{"color":"green"},imgYes+" 密码输入格式正确",true);
			}else{
				validateTip(userPassword.next(),{"color":"red"},imgNo+" 密码应在6-18位",false);
			}
		}else{
			validateTip(userPassword.next(),{"color":"red"},imgNo+" 密码不能为空，请重新输入",false);
		}
	});
	/*重复密码校验*/
	reUserPassword.on("focus",function(){
		validateTip(reUserPassword.next(),{"color":"#666666"},"* 请再次输入相同密码",false);
	}).on("blur",function(){
		if(reUserPassword.val() != null && reUserPassword.val() != ""){
			if(userPassword.val()==reUserPassword.val()){
				validateTip(reUserPassword.next(),{"color":"green"},imgYes+" 重复密码输入格式正确",true);
			}else{
				validateTip(reUserPassword.next(),{"color":"red"},imgNo+" 密码输入不一致",false);
			}
		}else{
			validateTip(reUserPassword.next(),{"color":"red"},imgNo+" 重复密码不能为空，请重新输入",false);
		}
	});
	/*身份证校验*/
	userCard.on("focus",function(){
		validateTip(userCard.next(),{"color":"#666666"},"* 请输入您的身份证",false);
	}).on("blur",function(){
		if(userCard.val() != null && userCard.val() != ""){
			var patrn18=/^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
			var patrn15=/^[1-9]\d{5}\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{2}[0-9Xx]$/;
			if(userCard.val().match(patrn18)||userCard.val().match(patrn15)){
				validateTip(userCard.next(),{"color":"green"},imgYes+"身份证输入格式正确",true);
			}else{
				validateTip(userCard.next(),{"color":"red"},imgNo+" 身份证输入格式不正确(只限中国大陆)",false);
			}
		}else{
			validateTip(userCard.next(),{"color":"red"},imgNo+" 身份证不能为空，请重新输入",false);
		}
	});
	/*手机号码校验*/
	userPhone.on("focus",function(){
		validateTip(userPhone.next(),{"color":"#666666"},"* 请输入11位手机号",false);
	}).on("blur",function(){
		if(userPhone.val() != null && userPhone.val() != ""){
			var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
			if(userPhone.val().match(patrn)){
				validateTip(userPhone.next(),{"color":"green"},imgYes+" 手机号输入格式正确",true);
			}else{
				validateTip(userPhone.next(),{"color":"red"},imgNo + " 您输入的手机号格式不正确",false);
			}
		}else{
			validateTip(userPhone.next(),{"color":"red"},imgNo+" 手机号码不能为空，请重新输入",false);
		}
	});
	//表单验证
	addBtn.bind("click",function(){
		if(userCode.attr("validateStatus") != "true"){
			alert("用户名为空或输入错误！");
			userCode.blur();
		}else if(userName.attr("validateStatus") != "true"){
			alert("真实姓名为空或输入错误！");
			userName.blur();
		}else if(userPassword.attr("validateStatus") != "true"){
			alert("密码为空或输入错误！");
			userPassword.blur();
		}else if(reUserPassword.attr("validateStatus") != "true"){
			alert("重复密码为空或输入错误！");
			reUserPassword.blur();
		}else if(userCard.attr("validateStatus") != "true"){
			alert("身份证为空或输入错误！");
			userCard.blur();
		}else if(userPhone.attr("validateStatus") != "true"){
			alert("电话为空或输入错误！");
			userPhone.blur();
		}else{
			$("#registerForm").submit();
		}
	});
});

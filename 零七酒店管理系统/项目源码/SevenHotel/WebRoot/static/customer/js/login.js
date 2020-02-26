var userCode = null;
var userPassword = null;
var loginBtn=null;
var login_wrap=null;
var logo=null;

$(function(){
	userCode = $("#userCode");
	userPassword = $("#userPassword");
	loginBtn = $("#loginBtn");
	login_wrap=$(".login_wrap");
	logo=$(".logo");
	login_wrap.css({"background":"url('"+path+"/static/customer/images/logo_bg.jpg') no-repeat center"});
	logo.css({"background":"url('"+path+"/static/customer/images/logowz.png') no-repeat center"});
	/*登陆账号判空及ajax判断*/
	userCode.on("focus",function(){
		validateTip(userCode.next(),{"color":"#666666"},"* 请输入登入账号",false);
	}).on("blur",function(){
		if(userCode.val() != null && userCode.val() != ""){
			$.ajax({
				type:"GET",//请求类型
				url:path+"/user/userCodeExist",//请求的url
				data:{userCode:userCode.val()},//请求参数
				dataType:"json",//ajax接口（请求url）返回的数据类型
				success:function(data){//data：返回数据（json对象）
					if(data.userCode == "true"){
						validateTip(userCode.next(),{"color":"green"},imgYes+ " 该账号正确",true);
					}else if(data.userCode == "false"){
						validateTip(userCode.next(),{"color":"red"},imgNo+" 该账号不存在",false);
					}
				},
				error:function(data){//当访问时候，404，500 等非200的错误状态码
					validateTip(userCode.next(),{"color":"red"},imgNo+" 您访问的页面不存在",false);
				}
			});
		}else{
			validateTip(userCode.next(),{"color":"red"},imgNo+" 登入账号不能为空，请重新输入",false);
		}
	});
	/*密码判空*/
	userPassword.on("focus",function(){
		validateTip(userPassword.next(),{"color":"#666666"},"* 请输入密码",false);
	}).on("blur",function(){
		if(userPassword.val() != null && userPassword.val() != ""){
			validateTip(userPassword.next(),{"color":"green"},"",true);
		}else{
			validateTip(userPassword.next(),{"color":"red"},imgNo+" 密码不能为空，请重新输入",false);
		}
	});
	//表单验证
	loginBtn.bind("click",function(){
		if(userCode.attr("validateStatus") != "true"){
			userCode.blur();
			alert("用户名格式不正确 ");
		}else if(userPassword.attr("validateStatus") != "true"){
			userPassword.blur();
			alert("密码格式不正确");
		}else{
			$("#loginForm").submit();
		}
	});
});
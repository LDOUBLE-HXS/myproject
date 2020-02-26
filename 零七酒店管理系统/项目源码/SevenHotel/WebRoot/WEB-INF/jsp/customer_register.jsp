<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>注册界面</title>
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/customer/css/register.css" />
</head>
<body>
	<div class="wrap register_wrap">
		<div class="content">
			<div class="logo"></div>
			<div class="register_box">
				<div class="register_form">
					<div class="register_title">注册</div>
					<form action="${pageContext.request.contextPath }/user/doRegister" method="post" id="registerForm">
						<div class="form_text_ipt">
							<input id="userCode" name="userCode" type="text" placeholder="用户登陆名" value="${userCode}">
							<!-- 放置提示信息 -->
							<font color="red"></font>
						</div>
						<div class="form_text_ipt">
							<input id="userName" name="userName" type="text" placeholder="用户真实姓名" value="${userName}">
							<font color="red"></font>
						</div>
						<div class="form_text_ipt">
							<input id="userPassword" name="userPassword" type="password" placeholder="密码" value="${userPassword}">
							<font color="red"></font>
						</div>
						<div class="form_text_ipt">
							<input id="reUserPassword" name="reUserPassword" type="password" placeholder="重复密码" value="${reUserPassword}">
							<font color="red"></font>
						</div>
						<div class="form_text_ipt">
							<input id="userCard" name="userCard" type="text" placeholder="身份证号码" value="${userCard}">
							<font color="red"></font>
						</div>
						<div class="form_text_ipt">
							<input id="userPhone" name="userPhone" type="text" placeholder="手机号(方便酒店联系)" value="${userPhone}">
							<font color="red"></font>
						</div>
						<div class="form_btn">
							<button type="button" id="add">注册</button>
						</div>
						<div class="form_reg_btn">
							<span>已有帐号？</span><a href="${pageContext.request.contextPath }/user/login">马上登录</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
    <input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
    <script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/jquery-1.8.3.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/common.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/register.js"></script>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   	<title>登录界面</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath }/static/customer/css/login.css" />
	</head>
	<body>
		<div class="wrap login_wrap">
			<div class="content">
				<div class="logo"></div>
				<div class="login_box">	
					<div class="login_form">
						<div class="login_title">
							客户登录
						</div>
						<form action="${pageContext.request.contextPath }/user/doLogin" method="get" id="loginForm">
							<div class="info" style="color:red;font-size:20px;text-align: center;">${error}</div>
							<div class="form_text_ipt">
								<input id="userCode" name="userCode" type="text" placeholder="登录名" value="${userCode}">
								<!-- 放置提示信息 -->
								<font color="red"></font>
							</div>
							<div class="form_text_ipt">
								<input id="userPassword" name="userPassword" type="password" placeholder="密码" value="${userPassword}">
								<font color="red"></font>
							</div>
							<div class="form_btn">
								<button type="button" id="loginBtn">登录</button>
							</div>
							<div class="form_reg_btn">
								<span>还没有帐号？</span><a href="${pageContext.request.contextPath }/user/register">马上注册</a>
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
		<script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/login.js"></script>
  </body>
</html>

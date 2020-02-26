<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>后台登陆</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/login.css" />
</head>

<body>
	<div class="login_box">
		<div class="login_l_img">
			<img src="static/admin/images/login-background.png" />
		</div>
		<div class="login">
			<div class="login_logo">
				<a href="#"><img id="workPic" src="static/admin/images/login_logo.png" /></a>
			</div>
			<div class="login_name">
				<p>后台管理系统</p>
			</div>
			<div class="info" style="color:red;font-size:20px;text-align: center;">${error}</div>
			<form id="loginForm" method="post" action="${pageContext.request.contextPath }/manager/doLogin">
				<input id="manCode" name="manCode" type="text" placeholder="账号" value="${manCode }"/>
				<font color=red style="font-size: 16px;"></font>
				<input id="manPassword" name="manPassword" type="password" placeholder="密码" />
				<font color=red style="font-size: 16px;"></font>
				<input id="loginBtn" value="登录" style="width:100%;" type="button" >
			</form>
		</div>
		<div class="copyright">某某有限公司 版权所有©2016-2018 技术支持电话：000-00000000</div>
	</div>
</body>
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
<script src="${pageContext.request.contextPath }/static/admin/js/login.js"></script>
</html>

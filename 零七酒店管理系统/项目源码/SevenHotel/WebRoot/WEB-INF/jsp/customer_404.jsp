<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>404ERROR</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/customer/css/cmstop-error.css" media="all">
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body class="body-bg">
<div class="main">
    <p class="title">非常抱歉，您要查看的页面没有办法找到</p>
    <a href="${pageContext.request.contextPath }/room/main" class="btn">返回网站首页</a>
</div>
</body>
</html>

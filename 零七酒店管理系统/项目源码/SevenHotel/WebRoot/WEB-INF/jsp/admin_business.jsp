<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
   <title>流水统计</title>
   		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>流水统计</h2>
			<div class="cont_box" style="border-top:1px dashed #ddd;">
				<p class="business_tit">营业额详情表</p>
				<table border="0" cellspacing="0" cellpadding="0" class="table business_table">
					<tbody>
						<tr>
							<td>充值收入</td>
							<td>${memberBusiness }</td>
						</tr>
						<tr>
							<td>订单收入</td>
							<td>${orderBusiness}</td>
						</tr>
						<tr>
							<td>营业总额</td>
							<td>${memberBusiness+orderBusiness}</td>
						</tr>
					</tbody>
				</table>
				<p class="business_tit">营业额说明</p>
				<ul class="business_info">
					<li>营业总额 = 充值收入 + 订单收入</li>
					<li>会员卡开卡总数：<span>${memberCount }</span> 张</li>
				</ul>
				<p class="business_tit">会员卡详情表</p>
				<table border="0" cellspacing="0" cellpadding="0" class="table business_table">
					<tbody>
						<c:forEach var="member" items="${memberList }">
							<tr>
								<td>${member.memberType}</td>
								<td>${member.memberPrice}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
	</body>
</html>

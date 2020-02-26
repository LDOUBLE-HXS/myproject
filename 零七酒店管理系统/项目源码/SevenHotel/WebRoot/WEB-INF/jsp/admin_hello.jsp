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
    
    <title>欢迎页面</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<!--今日预约-->
		<div class="hello_box hello_order">
			<h2><span></span>未处理订单</h2>
			<div class="hello_info">
				<table border="0" cellspacing="0" cellpadding="0">
					<thead>
						<tr>
							<th>会员</th>
							<th>手机号</th>
							<th>房间类型</th>
							<th>结算金额</th>
							<th>订单时间</th>
							<th>订单状态</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="order" items="${orderList }">
						<tr>
							<td>${order.customer.userName }</td>
							<td>${order.customer.userPhone }</td>
							<td>${order.roomtype.roomTypeName }</td>
							<td>￥${order.roomtype.typePrice } RMB</td>
							<td><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/></td>
							<td>未处理</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!--技术支持-->
		<div class="hello_box hello_opera">
			<h2><span></span>联系零七科技</h2>
			<div class="hello_info">
				<ul>
					<li>
						<label>作品出处：</label>
						<span>T1707</span>
						<span>零七小组</span>
						<span>长沙理工大学继续教育学院</span>
					</li>
				</ul>
			</div>
		</div>
		<!--javascript include-->
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/main.js"></script>
		<script>
			$(function(){
				function box(){
					var bodyH = $("body").height(),
						bodyW = $("body").width(),
						boxL = parseInt($(".hello_box").css("margin-left"));
					$(".hello_order").css({"width":(parseInt(bodyW)-(boxL*3)-505),"height":parseInt(bodyH)-70});
					$(".hello_opera").css({"width":"445px","height":(parseInt(bodyH)-210)/3});
				};
				box();
			});
		</script>
	</body>
</html>

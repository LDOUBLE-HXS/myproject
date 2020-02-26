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
    
   <title>订单列表</title>
   		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>订单列表</h2>
			<form id="orderForm" action="${pageContext.request.contextPath }/manager/orderList" method="post">
				<span>真实姓名:</span>
				<input placeholder="通过用户的真实姓名查询" name="userName" class="input-text"	type="text" value="${userName }">
					<span>订单状态:</span>
					<select id="orderState" name="orderState">
						<option value="0">请选择</option>
						<option value="1" <c:if test="${orderState==1 }">selected="selected"</c:if>>已付款</option>
						<option value="2" <c:if test="${orderState==2 }">selected="selected"</c:if>>未付款</option>
						<option value="3" <c:if test="${orderState==3 }">selected="selected"</c:if>>订单过期</option>
						<option value="4" <c:if test="${orderState==4 }">selected="selected"</c:if>>已退单</option>
					</select>
					<input type="hidden" name="pageIndex" value="1"/>
					<input type="submit" value="搜索" class="btn blue_btn search"/>
			</form>
			<div class="cont_box">
				<table border="0" cellspacing="0" cellpadding="0" class="table">
				<thead>
					<tr>
						<th>订单号</th>
						<th>房间类型</th>
						<th>会员</th>
						<th>手机号</th>
						<th>订单状态</th>
						<th>开单日期</th>
						<th>金额</th>
						<th>订单备注</th>
						<th width="200">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="order" items="${orderList}">
					<tr>
						<td>${order.id}</td>
						<td>${order.roomtype.roomTypeName}</td>
						<td>${order.customer.userName}</td>
						<td>${order.customer.userPhone}</td>
						<c:choose>
							<c:when test="${order.orderState==1}">
								<td>已付款</td>
							</c:when>
							<c:when test="${order.orderState==2}">
								<td>未付款</td>
							</c:when>
							<c:when test="${order.orderState==3}">
								<td>订单过期</td>
							</c:when>
							<c:when test="${order.orderState==4}">
								<td>已退单</td>
							</c:when>
						</c:choose>
						<td><fmt:formatDate value="${order.orderTime}" pattern="yyyy-MM-dd"/></td>
						<td>￥ <font color="red">${order.settlement}</font> RMB</td>
						<c:choose>
							<c:when test="${order.orderDesc!=''&&order.orderDesc!=null}">
								<td style="white-space:normal;">${order.orderDesc}</td>
							</c:when>
							<c:otherwise>
								<td>无订单备注</td>
							</c:otherwise>
						</c:choose>
						<td width="200">
							<a class="viewOrder" style="color:white;background-color:#5BC0DE;padding:5px 10px" orderid="${order.id}" href="javascript:void(0);">
								<i class="fa fa-eye"></i>
								<span>订单详情</span>
							</a>
							<a class="delOrder" style="color:white;background-color:red;padding:5px 10px;margin-left:5px;" checkOutTime="${order.checkOutTime}" orderState="${order.orderState}" orderid="${order.id}" href="javascript:void(0);">
								<i class="fa fa-trash-o"></i>
								<span>删除订单</span>
							</a>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
			<input type="hidden" id="totalPageCount" value="${totalPageCount}"/>
		  	<c:import url="rollpage.jsp">
	          	<c:param name="totalCount" value="${totalCount}"/>
	          	<c:param name="currentPageNo" value="${currentPageNo}"/>
	          	<c:param name="totalPageCount" value="${totalPageCount}"/>
          	</c:import>
		</div>
		</div>
		<div id="selOrderDiv" style="display: none;">
			<ul>
				<li><label>订单编号:</label><span id="orderId"></span></li>
				<li><label>房间类型:</label><span id="roomTypeName"></span>&nbsp;&nbsp;&nbsp;&nbsp;<a id="roomA" href="javascript:;" style="color:red;">(查看图片)</a><img width="300px" height="200px" id="roomImg" src="" alt="房型图片"></li>
				<li><label>预定房间数:</label><span id="orderRoomNum"></span></li>
				<li><label>会员级别:</label><span id="memberLevel"></span></li>
				<li><label>会员名:</label><span id="userName"></span></li>
				<li><label>会员电话:</label><span id="userPhone"></span></li>
				<li><label>具体下单时间:</label><span id="orderTime"></span></li>
				<li><label>入住时间:</label><span id="checkInTime"></span></li>
				<li><label>离店时间:</label><span id="checkOutTime"></span></li>
				<li><label>支付方式:</label><span id="payForWay"></span></li>
				<li><label>总金额:</label>￥ <span style="color:red" id="totalPrice"></span> RMB</li>
			</ul>
		</div>
		<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/orderList.js"></script>
	</body>
</html>

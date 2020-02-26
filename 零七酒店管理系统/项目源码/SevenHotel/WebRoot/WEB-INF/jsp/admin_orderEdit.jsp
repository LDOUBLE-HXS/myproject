<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>订单处理</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/static/admin/css/style.css" />
</head>
<body>
	<div class="main_box">
		<h2>
			<span></span>订单处理
		</h2>
		<font style="margin-left:20px;" color="red">(红框显示的是已超过时间的订单,不支持退钱处理,退单收取10%手续费)</font>
		<div class="cont_box">
			<table border="0" cellspacing="0" cellpadding="0" class="table">
				<thead>
					<tr>
						<th>订单号</th>
						<th>房间类型</th>
						<th>会员</th>
						<th>手机号</th>
						<th>入住时间</th>
						<th>离店时间</th>
						<th>金额</th>
						<th>订单备注</th>
						<th width="200px">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orderList}">
						<c:choose>
							<c:when test="${order.orderRoomNum>1}">
								<c:forEach begin="1" end="${order.orderRoomNum}">
									<tr>
									<td>${order.id }</td>
									<td>${order.roomtype.roomTypeName}</td>
									<td>${order.customer.userName }</td>
									<td>${order.customer.userPhone }</td>
									<td><fmt:formatDate value="${order.checkInTime}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class="checkOutTime"><fmt:formatDate
											value="${order.checkOutTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>￥ <font color="red">${order.settlement }</font> RMB
									</td>
									<c:choose>
										<c:when test="${order.orderDesc!=''&&order.orderDesc!=null}">
											<td style="white-space:normal;">${order.orderDesc }</td>
										</c:when>
										<c:otherwise>
											<td>无订单备注</td>
										</c:otherwise>
									</c:choose>
									<td><a orderId="${order.id}"
										customerId="${order.customer.id}"
										roomTypeId="${order.roomtype.id}" href="javascript:void(0);"
										class="table_btn table_edit edit_btn"> <i
											class="fa fa-edit"></i> <span>办理入住</span>
									</a> <a orderId="${order.id}" href="javascript:void(0);"
										class="table_btn table_del del_btn"> <i
											class="fa fa-recycle"></i> <span>退单</span>
									</a></td>
								</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td>${order.id }</td>
									<td>${order.roomtype.roomTypeName}</td>
									<td>${order.customer.userName }</td>
									<td>${order.customer.userPhone }</td>
									<td><fmt:formatDate value="${order.checkInTime}"
											pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td class="checkOutTime"><fmt:formatDate
											value="${order.checkOutTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
									<td>￥ <font color="red">${order.settlement }</font> RMB
									</td>
									<c:choose>
										<c:when test="${order.orderDesc!=''&&order.orderDesc!=null}">
											<td style="white-space:normal;">${order.orderDesc }</td>
										</c:when>
										<c:otherwise>
											<td>无订单备注</td>
										</c:otherwise>
									</c:choose>
									<td><a orderId="${order.id}"
										customerId="${order.customer.id}"
										roomTypeId="${order.roomtype.id}" href="javascript:void(0);"
										class="table_btn table_edit edit_btn"> <i
											class="fa fa-edit"></i> <span>办理入住</span>
									</a> <a orderId="${order.id}" href="javascript:void(0);"
										class="table_btn table_del del_btn"> <i
											class="fa fa-recycle"></i> <span>退单</span>
									</a></td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!--javascript include-->
	<input type="hidden" id="path" name="path"
		value="${pageContext.request.contextPath }" />
	<input type="hidden" id="referer" name="referer"
		value="<%=request.getHeader("Referer")%>" />
	<script
		src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script>
	<!-- 表格插件 -->
	<script
		src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/admin/js/orderEdit.js"></script>
</body>
<div id="editOrderDiv">
	<ul>
		<li><label>订单编号:</label><span id="orderId"></span></li>
		<li><label>用户:</label><span id="customerId"></span></li>
		<li><label>所选房型:</label><span id="roomTypeId"></span></li>
		<li><label>选择房间:</label> <select id="room"></select></li>
	</ul>
</div>
</html>

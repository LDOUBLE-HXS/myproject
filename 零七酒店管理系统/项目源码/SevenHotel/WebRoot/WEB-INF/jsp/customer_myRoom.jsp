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

<title>订单列表</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/myRoom.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
</head>
<body>
	<div class="main_box">
	<form id="orderForm" style="display: none;"
			action="${pageContext.request.contextPath }/user/selMyCheckIn"
			method="post">
			 <input type="hidden" name="pageIndex" value="1" /> 
		</form>
		<div class="cont_box">
			<table border="0" cellspacing="0" cellpadding="0" class="table">
				<thead>
					<tr>
						<th>房间类型</th>
						<th>楼层</th>
						<th>房间号</th>
						<th>办理入住时间</th>
						<th>入住时间</th>
						<th>离店时间</th>
						<th>入住状态</th>
						<th width="200">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="checkIn" items="${checkInList}">
						<tr>
							<td>${checkIn.room.roomtype.roomTypeName}</td>
							<td>${checkIn.room.roomFloor}</td>
							<td>${checkIn.room.roomCode}</td>
							<td><fmt:formatDate value="${checkIn.editOrderTime}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${checkIn.order.checkInTime}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td class="checkOutTime"><fmt:formatDate value="${checkIn.order.checkOutTime}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<c:choose>
								<c:when test="${checkIn.checkState==1}">
									<td class="checkState">正在入住</td>
								</c:when>
								<c:otherwise>
									<td class="checkState">已离店</td>
								</c:otherwise>					
							</c:choose>
							<td width="200">
								<a class="addcomment" orderId="${checkIn.order.id }"
								style="color:white;background-color:orange;padding:5px 10px"
								checkInId="${checkIn.id}" href="javascript:void(0);"> <i
									class="fa fa-eye"></i> <span>填写评论</span>
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
	<!--javascript include-->
	<input type="hidden" id="path" name="path"
		value="${pageContext.request.contextPath }" />
	<input type="hidden" id="referer" name="referer"
		value="<%=request.getHeader("Referer")%>" />
	<script
		src="${pageContext.request.contextPath }/static/customer/js/jquery-2.1.4.min.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/customer/js/common.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/customer/js/myRoom.js"></script>
</body>
<div id="commentDiv">
	<ul>
		<li><label>满意度</label><div id="commentStar"></div></li>
		<li><label>评论内容</label><textarea id="commentContext" rows="3" cols="40" style="resize:none;"></textarea></li>
		<li><div id="drop_area"></div></li>
	</ul>
</div>
</html>

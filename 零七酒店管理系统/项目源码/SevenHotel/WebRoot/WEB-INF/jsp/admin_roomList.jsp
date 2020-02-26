<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
   <title>房间管理</title>
   		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>房间列表</h2>
			<div class="search_formbox clearfix">
				<button type="button" class="btn blue_btn addRoom">添加房间</button>
			</div>
			<div id="colorTips">
				<span>房间状态:</span><span id="checkInRoom"></span>已住<span id="vacantRoom"></span>空房<span id="repair"></span>维修
			</div>
			<div id="roomDiv">
				<c:forEach var="room" items="${roomList}">
					<c:choose>
						<c:when test="${room.roomState==2}">
							<div roomCode=${room.roomCode } roomId="${room.id}" style="background-color: #884797" class="roomCodeDiv"><span class="roomCode">${room.roomCode}</span><br><span class="roomType">${room.roomtype.roomTypeName }</span></div>
						</c:when>
						<c:when test="${room.roomState==1}">
							<div roomCode=${room.roomCode } roomId="${room.id}" class="roomCodeDiv"><span class="roomCode">${room.roomCode}</span><br><span class="roomType">${room.roomtype.roomTypeName }</span></div>
						</c:when>
					</c:choose>
					
				</c:forEach>
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
				<li><label>总金额:</label>￥ <span style="color:red" id="totalPrice"></span> RMB</li>
			</ul>
		</div>
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/roomList.js"></script>	
	</body>
	<div id="roomOpenDiv">
		<ul>
			<li>
				<label>房间号</label>
				<input type="text" id="roomCode" oninput="value=value.replace(/[^\d]/g,'')">
			</li>
			<li>
				<label>楼层</label>
				<input type="text" id="roomFloor">
			</li>
			<li>
				<label>房间状态</label>
				<select id="roomState">
					<option value="0">请选择</option>
					<option value="1">可用</option>
					<option value="2">维修</option>
				</select>
			</li>
			<li>
				<label>房间类型</label>
				<select id="roomType">
					<option value="0">请选择</option>
					<c:forEach var="roomType" items="${roomTypeList}">
						<option value="${roomType.id}">${roomType.roomTypeName}</option>
					</c:forEach>
				</select>
			</li>
		</ul>
	</div>
</html>

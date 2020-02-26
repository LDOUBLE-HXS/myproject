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
    
    <title>办理入住</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>办理入住</h2>
			<div class="cont_box">
				<ul class="addpro_box">
						<li>
							<label>会员账号:</label>
							<input type="text" id="userCode" placeholder="请输入会员账号">
							<font color=red style="font-size: 16px;"></font>
						</li>
						<li>
							<label>选择房间:</label>
							<select id="roomType" style="display: inline-block;">
								<option value="0">请选择</option>
								<c:forEach var="roomType" items="${roomTypeList}">
									<option typePrice="${roomType.typePrice}" value="${roomType.id}">${roomType.roomTypeName}</option>
								</c:forEach>
							</select>
							<select id="room" style="display: inline-block;">
								<option value="0">请选择</option>
							</select>
						</li>
						<li>
							<label>入住-离店时间:</label>
							<input readonly="readonly" type="text"
							class="layui-input" id="checkRangeTime">
						</li>
					</ul>
					<div class="probtn_box clearfix">
						<input type="button" value="办理入住" class="btn blue_btn addCheckIn"/>
					</div>
			</div>
		</div>
	<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/checkIn.js"></script>
	</body>
</html>

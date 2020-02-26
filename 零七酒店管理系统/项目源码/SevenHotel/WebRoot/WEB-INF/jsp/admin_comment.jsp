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
    
    <title>本店评论</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>评论列表</h2>
			<div class="cont_box">
					<table border="0" cellspacing="0" cellpadding="0" class="table" id="table_box">
					<thead>
						<tr>
							<th>评论编号</th>
							<th width="82px">评论图片</th>
							<th>房型</th>
							<th>评论用户</th>
							<th>评星</th>
							<th>内容</th>
							<th>评论日期</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="comment" items="${commentList }">
							<td>${comment.id }</td>
							<td><img width="150px" height="80px;" src="${pageContext.request.contextPath }/${comment.comImg }"></td>
							<td>${comment.order.roomtype.roomTypeName }</td>
							<td>${comment.order.customer.userCode }</td>
							<c:choose>
								<c:when test="${comment.comStar==1 }">
									<td>极差</td>
								</c:when>
								<c:when test="${comment.comStar==2 }">
									<td>差</td>
								</c:when>
								<c:when test="${comment.comStar==3 }">
									<td>中等</td>
								</c:when>
								<c:when test="${comment.comStar==4 }">
									<td>好</td>
								</c:when>
								<c:when test="${comment.comStar==5 }">
									<td>非常棒</td>
								</c:when>
							</c:choose>
							<td>${comment.comContext }</td>
							<td><fmt:formatDate value="${comment.comDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/comment.js"></script>
	</body>
	<div id="modifyManagerDiv"">
			<ul>
				<li><div id="drop_area"></div></li>
				<li><label>管理账号:</label><span id="manCode"></span></li>
				<li><label>员工姓名:</label><input type="text" id="manName"></li>
				<li><label>联系方式:</label><input type="text" id="manPhone" ></li>
				<li><label>性别:</label><span id="manSex"></span></li>
				<li>
					<label>职务:</label>
					<select id="position">
						<c:forEach var="position" items="${positionList}" begin="1">
							<option value="${position.id}">${position.positionType}</option>
						</c:forEach>
					</select>
				</li>
				<li><label>工资:</label><span id="salary"></span> RMB</li>
				<li><label>入职时间:</label><span id="creationDate"></span></li>
				<li>
					<label>上岗状态:</label>
					<select id="manState">
						<option value="1">在职</option>
						<option value="2">离职</option>
					</select>
				</li>
			</ul>
		</div>
</html>

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
    
    <title>添加员工</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
		<h2><span></span>添加员工</h2>
			<div class="cont_box">
					<ul class="addpro_box">
						<li>
							<label>上传工作照:</label>
						</li>
						<li >
							<div id="drop_area"></div>
						</li>
						<li>
							<label>员工账号：</label>
							<input type="text" style="width: 250px" placeholder="请输员工账号" id="manCode"/>
							<font color=red style="font-size: 16px;"></font>
						</li>
						<li>
							<label>姓名：</label>
							<input type="text" style="width: 250px" placeholder="请输员工姓名" id="manName"/>
						</li>
						<li>
							<label>手机号：</label>
							<input type="text" style="width: 250px" placeholder="请输入手机号" id="manPhone" oninput="value=value.replace(/[^\d]/g,'')"/>
						</li>
						<li>
							<label>性别：</label>
							<select id="manSex" style="width: 250px">
								<option value="0">请选择</option>
								<option value="2">男</option>
								<option value="1">女</option>
							</select>
						</li>
						<li>
							<label>岗位：</label>
							<select id="position" style="width: 250px">
								<option value="0">请选择所属岗位</option>
								<c:forEach var="position" items="${positionList}" begin="1">
									<option value="${position.id}">${position.positionType}</option>
								</c:forEach>
							</select>
						</li>
						<li style="line-height: 40px">
							<label>注:</label><font color="red">(员工初始密码都为1234567)</font>
						</li>
					</ul>
					<div class="probtn_box clearfix">
						<input type="button" value="添加员工" class="btn blue_btn addBtn"/>
					</div>
			</div>
		</div>
	<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/addManager.js"></script>
	</body>
</html>

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
    
    <title>本店员工</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>员工列表</h2>
			<div class="cont_box">
					<div class="search_formbox clearfix">
					<form action="${pageContext.request.contextPath }/manager/toManagerPage" method="post">
					<input type="submit" class="btn blue_btn" value="全部员工">
					</form>
					<form action="${pageContext.request.contextPath }/manager/toManagerPage" method="post">
					<input type="hidden" name="manState" value="1">
					<input type="submit" class="btn blue_btn" value="在职员工">
					</form>
					<form action="${pageContext.request.contextPath }/manager/toManagerPage" method="post">
					<input type="hidden" name="manState" value="2">
					<input type="submit" class="btn blue_btn" value="离职员工">
					</form>
					</div>
					
					<table border="0" cellspacing="0" cellpadding="0" class="table" id="table_box">
					<thead>
						<tr>
							<th>员工编号</th>
							<th width="82px">员工照</th>
							<th>姓名</th>
							<th>性别</th>
							<th>岗位</th>
							<th>电话</th>
							<th>录入时间</th>
							<th>状态</th>
							<th width="268">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="manager" items="${managerList }">
						<tr>
							<td>${manager.id }</td>
							<th><img src="${manager.workPicPath }" width="82px" height="82px" alt="工作照"></th>
							<td>${manager.manName }</td>
							<c:choose>
								<c:when test="${manager.manSex==1}">
									<td>女</td>
								</c:when>
								<c:otherwise>
									<td>男</td>
								</c:otherwise>
							</c:choose>
							<td>${manager.position.positionType }</td>
							<td>${manager.manPhone }</td>
							<td><fmt:formatDate value="${manager.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<c:choose>
								<c:when test="${manager.manState==1}">
									<td>在岗</td>
								</c:when>
								<c:otherwise>
									<td>离职</td>
								</c:otherwise>
							</c:choose>
							
							<td>
								<a manId="${manager.id }" href="javascript:void(0);" class="table_btn table_edit edit_btn">
									<i class="fa fa-edit"></i>
									<span>编辑</span>
								</a>
								<a manId="${manager.id }" href="javascript:void(0);" style="background-color:red" class="table_btn table_info del_btn">
									<i class="fa fa-trash-o"></i>
									<span>删除记录</span>
								</a>
							</td>
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
		<script src="${pageContext.request.contextPath }/static/admin/js/managerList.js"></script>
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

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>房间分类管理</title>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>房间分类管理</h2>
			<div class="search_formbox clearfix">
				<button type="button" class="btn blue_btn addRoomType">添加房间类型</button>
			</div>
			<div class="cont_box">
				<table border="0" cellspacing="0" cellpadding="0" class="table" >
				<thead>
					<tr>
						<th>类型编号</th>
						<th>图片</th>
						<th>房间类型名称</th>
						<th>房间简介</th>
						<th>房间详情</th>
						<th>房间价格</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${roomTypeList}" var="roomType">
					<tr>	
						<td>${roomType.id}</td>					
						<td><img alt="房间图片" src="${roomType.roomImg}" style="width:100px;height: auto;padding-left: 10px"></td>
						<td>${roomType.roomTypeName}</td>
						<td>${roomType.sketch}</td>	
						<td><div style="width: 350px;overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">${roomType.describe}</div></td>	
						<td>￥<font color="red">${roomType.typePrice}</font> RMB</td>				
						<td>
							<a roomTypeId="${roomType.id}" href="javascript:void(0);" class="table_btn table_edit edit_btn">
								<i class="fa fa-edit"></i>
								<span>编辑</span>
							</a>
							<a roomTypeId="${roomType.id}" href="javascript:void(0);" class="table_btn table_del del_btn">
								<i class="fa fa-trash-o"></i>
								<span>删除</span>
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
		<script src="${pageContext.request.contextPath }/static/admin/js/roomTypeList.js"></script>
	</body>
	<div id="roomTypeDiv">
		<ul>
				<li>
					<div id="drop_area"></div>
				</li>
				<li>
					<label>房间类型名称</label>
					<input type="text" id="roomTypeNameModify">
				</li>
				<li>
					<label>房间简介</label>
					<input type="text" id="sketchModify">
				</li>
				<li>
					<label>房间价格</label>
					<input type="text" id="typePriceModify" oninput="value=value.replace(/[^\d]/g,'')">
				</li>
				<li>
					<label>房间详情</label>
					<textarea style="resize:none;" rows="5" cols="20" id="describeModify"></textarea>
				</li>
			</ul>
	</div>
</html>

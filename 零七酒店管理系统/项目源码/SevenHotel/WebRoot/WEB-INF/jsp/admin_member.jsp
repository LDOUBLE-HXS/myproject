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
    
    <title>会员福利</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>会员福利</h2>
			<div style="height: 50px;">
				<input type="button" value="添加福利" id="addMemberbutton">
			</div>
				<div class="cont_box">
				<table border="0" cellspacing="0" cellpadding="0" class="table" id="table_box">
				<thead>
					<tr>
						<th style="text-align: center;">编号</th>
						<th style="text-align: center;">会员等级</th>
						<th style="text-align: center;">会员折扣</th>
						<th style="text-align: center;" width="100">创建者</th>
						<th style="text-align: center;">创建时间</th>
						<th style="text-align: center;" width="100">修改者</th>
						<th style="text-align: center;">修改时间</th>
						<th style="text-align: center;" width="200">操作</th>
					</tr>
				</thead>
				<tbody>
				 <c:forEach var="member" items="${memberList}">
					<tr>
						<td style="text-align: center;">${member.id}</td>
						<td style="text-align: center;">${member.memberType}</td>
						<c:choose>
							<c:when test="${member.discount==1.00}">
								<td style="text-align: center;">无折扣</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;">${member.discount}</td>
							</c:otherwise>
						</c:choose>
						<td class="createBy" style="text-align: center;">${member.createdBy}</td>
						<td style="text-align: center;"><fmt:formatDate value="${member.creationDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<c:choose>
							<c:when test="${member.modifyBy!=0}">
								<td class="modifyBy" style="text-align: center;">${member.modifyBy}</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;">无</td>
							</c:otherwise>
						</c:choose>
						<c:choose>
							<c:when test="${member.modifyDate!=null}">
								<td style="text-align: center;"><fmt:formatDate value="${member.modifyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center;">无</td>
							</c:otherwise>
						</c:choose>
						
						<td style="text-align: center;">
						<span><a style="margin:0px 5px" class="modifyMember" href="javascript:;" memberid=${member.id } ><img src="${pageContext.request.contextPath }/static/admin/images/xiugai.png" alt="修改" title="修改"/></a></span>
						<span><a class="deleteMember" href="javascript:;" memberid=${member.id } ><img src="${pageContext.request.contextPath }/static/admin/images/schu.png" alt="删除" title="删除"/></a></span>
						</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
		</div>
		<div id="addMemberDiv" style="display: none;">
			<ul>
			<li><label>会员等级：</label> <input type="text"
				placeholder="请输入会员等级"  id="userMemberTypeInput" /></li>
			<li><label>会员折扣：</label>  
				<select id="discountSelect" style="width: 180px;">
					<option value="0">--请选择--</option>
					<option value="1.00">无折扣</option>
					<option value="0.95">0.95</option>
					<option value="0.90">0.90</option>
					<option value="0.85">0.85</option>
					<option value="0.80">0.80</option>
					<option value="0.75">0.75</option>
					<option value="0.70">0.70</option>
					<option value="0.65">0.65</option>
					<option value="0.60">0.60</option>
					<option value="0.55">0.55</option>
					<option value="0.50">0.50</option>
	        	</select>
	        </li>
			</ul>
		</div>
		<div id="modifyMember" style="display: none;">
			<ul>
			<li><label>会员等级：</label> <input type="text"
				placeholder="请输入会员等级"  id="userMemberType" /></li>
			<li><label>会员折扣：</label>  
				<select id="discount" style="width: 180px;">
					<option value="0">请选择</option>
					<option value="1.00">无折扣</option>
					<option value="0.95">0.95</option>
					<option value="0.90">0.90</option>
					<option value="0.85">0.85</option>
					<option value="0.80">0.80</option>
					<option value="0.75">0.75</option>
					<option value="0.70">0.70</option>
					<option value="0.65">0.65</option>
					<option value="0.60">0.60</option>
					<option value="0.55">0.55</option>
					<option value="0.50">0.50</option>
	        	</select>
	        </li>
			</ul>
		</div>
		<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/member.js"></script>
	</body>
</html>

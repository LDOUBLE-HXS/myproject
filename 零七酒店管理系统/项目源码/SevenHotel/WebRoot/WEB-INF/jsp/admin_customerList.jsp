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
    
    <title>本店会员</title>
    	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>本店会员</h2>
			<form id="userListForm" method="post" action="${pageContext.request.contextPath }/manager/customerList">
					 <span>姓名：</span>
					 <input placeholder="通过用户的真实姓名查询" name="userName" class="input-text"	type="text" value="${userName }">
					 <span>会员等级：</span>
					 <select name="userMemberId">
						<c:if test="${memberList != null }">
						   <option value="0">--请选择--</option>
						   <c:forEach var="member" items="${memberList}">
						   		<option <c:if test="${member.id==usermemberId }">selected="selected"</c:if> value="${member.id}">${member.memberType}</option>
						   </c:forEach>
						</c:if>
	        		</select>
					 <input type="hidden" name="pageIndex" value="1"/>
					 <input	value="查 询" type="submit" id="searchbutton">
				</form>
			<div class="cont_box">
				<table border="0" cellspacing="0" cellpadding="0" class="table" id="table_box">
				<thead>
					<tr>
						<th style="text-align: center;">会员账号</th>
						<th style="text-align: center;">真实姓名</th>
						<th style="text-align: center;">手机号</th>
						<th style="text-align: center;">身份证号</th>
						<th style="text-align: center;">注册日期</th>
						<th style="text-align: center;">会员等级</th>
						<th style="text-align: center;">会员积分</th>
						<th style="text-align: center;" width="200">操作</th>
					</tr>
				</thead>
				<tbody>
				 <c:forEach var="customer" items="${customerList}">
					<tr>
						<td style="text-align: center;">${customer.userCode }</td>
						<td style="text-align: center;">${customer.userName }</td>
						<td style="text-align: center;">${customer.userPhone }</td>
						<td style="text-align: center;">${customer.userCard }</td>
						<td style="text-align: center;"><fmt:formatDate value="${customer.creationDate }" pattern="yyyy-MM-dd"/></td>
						<td style="text-align: center;">${customer.member.memberType }</td>
						<td style="text-align: center;">${customer.integral }</td>
						<td style="text-align: center;">
						<span><a class="viewCustomer" href="javascript:;" customerid=${customer.id } username=${customer.userName }><img src="${pageContext.request.contextPath }/static/admin/images/read.png" alt="查看" title="查看"/></a></span>
						<span><a class="modifyCustomer" href="javascript:;" customerid=${customer.id } username=${customer.userName }><img src="${pageContext.request.contextPath }/static/admin/images/xiugai.png" alt="修改" title="修改"/></a></span>
						<span><a class="deleteCustomer" href="javascript:;" customerid=${customer.id } username=${customer.userName }><img src="${pageContext.request.contextPath }/static/admin/images/schu.png" alt="删除" title="删除"/></a></span>
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
		<div id="selCustomerDiv" style="display: none;">
			<ul>
				<li><label>账号:</label><span id="userCodeSpan"></span></li>
				<li><label>真实姓名:</label><span id="userNameSpan"></span></li>
				<li><label>电话:</label><span id="userPhoneSpan"></span></li>
				<li><label>身份证:</label><span id="userCardSpan"></span></li>
				<li><label>绑卡银行:</label><span id="bankNameSpan"></span></li>
				<li><label>注册日期:</label><span id="creationDateSpan"></span></li>
				<li><label>会员等级:</label><span id="userMemberSpan"></span></li>
				<li><label>会员积分:</label><span id="integralSpan"></span></li>
			</ul>
		</div>
	<div id="modifyCustomerDiv" style="display: none;">
		<ul>
			<li><label>账号：</label> <input type="text"
				placeholder="请输入会员登陆账号"  id="userCodeInput" /> <font
				color=red style="font-size: 16px;"></font></li>
			<li><label>真实姓名：</label> <input type="text"
				placeholder="请输入会员真实姓名"  id="userNameInput" /></li>
			<li><label>手机号：</label> <input type="text"
				placeholder="请输入会员手机号码"  id="userPhoneInput" /></li>
			<li><label>身份证号：</label> <input type="text"
				placeholder="请输入身份证号码"  id="userCardInput" /></li>
			<li><label>会员等级：</label> <select
				id="userMemberIdInput" style="width: auto;">
					<option value="0">--请选择--</option>
					<c:forEach var="member" items="${memberList}">
						<option value="${member.id}">${member.memberType}</option>
					</c:forEach>
			</select></li>
			<li><label>会员积分：</label> <input type="text"
				placeholder="请输入会员所持初始积分"  id="integralInput"
				oninput="value=value.replace(/[^\d]/g,'')"
				 /></li>
		</ul>
	</div>
	<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery.dataTables.min.js"></script><!-- 表格插件 -->
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/customerList.js"></script>
	</body>
</html>

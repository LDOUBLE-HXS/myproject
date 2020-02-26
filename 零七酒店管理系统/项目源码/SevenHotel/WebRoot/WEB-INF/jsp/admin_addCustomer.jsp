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
    
   <title>添加会员</title>
   		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
	</head>
	<body>
		<div class="main_box">
			<h2><span></span>添加会员</h2>
			<div class="cont_box">
				<form id="addCustomerForm" action="${pageContext.request.contextPath }/manager/doAddCustomer" method="post" >
					<ul class="addpro_box adduser_box">
						<li>
							<label>账号：</label>
							<input type="text" placeholder="请输入会员登陆账号" name="userCode" id="userCode"  />
							<font color=red style="font-size: 16px;"></font>
						</li>
						<li>
							<label>真实姓名：</label>
							<input type="text" placeholder="请输入会员真实姓名" name="userName" id="userName"  />
						</li>
						<li>
							<label>手机号：</label>
							<input type="text" placeholder="请输入会员手机号码" name="userPhone" id="userPhone" />
						</li>
						<li>
							<label>身份证号：</label>
							<input type="text" placeholder="请输入身份证号码" name="userCard" id="userCard" />
						</li>
						<li>
							<label>会员等级：</label>
						<select name="userMemberId" id="userMemberId" style="width: 255px;">
						   <option value="0">请选择</option>
						   <c:forEach var="member" items="${memberList}">
						   		<option value="${member.id}">${member.memberType}</option>
						   </c:forEach>
	        			</select>
						</li>
						<li>
							<label>会员积分：</label>
							<input type="text" placeholder="请输入会员所持初始积分" name="integral" id="integral" oninput="value=value.replace(/[^\d]/g,'')" required data-rule-isCarNo="true"/>
						</li>
						<li>
							<font style="color:red;margin-left: 30px;">温馨提示：添加会员的初始密码都为123456</font>
						</li>
					</ul>
					<div class="probtn_box clearfix">
						<input id="addBtn" type="button" value="添加会员" class="btn blue_btn"/>
					</div>
				</form>
			</div>
		</div>
		<!--javascript include-->
		<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
		<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
		<script src="${pageContext.request.contextPath }/static/admin/js/addCustomer.js"></script>
		<%-- <script src="${pageContext.request.contextPath }/static/admin/js/jquery.form.min.js"></script><!-- 异步提交表单 --> --%>
		<%-- <script src="${pageContext.request.contextPath }/static/admin/js/jquery.cxselect.min.js"></script> --%><!-- 多级下拉框 -->
	</body>
</html>

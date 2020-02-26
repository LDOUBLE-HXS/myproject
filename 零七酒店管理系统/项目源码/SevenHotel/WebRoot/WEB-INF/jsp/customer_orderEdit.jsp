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

<title>支付订单</title>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css" />
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/order.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
</head>
<body>
	<div class="main_box">
		<div class="cont_box">
			<table border="0" cellspacing="0" cellpadding="0" class="table">
				<thead>
					<tr>
						<th>订单号</th>
						<th>房间类型</th>
						<th>房间数量</th>
						<th>订单状态</th>
						<th>开单日期</th>
						<th>入住日期</th>
						<th>离开日期</th>
						<th>金额</th>
						<th>订单剩余支付时间</th>
						<th width="200">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="order" items="${orderList}">
							<tr>
							<td>${order.id}</td>
							<td class="roomTypeName">${order.roomtype.roomTypeName}</td>
							<td>${order.orderRoomNum}</td>
							<c:choose>
								<c:when test="${order.orderState==1}">
									<td class="orderStateTd">已付款</td>
								</c:when>
								<c:when test="${order.orderState==2}">
									<td class="orderStateTd">未付款</td>
								</c:when>
								<c:when test="${order.orderState==3}">
									<td class="orderStateTd">订单过期</td>
								</c:when>
								<c:when test="${order.orderState==4}">
									<td class="orderStateTd">已退单</td>
								</c:when>
							</c:choose>
							<td class="orderTime"><fmt:formatDate value="${order.orderTime}"
									pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td><fmt:formatDate value="${order.checkInTime}"
									pattern="yyyy-MM-dd" /></td>
							<td><fmt:formatDate value="${order.checkOutTime}"
									pattern="yyyy-MM-dd" /></td>
							<td class="totalPrice">￥ <font color="red">${order.settlement}</font> RMB
							</td>
							<td class="payForTime">
							<!-- 倒计时 -->
							<div class="time-item">
    							<strong class="minute_show">00分</strong>
    							<strong class="second_show">00秒</strong>
							</div>
							</td>
							<td class="payForOrderTd" width="200">
							<a class="payForOrder"
								style="color:white;background-color:#5BC0DE;padding:5px 10px"
								orderid="${order.id}" href="javascript:void(0);"> <i
									class="fa fa-eye"></i> <span>支付订单</span>
							</a>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
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
		src="${pageContext.request.contextPath }/static/customer/js/orderEdit.js"></script>
</body>
<!-- 支付界面 -->
<div id="payFor" style="display: none;">
	<div class="wenx_xx">
        <div class="mz"><h3>零七酒店住宿</h3></div>
        <div class="zhifu_price"></div></div>
    <a href="javascript:void(0);" class="ljzf_but all_w">立即支付</a>
    <div class="ftc_wzsf">
        <div class="srzfmm_box">
            <div class="qsrzfmm_bt clear_wl">
                <img src="static/customer/images/xx_03.jpg" class="tx close fl">
                <img src="static/customer/images/jftc_03.png" class="tx fl">
                <span class="fl">请输入支付密码</span></div>
            <div class="zfmmxx_shop">
                <div class="mz"></div>
                <div class="zhifu_price"></div></div>
            <ul class="mm_box">
                <li></li><li></li><li></li><li></li><li></li><li></li>
            </ul>
        </div>
        <div class="numb_box">
            <div class="xiaq_tb">
                <img src="static/customer/images/jftc_14.jpg" height="10"></div>
            <ul class="nub_ggg">
                <li><a href="javascript:void(0);" class="zf_num">1</a></li>
                <li><a href="javascript:void(0);" class="zj_x zf_num">2</a></li>
                <li><a href="javascript:void(0);" class="zf_num">3</a></li>
                <li><a href="javascript:void(0);" class="zf_num">4</a></li>
                <li><a href="javascript:void(0);" class="zj_x zf_num">5</a></li>
                <li><a href="javascript:void(0);" class="zf_num">6</a></li>
                <li><a href="javascript:void(0);" class="zf_num">7</a></li>
                <li><a href="javascript:void(0);" class="zj_x zf_num">8</a></li>
                <li><a href="javascript:void(0);" class="zf_num">9</a></li>
                <li><a href="javascript:void(0);" class="zf_empty">清空</a></li>
                <li><a href="javascript:void(0);" class="zj_x zf_num">0</a></li>
                <li><a href="javascript:void(0);" class="zf_del">删除</a></li>
            </ul>
        </div>
        <div class="hbbj"></div>
    </div>
</div>
</html>

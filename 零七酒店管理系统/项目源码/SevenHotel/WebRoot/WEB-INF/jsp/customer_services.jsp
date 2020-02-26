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
    
    <title>服务中心</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">	
	<style type="text/css">
	.icons {
	background-position: -30px -180px;
    display: inline-block;
    vertical-align: middle;
    margin-right: 8px;
    width: 21px;
    height: 21px;
    background-image: url(static/customer/images/icon_facility.png);
    background-repeat: no-repeat;

}
	</style>
	<!-- layui -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<!-- Stylesheets -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/superfish.css">
<!-- Date Picker -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/bootstrap-datepicker.min.css">
<!-- CS Select -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/cs-select.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/cs-skin-border.css">
<!-- Themify Icons -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/themify-icons.css">
<!-- Flat Icon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/flaticon.css">
<!-- Icomoon -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/icomoon.css">
<!-- Flexslider  -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/flexslider.css">
<!-- Style -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/customer/css/style.css">
<!-- Modernizr JS -->
<script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/modernizr-2.6.2.min.js"></script>
	
  </head>
  
  <body>
   <div id="fh5co-wrapper">
	<div id="fh5co-page">
		<div id="fh5co-header">
				<header id="fh5co-header-section">
				<div class="container">
					<div class="nav-header">
						<a href="javaScript:;" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
						<h1 id="fh5co-logo">
							<a href="${pageContext.request.contextPath }/user/main">SevenHotel</a>
						</h1>
						<nav id="fh5co-menu-wrap" role="navigation">
						<ul class="sf-menu" id="fh5co-primary-menu">
							<li><a href="${pageContext.request.contextPath }/user/main">主页</a></li>
							<li><c:choose>
									<c:when test="${userSession.userName!=null}">
										<a customerId="${userSession.id}" id="loginName" href="javascript:;">${userSession.userName}</a>
										<ul class="fh5co-sub-menu">
											<li><a href="javascript:;">个人中心</a>
												<ul class="fh5co-sub-menu">
													<li><a href="javascript:;" id="selInformation">查看个人信息</a></li>
													<li><a href="javascript:;" id="modifyInformation">修改个人信息</a></li>
													<li><a href="javascript:;" id="modifyPassword">修改密码</a></li>
													<li><a href="javascript:;" id="selMyComment">我的评论</a></li>
												</ul></li>
											<li><a href="javascript:;" target="_blank">客房中心</a>
												<ul class="fh5co-sub-menu">
													<li><a id="selMyRoom" href="javascript:;">入房查询</a></li>
												</ul></li>
											<li><a href="javascript:;">订单中心</a>
												<ul class="fh5co-sub-menu">
													<li><a href="javascript:;" id="selReserve">查看订单</a></li>
													<li><a href="javascript:;" id="payForOrder">支付订单</a></li>
												</ul></li>
												<c:choose>
													<c:when test="${userSession.bank.bankName!=null}">
														<li><a class="Card" href="javascript:;">${userSession.bank.bankName}</a>
															<ul class="fh5co-sub-menu">
																<li><a href="javascript:;" id="selBank">银行卡信息</a></li>
															</ul></li>
													</c:when>
													<c:otherwise>
														<li><a class="Card" id="bindCard" href="javascript:;">绑卡</a></li>
													</c:otherwise>
												</c:choose>
											<li><a
												href="${pageContext.request.contextPath }/user/signOut">退出</a></li>
										</ul>
									</c:when>
									<c:otherwise>
										<a id="loginName" href="${pageContext.request.contextPath }/user/login">登陆</a>
									</c:otherwise>
								</c:choose></li>
							<li><a href="javascript:;" class="fh5co-sub-ddown">客房</a>
								<ul class="fh5co-sub-menu">
									<li><a href="javascript:;">标准套间</a>
										<ul class="fh5co-sub-menu">
											<c:forEach items="${BZRoom}" var="RoomType">
												<li><a href="javascript:;" class="roomClick"
													id="${RoomType.id}">${RoomType.roomTypeName}</a></li>
											</c:forEach>
										</ul></li>
									<li><a href="javascript:;">豪华套间</a>
										<ul class="fh5co-sub-menu">
											<c:forEach items="${HHRoom}" var="RoomType">
												<li><a href="javascript:;" class="roomClick"
													id="${RoomType.id}">${RoomType.roomTypeName}</a></li>
											</c:forEach>
										</ul></li>
									<c:forEach items="${OtherRoom}" var="RoomType">
										<li><a href="javascript:;" class="roomClick"
											id="${RoomType.id}">${RoomType.roomTypeName}</a></li>
									</c:forEach>
								</ul></li>
							<li><a id="memberWelfare" href="javascript:;">会员福利</a>
								<ul class="fh5co-sub-menu">
									<!-- 客户有会员的话只能升级会员 -->
									<c:choose>
										<c:when test="${userSession==null}">
											<c:forEach var="member" begin="1" items="${memberList}">
												<li><a memberId=${member.id } class="member" href="javascript:;"><span class="memberType">${member.memberType}卡</span><span class="discount">(享受折扣:${member.discount}折<span class="memberPrice">${member.memberPrice }</span> RMB)</span></a></li>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach var="member" begin="${userSession.member.id}" items="${memberList}">
												<li><a memberId=${member.id } class="member" href="javascript:;"><span class="memberType">${member.memberType}卡</span><span class="discount">(享受折扣:${member.discount}折<span class="memberPrice">${member.memberPrice }</span> RMB)</span></a></li>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</ul>
							</li>
							<li><a href="${pageContext.request.contextPath}/user/services">服务</a></li>
							<li><a href="${pageContext.request.contextPath}/user/blog">博客</a></li>
						</ul>
						</nav>
					</div>
				</div>
				</header>

			</div>
	<!-- end:fh5co-header -->
	<div class="fh5co-parallax" style="background-image: url(static/customer/images/slider2.jpg);" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 col-sm-12 col-sm-offset-0 col-xs-12 col-xs-offset-0 text-center fh5co-table">
					<div class="fh5co-intro fh5co-table-cell">
						<h1 class="text-center">我们提供服务</h1>
						<p>由优秀的人们用爱制作 <a href="http://"></a></p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="fh5co-services-section">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<div class="services">
						<span><i class="ti-location-pin"></i></span>
						<div class="desc">
							<h3>无障碍位置</h3>
							<p>地处长沙CPD和CBD黄金地段，政治、经济、文化中心，为湖南白金高星级花园式酒店。酒店拥有华南地区较大的市政花园广场，草木掩映、绿茵缤纷。</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="services">
						<span><i class="ti-alarm-clock"></i></span>
						<div class="desc">
							<h3>全天候开放</h3>
							<p>
							<i class="icons"></i>会议室<br>
							<i class="icons"></i>健身室<br>
							<i class="icons"></i>酒吧<br>
							<i class="icons"></i>餐厅
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="services">
						<span><i class="ti-calendar"></i></span>
						<div class="desc">
							<h3>我们的设施</h3>
							<p>酒店设施设备配备齐全，拥有四百余间精美客房，空间宽广、舒适，奢华却不失温馨，处处充满了细心关怀，是享受休闲浪漫时光的欢乐场所。</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="services">
						<span><i class="ti-alarm-clock"></i></span>
						<div class="desc">
							<h3>免费WIFI</h3>
							<p>
							<i class="icons"></i>客房WIFI免费<br>
							<i class="icons"></i>房间内高速上网<br>
							<i class="icons"></i>公共区WIFI免费<br>
							<i class="icons"></i>随时随地畅享WIFI 
							</p>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="services">
						<span><i class="ti-signal"></i></span>
						<div class="desc">
							<h3>我们的宣言</h3>
							<p>遥远的地方，远离Vokalia和Consonantia等国家的山脉背后，有盲文。他们分开居住在Bookmarksgrove，就在Semantics海岸，一个大型语言海洋。</p>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>
<footer id="footer" class="fh5co-bg-color">
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<div class="copyright">
							<p>
								<small>Copyright &copy; 2019.Company name All rights
									reserved. 
							</p>
						</div>
					</div>
					<div class="col-md-6">
						<div class="row">
							<div class="col-md-3">
								<h3>快速链接</h3>
								<ul class="link">
									<li><a href="">关于我们</a></li>
									<li><a
										href="${pageContext.request.contextPath }/user/main">酒店</a></li>
									<li><a href="javaScript:;">客户服务</a></li>
									<li><a href="javaScript:;">联系我们</a></li>
								</ul>
							</div>
							<div class="col-md-3">
								<h3>我们的设施</h3>
								<ul class="link">
									<li><a href="javaScript:;">餐厅</a></li>
									<li><a href="javaScript:;">酒吧</a></li>
									<li><a href="javaScript:;">会议</a></li>
									<li><a href="javaScript:;">游泳池</a></li>
									<li><a href="javaScript:;">水疗</a></li>
									<li><a href="javaScript:;">健身房</a></li>
								</ul>
							</div>
							<div class="col-md-6">
								<h3>体验</h3>
								<p>但当然，始终处于核心。Mauris杂色山雀，大和免费的热身。</p>
								<form action="javaScript:;" id="form-subscribe">
									<div class="form-field">
										<input type="email" placeholder="Email Address" id="email">
										<input type="submit" id="submit" value="Send">
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<ul class="social-icons">
							<li><a href="javaScript:;"><i class="icon-twitter-with-circle"></i></a>
								<a href="javaScript:;"><i class="icon-facebook-with-circle"></i></a> <a
								href="javaScript:;"><i class="icon-instagram-with-circle"></i></a> <a
								href="javaScript:;"><i class="icon-linkedin-with-circle"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
			</footer>
	</div>
	<!-- END fh5co-page -->
	</div>
	<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
	<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>  
	<!-- Javascripts -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/jquery-2.1.4.min.js"></script>
	<!-- Dropdown Menu -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/hoverIntent.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/superfish.js"></script>
	<!-- Waypoints -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/jquery.waypoints.min.js"></script>
	<!-- Counters -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/jquery.countTo.js"></script>
	<!-- Stellar Parallax -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/jquery.stellar.min.js"></script>
	<!-- Owl Slider -->
	<!-- Date Picker -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/bootstrap-datepicker.min.js"></script>
	<!-- CS Select -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/classie.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/selectFx.js"></script>
	<!-- Flexslider -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/jquery.flexslider-min.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/custom.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/common.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/static/customer/js/main.js"></script>
	</body>
	<div id="modifyPasswordDiv" style="display: none;">
	<form id="modifyPasswordForm"
		action="${pageContext.request.contextPath }/user/modifyPassword"
		method="post">
		<table style="margin:20px 40px;">
			<tr>
				<td style="padding: 10px">原密码:</td>
				<td style="padding: 10px"><input id="oldUserPassword"
					name="oldUserPassword" type="password"><font color="red"></font></td>
			</tr>
			<td style="padding: 10px">修改密码:</td>
			<td style="padding: 10px"><input id="userPassword"
				name="userPassword" type="password"><font color="red"></font></td>
			</tr>
			</tr>
			<td style="padding: 10px">确认密码:</td>
			<td style="padding: 10px"><input id="userPasswordAgain"
				name="userPasswordAgain" type="password"><font color="red"></font></td>
			</tr>
		</table>
	</form>
</div>
<!-- 预定房间 -->
<div id="roomDetail" style="display: none;">
	<img id="roomTypeImg" width="273px" height="210px" alt="房间图片"
		src="">
	<div id="roomType">
		<h3 id="roomTypeNameH3"></h3>(房间单价:<span id="roomUnitPrice"></span>&nbsp;RMB)<br>(剩余房数:<span id="roomSurplus"></span>&nbsp;间)<br>
		<div id="roomTime">
			<label>入住-离开时间:</label> <input readonly="readonly" type="text"
				class="layui-input" id="checkRangeTime">
		</div>
		<div id="roomNum">
			<label>房间数量:</label><input class="sdddq" id="inp" readonly="readonly">
		</div>
		<div id="roomDesc">
			<label>备注:</label><br>
			<textarea rows="3" cols="30" style="resize:none;"></textarea>
		</div>
		<a style="margin-right:10px" id="roomDesc_a">房型详情</a> <a id="roomRule">预定规则</a>
	</div>
	<div id="roomPrice">
		<p><font style="color:gray;font-size: 16px;font-weight: bolder;">房费总计:</font>￥<span id="totalPrice"></span>&nbsp;RMB<br><a href="javaScript:;" id="priceDec">(费用明细)</a></p>
		<br> <br> <br><br> <br> <br> <br><br> <br> <br>
		<button id="reserveBtn">预定</button>
	</div>
</div>
<!-- 绑定银行卡 -->
<div id="bindCardDiv" style="display: none">
	<ul>
		<li><label>银行名:</label><input type="text" id="bankNameInp" placeholder="(请输入正确的银行名)"></li>
		<li><label>卡号:</label><input type="text" id="bankCardInp" placeholder="(请输入19位卡号)" oninput="value=value.replace(/[^\d]/g,'')"></li>
		<li><label>支付密码:</label><input type="password" id="bankPasswordInp" placeholder="(请输入6位数)" oninput="value=value.replace(/[^\d]/g,'')"></li>
		<li><label>设定余额:</label><input type="text" id="bankBalanceInp" placeholder="(请输入虚拟余额)" oninput="value=value.replace(/[^\d]/g,'')"></li>
	</ul>
</div>
<!-- 查看银行卡 -->
<div id="selBankDiv" style="display: none;">
	<ul>
		<li><label>银行名:</label><span id="bankName"></span></li>
		<li><label>卡号:</label><span id="bankCard"></span></li>
		<li><label>余额:</label><span id="bankBalance"></span></li>
	</ul>
</div>
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

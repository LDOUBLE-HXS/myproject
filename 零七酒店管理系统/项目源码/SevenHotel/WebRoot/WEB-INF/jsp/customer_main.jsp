<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<title>零七连锁酒店官网</title>
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
						<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle"><i></i></a>
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
			<aside id="fh5co-hero" class="js-fullheight">
			<div class="flexslider js-fullheight">
				<ul class="slides">
					<c:forEach items="${BZRoom}" var="RoomType" begin="0" end="0">
						<li
							style="background-image: url(${RoomType.roomImg});background-size:cover;">
							<div class="overlay-gradient"></div>
							<div class="container">
								<div class="col-md-12 col-md-offset-0 text-center slider-text">
									<div class="slider-text-inner js-fullheight">
										<div class="desc">
											<p>
												<span>${RoomType.roomTypeName}</span>
											</p>
											<h2>${RoomType.sketch}</h2>
											<p>
												<a href="javaScript:;" class="btn btn-primary roomClick"
													id="${RoomType.id}">立刻预定</a>
											</p>
										</div>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
					<c:forEach items="${HHRoom}" var="RoomType" begin="0" end="0">
						<li
							style="background-image: url(${RoomType.roomImg});background-size:cover;">
							<div class="overlay-gradient"></div>
							<div class="container">
								<div class="col-md-12 col-md-offset-0 text-center slider-text">
									<div class="slider-text-inner js-fullheight">
										<div class="desc">
											<p>
												<span>${RoomType.roomTypeName}</span>
											</p>
											<h2>${RoomType.sketch}</h2>
											<p>
												<a href="javaScript:;" class="btn btn-primary roomClick"
													id="${RoomType.id}">立刻预定</a>
											</p>
										</div>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>

					<c:forEach items="${OtherRoom}" var="RoomType">
						<li
							style="background-image: url(${RoomType.roomImg});background-size:cover;">
							<div class="overlay-gradient"></div>
							<div class="container">
								<div class="col-md-12 col-md-offset-0 text-center slider-text">
									<div class="slider-text-inner js-fullheight">
										<div class="desc">
											<p>
												<span>${RoomType.roomTypeName}</span>
											</p>
											<h2>${RoomType.sketch}</h2>
											<p>
												<a href="javaScript:;" class="btn btn-primary roomClick"
													id="${RoomType.id}">立刻预定</a>
											</p>
										</div>
									</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
			</aside>
			<div class="wrap">
				<div class="container">
					<div class="row">
						<div id="availability">
							<form action="#">
								<div class="a-col">
									<section id="selectRoom"> <select class="cs-select cs-skin-border">
										<option value="" disabled selected>选择房间</option>
										<c:forEach items="${AllRoom}" var="RoomType">
											<option class="chooseOption" id="${RoomType.id}">${RoomType.roomTypeName}</option>
										</c:forEach>
									</select> </section>
								</div>
								<div class="a-col alternate">
									<div class="input-field">
										<label for="date-start">入住时间</label> <input
											readonly="readonly" type="text" class="layui-input"
											id="checkInTime">
									</div>
								</div>
								<div class="a-col alternate">
									<div class="input-field">
										<label for="date-end">离开时间</label> <input readonly="readonly"
											type="text" class="layui-input" id="checkOutTime">
									</div>
								</div>
								<div class="a-col action">
									<a href="javascript:;" id="checkRoom"><span>检查空房<br />立即预定
									</span> </a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

			<div id="fh5co-counter-section" class="fh5co-counters">
				<div class="container">
					<div class="row">
						<div class="col-md-3 text-center">
							<span class="fh5co-counter js-counter" data-from="0"
								data-to="20356" data-speed="5000" data-refresh-interval="50">20356</span>
							<span class="fh5co-counter-label">登记入住次数</span>
						</div>
						<div class="col-md-3 text-center">
							<span class="fh5co-counter js-counter" data-from="0"
								data-to="15501" data-speed="5000" data-refresh-interval="50">15501</span>
							<span class="fh5co-counter-label">服务客户</span>
						</div>
						<div class="col-md-3 text-center">
							<span class="fh5co-counter js-counter" data-from="0"
								data-to="8200" data-speed="5000" data-refresh-interval="50">8200</span>
							<span class="fh5co-counter-label">交易</span>
						</div>
						<div class="col-md-3 text-center">
							<span class="fh5co-counter js-counter" data-from="0"
								data-to="8763" data-speed="5000" data-refresh-interval="50">8763</span>
							<span class="fh5co-counter-label">在线&amp; 预订 </span>
						</div>
					</div>
				</div>
			</div>

			<div id="featured-hotel" class="fh5co-bg-color">
				<div class="container">

					<div class="row">
						<div class="col-md-12">
							<div class="section-title text-center">
								<h2>精品套餐</h2>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="feature-full-1col">
							<div class="image"
								style="background-image: url(static/customer/images/hotel_feture_1.jpg)">
								<div class="descrip text-center">
									<p>
										<small>最低</small><span>￥318/天</span>
									</p>
								</div>
							</div>
							<div class="desc">
								<h3>豪华单人间</h3>
								<p>客房设计时尚，豪华舒适，在世界各地及本土名家的艺术精品点缀下，处处彰显高雅品味。每个房间均配备先进的高科技设施，包括高速宽带上网、语音留言系统、等离子大屏幕电视；特别定制的睡床让每位宾客酣然入梦，
									宽敞的大理石浴室内有超大浴缸和独立淋浴间，并设有嵌入式镜面电视。无论度假还是公干，四季酒店都是您理想的出行之选。</p>
								<p>
									<a href="javascript:;" class="btn btn-primary btn-luxe-primary roomClick"  id="3">立即预定<i
										class="ti-angle-right"></i></a>
								</p>
							</div>
						</div>

						<div class="feature-full-2col">
							<div class="f-hotel">
								<div class="image"
									style="background-image: url(static/admin/images/room/1560821432955_ROOM.jpg);">
									<div class="descrip text-center">
										<p>
											<small>最低</small><span>￥412/天</span>
										</p>
									</div>
								</div>
								<div class="desc">
									<h3>情侣套间</h3>
									<p>专属情侣的 93
										层，沐浴在烛光和红玫瑰花瓣所营造的浪漫气息中，为情侣创造私密、尊贵、甜蜜的难忘时光。走廊的糖果、房间里的音乐及浴室里的浴盐和浴枕，均是酒店的用心之选</p>
									<p>
										<a href="javascript:;" class="btn btn-primary btn-luxe-primary roomClick" id="6">立即预定
											<i class="ti-angle-right"></i>
										</a>
									</p>
								</div>
							</div>
							<div class="f-hotel">
								<div class="image"
									style="background-image: url(static/admin/images/room/1560821432966_ROOM.jpg);">
									<div class="descrip text-center">
										<p>
											<small>最低</small><span>￥508/天</span>
										</p>
									</div>
								</div>
								<div class="desc">
									<h3>家庭套间</h3>
									<p>无论您的孩子是什么年纪，从初生婴儿到长大成人，广州四季酒店都是您的理想居庭。我们会特地为年轻小客人营造喜乐的氛围，随时候命的礼宾部人员会竭尽所能，为您与您的至亲安排一个完美温馨的假期。
									</p>
									<p>
										<a href="javascript:;" class="btn btn-primary btn-luxe-primary roomClick" id="7">立即预定<i
											class="ti-angle-right"></i></a>
									</p>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>

			<div id="testimonial">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="section-title text-center">
								<h2>顾客的快乐时光</h2>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="testimony">
								<blockquote>
									&ldquo;很不错的体验，无敌江景塔景，房间超大，大浴缸赞，全自动厕所，床品也很舒服！设施完善，下次还要再次入住。
								</blockquote>
								<p class="author">
									<cite>zhangsan</cite>
								</p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="testimony">
								<blockquote>
									&ldquo;一家人去广州吃玩，入住四季，满足了白天及夜晚对广州小蛮腰的欣赏，酒店的硬件设施及软件的服务态度都是可以认可的，下次仍然会住。
								</blockquote>
								<p class="author">
									<cite>lisi</cite>
								</p>
							</div>
						</div>
						<div class="col-md-4">
							<div class="testimony">
								<blockquote>
									&ldquo;四季酒店超级豪华，在西塔里面，可以换电梯到达顶层，上面有如星空一样的建筑，夜景很美，整个天河区都可以看到，珠江上的船都看得很清楚。
								</blockquote>
								<p class="author">
									<cite>dengchao</cite>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div id="fh5co-blog-section">
				<div class="container">
					<div class="row">
						<div class="col-md-12">
							<div class="section-title text-center">
								<h2>最新资讯</h2>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<div class="blog-grid"
								style="background-image: url(static/customer/images/image-1.jpg);">
								<div class="date text-center">
									<span>09</span> <small>8/Aug</small>
								</div>
							</div>
							<div class="desc">
								<h3>
									<a href="#">最有价值的酒店</a>
								</h3>
							</div>
						</div>
						<div class="col-md-4">
							<div class="blog-grid"
								style="background-image: url(static/customer/images/image-2.jpg);">
								<div class="date text-center">
									<span>09</span> <small>8/Aug</small>
								</div>
							</div>
							<div class="desc">
								<h3>
									<a href="#">酒店3周年活动</a>
								</h3>
							</div>
						</div>
						<div class="col-md-4">
							<div class="blog-grid"
								style="background-image: url(static/customer/images/image-3.jpg);">
								<div class="date text-center">
									<span>09</span> <small>8/Aug</small>
								</div>
							</div>
							<div class="desc">
								<h3>
									<a href="#">一个新的旅行地在这里等着你</a>
								</h3>
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
									<li><a href="#">客户服务</a></li>
									<li><a href="#">联系我们</a></li>
								</ul>
							</div>
							<div class="col-md-3">
								<h3>我们的设施</h3>
								<ul class="link">
									<li><a href="#">餐厅</a></li>
									<li><a href="#">酒吧</a></li>
									<li><a href="#">会议</a></li>
									<li><a href="#">游泳池</a></li>
									<li><a href="#">水疗</a></li>
									<li><a href="#">健身房</a></li>
								</ul>
							</div>
							<div class="col-md-6">
								<h3>体验</h3>
								<p>但当然，始终处于核心。Mauris杂色山雀，大和免费的热身。</p>
								<form action="#" id="form-subscribe">
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
							<li><a href="#"><i class="icon-twitter-with-circle"></i></a>
								<a href="#"><i class="icon-facebook-with-circle"></i></a> <a
								href="#"><i class="icon-instagram-with-circle"></i></a> <a
								href="#"><i class="icon-linkedin-with-circle"></i></a></li>
						</ul>
					</div>
				</div>
			</div>
			</footer>

		</div>
	</div>
	<input type="hidden" id="path" name="path"
		value="${pageContext.request.contextPath }" />
	<input type="hidden" id="referer" name="referer"
		value="<%=request.getHeader("Referer")%>" />
		<c:choose>
			<c:when test="${userSession!=null }">
				<input type="hidden" id="discount" name="discount"
		value="${userSession.member.discount}" />
			</c:when>
			<c:otherwise>
			<input type="hidden" id="discount" name="discount"
		value="1" />
			</c:otherwise>
		</c:choose>
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

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>酒店后台管理</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/layui/css/layui.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath }/layui/layui.js"></script>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/fontsawesome/css/font-awesome.css"/>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/admin/css/style.css"/>
</head>
<body>
<div class="header">
	<div class="logo">
		<a manId="${adminSession.id}" id="manager" href="javascript:void(0);"><img src="${adminSession.workPicPath}" alt="管理员头像" style="width:100px;height:100px;border:1px solid #09C; border-radius:50px;"></a>
	</div>
	<div class="nav">
		<ul class="clearfix">
			<li>
				<i class="fa fa-cogs font_lager"></i>
				<p data-id="room">房间管理</p>
			</li>
			<li>
				<i class="fa fa-file-text font_lager"></i>
				<p data-id="order">订单管理</p>
			</li>
			<li>
				<i class="fa fa-user-circle-o font_lager"></i>
				<p data-id="customer">会员管理</p>
			</li>
			<li>
				<i class="fa fa-users font_lager"></i>
				<p data-id="staff">员工管理</p>
			</li>
			<li>
				<i class="fa fa-credit-card font_lager"></i>
				<p data-id="member">会员福利</p>
			</li>
			<!-- <li>
				<i class="fa fa-cube font_lager"></i>
				<p data-id="goods">商品管理</p>
			</li> -->
			<li>
				<i class="fa fa-commenting font_lager"></i>
				<p data-id="comment">本店评论</p>
			</li>
			<li>
				<i class="fa fa-line-chart font_lager"></i>
				<p data-id="business">流水统计</p>
			</li>
			<!-- <li>
				<i class="fa fa-cab font_lager"></i>
				<p data-id="after_sales">会员反馈</p>
			</li> -->
		</ul>
	</div>
	<div class="nav_roll f_left" style="display:none;">
		<div class="f_left">
			<i class="fa fa-caret-left fa-1x" style="margin-top: 40px;"></i>
		</div>
		<div class="f_right">
			<i class="fa fa-caret-right fa-1x" style="margin-top: 40px;"></i>
		</div>
	</div>
	<ul class="login_msg">
		<li title="后台管理员" value="admin"><a href="javaScript:;" id="position">${adminSession.position.positionType}</a>,欢迎!</li>
		<li><a href="${pageContext.request.contextPath }/manager/exit">退出</a></li>
	</ul>
</div>
<!--top end-->
<div class="main_left">
	<h2><i class="menu_icon fa fa-reorder"></i></h2>
	<ul class="menu">
		<!--房间管理-->
		<li>
			<i class="menu_icon fa fa-list"></i>
			<a href="javascript:void(0);" data-id="room" data-href="${pageContext.request.contextPath }/manager/toRoomManager">房间列表</a>
		</li>
		<li>
			<i class="menu_icon fa fa-hourglass-half"></i>
			<a href="javascript:void(0);" data-id="room" data-href="${pageContext.request.contextPath }/manager/toRoomTypeManager">房间分类管理</a>
		</li>
		<li>
			<i class="menu_icon fa fa-history"></i>
			<a href="javascript:void(0);" data-id="room" data-href="${pageContext.request.contextPath }/manager/toCheckInPage">办理入住</a>
		</li>
		<!--会员管理-->
		<li>
			<i class="menu_icon fa fa-user"></i>
			<a href="javascript:void(0);" data-id="customer" data-href="${pageContext.request.contextPath }/manager/customerList">本店会员</a>
		</li>
		<li>
			<i class="menu_icon fa fa-user-plus"></i>
			<a href="javascript:void(0);" data-id="customer" data-fast="add_user" data-href="${pageContext.request.contextPath }/manager/addCustomer">添加会员</a>
		</li>
		<!--员工管理-->
		<li>
			<i class="menu_icon fa fa-users"></i>
			<a href="javascript:void(0);" data-id="staff" data-href="${pageContext.request.contextPath }/manager/toManagerPage">员工列表</a>
		</li>
		<li>
			<i class="menu_icon fa fa-plus-square"></i>
			<a href="javascript:void(0);" data-id="staff" data-href="${pageContext.request.contextPath }/manager/toAddManager">添加员工</a>
		</li>
		<!--本店评论-->
		<li>
			<i class="menu_icon fa fa-commenting-o"></i>
			<a href="javascript:void(0);" data-id="comment" data-href="${pageContext.request.contextPath }/manager/toComment">本店评论</a>
		</li>
		<!--商品管理-->
		<li>
			<i class="menu_icon fa fa-list"></i>
			<a href="javascript:void(0);" data-id="goods" data-href="${pageContext.request.contextPath }/manager/goods_List">商品列表</a>
		</li>
		<li>
			<i class="menu_icon fa fa-cube"></i>
			<a href="javascript:void(0);" data-id="goods" data-href="${pageContext.request.contextPath }/manager/add_Goods">添加商品</a>
		</li>
		<li>
			<i class="menu_icon fa fa-sitemap"></i>
			<a href="javascript:void(0);" data-id="goods" data-href="${pageContext.request.contextPath }/manager/goods_CLassify">商品分类管理</a>
		</li>
		<!--订单管理-->
		<li>
			<i class="menu_icon fa fa-file-text-o"></i>
			<a href="javascript:void(0);" data-id="order" data-href="${pageContext.request.contextPath }/manager/orderList">订单列表</a>
		</li>
		<li>
			<i class="menu_icon fa fa-clipboard"></i>
			<a href="javascript:void(0);" data-id="order" data-href="${pageContext.request.contextPath }/manager//dealOrder">订单处理</a>
		</li>
		<!--会员福利-->
		<li>
			<i class="menu_icon fa fa-credit-card-alt"></i>
			<a href="javascript:void(0);" data-id="member" data-href="${pageContext.request.contextPath }/manager/memberWelfare">会员福利</a>
		</li>
		<!--售后管理-->
		<li>
			<i class="menu_icon fa fa-th"></i>
			<a href="javascript:void(0);" data-id="after_sales" data-href="${pageContext.request.contextPath }/manager/user_feedback">反馈信息</a>
		</li>
		<!--业绩统计-->
		<li>
			<i class="menu_icon fa fa-bar-chart"></i>
			<a href="javascript:void(0);" data-id="business" data-href="${pageContext.request.contextPath }/manager/toBusiness">流水统计</a>
		</li>
	</ul>
</div>
<!--left end-->
<div class="main_right">
	<iframe src="${pageContext.request.contextPath }/manager/hello" name="cont_box" frameborder="0" width="100%" height="100%" seamless></iframe>
</div>
<!--desktop end-->
<!--javascript include-->
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
<script src="${pageContext.request.contextPath }/static/admin/js/jquery-2.1.4.min.js"></script>
<script src="${pageContext.request.contextPath }/static/admin/js/tipSuppliers.js"></script>
<script src="${pageContext.request.contextPath }/static/admin/js/common.js"></script>
<script src="${pageContext.request.contextPath }/static/admin/js/main.js"></script>

<script>
	$("iframe[name='cont_box']").on("load",function(){
		$(".loading").hide();
		setTimeout(function(){$("iframe[name='conte_box']").css("opacity","1");},500);
	});
	$(function(){
		$(".loading").hide();
		setTimeout(function(){$("iframe[name='cont_box']").css("opacity","1");},500);
		$(".nav li:first").trigger("click");
	});
	jQuery("body").jrdek({Mtop:".header",Mleft:".main_left",Mright:".main_right",foldCell:".main_left h2"});
</script>
</body>
</html>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的评论</title>
<!-- layui -->
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/layui/layui.js"></script>
<!--响应式框架-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/static/customer/css/bootstrap-grid.min.css" />

<!--图标样式-->
<link rel="stylesheet" href="http://jrain.oscitas.netdna-cdn.com/tutorial/css/fontawesome-all.min.css">

<!--滚动样式-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/customer/css/owl.carousel.min.css">

<!--核心样式-->
<link rel="stylesheet" href="${pageContext.request.contextPath }/static/customer/css/comment.css">


<!--演示页面样式，使用时可以不引用-->

</head>
<body>



<div class="container">

	<div class="row">
		<div class="col-md-12">
			<div id="news-slider" class="owl-carousel">
			<c:forEach var="comment" items="${commentList }">
				<div class="post-slide">
					<div class="post-img">
						<a href="javaScript:;"><img src="${pageContext.request.contextPath }/${comment.comImg}" alt=""></a>
					</div>
					<div class="post-content">
						<h3 class="post-title"><a href="javaScript:;">${comment.order.roomtype.roomTypeName}</a></h3>
						<p class="post-description">
							<div class="comContextDiv">
							${comment.comContext}
							</div>
						</p>
						<ul class="post-bar">
							<li><i class="fa fa-calendar"></i><fmt:formatDate value="${comment.comDate}"
									pattern="yyyy-MM-dd"/></li>
						</ul>
						<a commentId="${comment.id }" href="javaScript:;" class="read-more">删除评论</a>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="path" name="path" value="${pageContext.request.contextPath }"/>
		<input type="hidden" id="referer" name="referer" value="<%=request.getHeader("Referer")%>"/>
<script src="${pageContext.request.contextPath }/static/customer/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/static/customer/js/owl.carousel.min.js"></script>
<script
		src="${pageContext.request.contextPath }/static/customer/js/common.js"></script>
	<script
		src="${pageContext.request.contextPath }/static/customer/js/myComment.js"></script>
<script>
	$(document).ready(function() {
		$("#news-slider").owlCarousel({
			items:3,
			itemsDesktop:[1199,2],
			itemsDesktopSmall:[980,2],
			itemsMobile:[600,1],
			pagination:false,
			navigationText:false,
			autoPlay:true
		});
	});
</script>
</body>
</html>
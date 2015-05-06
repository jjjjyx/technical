<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="common/base.jsp"%>
<%
	String s=(String)request.getRequestURI();
	if(s.indexOf("index.jsp")==-1){
		response.sendRedirect("hello");
	}
	request.setAttribute("active", "sy");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>技术交流论坛</title>
<!-- bootstrap -->
<link href="${path }/dist/css/bootstrap.css" rel="stylesheet">
<link href="${path }/dist/css/bootstrap-overrides.css" rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/compiled/layout.css">
<!-- 图标 -->
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/font-awesome.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">

<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/signin.css">

	<script src="${path }/dist/js/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="${path }/dist/js/bootstrap.min.js"></script>
	<script src="${path }/dist/js/theme.js"></script>
	    <script src="${path }/dist/js/cookie.js"></script>
	    <script src="${path }/dist/js/getmd5.js"></script>
<style>
html { overflow-x: hidden; overflow-y: auto; }

</style>
</head>
<body>
	<%@include file="head.jsp"%>
	<%-- 这里是页面主体 --%>
	<div class="container contanier-body" style="max-width: 1366px;padding: 0px; ">
		<div class="row">
			<div class="col-md-12 col-sm-12">
				<div id="carousel-example-generic" class="carousel slide"
					data-ride="carousel">
					<!-- Indicators -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-example-generic" data-slide-to="0"
							class="active"></li>
						<li data-target="#carousel-example-generic" data-slide-to="1"></li>
						<li data-target="#carousel-example-generic" data-slide-to="2"></li>
					</ol>

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<div class="item active"
							style="max-height: 450px; overflow: hidden;">
							<img src="${path }/dist/img/1.jpg" alt="...">
							<div class="carousel-caption">
								<h3>test</h3>
								<p>test111111</p>
							</div>
						</div>
						<div class="item" style="max-height: 450px; overflow: hidden;">
							<img src="${path }/dist/img/2.jpg" alt="...">
							<div class="carousel-caption">
								<h3>test</h3>
								<p>test111111</p>
							</div>
						</div>
						<div class="item" style="max-height: 450px; overflow: hidden;">
							<img src="${path }/dist/img/3.jpg" alt="...">
							<div class="carousel-caption">
								<h3>test</h3>
								<p>test111111</p>
							</div>
						</div>
					</div>

					<!-- Controls -->
					<a class="left carousel-control" href="#carousel-example-generic"
						role="button" data-slide="prev" hidefocus="true"> <span
						class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
						<span class="sr-only">Previous</span>
					</a> <a class="right carousel-control" href="#carousel-example-generic"
						role="button" data-slide="next" hidefocus="true"> <span
						class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
						<span class="sr-only">Next</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="container ed" style="margin-top: 20px;margin-bottom: 20px;">
		<div class="row">
		<c:forEach var="l" items="${top_home_list.currentList }">
			<div class="col-sm-6 col-md-3 area">
				<div class="thumbnail">
					<img src="${path }${l['user_head_path'] }" alt="..." class="img-circle img-thumbnail" height="130px" width="130px">
					<div class="caption">
						<h3>${l['user_id'] }</h3>
						<p><a href="${path }/person!bbsContent?bbs_id=${l['bbs_id']}">${l['bbs_title'] }</a></p>
						<p class="col-sm-12" >
							<a href="${path }/person!bbsContent?bbs_id=${l['bbs_id']}" class="btn btn-primary" role="button">查看</a>
							<a href="javascript:void(0);" class="btn btn-primary" data-friend='addfriend' data-target="${l['user_id'] }">关注</a>
						</p>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
	</div>
	<%@include file="footer.jsp"%>

</body>
</html>
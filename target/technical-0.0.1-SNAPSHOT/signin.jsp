<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="common/base.jsp"%>
<%
	request.setAttribute("active", "sy");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>登录</title>
<!-- 图标 -->
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/font-awesome.css">

<link rel="stylesheet" href="${path }/dist/css/compiled/supersized.css">
<link rel="stylesheet" href="${path }/dist/css/compiled/style.css">

</head>
<body>

        <div class="page-container">
            <h1>登录</h1>
            <form action="" method="post">
                <input type="text" name="username" class="username" placeholder="用户名">
                <input type="password" name="password" class="password" placeholder="密码">
                <button type="submit">提交</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect">
                <p>忘记密码:</p>
                <p>
                    <a class="facebook" href=""></a>
                    <a class="twitter" href=""></a>
                </p>
            </div>
        </div>
		<script src="${path }/dist/js/jquery.min.js"></script>
        <script src="${path }/dist/js/supersized.3.2.7.min.js"></script>
		<script type="text/javascript">
		jQuery(function($){
		    $.supersized({
		        slide_interval     : 4000,    // Length between transitions
		        transition         : 1,    // 0-None, 1-Fade, 2-Slide Top, 3-Slide Right, 4-Slide Bottom, 5-Slide Left, 6-Carousel Right, 7-Carousel Left
		        transition_speed   : 1000,    // Speed of transition
		        performance        : 1,    // 0-Normal, 1-Hybrid speed/quality, 2-Optimizes image quality, 3-Optimizes transition speed // (Only works for Firefox/IE, not Webkit)
		        min_width          : 0,    // Min width allowed (in pixels)
		        min_height         : 0,    // Min height allowed (in pixels)
		        vertical_center    : 1,    // Vertically center background
		        horizontal_center  : 1,    // Horizontally center background
		        fit_always         : 0,    // Image will never exceed browser width or height (Ignores min. dimensions)
		        fit_portrait       : 1,    // Portrait images will not exceed browser height
		        fit_landscape      : 0,    // Landscape images will not exceed browser width

		        // Components
		        slide_links        : 'blank',    // Individual links for each slide (Options: false, 'num', 'name', 'blank')
		        slides             : [    // Slideshow Images
		                                 {image : '${path}/dist/css/img/backgrounds/1.jpg'},
		                                 {image : '${path}/dist/css/img/backgrounds/2.jpg'},
		                                 {image : '${path}/dist/css/img/backgrounds/3.jpg'}
		                       ]

		    });

		});
		</script>
    </body>

</html>



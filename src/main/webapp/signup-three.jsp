<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="common/base.jsp"%>
<%
	request.setAttribute("active", "sy"); 
	request.setAttribute("step", 3);
	String info= (String)request.getAttribute("info");
		if(null==info||"".equals(info))
			response.sendRedirect("signup-one.jsp");
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
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/compiled/signin.css">
<link href="${path }/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet"><%--时间日期工具 --%>
<script src="${path }/dist/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${path }/dist/js/bootstrap.min.js"></script>
<script src="${path }/dist/js/theme.js"></script>
<script src="${path }/dist/js/cookie.js"></script>
<script src="${path }/dist/js/getmd5.js"></script>	  
<style>

#wrapper{
	width:980px;
	margin:0px auto;
	position:relative;
	height:100%;
	overflow: hidden;
}
h1.not-found-text{
	
	font-size:50px;
	color:#fff;
	font-family:"SingleSleeveRegular", cursive;
	letter-spacing:2px;
	margin-bottom:20px;
	
}
div.not-found-text{
	position:absolute;
	top:35px;
	right:0px;
	width:500px;
	
}
div.dog-wrapper{
	
	position:absolute;
	bottom:300px;
	left:440px;
	
}
div.dog{
	position:absolute;
	bottom:0px;
	left:0px;
	width:80px;
	height:80px;
	z-index:999;
	background:url(${path}/dist/img/dog.png) 0px 0px no-repeat;
}
div.dog-bubble{
	font-size:14px;
	line-height:1.5;
	font-style:italic;
	height:179px;
	width:246px;
	background:url(${path}/dist/img/bubble.png) top center no-repeat;
	padding:20px 0px;
	position:absolute;
	bottom:-30px;
	left:30px;
	z-index:999;
	opacity:0;
	color:#555555;
	font-size:14px;
	text-shadow:1px 1px 0 #ffffff;
}
div.dog-bubble>p{
	text-align:center;
	padding:0px 35px;
}
div.bubble-options{
	opacity:0;
	visibility:hidden;
	display:none;
}
div.planet{
	position:absolute;
	bottom:-1100px;
	margin:0px auto;
	width:980px;
	background:url(${path}/dist/img/planet.png) center no-repeat;
	height:1920px;
	z-index:0;
	
}
</style>
</head>
<body>
<%@include file="signup.jsp" %>
	<div id="wrapper">
		<div class="not-found-text">
			<h1 class="not-found-text">恭喜您注册成功啦！</h1>
		</div>

		<div class="dog-wrapper">

			<div class="dog"></div>
			<!-- dog running -->

			<!-- dog bubble talking -->
			<div class="dog-bubble"></div>

			<!-- The dog bubble rotates these -->
			<div class="bubble-options">
				<p class="dog-bubble">恭喜你注册成功啦！</p>
				<p class="dog-bubble">
					<br /> 汪! 汪!
				</p>
				<p class="dog-bubble">
					<br /> 现在就要登录么
				</p>
				<p class="dog-bubble">
					登录后可以发帖，关注哦
				</p>
				<p class="dog-bubble">
					<br /> 汪! 汪!
				</p>
				<p class="dog-bubble">
					<br /> 快来快来，把你的最新研究成果展示给小伙伴看把~
				</p>
				<p class="dog-bubble">O(∩_∩)O哈哈哈~</p>
				<p class="dog-bubble">
						我很开心~
				</p>
			</div>
			<!-- The dog bubble rotates these -->
			<!-- dog bubble talking -->
		</div>
		<div class="planet"></div>
	</div>
	<script type="text/javascript">
	var degree = 0;
	var maxtalk = 0;
	var talkbubble = 1;
	$(window).load(function(){
		
		rotate();
	    dogRun();
		dogTalk();
	});
	$(document).ready(function(){
		//count talk bubbles
		$("div.bubble-options p.dog-bubble").each(function(){
			maxtalk++;
		});		
		
	});
	function dogTalk(){
		var timer = setTimeout(function() {
			//change the bubble html code
			$temp = "<p>"+$("div.bubble-options p.dog-bubble:nth-child("+talkbubble+")").html()+"</p>";		
			$("div.dog-bubble").html($temp);
			//browse through bubble-options
			if(talkbubble<maxtalk)
				talkbubble++;
			else
				talkbubble = 1;
			//show the bubble
			$(".dog-bubble").animate({"opacity":'1', "bottom":'60px'}, 400);
			//hide the bubble
			setTimeout(function() {
				$(".dog-bubble").animate({"opacity":'0', "bottom":'60px'}, 400);
				dogTalk();	
			}, 5000);		
			
		}, 2000);	
	}
	//function that handles the planet animation
	function rotate() {
		$planet = $("div.planet");
		  //CSS3
		$planet.css({ 'transform' : 'rotate(' + degree + 'deg)'}); 
		  // For webkit browsers: e.g. Chrome
		$planet.css({ WebkitTransform : 'rotate(' + degree*2 + 'deg)'});
		  // For Mozilla browser: e.g. Firefox
		$planet.css({ '-moz-transform' : 'rotate(' + degree + 'deg)'});
		  //IE9
		$planet.css({ '-ms-transform' : 'rotate(' + degree + 'deg)'});
		  //Opera
		$planet.css({ '-o-transform' : 'rotate(' + degree + 'deg)'});
		// Animate rotation with a recursive call
		var timer = setTimeout(function() {
			degree-=0.1; 
			rotate();
		},10);
	}
	//function that handles dog movement animation
	function dogRun(){
		var dog = $("div.dog");
		var timer2 = setTimeout(function() {
			if(dog.css("background-position") == "0px 0px")
				dog.css({"background-position":"-80px -2px"});
			else
				dog.css({"background-position":"0px 0px"});							 
			dogRun();	
			
		}, 130);	
		
	}
	</script>
</body></html>
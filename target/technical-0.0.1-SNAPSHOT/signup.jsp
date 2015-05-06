<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="common/base.jsp"%>

<style>
html {
	overflow-x: hidden;
	overflow-y: auto;
}
html, body{
	height:100%;
	background:#186aa9 url(${path}/dist/img/sky-background.png) top repeat-x;	
	padding:0;
	margin:0;
	font-family:Arial, Helvetica, sans-serif;
	
}
.site-container{
	width: 720px;
	margin:0px auto; 
}
.steps{
	width: 100%;
	display: table;
	margin: 30px auto 0;
	padding: 0px;
	overflow: hidden;
	list-style: none;
	border: 1px solid #ddd;
	border-radius:3px; 
	box-shadow:0 1px 3px rgba(0,0,0,0.05);
}
.steps>li.current{
	background-color: #fff;
	color: #333;
}
.steps>li{
	display: table-cell;
	width: 33.33%;
	padding: 10px 15px;
	color: #ccc;
	cursor: default;
	border-left: 1px solid #ddd;
	background-color:#fafafa;
}
.steps>li:first-child{
	border-left: 0;
}
.steps>li .step{
	display: block;
}
.steps>li>i{
	float: left;
	font-size: 32px;
	margin-right: 15px;
}
.steps-header{
	overflow: hidden;
	margin: 0 auto 30px;
	text-align: left;
	text-shadow: 0 1px 0 white;
	
}
</style>

	<%@include file="head.jsp"%>
	<%-- 这里是页面主体 --%>
	<div class="container contanier-body" style="margin-bottom: 20px;padding-bottom: 10px;">
		<div class="site-container">
			<div class="row steps-header">
				<div class="page-header" style="border: 0">
					<h1>加入我们</h1><br>
					<p  class="lead">欢迎您加入我们这个大学堂，这里可以学习您在课堂上学习不到的东西</p>
				</div>
				<ol class="steps">
					<li class="current"><i class="icon-user"></i><strong class="step">Step 1:</strong>注册信息</li>
					<li <c:if test="${step>=2}">class="current"</c:if><i class="icon-edit"></i><strong class="step">Step 2:</strong>基本资料</li>
					<li <c:if test="${step> 2}">class="current"</c:if>><i class="icon-ok"></i><strong class="step">Step 3:</strong>完成</li>
				</ol>
			</div>
		</div>
	</div>
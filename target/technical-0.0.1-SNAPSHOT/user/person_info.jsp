<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="com.model.UserinfoBean"%>
	<%@ page import="com.common.an.*" %>
	<%@ page import="java.lang.reflect.*" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../common/base.jsp"%>
<%!
	public String getMethodName(String fildeName){
		byte[] items = fildeName.getBytes();
		items[0] = (byte) ((char) items[0] - 'a' + 'A');
	return new String(items);
	}
%>
<%
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
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/compiled/signin.css">
	<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/animation.css">
<link rel="stylesheet" href="${path }/dist/css/jquery.Jcrop.css">

<script src="${path }/dist/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${path }/dist/js/bootstrap.min.js"></script>
<script src="${path }/dist/js/theme.js"></script>
<script src="${path }/dist/js/cookie.js"></script>
<script src="${path }/dist/js/getmd5.js"></script>
<script src="${path }/dist/js/jquery.pin.min.js"></script>
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
#user_info_middle table tr td:first-child{
	width: 150px;
	border-right: #edf2f7 1px solid;
}
.breadcrumb>a{
	float: right;
	}
</style>
</head>
<body>
	<%@include file="../head.jsp"%>
	<%-- 这里是页面主体 --%>
	<div class="container contanier-body"  >
		<div class="user_info-container a-bounceinB">
			<%@include file="person.jsp" %>
		</div>
	
		
		<div class="row">
			<!-- 左侧菜单 -->
			<div class="col-sm-2 hidden-xs sides" >
				<%@include file="left_menu.jsp" %>
			</div>
			<!-- 中间内容 -->
			
			<div class="col-sm-7 middle" id="user_info_middle">
			<form action="${path }/user!info">
				<div class="panel panel-info">
					<div class="panel-heading">
						<ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a>  </li>
						  <li><a href="${path }/user!info">个人资料</a>  </li>
						  <a href="${path }/user!edit">修改资料</a>
						 </ol>
					</div>
					<table class="table table-striped">
					 	<tbody>
					 		<%--
					 			UserinfoBean uinfo=(UserinfoBean)request.getAttribute("user_info");
					 			Field[] field = uinfo.getClass().getDeclaredFields();
					 			for (Field field2 : field) {
					 				String name = field2.getName();Method m;Object val;
					 				try {
					 					if(field2.getAnnotation(UserTitle.class)!=null){
					 						out.print("<tr>");
					 						out.print("<td>"+((UserTitle)field2.getAnnotation(UserTitle.class)).title()+"</td>");
					 						out.print("<td>");
					 						m = (Method) uinfo.getClass().getMethod("get" + getMethodName(name));
					 						val =  m.invoke(uinfo);// 调用getter方法获取属性值
					 						if (val != null)  out.print(val);
					 						else out.print("暂无");
						 					out.print("</td>");
						 					out.print("</tr>");
					 					}
					 				}catch (Exception e) {
					 					e.printStackTrace();
					 				}
					 			}
					 		--%>
					 		
					 		<tr>
					 			<td>真实姓名：</td>
					 			<td>${user_info['user_name'] }</td>
					 		</tr>
					 		<tr>
					 			<td>手机：</td>
					 			<td>${user_info['phone'] }</td>
					 		</tr>
					 		<tr>
					 			<td>QQ：</td>
					 			<td>${user_info['qqnum'] }</td>
					 		</tr>
					 		<tr>
					 			<td>性别：</td>
					 			<td>${user_info['sex'] }</td>
					 		</tr>
					 		<tr>
					 			<td>年龄：</td>
					 			<td>${user_info['age'] }</td>
					 		</tr>
					 		<tr>
					 			<td>生日：</td>
					 			<td>${user_info['birthday'] }</td>
					 		</tr>
					 		<tr>
					 			<td>星座：</td>
					 			<td>${user_info['constellation'] }</td>
					 		</tr>
					 		<tr>
					 			<td>现居住：</td>
					 			<td>${user_info['living'] }</td>
					 		</tr>
					 		<tr>
					 			<td>婚姻状况：</td>
					 			<td>${user_info['maritalstatus'] }</td>
					 		</tr>
					 		<tr>
					 			<td>血型：</td>
					 			<td>${user_info['bloodtype'] }</td>
					 		</tr>
					 		<tr>
					 			<td>家乡：</td>
					 			<td>${user_info['home'] }</td>
					 		</tr>
					 		<tr>
					 			<td>职业：</td>
					 			<td>${user_info['job'] }</td>
					 		</tr>
					 		<tr>
					 			<td>地址：</td>
					 			<td>${user_info['address'] }</td>
					 		</tr>
					 	</tbody>
					</table>
					<div class="panel-footer">
						
					</div>
				</div>
				</form>
			</div>
			
			<!-- 右侧功能区 -->
			<div class="col-sm-3 hidden-xs ">
				<%@include file="right_menu.jsp" %>
			</div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
	</script>
</body>
</html>
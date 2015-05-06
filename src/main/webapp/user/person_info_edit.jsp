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
<link href="${path }/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet"><%--时间日期工具 --%>
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
#user_info_middle table select{
	width: 150px;
}
#user_info_middle .panel-footer{
	 -webkit-box-shadow: inset 0px 1px 0px rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: inset 0px 1px 0px rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
  box-shadow: inset 0px 1px 0px rgba(255, 255, 255, 0.5), 0px 1px 2px rgba(0, 0, 0, 0.2);
  background-color: #00a1cb;
  background: -webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, #00b5e5), color-stop(100%, #008db2));
  background: -webkit-linear-gradient(top, #00b5e5, #008db2);
  background: -moz-linear-gradient(top, #00b5e5, #008db2);
  background: -o-linear-gradient(top, #00b5e5, #008db2);
  background: linear-gradient(top, #00b5e5, #008db2);
  height: 40px;
  width:100%;
  font-weight: 300;
  font-size: 14px;
  font-family: "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif;
  color: #fff;
  
  text-decoration: none;
  text-align: center;
  padding: 0px;
  line-height: 40px;
  cursor: pointer;
}
#user_info_middle .panel-footer:hover {
  background-color: #00a1cb;
  background: -webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, #00c9fe), color-stop(100%, #008db2));
  background: -webkit-linear-gradient(top, #00c9fe, #008db2);
  background: -moz-linear-gradient(top, #00c9fe, #008db2);
  background: -o-linear-gradient(top, #00c9fe, #008db2);
  background: linear-gradient(top, #00c9fe, #008db2);
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
			<form action="${path }/user!edit_user" id="user_info_form" method="post">
				<div class="panel panel-info">
					<div class="panel-heading">
						<ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a>  </li>
						  <li><a href="${path }/user!info">个人资料</a>  </li>
						  <li><a href="${path }/user!edit">修改资料</a></li>
						 </ol>
					</div>
					<table class="table table-striped">
					 	<tbody>
					 		
					 		<tr>
					 			<td>真实姓名：</td>
					 			<td><input type="text" name="userBean.user_name" class="form-control" value="${user_info['user_name'] }"/></td>
					 		</tr>
					 		<tr>
					 			<td>手机：</td>
					 			<td><input type="text" name="user_info.phone" class="form-control" value="${user_info['phone'] }" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
					 		</tr>
					 		<tr>
					 			<td>QQ：</td>
					 			<td><input type="text" name="user_info.qqnum" class="form-control" value="${user_info['qqnum'] }" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
					 		</tr>
					 		<tr>
					 			<td>性别：</td>
					 			<td><input type="radio" name="user_info.sex" value="男" >
										男
								
									<input type="radio" name="user_info.sex" value="女">
										女
								</td>
					 		</tr>
					 		<tr>
					 			<td>年龄：</td>
					 			<td><input type="text" name="user_info.age" class="form-control" value="${user_info['age'] }" onkeyup="this.value=this.value.replace(/\D/g,'')"/></td>
					 		</tr>
					 		<tr>
					 			<td>生日：</td>
					 			<td><input type="text" name="user_info.birthday" class="form-control form_datetime"  value="${user_info['birthday'] }" maxlength="16" readonly="readonly"/>
					 			</td>
					 		</tr>
					 		<tr>
					 			<td>星座：</td>
					 			<td>
					 			<select class="" id="constellation_select" name="user_info.constellation">
					 				<option value="水瓶座">水瓶座</option>
					 				<option value="双鱼座">双鱼座</option>
					 				<option value="白羊座">白羊座</option>
					 				<option value="金牛座">金牛座</option>
					 				<option value="双子座">双子座</option>
					 				<option value="巨蟹座">巨蟹座</option>
					 				<option value="狮子座">狮子座</option>
					 				<option value="处女座">处女座</option>
					 				<option value="天秤座">天秤座</option>
					 				<option value="天蝎座">天蝎座</option>
					 				<option value="射手座">射手座</option>
					 				<option value="摩羯座">摩羯座</option>
								</select>
					 			</td>
					 		</tr>
					 		<tr>
					 			<td>现居住：</td>
					 			<td><input type="text" name="user_info.living" class="form-control" value="${user_info['living'] }"/></td>
					 		</tr>
					 		<tr>
					 			<td>婚姻状况：</td>
					 			<td>
					 				<select class="" id="maritalstatus_select" name="user_info.maritalstatus">
					 					 	<option value="未婚">未婚</option>
											<option value="已婚">已婚</option>
											<option value="恋爱中">恋爱中</option>
											<option value="单身贵族">单身贵族</option>
									</select>
									
					 			</td>
					 			
					 		</tr>
					 		<tr>
					 			<td>血型：</td>
					 			<td>
					 				<select class="" id="bloodtype_select" name="user_info.bloodtype">
					 						<option value="我也不知道">我也不知道</option>
					 					 	<option value="A">A</option>
											<option value="B">B</option>
											<option value="O">O</option>
											<option value="AB">AB</option>
									</select>
								</td>
					 		</tr>
					 		<tr>
					 			<td>家乡：</td>
					 			<td><input type="text" name="user_info.home" class="form-control" value="${user_info['home'] }"/></td>
					 		</tr>
					 		<tr>
					 			<td>职业：</td>
					 			<td><input type="text" name="user_info.job" class="form-control" value="${user_info['job'] }"/></td>
					 		</tr>
					 		<tr>
					 			<td>地址：</td>
					 			<td><input type="text" name="user_info.address" class="form-control" value="${user_info['address'] }"/></td>
					 		</tr>
					 		
					 		
					 	</tbody>
					</table>
					<div class="panel-footer">
						完成
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
		<script src="${path }/dist/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${path }/dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {//${user_info['bloodtype'] }
			$("#maritalstatus_select").find("option[value='${user_info['maritalstatus']}']").attr("selected",true);
			$("#bloodtype_select").find("option[value='${user_info['bloodtype']}']").attr("selected",true);
			$("#constellation_select").find("option[value='${user_info['constellation'] }']").attr("selected",true);
			$("input[type=radio][value='${user_info['sex']}']").attr("checked",true);
			
			$("#user_info_form input[name='user_info.birthday']").datetimepicker({format: 'yyyy-mm-dd',language:  'zh-CN',weekStart: 1,
			    todayBtn:  1,
				autoclose: 1,
				todayHighlight: 1,
				startView: 4,
				forceParse: 0,
			    showMeridian: 1,
			    minView: 2,
			});
			
			$("#user_info_form input[name='user_info.phone']").blur(function(){
				var phone = /^1[3|4|5|8][0-9]\d{4,8}$/;
				if(!phone.test($(this).val())){
					alert($(this).val()+"可能不能是一个正确的手机号码,请确认");
				}
					
			});
			$("#user_info_middle .panel-footer").click(function(){
				$("#user_info_form").submit();
			});
		});
	</script>
</body>
</html>
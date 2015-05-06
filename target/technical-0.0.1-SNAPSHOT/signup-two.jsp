<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="common/base.jsp"%>
<%
	request.setAttribute("active", "sy");
	request.setAttribute("step", 2);
	String account= (String)request.getAttribute("account");
		if(null==account||"".equals(account))
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
table.tabl tr>td {
	text-align: right;
}

table.table tr>td:nth-child(1) {
	width: 80px;
}
</style>
</head>
<body>
<%@include file="signup.jsp" %>
<div class="container" id="tow" style="margin-bottom: 20px;padding-bottom: 10px;">
	<div class="row">
		<div class="alert alert-info col-sm-8 col-sm-offset-2" role="alert">
			<h3>个人信息</h3>
			<hr />
			*填写您的个人信息，这会让跟多人关注到你<br> *我们会对您的信息进行保密<br>
			*这些信息以后可以在修改
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6 col-sm-offset-2 thumbnail" style="background-color: #fff;">
			<form class="form-horizontal" role="form" action="" id="user_info_form" method="post">
				
				<input type="hidden" value="<%=account %>" name="user.user_account">
				<div class="form-group has-feedback">
					<label class="col-sm-4 control-label">真实姓名</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" name="user.user_name" maxlength="20">
					</div>
				</div>
				<div class="form-group has-feedback">
					<label class="col-sm-4 control-label">性别</label>
					<div class="col-sm-5">
						<label class="radio-inline"> 
							<input type="radio" name="uinfo.sex" value="1" checked="checked">
								男
							</label> <label class="radio-inline"> 
							<input type="radio" name="uinfo.sex" value="0">
								女
						</label>
					</div>
				</div>
				<div class="form-group has-feedback">
					<label class="col-sm-4 control-label">生日</label>
					<div class="col-sm-5">
						<input type="text" class="form-control form_datetime" name="uinfo.birthday" maxlength="30" readonly="readonly">
					</div>
				</div>
				<div class="form-group has-feedback">
					<label class="col-sm-4 control-label">年龄</label>
					<div class="col-sm-5">
						<input type="text" class="form-control" name="uinfo.age" maxlength="30">
					</div>
				</div>
				<!-- 
				<div class="form-group has-feedback">
					<label class="col-sm-4 control-label">头像</label>
					<div class="col-sm-5">
						<input type="file" class="form-control" name="" maxlength="30"
						data-toggle="tooltip" data-placement="right" title="点击上传头像">
					</div>
				</div> -->
				<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4 ">
					<button type="button" class="btn-glow primary " id="submit_form" >提交</button>
					<button type="button" class="btn-glow sueecss" id="submit_form_skip">跳过</button>
				</div>
			</div>
			</form>
		</div>
		<div class="col-md-2">
			<div class="row">
				<div class=" col-md-12">
					<div class="thumbnail">
						<div class="caption">
							<h3>test</h3>
							<p>
								不知道写什么，<br /> test<s>test</s>
							</p>

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@include file="footer.jsp" %>
	<script src="${path }/dist/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${path }/dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
$(function(){
	$(".form_datetime").datetimepicker({format: 'yyyy-mm-dd',language:  'zh-CN',weekStart: 1,
	    todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
	    showMeridian: 1,
	    minView: 2,
	    pickerPosition:"bottom-left"
	});
});
$(document).ready(function() {
	$("#submit_form_skip").bind("click",{skip:true},form_submit);
	$("#submit_form").bind("click",{skip:false},form_submit);
});
function form_submit(e){
	//alert(e.data.skip);
	var submitURL="${path}/signup!signuptow?date="+new Date()+"&skip="+e.data.skip;
	$("#user_info_form").attr("action",submitURL);
	$("#user_info_form").submit();
	//form_data.push({name:"skip",value:e.data.skip});
	
	/*jQuery.post(submitURL,form_data,function(jsonData){
		if(jsonData.info){
			alert(jsonData.text);
			window.location.reload(true);
		}else{
			alert("注册失败：原因：\n"+jsonData.text);
		}
	},"json");
	*/
	
}
</script>
</body>
</html>

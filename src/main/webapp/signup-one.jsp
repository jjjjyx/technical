<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="common/base.jsp"%>
<%
	request.setAttribute("active", "sy");
	request.setAttribute("step", 1);
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

<script src="${path }/dist/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${path }/dist/js/bootstrap.min.js"></script>
<script src="${path }/dist/js/theme.js"></script>
<script src="${path }/dist/js/cookie.js"></script>
<script src="${path }/dist/js/getmd5.js"></script>	  
<style>
</style>
</head>
<body>

 <%@include file="signup.jsp" %>
<div class="container" >

		<form class="form-horizontal" role="form" method="post" action="" id="signup_form">
			<div class="form-group has-feedback">
				<label for="inputEmail3" class="col-sm-4 control-label">用户名</label>
				<div class="col-sm-4">
					<input type="text" class="form-control " 
						name="user.user_account" maxlength="20" data-toggle="tooltip" data-placement="right" title="用户名应在6-20位">  
				</div>
			</div>
			<div class="form-group has-feedback">
				<label for="inputEmail3" class="col-sm-4 control-label">常用邮箱</label>
				<div class="col-sm-4">
					<input type="email" class="form-control " 
						name="user.common_mail" maxlength="40" data-toggle="tooltip" data-placement="right" title="格式必须正确">  
				</div>
			</div>
			<div class="form-group">
				<label for="inputPassword3" class="col-sm-4 control-label">密码</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="user.user_pass"
						maxlength="18" data-toggle="tooltip" data-placement="right" title="密码应在6-18位，且不包含特殊字符">
				</div>
			</div>
			<div class="form-group">
				<label for="inputcPassword3" class="col-sm-4 control-label">确认密码
				</label>
				<div class="col-sm-4">
					<input type="password" class="form-control" name="conf_pass" maxlength="18" onkeypress='if(event.keyCode==13) document.getElementById("submit_form").click()'> 
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-4 col-sm-4 ">
					<button type="button" class="btn-glow primary btn-lg btn-block" id="submit_form" >Sign up</button>
					<button type="button" class="btn-glow sueecss btn-lg btn-block" onclick="javascript :history.back(-1)" >Return</button>
				</div>
			</div>
		</form>
	</div>
<%@include file="footer.jsp" %>

<script type="text/javascript">
	$(document).ready(function() {
		//获取焦点
		var ispass=[];
		$("#signup_form input").on('focus',function() {
			$(this).closest("div.form-group").attr("class","form-group");//复原
		});
		$("#signup_form input[name='user.user_account']").on("blur",function(e){
			var $obj=$(this);
			if($(this).val()!=null&&$(this).val()!=""){
				var data_={account:$(this).val()};
				var submitURL="${path}/signup!isAccount?date"+new Date()+"";
				jQuery.post(submitURL,data_,function(jsonData){
					if(!jsonData.info){
						alert("该账号已经被注册");
						$obj.closest("div.form-group").addClass("has-error");
						ispass.push(false);
					}
				},"json");
			}
		});
		$("#submit_form").on('click',function() {
			var email = /^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)$/;
			var mima = /^(\w){6,20}$/;
			var account=/^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){4,19}$/;//用户名字母开头5-20位
			var obj_input=$("#signup_form input");
			var pass_str;
			//alert(ispass.length);
			obj_input.each(function(i,n){
				var $obj = $(n);
				var name_str=$obj.attr("name");
				switch (name_str){
					case "user.user_account":
						if(isNull($obj.val())){
							alert("用户名不可为空");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
							return;
						}else if(!account.exec($obj.val())){
							alert("用户名不符合规范");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
							return;
						}
						break;
					case "user.common_mail":
						if(!email.exec($obj.val())){
							alert("邮箱不符合规范");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
							return;
						}
						break;
					case "user.user_pass":
						pass_str=$obj.val();
						if(isNull(pass_str)){
							alert("密码不可为空");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
						}else if(!mima.exec(pass_str)){
							alert("密码不符合规范");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
						}
						break;
					case "conf_pass":
						if(isNull($obj.val())){
							alert("请重新输入密码");
							$obj.closest("div.form-group").addClass("has-error");
						}else if(pass_str!=$obj.val()){
							alert("两次密码不相等");
							$obj.closest("div.form-group").addClass("has-error");
							ispass.push(false);
							return ;
						}
						break;
					default:
						break;
				}
				//ispass = true;
			});
			//alert(ispass.length);
			if(ispass.length>0){
				ispass=[];
				return;
			}
			
			var submitURL="${path}/signup!signupone?date="+new Date()+"";
			$("#signup_form").attr("action",submitURL);
			$("#signup_form").submit();
			/*jQuery.post(submitURL,form_data,function(jsonData){
				if(jsonData.info){
					alert(jsonData.text);
					window.location.replace("${path}/signup!next");
				}else{
					alert("注册失败：原因：\n"+jsonData.text)
				}
			},"json");
			*/
		});
	});
	function isNull(str){
		if(str==null||str=="")
			return true;
		else
			return false;
	}
</script>
</body>
</html>

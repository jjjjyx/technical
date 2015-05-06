<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/base.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>

.sign-container {
	 position: relative;
  background-color: #fff;
  -webkit-background-clip: padding-box;
          background-clip: padding-box;
  border: 1px solid #999;
  border: 1px solid rgba(0, 0, 0, .2);
  border-radius: 6px;
  outline: 0;
  -webkit-box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
          box-shadow: 0 3px 9px rgba(0, 0, 0, .5);
}

</style>
 <header class="navbar navbar-inverse navbar-fixed-top" role="banner">
	<div class="container" style="max-width: 1366px;padding: 0px;">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="navcollapse"
			data-target="#example-navbar-collapse" >
			<span class="sr-only">网站首页</span> <span class="icon-bar" ></span> <span
				class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="#">Technical<i
			class="icon-reorder visible-xs-inline"
			style="font-size: 15px; margin-left: 10px;" id="menu-toggler"></i></a>
	</div>
	<div class="collapse navbar-collapse" id="example-navbar-collapse">
		<ul class="nav navbar-nav">
		<%
			String active=(String)request.getAttribute("active");
		%>
			<li class="<%if(active==null||active.equals("sy")) out.print("active");%>"><a href="${path }/hello">首页</a></li>
			
			<li class="<%if(active.equals("api"))  out.print("active");%>"><a href="#">帮助</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="hidden-xs hidden-sm notification-dropdown">
				<a href="#" class="trigger" style="font-size: 17px; color: #9ba3ad">
                    <i class="icon-envelope" ></i>
                    <span class="count">${fn:length(mycommentlist)==0?"":fn:length(mycommentlist) }</span>
                </a>
                <div class="pop-dialog">
                    <div class="pointer right">
                        <div class="arrow"></div>
                        <div class="arrow_border"></div>
                    </div>
                    <div class="body">
                        <a href="#" class="close-icon"><i class="icon-remove-sign"></i></a>
                        <div class="messages">
                        <c:forEach var="l" items="${mycommentlist }">
                            <a href="#" class="item">
                                <img src="${path }${l['user_head_path'] }" class="display img-thumbnail a-flipinY" />
                                <div class="name">${l['comment_user_id'] }</div>
                                <div class="msg">
                                  		 ${l['comment_content']}
                                </div>
                                <span class="time"><i class="icon-time"></i> ${l['comment_time'] }.</span>
                            </a>
                            </c:forEach>
                            <c:if test="${fn:length(mycommentlist)==0 }">
                            	 <a href="#" class="item">
                            	 	没有新消息
                            	 </a>
                            </c:if>
                            <div class="footer">
                                <a href="${path }/user!mycomment?old=true" class="logout">查看所有消息</a>
                            </div>
                        </div>
                    </div>
                </div>
			</li>
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"  data-toggle="tooltip" data-placement="left" 
   					title="${sessionScope.user.user_name==null?sessionScope.user.user_account:sessionScope.user.user_name  }" data-delay="{show:1000, hide: 100}" style="min-width: 100px;"> 
					<img src="${path }${sessionScope.user.user_head_path }"	<%--${path}/Images/default.gif --%>
					height="30" height="30" class="img-circle" width="30" style="margin-right: 5px;">${sessionScope.user.user_name==null?sessionScope.user.user_account:sessionScope.user.user_name  }
			</a>
				<ul class="dropdown-menu">
					<li><a href="${path }/person!newBBS"><i class="icon-paste"></i>发表新文章</a></li>
					<li><a href="${path }/person!index"><i class="icon-user"></i>个人主页</a></li>
					<li><a href="#"><i class="icon-cog"></i>账号设置</a></li>
					<li class="divider"></li>
					<li><a href="#" data-outlock><i class="icon-off"></i>退出</a></li>
				</ul>
			</li>
			</c:if>
		</ul>
	</div>
	</div>
</header>
<div class="modal fade" id="signmodel" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
   		 <div class="login-wrapper">

        	<div class="box" style="margin-top: 10px;">
            <div class="content-wrap">
                <h6>登录</h6>
                <form id="login" method="post">
                <input class="form-control" type="text" placeholder="用户名" name="user.user_account">
                <input class="form-control" type="password" placeholder="密码" name="user_pass" onkeypress='if(event.keyCode==13) document.getElementById("signin").click()'>
                <a href="#" class="forgot">忘记密码?</a>
                <div class="remember">
                    <input id="remember" type="checkbox" name="remember">
                    <label for="remember">记住密码</label>
                </div>
                </form>
                <a class="btn-glow primary login" href="#" id="signin">登录</a>
                <a class="btn-glow primary login" href="#" data-dismiss="modal">取消</a>
                
            </div>
        </div>
   	</div>
</div>
</div>


<script type="text/javascript">
<!--
var loadnum=getCookie("loagnum");
$(document).ready(function() {
	$("[data-toggle='tooltip']").tooltip();
		$("#load_btn").on("click",function(e){
			$("#signmodel").modal('show');
		});
		$("[data-outlock]").click(function(){
			var submitURL = "${path}/signin!outlock?date="+new Date()+"";
			jQuery.post(submitURL,null,function(jsonData){
				if(jsonData.info){
					alert(jsonData.text);
					window.location.replace("${path}/hello");
				}else
					alert("失败，原因：\n"+jsonData.text);
			},"json");
		});
});
$(function () {
	if(window.parent.location.href!=window.location.href){
		top.location.href=window.location.href;
	}
	if(getCookie("cb")=="true"){
		document.getElementById('remember').checked=true;
		$("#signmodel input[name='user.user_account']").val(getCookie("mail"));
		$("#signmodel input[name='user_pass']").val(getCookie("pass"));
	}
	 // bg switcher
    var $btns = $(".bg-switch .bg");
    $btns.click(function (e) {
        e.preventDefault();
        $btns.removeClass("active");
        $(this).addClass("active");
        var bg = $(this).data("img");

        $("html").css("background-image", "url('${path }/dist/img/bgs/" + bg + "')");
    });
    $("#remember").on("change",function(){
    	setCookie("cb",document.getElementById('remember').checked,60*60*24);
    });
    $("#signin").on("click",function(e){
    	// 登录验证
    	if($("#signmodel input[name='user.user_account']").val()==""||$("#signmodel input[name='user.user_account']").val().length<=0){
			alert("用户名不可为空");
			$("#signmodel input[name='user.user_account']").focus();
			return;
		}else if($("#signmodel input[name='user_pass']").val()==""||$("#signmodel input[name='user_pass']").val().length<=0){
			alert("密码不可为空");
			$("#signmodel input[name='user_pass']").focus();
			return;
		}
    	//hex_md5
    	var pass=$("#signmodel input[name='user_pass']").val();
    	
		var t=$('#login').serializeArray();
		t.push({name:"user.user_pass",value:hex_md5(pass)})
		var submitURL = "${path}/signin!login?date="+new Date()+"";
		jQuery.post(submitURL,t,function(jsonData){
			if(jsonData.info){
				if(document.getElementById('remember').checked==true){
					setCookie('mail',$("#signmodel input[name='user.user_account']").val(),60*60*24);
					setCookie('pass',pass,60*60*24);
				}

				window.location.replace("${path}/hello");
			}else{
				alert(jsonData.text);
				$("#signmodel input[name='user.user_account']").focus();
			}
		},"json");
    	//top.location.href="${path}/index.html";
    })
});
//-->
</script>

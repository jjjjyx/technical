<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../common/base.jsp"%>
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
			
			<div class="col-sm-7 middle" id="content_body">
			<form action="${path }/person!index">
				<div class="panel panel-info">
					<div class="panel-heading"><ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a>
						  </li>
						 </ol></div>
					<div class="panel-body">
						<ul class="home_ul">
							<c:forEach var="l" items="${allbbsResult.currentList }">
							<li>
								<img class="img-circle a-flipinY"  src="${path }${l['user_head_path'] }">
								<a class="home_bbs_list_name" href="#">${l['user_id'] }</a>
								
								<c:choose>
									<c:when test="${sessionScope.user.user_account==l['user_id']}">
										
									</c:when>
									<c:when test="${l['IsBelongToMyFriend']==1}">
										<i class="icon-heart" title="取消关注" data-useraccount="${l['user_id'] }"></i>
									</c:when>
									<c:when test="${l['IsBelongToMyFriend']==0}">
										<i class="icon-heart-empty" title="关注" data-useraccount="${l['user_id'] }"></i>
									</c:when>
								</c:choose>
								<span class="home_bbs_list_time"><fmt:formatDate value="${l['create_time'] }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
								<div class="home_bbs_list_title">
									<h3><a href="${path }/person!bbsContent?bbs_id=${l['bbs_id']}">${l['bbs_title'] }</a></h3>
									<span><i class="icon-comment-alt"></i>评论(${l['commentcount'] })</span>
									<%--layer-user 楼层作者 --%>
									<span><a href="javascript:void(0);">收藏</a></span>
									<span><a href="javascript:void(0);">举报</a></span>
								</div>
							</li>
							</c:forEach>
							
						</ul>
					</div>
					<div class="panel-footer">
						<a href="javascript:void(0);"  data-currentpage="${allbbsResult.pageutil.per }">上一页</a>
						<a href="javascript:void(0);"  data-currentpage="${allbbsResult.pageutil.next }">下一页</a>
					</div>
				</div>
				<input type="hidden" name="currentPage" value="${allbbsResult.pageutil.currentPage }">
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
			/*$("#left_menu_div").pin({
				containerSelector: ".row"
			});*/
			$("#content_body .panel-footer>a").on("click",function(e){
				var $this=$(this);
				$("#content_body input[name='currentPage']").val($this.data("currentpage"));
				$("#content_body form").submit();
				//设置分页，排序 就不写 不怎么需要
			});
			$(".icon-heart").click(function(){
				//验证成功
				var submitURL="${path}/friend!removefriend?date="+new Date()+"";
				var form_data=[{name:"user_account",value:$(this).data("useraccount")}];
				jQuery.post(submitURL,form_data,function(jsonData){
					var info =jsonData.info;
					if(info){
						alert("已取消关注");
						window.location.href="${path}/person!index";
					}else{
						alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
					}
				},"json");
			});
			$(".icon-heart-empty").click(function(){
				//验证成功
				var submitURL="${path}/friend!addfriends?date="+new Date()+"";
				var form_data=[{name:"user_account",value:$(this).data("useraccount")}];
				jQuery.post(submitURL,form_data,function(jsonData){
					var info =jsonData.info;
					if(info){
						alert("已关注");
						window.location.href="${path}/person!index";
					}else{
						alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
					}
				},"json");
			});
		});
	</script>
</body>
</html>
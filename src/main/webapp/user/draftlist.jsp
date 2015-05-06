<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<div class="container contanier-body">
		<div class="user_info-container a-bounceinB">
			<%@include file="person.jsp" %>
		</div>
	
		
		<div class="row">
			<!-- 左侧菜单 -->
			<div class="col-sm-2 hidden-xs sides">
				<%@include file="left_menu.jsp" %> 
			</div>
			<!-- 中间内容 -->
			<div class="col-sm-7 middle" id="content_body">
				<form action="${path }/person!draft" method="post" id="edit_list_from">
					<div class="panel panel-info">
						<div class="panel-heading"><ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a>
						  </li>
						  <li><a href="${path }/person!draft">草稿箱</a></li>
						 </ol>
						 </div>
						<div class="panel-body">
							<ul class="media-list">
							<c:forEach var="l" items="${draftResult.currentList }">
								<li class="media">
							    <div class="media-body">
							      <h4 class="media-heading" title="继续编辑"><a href="${path }/person!newBBS?bbs_id=${l.bbs_id}">
							      	<i class="icon-edit"></i>${l.bbs_title }</a><i class="icon-trash" data-oper="del" data-target="${l.bbs_id}"></i><small>${l.create_time }</small></h4>
							    </div>
							  </li>
							</c:forEach>
							<c:if test="${fn:length(draftResult.currentList)==0 }">
								<li class="footer">
									<a href="${path }/person!newBBS">草稿箱空空如也，去发布新文章吧</a>
								</li>
							</c:if>
							</ul>
						</div>
						<div class="panel-footer" style="min-height: 40px;">
							<a href="javascript:void(0);"  data-currentpage="${draftResult.pageutil.per }">上一页</a>
							<a href="javascript:void(0);"  data-currentpage="${draftResult.pageutil.next }">下一页</a>
						</div>
					</div>
					<input type="hidden" name="currentPage" value="${draftResult.pageutil.currentPage}">
					<input type="hidden" name="orderType" value="${draftResult.pageutil.orderType}">
					<input type="hidden" name="sortField" value="${draftResult.pageutil.sortField}">
				</form>
			</div>
			<!-- 右侧功能区 -->
			<div class="col-sm-3 hidden-xs">
				<%@include file="right_menu.jsp" %>
			</div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
	<script type="text/javascript">
		$(function(){
			
		});
		$(document).ready(function() {
			$("#edit_list_from .panel-footer>a").on("click",function(e){
				
				var $this=$(this);
				$("#edit_list_from input[name='currentPage']").val($this.data("currentpage"));
				$("#edit_list_from").submit();
				//设置分页，排序 就不写 不怎么需要
			});
			$("ul.media-list i.icon-trash[data-oper='del']").click(function(){
				var submitURL="${path}/person!delbbs?date="+new Date()+"";
				var form_data=[{name:"bbs_id",value:$(this).data("target")}];
				jQuery.post(submitURL,form_data,function(jsonData){
					var info =jsonData.info;
					if(info){
						alert("删除成功")
						window.location.reload(true);
					}else{
						alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
						return ;
					}
				},"json");
			});
		});
		
	</script>
</body>
</html>
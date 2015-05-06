<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
			<form action="${path }/person!bbsList" method="post" id="bbs_list_from">
				<div class="panel panel-info">
					<div class="panel-heading">
						<ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a></li>
						  <li><a href="${path }/person!bbsList">我的文章列表</a></li>
						  <%
						  	String s=(String)request.getAttribute("category");
						  	if(s!=null&&!"".equals(s)){
						  		out.print("<li><a href=\"#\">"+s+"</a></li>");
						  	}
						  %>
						</ol>
					</div>
					<div class="panel-body" id="">
						<ul class="media-list">
							<c:forEach var="l" items="${bbsResult.currentList }">
								<li class="media">
							    <div class="media-body">
							      <h4 class="media-heading" ><a href="${path }/person!bbsContent?bbs_id=${l.bbs_id}" title="点击查看">
							      	<i class="icon-paste"></i>${l.bbs_title }</a><i class="icon-trash" data-oper="del" data-target="${l.bbs_id}"></i><small>${l.create_time }</small></h4>
							    </div>
							  </li>
							</c:forEach>
							<c:if test="${fn:length(bbsResult.currentList)==0 }">
								<li class="footer">
									<a href="${path }/person!newBBS">还没有发布任何文章，去试试发表一篇新文章</a>
								</li>
							</c:if>
						</ul>
					</div>
					<div class="panel-footer">
						<a href="javascript:void(0);"  data-currentpage="${bbsResult.pageutil.per }">上一页</a>
						<a href="javascript:void(0);"  data-currentpage="${bbsResult.pageutil.next }">下一页</a>
					</div>
				</div>
					<input type="hidden" name="category" value="${category }">
					<input type="hidden" name="currentPage" value="${bbsResult.pageutil.currentPage}">
					<input type="hidden" name="orderType" value="${bbsResult.pageutil.orderType}">
					<input type="hidden" name="sortField" value="${bbsResult.pageutil.sortField}">
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
		$(document).ready(function() {
			$("ol.breadcrumb:last-child").addClass("active");
			$("#bbs_list_from .panel-footer>a").on("click",function(e){
				var $this=$(this);
				$("#bbs_list_from input[name='currentPage']").val($this.data("currentpage"));
				$("#bbs_list_from").submit();
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
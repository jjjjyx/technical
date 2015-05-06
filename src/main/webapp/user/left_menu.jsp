<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/base.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<ul class="list-group" id="dashboard_menu">
	<li >
		<a href="${path }/person!index"><i class="icon-home"></i><span>首页</span></a>
	</li>
	<li>
		<a href="${path }/user!info" ><i class="icon-user"></i><span>个人资料</span></a>
	</li>
	<li>
		<a href="${path }/user!mycomment" ><i class="icon-comments"></i><span>评论我的</span><span class="badge">${fn:length(mycommentlist)==0?"":fn:length(mycommentlist)}</span></a>
	</li>
	<li>
		<a href="#"  class="dropdown-toggle"><i class="icon-tasks"></i><span>我的文章</span><i class="icon-chevron-down"></i></a>
		<ul class="submenu">
			<c:forEach var="l" items="${categoryList }">
				<li><a href="${path }/person!bbsList?category=${l['name']}" data-url-a="">${l['name'] }(${l['catecount']})</a></li>
			</c:forEach>
		</ul>
	</li>
	<li>
		<a href="${path }/person!draft" ><i class="icon-edit"></i><span>草稿箱</span><span class="badge">${draftcount==0?"":draftcount}</span></a>
	</li>
	<li>
		<a href="${path }/friend!list"><i class="icon-heart-empty"></i><span>我的关注</span></a>
	</li>
	
</ul>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#dashboard_menu a").click(function(){
				setCookie("dashboard_menuisactive", $(this).closest("#dashboard_menu>li").index());
			});
			/*$("a[data-url-a]").each(function(i){
				var $this=$(this);
				//$this.attr("href",$this.attr("href")+encodeURI($this.data("url-a")).replace(/\+/g,'%2B'));
				$this.attr("href",$this.attr("href")+$this.data("url-a"));
			});*/
			var dashboard_menuisactive=getCookie("dashboard_menuisactive");
			if(dashboard_menuisactive!=null&&dashboard_menuisactive!="")
				$("#dashboard_menu>li").eq(dashboard_menuisactive).addClass("active");
			else
				$("#dashboard_menu>li").eq(0).addClass("active");
		});
		
	</script>

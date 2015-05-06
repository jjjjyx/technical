<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/base.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<ul class="list-group" id="right-menu">
	<li>
		<a class="" href="${path }/person!newBBS"><i class="icon-edit"></i><span>写文章</span></a>
	</li>
	<li>
	<form action="" id="top_right_from"></form>
		<h6>置顶区</h6>
		<hr>
		<ul class="right_ul">
		<c:forEach var="l" items="${top_right_list.currentList }">
			<li><img class="img-circle a-flipinY"  src="${path }${l['user_head_path'] }">
				<a class="right_bbs_list_name" href="${path }/person!bbsContent?bbs_id=${l['bbs_id']}">${l['bbs_title'] }</a>
			</li>
		</c:forEach>
			<li><i class=" icon-chevron-left" data-currentpage="${top_right_list.pageutil.per }"></i>
				<i class=" icon-chevron-right" data-currentpage="${top_right_list.pageutil.next }"></i></li>
		</ul>
		<input type="hidden" name="currentPage" value="${top_right_list.pageutil.currentPage }">
		</form>
	</li>
</ul>
<script type="text/javascript">
		$(document).ready(function() {
			`$(".right_ul li:last i").on("click",function(e){
				var $this=$(this);
				$("#top_right_from input[name='currentPage']").val($this.data("currentpage"));
				alert(window.location.href)
				$("#top_right_from").attr("action",window.location.href);
				$("#top_right_from").submit();
				//设置分页，排序 就不写 不怎么需要
			});
		});
</script>	
	
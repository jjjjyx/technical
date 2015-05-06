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
<script src='${path }/dist/js/pageutil.js' type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="${path }/ueditor1_3_6-utf8-jsp/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${path }/ueditor1_3_6-utf8-jsp/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="${path }/ueditor1_3_6-utf8-jsp/lang/zh-cn/zh-cn.js"></script>
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
.person-info{
	padding: 8px 15px;
	margin-bottom: 10px;
	background-color: #9999FF;
	border-radius: 4px;
	text-align: left;
	font-weight: 900;
}
.person-name{
	text-align: center;
	font-size: 12px;
	margin-top: 5px;
	margin-bottom: 10px;
}
.panel-body .row{
	margin-top: 10px;
}
.bbs_title{
	margin:3px 3px;
}
.bbs_title a{
	font-family: "黑体";
	color: #000;
	text-decoration: none;
}
.bbs_title span{
	margin-top: 30px;
	color: #333;
}
.caption{
	overflow-x: auto;
}
.ys-01{
	text-align: center;
}
.ys-02 span{
	margin-right: 10px;
}
.ys-03 i{
	font-size: 10px;
}
.bbs_manage{
	padding:3px 10px; 
	margin-bottom: 10px;
	height: 40px;
}

.bbs_manage div:last-child{
	float: right;
}
.look_comment{
	text-align: center;
	cursor: pointer;
	margin-top: 5px;
}
.look_comment:hover{
	background-color:#ccc;
	border-radius: 4px;
}
.look_comment span{
	font-size: 15px;
}
.look_comment i{
	margin-right: 5px;
	
}
#comment_row .btn_div *{
	float: left;
}
#comment_row .vali{
	display: block;
  width: 100px;
  height: 30px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.428571429;
  color: #555555;
  vertical-align: middle;
  background-color: #ffffff;
  border: 1px solid #cccccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075);
  -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  margin-left: 8px;
  margin-right: 8px;
}
</style>
</head>
<body>
	<%@include file="../head.jsp"%>
	<%-- 这里是页面主体 --%>
	<div class="container-fluid contanier-body" style="padding: 0px 30px;" >
		<div class="user_info-container a-bounceinB">
			<%@include file="person.jsp" %>
		</div>
		<div class="row">
			<!-- 中间内容 -->
			<div class="col-sm-12 middle">
				<div class="panel panel-info">
					<div class="panel-heading"><ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a></li>
						  <c:if test="${bbscontentBean['bbsauthor']==sessionScope.user.user_account}">
						  	<li><a href="${path }/person!bbsList">我的文章列表</a></li>
						  </c:if>
						  <li><a href="${path }/person!bbsContent?bbs_id=<%=request.getParameter("bbs_id")%>">${bbscontentBean['bbsTitle'] }</a></li>
						</ol>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-2 hidden-xs">
								<div class="thumbnail">
							      <div class="person-info">楼主资料</div>
							      <div class="caption ys-01">
							        <img src="${path }${bbscontentBean['authorheadsrc']}" alt="..." class="img-thumbnail">
							        <p class="person-name">${bbscontentBean['bbsauthor']}</p>
							        <div class="col-sm-12 ys-03">
										<a href="#" class="btn btn-primary btn-xs" role="button"><i class="icon-tag"></i>看资料</a>
										<c:if test="${bbscontentBean['bbsauthor']!= sessionScope.user.user_account}">
											<a href="javascript:void(0);" class="btn btn-primary btn-xs" data-friend="addfriend" data-target="${bbscontentBean['bbsauthor']}"><i class="icon-plus"></i>加关注</a>
										</c:if>
									</div>
									<!--  <div class="col-sm-12 ys-02">
										<span >粉丝：0</span>
										<span>文章数：0</span><br>
										<span>评论：</span>
										<span></span>
									</div>-->
							      </div>
							    </div>
							</div>
							<div class="col-sm-10" style="padding-left: 0px;">
								<div class="thumbnail" style="padding: 10px 20px;">
									<div class="bbs_title">
										<h3><a href="${path }/person!bbsContent?bbs_id=<%=request.getParameter("bbs_id")%>">${bbscontentBean['bbsTitle'] }</a></h3>
									</div>
									<div class="bbs_manage">
										<span>分类：<a href="${path }/person!bbsList?category=" data-url-a="${bbscontentBean['bbsCategory']}">${bbscontentBean['bbsCategory'] }</a></span>
										<div>
											<span style="color: #bbb;margin-right: 5px;"><fmt:formatDate value="${bbscontentBean['bbscreatetime'] }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
											<span><a href="#comment_div" data-pid="${bbscontentBean['bbsId'] }" data-layer-user="${bbscontentBean['bbsauthor']}"><i class="icon-comment-alt"></i>评论(0)</a></span>
											<%--layer-user 楼层作者 --%>
											<span><a href="javascript:void(0);">收藏</a></span>
											<span><a href="javascript:void(0);">举报</a></span>
										</div>
									</div>
									<div class="caption ys-04">
										${bbscontentBean['bbsContent'] }
									</div>
									
								</div>
								<div class="look_comment" data-loading-text="<span><i class='icon-spinner icon-spin'></i>展开评论</span>">
										<span><i class="icon-chevron-down"></i>展开评论</span><!-- icon-chevron-up   (icon-spinner icon-spin) -->
								</div>
							</div>
						</div>
						<div id="comment_list" style="display: none;">
						<form action="" id="comment_list_form">
							<div class="row" style="display: none" id="no_comment">
							<div class="col-md-10 col-sm-offset-2">
								<span>还没有人评论，快来<a href="#comment_div" data-pid="${bbscontentBean['bbsId'] }" data-layer-user="${bbscontentBean['bbsauthor']}">挽尊~</a></span>
							</div>
						</div>
						<c:forEach var="l" items="${bbscontentBean['list']}" varStatus="s">
							<div class="row" id="${l['comment_id'] }">
								<div class="col-sm-2 hidden-xs">
									<div class="thumbnail">
								      <div class="person-info">${l['comment_layer'] }楼资料</div>
								      <div class="caption ys-01">
								        <img src="${path }${l['user_hear_src']}" alt="..." class="img-thumbnail">
								        <p class="person-name">${l['comment_user_id'] }</p>
								        <div class="col-sm-12 ys-03">
											<a href="#" class="btn btn-primary btn-xs" role="button"><i class="icon-tag"></i>看资料</a>
											<c:if test="${l['comment_user_id']!= sessionScope.user.user_account}">
												<a href="#" class="btn btn-primary btn-xs" data-friend="addfriend" data-target="${l['comment_user_id']}"><i class="icon-plus"></i>加关注</a>
											</c:if>
										</div>
								      </div>
								    </div>
								</div>
								<div class="col-sm-10" style="padding-left: 0px;">
									<div class="thumbnail" style="padding: 10px 20px;">
										<div class="bbs_manage">
											<span>回复：${l['comment_pname'] }</span>
											<div>
												<span style="color: #bbb;margin-right: 5px;"><fmt:formatDate value="${l['comment_time'] }" pattern="yyyy-MM-dd HH:mm:ss"/></span>
												<span><a href="#comment_div" data-pid="${l['comment_id'] }" data-layer-user="${l['comment_user_id'] }"><i class="icon-comment-alt"></i>评论</a></span>
												<!--  data-pid该层的id -->
												<span><a href="javascript:void(0);">举报</a></span>
											</div>
											
										</div>
										<div class="caption">${l['comment_content'] }</div>
									</div>
								</div>
							</div>
						</c:forEach>
						<div class="row">
							<div class="col-md-10 col-sm-offset-2">
								<div id="page_pack" data-pagejson='${bbscontentBean["pageinfo"]}' data-type="page_pack">
								</div>
							</div>
						</div>
						<input type="hidden" name="bbs_id" value="${bbscontentBean['bbsId'] }">
						</form>
						</div>
						<div class="row" style="display: none;" id="comment_row">
							<form action="" id="comment_form">
								<div class="col-sm-10 col-sm-offset-2" style="padding-left: 0px;">
									<p>回复：<span id="quote_span"></span></p>
									<input type="hidden" name="commentbean.comment_pid">
									<input type="hidden" name="bbs_id" value="${bbscontentBean['bbsId'] }">
								</div>
								<div class="col-sm-10 col-sm-offset-2" style="padding-left: 0px;" id="comment_div">
									<script id="bbscomment" name="content_str" type="text/plain" style="width:50%;height:200px;"></script>
								</div>
								<div class="col-sm-10 col-sm-offset-2 btn_div" style="padding-left: 0px;margin-top: 10px;" >
									<button type="button" class="btn-flat primary" id="comment_form_submit" data-loading-text="<i class='icon-spinner icon-spin'></i>">发表</button>
									<input type="text" name="vali" placeholder="输入右侧的验证码" class="vali" onkeypress='if(event.keyCode==13) document.getElementById("comment_form_submit").click()'>
									<img id="img_vali" alt="" src="${path }/img/vc.jpg" onclick="this.src='${path }/img/vc.jpg?'+new Date().getTime()">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="../footer.jsp"%>
	<script type="text/javascript">
		
		$(function(){
			var comment_up_down=getCookie("comment_up_down");
			if(comment_up_down!="")
				if(comment_up_down=="icon-chevron-up"){
					$(".look_comment").html("<span><i class=\"icon-chevron-down\"></i>收起评论</span>");
					$("#comment_list").show();
				}
			var config_json = {
				 	toolbars:[
				            ['fullscreen', 'source', '|', 'undo', 'redo', '|','insertimage','emotion','|','insertcode']
				        ],wordCount:true,maximumWords:144 ,wordCountMsg:'当前已输入 {#count} 个字符，您还可以输入{#leave} 个字符'
				        	,wordOverFlowMsg:'<span style="color:red;">你输入的字符个数已经超出最大允许值，服务器可能会拒绝保存！</span>'   
				};
			//渲染编辑器	
			var editue=UE.getEditor('bbscomment',config_json);
			$(document).ready(function() {
				//点击评论
				$("a[href='#comment_div']").click(function(){
					$("#comment_row").slideDown();
					$("#quote_span").html($(this).data("layer-user"));
					$("#comment_form input[name='commentbean.comment_pid']").val($(this).data("pid"));
				});
				//展开评论&收起评论
				$(".look_comment").bind("click",function(e){
					var $thisobj=$(this);
					var i=$thisobj.find("i");
					if(i.hasClass("icon-chevron-down")){
						setCookie("comment_up_down","icon-chevron-up" );
						$thisobj.html("<span><i class=\"icon-chevron-up\"></i>展开评论</span>");
					}else{
						setCookie("comment_up_down","icon-chevron-down" );
						$thisobj.html("<span><i class=\"icon-chevron-down\"></i>收起评论</span>");
					}
					$("#comment_list").slideToggle();
					
				});
				$("#comment_form_submit").bind("click",function(e){
					var $thisobj=$(this);
					$thisobj.button('loading');
					var contentLength=editue.getContentLength(true);
					if(contentLength==0){
						alert("内容不可为空");
						editue.focus();
						return $thisobj.button('reset');
					}else if(contentLength>144){
						alert("字数超出限制,请简要概述");
						editue.focus();
						return $thisobj.button('reset');
					}
					var vali=$("#comment_form input[name='vali']").val();
					if(vali==null||""==vali){
						alert("请输入验证码");
						return $thisobj.button('reset');
					}
					//验证成功
					var submitURL="${path}/person!saveBBScomment?date="+new Date()+"";
					var form_data=$("#comment_form").serializeArray();
					form_data.push({name:"commentbean.comment_pname",value:$("#quote_span").html()});
					jQuery.post(submitURL,form_data,function(jsonData){
						var info =jsonData.info;
						if(info){
							$thisobj.button('reset');
							alert("评论成功");
							window.location.reload(true);
						}else{
							alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
							$("#img_vali").click();
							return $thisobj.button('reset');
						}
					},"json");
				});
				if(jQuery("#page_pack").data("pagejson")!=null&&jQuery("#page_pack").data("pagejson")!=""){
					var pagepack=$("#page_pack");
		       // alert(jQuery("#page_pack").data("pagejson").pageUrl);
					CreateDom_ys2(pagepack);
					var datajson=$("#page_pack").data("pagejson");
					var formobj=pagepack.closest("form");
					formobj.attr("action",datajson.pageUrl);
					formobj.attr("method","post");
					var bObj=pagepack.find("b");
					bObj.eq(0).html(datajson.currentPage);
					bObj.eq(1).html(datajson.allPage);
					bObj.eq(2).html(datajson.maxrecord);
					bObj.eq(3).html(datajson.allResult);
					//判断结果条数
					if(datajson.allResult*1==0){
						
						$("#no_comment").show();
					}
					//默认等于当前页
					$("#page_pack input[name='currentPage']").val(datajson.currentPage);
					$("#page_pack input[name='sortField']").val(datajson.sortField);
					$("#page_pack input[name='orderType']").val(datajson.orderType);
					//alert(intputobj.eq(0).val());
					var per=datajson.per;
					var next=datajson.next;
					var currentPage=datajson.currentPage;
					var buttonper=$("[data-direction='per']");
					var buttonnext=$("[data-direction='next']");
					
					//$("input[name='maxrecord']").val(datajson.maxrecord);
					if(per*1==currentPage*1){
						buttonper.addClass("disabled");
					}else{
						buttonper.removeClass("disabled");
					}
					
					if(next*1==currentPage*1){
						buttonnext.addClass("disabled");
					}else if(next*1==0){
						buttonnext.addClass("disabled");
					}else{
						buttonnext.removeClass("disabled");
					}
					
					if(!buttonper.hasClass("disabled")){
						buttonper.bind("click",function(){
							$("#page_pack input[name='currentPage']").val(datajson.per);
							formobj.submit();
							//alert(formobj.serialize());
						});
					}
					if(!buttonnext.hasClass("disabled")){
						buttonnext.bind("click",function(){
							$("#page_pack input[name='currentPage']").val(datajson.next);
							formobj.submit();
						});
					}
				}
			});
		});
	</script>
</body>
</html>

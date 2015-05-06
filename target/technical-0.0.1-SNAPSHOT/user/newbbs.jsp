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
<link rel="stylesheet" href="${path }/dist/css/jquery.Jcrop.css">

<script src="${path }/dist/js/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="${path }/dist/js/bootstrap.min.js"></script>
<script src="${path }/dist/js/theme.js"></script>
<script src="${path }/dist/js/cookie.js"></script>
<script src="${path }/dist/js/getmd5.js"></script>
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
input[type='text'].input_p{
font-size: 26px !important;
color: #000;
	text-align: center;
	font-family: "黑体";
	height: 50px;
	padding: 3px 15px;
	height: 50px;
	padding: 3px 15px;
}
.input_p:-ms-input-placeholder{
	color: #000;
	
	text-align: center;
	font-family: "黑体";

}
.select_category{
	height: 40px;
	padding: 10px;
	margin: 0px;
}

.select_category>p>label{
	font-weight: normal;
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
			<div class="col-sm-2 hidden-xs sides">
				<%@include file="left_menu.jsp" %>
			</div>
			<!-- 中间内容 -->
			<form action="" id="bbsContent_form" class="form-horizontal" method="post">
			<div class="col-sm-10 middle">
				<div class="panel panel-info">
					<div class="panel-heading">
					<ol class="breadcrumb" style="margin: 0px;">
						  <li><a href="${path }/person!index">首页</a> </li>
						  <li><a href="${path }/person!newBBS">新建文章</a></li>
						 </ol>
					</div>
					<div class="panel-body">
						<div class="row" style="margin-bottom: 10px;">
							<div class="form-group" style="text-align: center;">
								<div class="col-sm-8 col-md-offset-2">
									<input type="hidden" name="bbsBean.bbs_id" value="${bbs_id }">
									<input type="text" class="form-control input_p" name="bbsBean.bbs_title" maxlength="30" 
										placeholder="请在这里输入标题" value="${bbs_content_map['bbsTitle'] }">
								</div>
							</div>
						</div>
						<script id="bbsContent" name="content_str" type="text/plain" style="width:100%;height:300px;">
							${bbs_content_map['bbsContent'] }
						</script>
						
					<div class="row" style="margin-top: 10px;">
						<div class="select_category" id="category_p">
							<p style="float: left;">
								<label class="">文章分类</label>
								<select class="" style="width: 100px;" id="category_list" name="bbsBean.category">
									  <c:forEach var="t" items="${categoryList}">
									  	 <option value="${t['name'] }" <c:if test="${bbs_content_map['bbsCategory']==t['name'] }">selected="selected"</c:if>>${t['name'] }</option>
									  </c:forEach>
								</select>
								<a href="javascript:void(0);" title="添加分类" data-toggle="modal" data-target="#add_category">添加分类</a>
							</p>
							<%-- 
							<p style="float: right;">
								<a href="javascript:void(0);" title="添加分类" data-toggle="modal" data-target="#upload_file"><i class=" icon-upload-alt"></i>上传附件</a>
							</p>--%>
						</div>
					</div>
					</div>
					<div class="panel-footer">
						 <button type="button" class="btn btn-default" id="btn_save" data-loading-text="<i class='icon-spinner icon-spin'></i>正在保存">
						 	<i class="icon-save"></i>保存
						 </button>
	        			<button type="button" class="btn btn-primary" id="btn_release" data-loading-text="<i class='icon-spinner icon-spin'></i>正在发布">
	        				<i class="icon-leaf"></i>发布
	        			</button>
					</div>
				</div>
				</div>
			</form>
		</div>
	</div>
<div class="modal fade " id="add_category" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">新建分类</h4>
	      </div>
	      <div class="modal-body">
	       	<form action="" method="post" id="category_form">
	       		<p>分类名称：<input type="text" name="category.category_name" maxlength="12"/>(最多12个字母或6个汉字)</p>
	       	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary" id="category_form_submit">确认提交</button>
	      </div>
	    </div>
  </div>
</div>
<%-- 
<div class="modal fade " id="upload_file" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-sm">
	    <div class="modal-content ">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">上传附件</h4>
	      </div>
	      <div class="modal-body">
	       	<form action="">
				<input type="file" />	       		
	       	</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">上传</button>
	      </div>
	    </div>
  </div>
</div>
--%>
	<%@include file="../footer.jsp"%>
	<script type="text/javascript">
	$(document).ready(function() {
		$("#btn_save").bind("click",{info:"d"},saveBBS);<%--草稿 d  发布 r --%>
		$("#btn_release").bind("click",{info:"r"},saveBBS);<%--草稿 d  发布 r --%>
		$("#category_form_submit").click(function(){
			var text=$("#category_form input[name='category.category_name']").val();
			if(text==null||text==""){
				alert("分类名称不可以为空");
				return ;
			}
			var submitURL="${path}/category!addcategory?date="+new Date()+"";
			var form_data=$("#category_form").serializeArray();
			jQuery.post(submitURL,form_data,function(jsonData){
				var info =jsonData.messages.info;
				if(info){
					$("#add_category").modal('hide');
					$("<option value='"+jsonData.obj.category_name+"'>"+jsonData.obj.category_name+"</option>").appendTo($("#category_list"));
					location.hash="#category_p";
				}else{
					alert("啊哦！操作出错了\n因为："+jsonData.messages.text);
				}
			},"json");
		});
	});
	function saveBBS(e){
		var $thisobj=$(this);
		$thisobj.button('loading');
		var title=$("#bbsContent_form input[name='bbsBean.bbs_title']").val();
		if(title==null||title==""){
			alert("请输入标题");
			$("#bbsContent_form input[name='bbsBean.bbs_title']").focus();
			return $thisobj.button('reset');
		}
		var submitURL="${path}/person!saveBBS?date="+new Date()+"";
		var form_data=$("#bbsContent_form").serializeArray();
		form_data.push({name:"bbsBean.bbs_info",value:e.data.info});
		jQuery.post(submitURL,form_data,function(jsonData){
			var info =jsonData.info;
			if(info){
				$thisobj.button('reset');
				if(e.data.info=="r"){ //成功发布 跳转页面
					alert("发布成功，小伙伴们很快就可以看见您的文章了");
					window.location.replace("${path}/person!index");
				}else{
					alert("保存好了~");
				}
			}else{
				alert("啊哦，出了点小问题：原因：\n"+jsonData.text);
				return $(this).button('reset');
			}
			
		},"json");
	}
		$(function(){
			//渲染编辑器	
			UE.getEditor('bbsContent');
		});
	</script>
</body>
</html>
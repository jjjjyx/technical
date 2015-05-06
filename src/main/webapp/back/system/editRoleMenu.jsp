<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../common/base.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>

<meta http-equiv="X-UA-Compatible" content="IE=10" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="${path }/dist/css/bootstrap.css" rel="stylesheet">
<link href="${path }/dist/css/bootstrap-overrides.css" rel="stylesheet">
<link href='${path }/dist/css/zTreeStyle/zTreeStyle.css' rel='stylesheet' />

<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/icons.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">

<!-- libraries -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/font-awesome.css">

<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
<style type="text/css">
.ztree>li {
	float: left;
	display: inline;
	width: 185px;
	height: 600px;
	padding-bottom: 20px;
}
.ztree>li:nth-child(even){
	background-color: #f9f9f9;
}
.ztree span.button.switch{
	display: none;/* 取消树的+/-*/
}
</style>
</head>
<body>
	<div class="panel panel-default">
		<div class="panel-heading" style="background: none;height: 50px;">
			<i class="table-edit"></i><span>编&nbsp;辑&nbsp;角色&nbsp;权&nbsp;限 &nbsp;-&nbsp;超级管理员</span>
			<button type="button" class="btn btn-default"  style="float: right; margin-right: 60px;" onclick="javascript :history.back(-1)">取消</button>
			<button type="button"
				class="btn btn-default"
				style="float: right; margin-right: 5px;" onclick="checkedcount()">完成</button>

		
		</div>
		<div class="panel-body" style="padding: 0px;">
			<div id='MenuTreeNode' class="ztree"></div>
			<form action="${path }/back/role!editRoleMenu" method="post" id="roleEdit">
				<input type="hidden" id="roleid" name="roleid" value="<%=request.getParameter("roleid")%>">
				<input type="hidden" id="Meunid" name="menuid" value="">
				
			</form>
		</div>
	</div>

<script src="${path }/dist/js/jquery.min.js"></script>
	<script src='${path }/dist/js/bootstrap.min.js'></script>
	<script src='${path }/dist/js/jquery.ztree.core-3.5.js'></script>
	<script src='${path }/dist/js/jquery.ztree.excheck-3.5.js'></script>
	<script src='${path }/dist/js/jquery.ztree.exedit-3.5.js'></script>
	<script type="text/javascript">
		var settingMenu = {
			view : {
				selectedMulti : false,//多选
				showLine : true,//显示链接线
				txtSelectedEnable : false,//不可以选择文字
				showIcon : false,//不显示ico
				dblClickExpand: false//不允许双击展开关闭节点

			},
			async : {
				enable : false,//不使用开启异步加载
			},
			callback : {
				beforeClick : beforeClick,
			},
			data : {
				simpleData : {
					enable : true,
				}
			},
			check : {
				enable : true,
				chkStyle : "checkbox"
			}
		};
		function beforeClick(treeId, treeNode) {
			return true;
		}

		
		//完成
		function checkedcount(){
			var treeObj = $.fn.zTree.getZTreeObj("MenuTreeNode");
			var nodes = treeObj.getCheckedNodes(true);
			var purviewid ="";
			for(var i=0;i<nodes.length;i++){
				//alert(nodes[i].id);
				purviewid+=nodes[i].id+"";
				if(i<nodes.length-1)	purviewid+=",";
			}
			$('#Meunid').val(purviewid);
			//$('#roleEdit').submit();
			var formData =jQuery("#roleEdit").serializeArray();
			var saveURL ="${path }/back/role!editRoleMenu?date"+new Date()+"";
		
			jQuery.post(saveURL,formData,function(jsonData){
				var info=jsonData.info;
				if(info){
					alert("修改成功");
					history.back(-1);
				}else{
					alert("修改失败\n原因："+jsonData.text);
				}
			},"json");
		}
		$(document).ready(function() {
			var formData = jQuery("#roleEdit").serializeArray();
			//alert(formData);
			var saveURL = "${path}/back/role!loadRoleMenu?date="+new Date()+"";
			
			jQuery.post(saveURL,formData,function(jsonData){
				var ztreeobj=$.fn.zTree.init($("#MenuTreeNode"), settingMenu,jsonData);
			},"json");
		});
	</script>
</body>
</html>
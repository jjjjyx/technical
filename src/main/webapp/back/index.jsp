<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/base.jsp"%>
<%request.setAttribute("active", "sy"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${path }/dist/css/bootstrap.css" rel="stylesheet">
<link href="${path }/dist/css/bootstrap-overrides.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/layout.css">
<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/icons.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">

<!-- libraries -->
<link rel="stylesheet" type="text/css"
	href="${path }/dist/css/font-awesome.css">

<%--<link href='${path }/dist/css/zTreeStyle/zTreeStyle.css' rel='stylesheet' /> --%>
<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
<style>
#dashboard-menu a,#user_menu a{
	text-transform: none;
} 
#user_menu.ztree{
	list-style: none;
	padding-right: 15px;
	padding-left: 15px;
	margin-bottom: 0;
	margin-left: 20px;
}
.ztree>li {  position: relative;}
.ztree>li>a {display: block;
  padding: 19px 14px 15px 14px;
  margin-left: -15px;
  margin-bottom: 5px;
  border-bottom: 1px solid #dae1e8;
  box-shadow: 0 2px 1px -1px #FFFFFF;
  color: #6e829b;
  outline: 0px;
  line-height: 21px;
  cursor: pointer;}
.ztree>li>a:hover {color: #33455a;
  text-decoration: none;}

.ztree li>a.curSelectedNode {  
	color: #33455a;
	text-decoration: none;
	font-weight: 600;
	text-shadow: 1px 1px 1px #fff;}
.ztree li a.level0 span:nth-child(2) {
/*第一层span样式*/
margin-left: 35px;
  transition: color .1s linear;
  -moz-transition: color .1s linear;
  -webkit-transition: color .1s linear;
  -o-transition: color .1s linear;
} 
.ztree li a.level0 span:first-child{
	/*第一层span样式图标样式*/
	position: absolute;
	  font-size: 23px;
  top: 17px;
  left: 0;
  height: 24px;
  width: 24px;
  opacity: 0.7;
  transition: opacity .1s ease;
  -moz-transition: opacity .1s ease;
  -webkit-transition: opacity .1s ease;
  -o-transition: opacity .1s ease;
}
.ztree li a.level0 i.icon-chevron-down{
	  position: relative;
  float: right;
  top: 5px;
  font-size: 11px;
  color: #686868;
  width: initial;
  height: initial;
}
.ztree ul.level0{
	list-style-type: none;
	display: none;
	margin-top: 7px;
	margin-bottom: 15px;
	margin-right: 5px;
	margin-left: -15px;
	padding-left: 15px;
	border-bottom: 1px solid #dae1e8;
	box-shadow: 0 2px 1px -1px #FFFFFF;
	padding-bottom: 10px;
}
.ztree ul.level0 li a{
  font-weight: normal;
  font-size: 13px;
  color: #4c535a;
  text-decoration: none;
  display: block;
  margin-bottom: 7px;
}
.ztree ul.level0 li a.curSelectedNode{
  font-weight: bold;
  text-shadow: none;
}
.ztree ul.level0 li a:hover {
  text-decoration: underline;
}

</style>
</head>
<body>
	<%@include file="../head.jsp" %>
	
	<!-- sidebar -->
	<div id="sidebar-nav">
		<ul id="user_menu" class="ztree"></ul>
		<div class="pointer" style="display: none" id="pointer_id">
             <div class="arrow"></div>
             <div class="arrow_border"></div>
         </div>
		
	</div>
 
	<div class="skins-nav">
			<a href="#" class="skin first_nav selected"> <span class="icon"></span><span
				class="text">默认皮肤</span>
			</a> <a href="#" class="skin second_nav"
				data-file="${path }/dist/css/compiled/skins/dark.css"> <span
				class="icon"></span><span class="text">深色皮肤</span>
			</a>
		</div>

	<div class="content">
		<!-- settings changer -->
		<iframe src=""  width="100%" height="100%" id="main_iframe"
			 frameborder="0"  onload="this.height=this.contentWindow.document.documentElement.scrollHeight">
		</iframe> 
		<script type="text/javascript">
		function autoHeight(){
	        var iframe = document.getElementById("Iframe");
	        if(iframe.document){//ie自有属性
	            iframe.style.height = iframe.Document.documentElement.scrollHeight;
	        }else if(iframe.contentDocument){//ie,firefox,chrome,opera,safari
	            iframe.height = iframe.contentDocument.body.offsetHeight ;
	        }
	    }</script>
		
	<div id="tbox">
	<a id="pinglun" href="#tag_cmt"></a>
	<a id="xiangguan" href="#tag_about"></a>
	<a id="gotop" href="javascript:void(0)"></a>
</div>
	</div>
	<!-- end sidebar -->
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="${path }/dist/js/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="${path }/dist/js/bootstrap.min.js"></script>
	<script src="${path }/dist/js/top.js"></script>
	<script src="${path }/dist/js/theme.js"></script>
	<script src="${path }/dist/js/cookie.js"></script>
	<script src='${path }/dist/js/jquery.ztree.core-3.5.js'></script>
	<script type="text/javascript">
	var settingMenu = {
			view : {
				selectedMulti : false,//多选
				showLine : false,//不显示链接线
				txtSelectedEnable : false,//不可以选择文字
				showIcon : true,//不显示ico
				dblClickExpand: false,//不允许双击展开关闭节点
				addDiyDom: addDiyDom
			},
			async : {
				enable : false,//不使用开启异步加载
				dataFilter : filter,
			},
			callback : {
				//beforeClick : beforeClick,//点击之前调用
				onClick: zTreeOnClick,
			},
			data : {
				simpleData : {
					enable : true,
				}
			}
		};
	
		function filter(treeId, parentNode, childNodes) {
			if (!childNodes)
				return null;
			for (var i = 0, l = childNodes.length; i < l; i++) {
				childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
				//if(childNodes[i].id*1==201)
			}
			return childNodes;
		}
		//节点点击
		function zTreeOnClick(e,treeId, treeNode) {
			if(!treeNode.isParent){//不是父节点打开页面
				
				$("#main_iframe").attr("src","${path}/back"+treeNode.menu_herf+"?target="+"${path}/back"+treeNode.menu_herf+"&type="+treeNode.name);
				setCookie("select_node",treeNode.id);
			}else{//是父节点展开子节点
				var zTree = $.fn.zTree.getZTreeObj("user_menu");
				zTree.expandNode(treeNode);
			}
			var objLi=$("#"+treeNode.tId+"_a").closest("#user_menu>li.level0");
			$("#pointer_id").prependTo(objLi).show();
		}
		//自定义添加DOM
		function addDiyDom(treeId, treeNode){
			var aObj = $("#" + treeNode.tId + "_a");
			//<i class="icon-chevron-down"></i>
			if(!treeNode.isParent){
				return;
			}else{
				var editStr = "<i class='icon-chevron-down'></i>";
				aObj.append(editStr);
			}
		}
	$(document).ready(function() {
		$("[data-toggle='tooltip']").tooltip();
		var saveURL = "${path}/back/menu!loadUserMenu?date="+new Date()+"";
		jQuery.post(saveURL,null,function(jsonData){
			var treeObj=$.fn.zTree.init($("#user_menu"), settingMenu,jsonData);
			//如果cookie 没有上次选择的记录则默认首页，首页为‘浏览录入’节点
			var select_node=getCookie("select_node");
			var node;
			if(select_node!=null&&select_node!=""){
				node =treeObj.getNodeByParam("id",select_node);//上次的选择
			}else{
				node = treeObj.getNodeByParam("id",201);//默认选择
			}
			treeObj.selectNode(node);
			$("#main_iframe").attr("src","${path}/back"+node.menu_herf+"?target="+"${path}/back"+node.menu_herf+"&type="+node.name);
			setCookie("select_node",node.id);
			var objLi=$("#"+node.tId+"_a").closest("#user_menu>li");
			$("#pointer_id").prependTo(objLi).show();
		},"json");
	});
			
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../../common/base.jsp"%>
<%
	response.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link href="${path }/dist/css/bootstrap.css" rel="stylesheet">
<link href="${path }/dist/css/bootstrap-overrides.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/icons.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">
<!-- libraries -->
<link rel="stylesheet" type="text/css"  href="${path }/dist/css/font-awesome.css">
<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
<style type="text/css">
.nav-header {
	display: block;
	padding: 3px 15px;
	font-size: 11px;
	font-weight: bold;
	line-height: 20px;
	color: #999;
	text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
	text-transform: uppercase;
}
#firstRow{
	padding: 3px;
}
</style>
</head>
<body>
<div id="pad-wrapper">
	<div class="row head">
	<div class="col-md-12">
			<h3><%=new String(request.getParameter("type").getBytes("ISO-8859-1"),"UTF-8") %></h3>
			</div>
	</div>
	<div class="row">
		<div class="panel panel-success">
				<div class="panel-heading" >
				
				<a class="btn-flat primary new-product" id="btnAdd"><i class="icon-plus"></i> <span>Add measure</span></a>
				</div>
			<div class="panel-body">
				<form action="" id="list_page_form" method="post">
				<ul class="list-group" id="list_page">
					<li class="list-group-item" style="display: none" id="firstRow">
						<input type="text" class="form-control input-sm" placeholder="print：" name="measurebean.measure_name" value=""
						maxlength=15/>
						<input type="hidden" name="measurebean.measure_type" value="<%=new String(request.getParameter("type").getBytes("ISO-8859-1"),"UTF-8") %>">
					</li>
					<c:forEach var="wal" items="${basisList }">
				    	<li class="list-group-item" data-id="${wal.measure_id }">${wal.measure_name }</li>
					</c:forEach>
					
				</ul>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="${path }/dist/js/jquery.min.js"></script>
<script src='${path }/dist/js/bootstrap.min.js'></script>
<script src="${path }/dist/js/context.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var obj_,obj_next_select,select_text;//当前选中，上次选中,选择修改的文本
	$("#btnAdd").bind("click", addRole);
	$("#list_page li").bind("mouseover",function(){
		if($("body>ul.compressed-context").css("display")!='block')
			obj_=this;});
	context.init({preventDoubleContext: true});//右键菜单插件
	context.settings({compress: true});
	context.attach('#list_page>li',[
          // {header: 'Compressed Menu'},
          {text: '修改', action:function(e){
          	var select_obj=$(obj_);					//获取到点击的Dom
          	obj_next_select=select_obj;				//把这Dom 存起来，防止取消的时候回退出错
          	$("#btnAdd").addClass("disabled");		//新建功能暂时关闭
          	$("#btnAdd").unbind("click",addRole);
          	var input_obj=$("#firstRow>input");		//将input 放到要修改的Dom
          	select_text=select_obj.html();			//记录下Dom 的html
          	input_obj.eq(0).val(select_obj.html())
          	select_obj.html("");
          	input_obj.appendTo(select_obj);
          	
          	var from_obj=$("#list_page_form");
      		var idobj=$("<input type=\"hidden\" name=\"measurebean.measure_id\" >").appendTo(from_obj);
      		idobj.val(select_obj.data("id"));
          }},
          {text: '删除', action:function(e){
          	//alert(this.innerHTML);
          	var select_obj=$(obj_);
          	if(confirm("确认删除单位：\""+select_obj.html()+"\"  吗")){
          		var from_obj=$("#list_page_form");
          		var idobj=$("<input type=\"hidden\" name=\"measurebean.measure_id\" >").appendTo(from_obj);
          		idobj.val(select_obj.data("id"));
          		var from_data=from_obj.serializeArray();
          		var saveURL = "${path}/back/basis!deletl?date="+new Date()+"";
        		jQuery.post(saveURL,from_data,function(jsonData){
        			if(jsonData.info){
        				alert("删除成功");
        				 window.location.reload();
        			}else{
        				alert("删除失败：原因\n"+jsonData.text);
        			}
        		},"json");
          	}else{
          		return true;
          	}
          }},
          {divider:true},
          {text: '完成', action:carry_out},
          {text: '取消', action:function(e){
        	  var whichEl = $("#firstRow");					
        	  var input_obj=obj_next_select.find("input");	//获取到取消下的input
        	  if(input_obj.length==0) return true;
        	  input_obj.appendTo(whichEl);
        	  obj_next_select.html(select_text);			//回滚文本
        	  input_obj.eq(0).val("");		
        	  $("#btnAdd").removeClass("disabled");			//恢复增加按钮
        	  $("#btnAdd").bind("click", addRole);
          	return true;
          }}
      ]);
});
function carry_out(){
	var from_obj=$("#list_page_form");
	var isValidation=false;
	from_obj.find("input").each(function(){
		var obj=$(this);
		if(obj.val()==null&&obj.val()==""){
			alert("参数不可为空");
			isValidation=false;
			return ;
		}else{
			isValidation=true;
		}
	});
	if(!isValidation) return ;
	//from_obj.attr("action","${path}/back/basis!add");
	var from_data=from_obj.serializeArray();
	var saveURL = "${path}/back/basis!addORedit?date="+new Date()+"";
	jQuery.post(saveURL,from_data,function(jsonData){
		if(jsonData.info){
			alert(jsonData.text);
			 window.location.reload();
		}else{
			alert("添加失败：原因\n"+jsonData.text);
		}
	},"json");
	
}
//增加角色按钮
function addRole() {
	var whichEl = $("#firstRow");
	if (whichEl.css("display") == "none") {
		whichEl.slideDown("slow");
		$("#btnAdd").html("Cance New");
		whichEl.find("input[name='measurebean.measure_name']").focus();
	} else {
		whichEl.slideUp();
		$("#btnAdd").html("Add measure");

	}
}
</script>
</body>
</html>
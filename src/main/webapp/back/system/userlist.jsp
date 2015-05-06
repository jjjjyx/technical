<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="com.model.UserBean"%>
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
<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/tables.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">
<!-- libraries -->
<link rel="stylesheet" type="text/css"  href="${path }/dist/css/font-awesome.css">
<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">

<link href="${path }/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet"><%--时间日期工具 --%>
<script src="${path }/dist/js/jquery.min.js"></script>
<style type="text/css">
	.aid_li>li{
		list-style-type:none;
		margin-top: 4px;
		padding-left: 10px;
		padding-right: 10px;
		cursor: pointer;
		
	}
	.aid_li>li:first-child{
		margin-top:10px; 
	}
	.aid_li>li:nth-child(even){
		background-color: #eee;
	}
	.aid_li{
		border: 1px solid #ccc;
		padding:0px;
		background-color: #fff;
		padding-top: 5px;
		padding-bottom: 5px;
		margin-top:0; 
		width:160px;
		min-height: 50px;
		height: 300px;
		overflow: scroll;
		overflow-x: hidden;	
	}
</style>
</head>
<body >
<div id="pad-wrapper" class="table-wrapper users-table section">
	<div class="row head">
	<div class="col-md-12">
			<h3>管理用户</h3>
			</div>
	</div>
<div id="list_page">
<form action="" id="list_page_form">
	<div class="row filter-block">
			<div class="pull-left dropdown">
				<i class="icon-wrench" id="table_set" style="cursor: pointer;" title="表格设置" data-toggle="dropdown" data-target-id="#table_tr"></i>
				
			</div>
			<div class="pull-right">
				<!-- <input type="text" class="search" placeholder="输入要查找的用户名："> -->
				<a class="btn-flat success new-product" id="search" ><i class="icon-search"></i> <span>Search</span></a>
				<a class="btn-flat success new-product" id="select_user" data-target="#advanced_select"><i class="icon-search"></i> <span>Search Set</span><i class="icon-sort-down" ></i></a>
				<a class="btn-flat success new-product" id="add_user"><i class="icon-plus"></i> <span>Add User</span></a>
				<a class="btn-flat success new-product" id="edit_user" ><i class="icon-edit"></i> <span>Edit User</span></a>
				<a class="btn-flat success new-product" id="del_user"><i class="icon-trash"></i><span>Del User</span></a>
				<%--disabled --%>
			</div><!-- 按钮组 -->
	</div>

	<div class="row">
		<div class="col-md-12">
			<table class="table table-hover">
				<thead>
					<tr >
						<th class="col-md-2 sortable" data-property="user_name"><input type="checkbox">Name</th>
						<th class="col-md-2 sortable" data-property="user_online"><span class="line"></span>Signed
							up</th>
						<th class="col-md-1 sortable" data-property="empid"><span class="line"></span>Emp
							No</th>
						<th class="col-md-2 sortable align-right" data-property="user_mail"><span class="line"></span>Email
						</th>
					</tr>
				</thead>
				<tbody>
					<tr id="advanced_select" style="display: none;">
						<td>
							<input class="form-control input-sm" type="text" name="select_name" placeholder="输入要查找的用户名：" value="${select_name }"/>
						</td>
						<td title="请输入要查找的时间区间">
							<div class="col-md-5" style="margin-left: 0;margin-right: 0px;" >
	                        	<input class="form-control form_datetime input-sm" type="text" name="select_load_go" readonly="readonly" value="${select_load_go }"/>
	                        </div>
	                       	<div class="col-md-1" style="margin-left: 0;margin-right: 0px;"><span>至</span></div>
	                        <div class="col-md-5" style="margin-left: 0;margin-right: 0px;">
	                        	<input class="form-control form_datetime input-sm" type="text" name="select_load_end" readonly="readonly" value="${select_load_end }"/>
	                    	</div>
						</td>
						<td >
							<input class="form-control input-sm" type="text" name="select_emp_id" placeholder="输入要查找的用户部门："/>
						</td>
						<td>
							 <input class="form-control input-sm" type="text" name="select_mail" value="${select_mail }" placeholder="输入要查找的用户邮箱："/>
						</td>
					</tr>
					<c:forEach var="wal" items="${userlist.currentList}"
						varStatus="status">
						<tr class="first " >
							<td><input type="checkbox" name="select_user">
							<img src="${path}/Images/default.gif" class="img-circle avatar hidden-phone" /> 
								<span class="name">${wal.user_name }</span>
								<span class="subtext">Graphic Design</span>
							</td>
							<td>Mar 13, 2015$</td>
							<td>$ 4,500.00</td>
							<td class="align-right mail_select"><a href="#" title="发送邮件">${wal.user_mail }</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
			<div class="col-md-12">
				<div id="page_pack" data-pagejson='${userlist.pageutiljson}' data-type="page_pack">
					
				</div>
			</div>
	</div>
</form>
</div>		
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
   aria-labelledby="myModalLabel" aria-hidden="true">
   <div class="modal-dialog">
   		<div class="modal-content">
   		 <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            <h4 class="modal-title" id="myModalLabel">修改用户角色</h4><%--用户资料由用户自行修改 --%>
         </div>
   		<div class="modal-body row">
   			<form action="${path }/back/user!editUserRole" id="form2" method="post">
         		<div class="field-box" >
                     <label>邮箱:</label>
                     <div class="col-md-7">
                         <input class="form-control" type="text" id="mail_user" name="user.user_mail" readonly="readonly"/>
                     </div>              
                </div>
                <div class="field-box">
                     <label>用户所属角色</label>
                     <div class="col-md-7">
                        <input type="text" class="form-control" id="role_name"  readonly="readonly"/>
						<input type="hidden" id="hidden_role_id" value="" name="role_id_array"/>
					</div> 
						<div class="col-md-1">
                			<i class="icon-refresh" style="font-size: 19px;position: relative;top:6px;cursor:pointer;"
                			id="refresh_input"></i>
                		</div>        
                	</div>
      	 	</form>
         </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default"  data-dismiss="modal">关闭 </button>
            <button type="button" class="btn btn-primary" id="model_submit">提交更改</button>
         </div>
   		</div>
   </div>
</div>

<ul id="menuContent" class="dropdown-menu" style="display:none; position: absolute;z-index: 55555;height:150px;overflow: scroll;overflow-x: hidden;	">
	<c:forEach var="wal" items="${roleList }">
		<li data-role-id="${wal.role_id }"><a href="#">${wal.role_name }</a></li>
	</c:forEach>
</ul>
<ul class="dropdown-menu" id="table_tr" style="display:none; position: absolute;z-index: 55554;">
   	<li><a href="#"><i class="icon-eye-open" style="margin-right: 5px; cursor: pointer;" data-is-open="true" data-open-tr="1"></i>sign up</a></li>
   		<li><a href="#"><i class="icon-eye-open" style="margin-right: 5px; cursor: pointer;" data-is-open="true" data-open-tr="2"></i>emp no</a></li>		
</ul>
	<%--jquery 放在了head --%>
	<script src='${path }/dist/js/bootstrap.min.js'></script>
	<script src='${path }/dist/js/pageutil.js' type="text/javascript"></script>
	<script src="${path }/dist/js/cookie.js"></script>
	<script src="${path }/dist/js/bootstrap-datetimepicker.min.js"></script>
	<script src="${path }/dist/js/bootstrap-datetimepicker.zh-CN.js"></script>
	<script type="text/javascript">
	var checknum=0;//被点击的复选框数量
	//全选
	$(".table th input:checkbox").click(function () {
  		$checks = $(this).closest(".table").find("tbody input:checkbox");
  		
  		$checkTR = $(this).closest(".table").find("tbody tr");
  		if ($(this).is(":checked")) {
  			$checks.prop("checked", function(index,attr){
  				$checkTR.eq(index).addClass("action");
  				return true;
  			});
  			checknum=$checks.length;
  		} else {
  			$checks.prop("checked", function(index,attr){
  				$checkTR.eq(index).removeClass("action");
  				return false;
  			});
  			checknum=0;
  		}
  	});
	//勾选
	$(".table tr>td input:checkbox").change(function () {
  		$checkTR = $(this).closest(".first");
  		if ($(this).is(":checked")) {
  			$checkTR.addClass("action");
  			checknum++;
  		} else {
  			$checkTR.removeClass("action");
  			checknum--;
  		}
  		if(checknum>1){
  			$("#edit_user").addClass("disabled");
  		}else{
  			$("#edit_user").removeClass("disabled");
  		}
  	});
	function select_set_click(){
		var select_TR=$(""+$("#select_user").data("target"));
		select_TR.toggle();
		setCookie("select_display", select_TR.css("display"));
	}
	$(document).ready(function() {
		var select_zt=getCookie("select_display");
		if(select_zt!=null&&select_zt!=""){
			if(select_zt!="none")
				$("#advanced_select").show();
		}
		//点击修改按钮
		$("#edit_user").on("click",function(e){
			if(checknum>1){
				alert("无法对多个用户同时修改");
			}else if(checknum==0){
				alert("请选择一个用户操作");
			}else{
				$('#myModal').modal('show');
			}
		});
		//高级查询
		$("#select_user").on("click",select_set_click);
		//点击查询
		$("#search").on("click",function(e){
			$("#list_page_form").submit();
		});
		//修改模糊框打开
		$("#myModal").on("show.bs.modal",function(e){
			var selectobj=$(".table tr>td input:checked");
			var selectTD=selectobj.parent();
			var selectTR=selectTD.parent();
			var user_ID = {user_id:selectTR.find(".mail_select>a").text()};
			var saveURL = "${path}/back/user!loadUserinfo?date="+new Date()+"";
			jQuery.post(saveURL,user_ID,function(jsonData){
				if(jsonData.info){
					//$("input[name='user.user_name']").val(jsonData.user.user_name);
					$("#form2 input[name='user.user_mail']").val(jsonData.user.user_mail);
					var roleidlist=jsonData.user.roleid;
					var roleid;
					var rolename;
					for(var i=0;i<roleidlist.length;i++){
						if(roleid==null&&rolename==null){
							roleid=roleidlist[i].role_id+"";
							rolename=roleidlist[i].role_name+"";
						}else{
							roleid+=","+roleidlist[i].role_id+"";
							rolename+=","+roleidlist[i].role_name+"";
						}
						$("[data-role-id='"+roleidlist[i].role_id+"']").hide();
					}
					$("#role_name").val(rolename);
					$("#form2 input[name='role_id_array']").val(roleid);
				}else{
					alert(jsonData.text);
				}
			},"json");
			
		});
		//关闭模糊框重置选择
		$("#myModal").on("hidden.bs.modal",refresh_select);
		//重置选择
		$("#refresh_input").on("click",refresh_select);
		//选择角色
		$("#menuContent>li").on("click",function(){
			var hidden_obj=$("#hidden_role_id");
			var input_obj=$("#role_name");
			if(hidden_obj.val()==null||hidden_obj.val()==""){
				hidden_obj.val($(this).data("role-id"));
				input_obj.val($(this).find("a").html());
			}else{
				hidden_obj.val(hidden_obj.val()+","+$(this).data("role-id"));
				input_obj.val(input_obj.val()+","+$(this).find("a").html());
			}
			$(this).hide();
			
		});
		// 展开角色列表
		$("#role_name").on("click",function(e){
			var cityObj = $(this);
			var cityOffset = cityObj.offset();
			$("#menuContent").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
			$("body").bind("mousedown", onBodyDown);
		})
		//提交修改
		$("#model_submit").on("click",function(e){
			var form_data=$("#form2").serialize();
			var submitURL="${path}/back/user!editUserRole";
			//alert(form_data);
			jQuery.post(submitURL,form_data,function(jsonData){
				if(jsonData.info){
					//刷新页面
					$("#list_page_form").submit();
				}else{
					alert(jsonData.text);
				}
			},"json");
		});
		//时间日期选择工具
		$(".form_datetime").datetimepicker({format: 'yyyy-mm-dd',language:  'zh-CN',weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
	        showMeridian: 1,
	        minView: 2,
	        pickerPosition:"bottom-left"});
		$("#table_set").on("click",function(e){
			var cityObj = $(this);
			var cityOffset = cityObj.offset();
			$("#table_tr").css({left:cityOffset.left + "px", top:cityOffset.top + cityObj.outerHeight() + "px"}).slideDown("fast");
			//alert(cityObj.data("target-id").html());
			$("body").bind("mousedown", onBodyDown);
		});
		$("[data-open-tr]").on("click",function(e){
			var table_obj=$("#list_page").find("table");
			var Td_num=$(this).data("open-tr");
			if($(this).hasClass("icon-eye-open")){
				$(this).removeClass("icon-eye-open");
				$(this).addClass("icon-eye-close");
				$("tr>th:nth-child("+(Td_num+1)+")",table_obj).hide();
				$("tr",table_obj).each(function(){$("td:eq("+Td_num+")",this).hide()});
			}else{
				$(this).removeClass("icon-eye-close");
				$(this).addClass("icon-eye-open");
				$("tr>th:nth-child("+(Td_num+1)+")",table_obj).show();
				$("tr",table_obj).each(function(){$("td:eq("+Td_num+")",this).show()});
			}
			
			 //$("#table5 tr td::nth-child(3)").hide();  
			   // $("#table5 tr").each(function(){$("td:eq(3)",this).hide()});
			
		});
	});
		function onBodyDown(event) {
			if (!( event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0 ||
					event.target.id=="table_tr"|| $(event.target).parents("#table_tr").length>0)) {
				hideMenu();
			}
		}
		//复原
		function refresh_select(){
			$("#role_name").val("");
			$("#hidden_role_id").val("");
			var liobj=$('#menuContent>li');
			for(var i=0;i<liobj.length;i++){
				liobj.eq(i).show();
			}
		}
		//接触 body绑定
		function hideMenu() {
			$("#menuContent").fadeOut("fast");
			$("#table_tr").fadeOut("fast");
			$("body").unbind("mousedown", onBodyDown);
		}
	
	</script>
</body>
</html>
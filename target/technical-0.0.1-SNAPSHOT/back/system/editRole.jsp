<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="com.model.Messages"%>

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

<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/tables.css">
<link rel="stylesheet" type="text/css" href="${path }/dist/css/compiled/icons.css">
<!-- Button -->
<link href="${path }/dist/css/compiled/elements.css" rel="stylesheet">

<!-- libraries -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/font-awesome.css">


<!-- this -->
<link rel="stylesheet" type="text/css" href="${path }/dist/css/app.css">
<style type="text/css">
table a, table span {
	margin-right: 5px;
}
</style>
</head>
<div id="pad-wrapper" class="table-wrapper products-table section">

	<div class="row head">
		<div class="col-md-12">
			<h4>管理角色</h4>
		</div>
	</div>

	
<div id="list_page">
<form action="" id="list_page_form">
<div class="row filter-block">
		<div class="pull-right">
			<input type="text" class="search" name="select_name" value="${select_name}" placeholder="输入要查找的角色名：">
			<a class="btn-flat success new-product" id="search" ><i class="icon-search"></i> <span>Search</span></a>
			<a class="btn-flat success new-product" id="btnAdd">+ Add Role</a>
		</div>
	</div>
<div class="row">
	<div class="col-md-12">
			<table class="table table-hover">
			<thead>
				<tr>
					<th data-property="role_id" class="col-md-1 sortable">序号</th>
					<th data-property="role_name" class="col-md-2 sortable">角色名称</th>
					<th class="col-md-3 sortable">角色备注</th>
					<th class="col-md-4 sortable">角色用户数</th>
					<th class="col-md-2 sortable">编辑</th>
				</tr>
			</thead>
			<tbody id="rolelist">

				<c:forEach var="wal" items="${rolelist.currentList}"
					varStatus="status">
					<tr id="row_${status.count }">
						<td id="id_${status.count }">${status.count }</td>
						<td id="RoleName_${status.count }"
							<c:if test='${wal.role_name=="超级管理员"}'>style="color: #f00"</c:if>>${wal.role_name }</td>
						<td id="Roleremark_${status.count }">${wal.role_remark}</td>
						<td id="RoleNum_${status.count }">总用户数：<span>001</span>禁止登录数：<span>000</span></td>
						<td id="Operating_${status.count }">
							<ul class="actions">
								<c:if test='${wal.role_name!="超级管理员"}'>
                                   <li><i class="table-edit" data-toggle="modal" data-target="#myModal" onclick="modify('${status.count }','${wal.role_id }')"></i></li>
                                </c:if>
                                   <li><i class="table-settings" onclick="window.location.href='${path }/back/system/editRoleMenu.jsp?roleid=${wal.role_id }'"></i></li>
                                <c:if test='${wal.role_name!="超级管理员"}'>
                                   <li class="last"><i class="table-delete" id="oper_del" onclick="delRole('${wal.role_id }')" data-oper-del-id="${wal.role_id }"></i></li>
                                    
                                </c:if>
							</ul>	
						</td>
					</tr>
				</c:forEach>
				
				<tr id="firstRow" style="display: none">
					<form id="form1" action="${path}/back/role!addRole" method="post">
						<td>#</td>
						<td><input type="text" class="form-control input-sm"
							placeholder="name：" name="role.role_name" /></td>
						<td><input type="text" class="form-control input-sm"
							placeholder="remark:" name="role.role_remark" /></td>
						<td style="color: #00f;">请输入角色名称</td>
						<td><a href="#" id="conif">完成</a><a href="#" id="aAdd">取消</a></td>
					</form>
				</tr>

			</tbody>
		</table>
		
	</div>
</div>
		<div class="row">
			<div class="col-md-12">
				<div id="page_pack" data-pagejson='${rolelist.pageutiljson}' data-type="page_pack">
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
            <button type="button" class="close" data-dismiss="modal" 
               aria-hidden="true">×
            </button>
            <h4 class="modal-title" id="myModalLabel">
             		修改 角色名称
            </h4>
         </div>
         
   		<div class="modal-body row">
   			<form action="${path }/back/role!editRole" id="form2" method="post">
         		<div class="field-box" >
                     <label>角色id:</label>
                     <div class="col-md-7">
                         <input class="form-control" type="text" id="role_id" disabled="disabled"/>
                         <input class="form-control" type="hidden" name="role.role_id" id="role_id2"/>
                     </div>              
                </div>
                <div class="field-box">
                     <label>角色名称:</label>
                     <div class="col-md-7">
                         <input class="form-control" type="text" name="role.role_name" id="role_name"/>
                     </div>              
                </div>
                <div class="field-box">
                     <label>角色备注:</label>
                     <div class="col-md-7">
                         <input class="form-control" type="text" name="role.role_remark" id="role_remark"/>
                     </div>              
                </div>
      	 	</form>
         	
         </div>
         
          <div class="modal-footer">
            <button type="button" class="btn btn-default" 
               data-dismiss="modal">关闭
            </button>
            <button type="button" class="btn btn-primary" onclick="submitform2()">
               		提交更改
            </button>
         </div>
   		</div>
   </div>
   </div>
<script src="${path }/dist/js/jquery.min.js"></script>
<script src='${path }/dist/js/bootstrap.min.js'></script>
<script src='${path }/dist/js/pageutil.js' type="text/javascript"></script>
	<script src="${path }/dist/js/cookie.js"></script>
<script type="text/javascript">
	//修改角色
	var whichTr, idtd, nametd,remark;
	function modify(id, id2) {
		$("#firstRow").hide();
		
		whichTr = $('#row_' + id);//TR
		idtd = 		whichTr.children("#id_" + id);
		nametd = 	whichTr.children("#RoleName_" + id);
		remark = 	whichTr.children("#Roleremark_" + id);
		
		$("#role_id").val(idtd.html());
		$("#role_name").val(nametd.html());
		$("#role_remark").val(remark.html());
		$("#role_id2").val(id2);
	}
	//删除角色
	function delRole(id){
		var Data_id={roleid:id};
		//alert(id);
		var submitURL="${path}/back/role!delRole";
		jQuery.post(submitURL,Data_id,function(jsonData){
			if(jsonData.info){
				alert("删除成功");
				//刷新页面
				$("#list_page_form").submit();
			}else{
				alert(jsonData.text);
			}
		},"json");
	}
	//修改角色-提交
	function submitform2() {
		if($("#role_name").val()!=null&&$("#role_name").val()!=""){
			var Data_from=$("#form2").serializeArray();
			var submitURL="${path }/back/role!editRole";
			jQuery.post(submitURL,Data_from,function(jsonData){
				if(jsonData.info){
					$("#list_page_form").submit();
				}else{
					alert(jsonData.text);
				}
			},"json");
		}else{
			alert("角色名不可为空!");
			$("#role_name").focus();
		}
	}
	//增加角色按钮
	function addRole() {
		var whichEl = $("#firstRow");
		if (whichEl.css("display") == "none") {
			whichEl.show();
			$("#btnAdd").html("Cance New");
			whichEl.find("input[name='role.role_name']").focus();
		} else {
			whichEl.hide();
			$("#btnAdd").html("+ Add Role");
		}
}
	$(document).ready(function() {
		$("#search").on("click",function(e){
			$("#list_page_form").submit();
		});
		//增加角色绑定点击事件
		$("#btnAdd").bind("click", addRole);
		//新建角色-提交数据
		$("#conif").bind("click",function() {
				if ($("#firstRow input[name='role.role_name']").val()!= null&&$("#firstRow input[name='role.role_name']").val()!=""){
					addData=	$("#form1").serialize();
					addURL=		"${path}/back/role!addRole?date="+new Date()+"";
					$.ajax({
						async:false,
						cache:false,type:"POST",dataType:"json",url:addURL,data:addData,
	    				success : function(jsonData) {
	    					if(jsonData.info==true){
	    						//alert(window.location.href);
	    						window.location.replace(window.location.href);
	    					}else{
	    						alert("失败：原因：\n"+jsonData.text);
	    						name.focus();
	    					}
	    				},
	    				error : function() {
	    					alert("新建失败");
	    				}
	    			});
				}else{
					alert("角色名不能为空");
				}
		});
	});
	
</script>

<%--
	if(request.getAttribute("tip")!=null){
		Messages m=(Messages)request.getAttribute("tip");
		out.print("<script type=\"text/javascript\">");
		if(!m.getInfo()){
			out.print("alert("+m.getText()+");");
		}else{
			out.print("alert('修改成功');");
		}
		m=null;
		request.setAttribute("tip", m);
		out.print("</script>");	
	}
--%>
</body>
</html>
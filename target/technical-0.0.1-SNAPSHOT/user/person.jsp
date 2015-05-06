<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="../common/base.jsp"%>

<script src="${path }/dist/js/ajaxfileupload.js"></script>
<script src="${path }/dist/js/jquery.Jcrop.js"></script>
<style>
<!--
.preview-container{
overflow: hidden;
}
-->
</style>
	<img class="img-circle a-flipinY img-head"  src="${path }${sessionScope.user.user_head_path }" height="130px;"/>
	<span class="a_edit_head"><i class="icon-edit"></i>修改头像</span>
	<h3>${sessionScope.user.user_account  }的主页</h3>
	<p>test: 放点个人说明</p>
	<!-- Modal -->
<div class="modal fade" id="a_edit_head_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
     <form action="" enctype="multipart/form-data" id='formFile' method="post" >
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">修改头像</h4>
      </div>
     	
      <div class="modal-body">
        <input type="file" name="uploadimage" id="head_photo_input" value="选择新头像">*注意，文件小于4M，文件格式要求jpg、gif、png和bmp
        <p>预览：</p>
		<div class="row">
			<div class="col-md-8" id="browse">
				<img src="${path }/dist/img/no-img-gallery.png" alt=".." id="browse_img"/>
			</div>
			<div class="col-md-4">
				<div id="preview-pane">
				<div class="preview-container"></div>
	        		<img class="img-circle img-head"  src="${path}/dist/img/a.jpg" id="preview"/>
	        	</div>
	        	<img class="img-circle img-head" width="30px;" src="${path}/dist/img/a.jpg"/>
	        </div>
	        <input type="hidden" name="image.srcpath" id="srcpath">
	        <input type="hidden" name="image.x" id="x"/>  
		    <input type="hidden" name="image.y" id="y"/>  
		    <input type="hidden" name="image.width" id="width"/>  
		    <input type="hidden" name="image.height" id="height"/> 
		</div>
      </div>
     
      
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="config_cut_uoload">确认上传</button>
      </div>
      </form>
    </div>
  </div>
</div>
<script>
$(document).ready(function() {
		$("span.a_edit_head").click(function(){
			$("#a_edit_head_Modal").modal("show");
		});
		$("#head_photo_input").change(function(){ 
			$.ajaxFileUpload({
				url:"${path}/uploadFileAction!upimg",
				secureuri:false,
				fileElementId:"head_photo_input",
				dataType: 'json',
				data:{name:'logan', id:'id'},
				success: function (data, status) {
					if(data.message.info){
						$("#browse_img").attr("src",data.href);
						$("#srcpath").val(data.path);
						imgcut();
						
					}else{
						alert(data.text+"请重新上传");
					}
				},
				error: function (data, status, e) {
				}
			})
			
		});
		$("#config_cut_uoload").click(function(){
			$("#formFile").attr("action","${path}/user!edituserhead");
			
			$("#formFile").submit();
		});
});
function imgcut(){
	var jcrop_api, boundx, boundy;  
	$("#browse_img").Jcrop({  
        	aspectRatio: 1,
        	allowSelect:false,
        	createHandles:['n','s','e','w','nw','ne','se','sw'],
        	onChange:updatePreview,
        	onSelect:updatePreview
        },function(){  
            // Use the API to get the real image size  
           
            var bounds = this.getBounds(); 
            this.setSelect([0,0,130,130]);
            boundx = bounds[0];  
            boundy = bounds[1];   
            jcrop_api = this; 
         
        }
     );
};
function updatePreview(c){
	 if (parseInt(c.w) > 0){
		 $('#width').val(c.w);
		 $('#height').val(c.h); //c.h 裁剪区域的高  
         $('#x').val(c.x);  //c.x 裁剪区域左上角顶点相对于图片左上角顶点的x坐标  
         $('#y').val(c.y);  //c.y 裁剪区域顶点的y坐标</span>  
	 }
}
</script>

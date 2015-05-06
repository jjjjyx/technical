package com.action;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.common.uilt.DateUtil;
import com.google.gson.Gson;
import com.model.Messages;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/")
@Action(value = "uploadFileAction", results = {

})
public class UploadFileAction extends BaseAction{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5479421913591501096L;
	public static final String FILE_TYPE="image/jpeg,image/png,image/gif,image/png,,image/bmp";
	public static final long maximumsize=4194304;//4M
	/**
	 * 接收文件的属性
	 * 
	 * 文件名称：控件名称+FileName
	 * 
	 * 文件类型：控件名称+ContentType
	 */
	private File uploadimage;
	private String uploadimageFileName;
	private String uploadimageContentType;
	
	public String upimg() throws Exception{
		System.out.println("文件名"+uploadimageFileName);
		System.out.println("文件类型"+uploadimageContentType);
		System.out.println("文件大小"+uploadimage.length());
		System.out.println("文件临时路径"+uploadimage.getAbsolutePath());
		
		PrintWriter out = response.getWriter();
		Messages m=new Messages();
		Map<String,Object> map=new HashMap<String , Object>();
		Gson gson = new Gson();
		ServletContext rel=ServletActionContext.getServletContext();
		File uploadFile = new File(rel.getRealPath("headtemp"));
		
		if (!uploadFile.exists()) {//判断输出路径是否存在
            uploadFile.mkdir();  
        }
		if(FILE_TYPE.indexOf(uploadimageContentType)==-1){
			m.setInfo(false);
			m.setText("类型不符");
			map.put("message", m);
			return NONE;	
		}
		if(maximumsize<uploadimage.length()){
			m.setInfo(false);
			m.setText("文件太大，无法上传");
			map.put("message", m);
			return NONE;
		}
		File tempfile = new File(uploadFile,DateUtil.getTimeStamp() + "_"+uploadimageFileName);
		copy(uploadimage,tempfile);
		m.setInfo(true);
		m.setText(rel.getContextPath()+"/headtemp/"+tempfile.getName());
		map.put("message", m);
		map.put("href", rel.getContextPath()+"/headtemp/"+tempfile.getName());
		map.put("path", tempfile.getAbsolutePath());
		out.print(gson.toJson(map));
		
		out.flush();
		out.close();
		return NONE;
	}
	
	public File getUploadimage() {
		return uploadimage;
	}
	public void setUploadimage(File uploadImage) {
		this.uploadimage = uploadImage;
	}

	public String getUploadimageFileName() {
		return uploadimageFileName;
	}

	public void setUploadimageFileName(String uploadimageFileName) {
		this.uploadimageFileName = uploadimageFileName;
	}

	public String getUploadimageContentType() {
		return uploadimageContentType;
	}

	public void setUploadimageContentType(String uploadimageContentType) {
		this.uploadimageContentType = uploadimageContentType;
	}
	
	 /**
     * 复制文件
     * @param src 需要复制的文件
     * @param dst 目标
     */
    public void copy(File src, File dst) {  
        try {  
            InputStream in = null;  
            OutputStream out = null;  
            try {  
                in = new BufferedInputStream(new FileInputStream(src),  
                        16*1024);  
                out = new BufferedOutputStream(new FileOutputStream(dst),  
                        16*1024);  
                byte[] buffer = new byte[16*1024];  
                while (in.read(buffer) > 0) {  
                    out.write(buffer);  
                }  
            } 
            finally { 
            	
            	
                if (null != in) {  
                    in.close();  
                }  
                if (null != out) {  
                    out.close();  
                }  
            }  
        } catch (Exception e) {  
        	e.printStackTrace();
        }  
    }  
	
	
}

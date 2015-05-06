package com.action;

import javax.servlet.ServletContext;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.model.OperateImage;
import com.model.UserBean;
import com.model.UserinfoBean;
import com.service.imp.BBsService;
import com.service.imp.CategoryService;
import com.service.imp.CommentService;
import com.service.imp.UserService;

@Controller
@ParentPackage("defaultpackage")
@Namespace("/")
@Action(value="user" ,results={
		@Result(name="success",location="/user/person_info.jsp"),
		@Result(name="edit",location="/user/person_info_edit.jsp"),
		@Result(name="error",location="/hello.jsp"),
		@Result(name="index",type="redirectAction", location = "person!index"),
		@Result(name="mycomment",location="/user/mycomment.jsp")
})
public class PersonAction extends BBsAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7441401883561488277L;
	@Autowired
	private UserService userService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BBsService bbsSerivce;
	@Autowired
	private CommentService commentService;
	private UserBean userBean;
	private UserinfoBean user_info;
	private OperateImage image;
	
	public String info(){
		try {
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			request.setAttribute("categoryList", this.categoryService.list(session));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
		
			request.setAttribute("user_info", this.userService.getUserInfoById(session));
		} catch (Exception e) {
			// TODO: handle exception
		}
		return SUCCESS;
	}
	public String edit(){
		try {
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			request.setAttribute("categoryList", this.categoryService.list(session));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			request.setAttribute("user_info", this.userService.getUserInfoById(session));
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "edit";
	}
	
	public String edituserhead(){
		try {
			 ServletContext rel=ServletActionContext.getServletContext();
			 String sevepath =rel.getRealPath("headimg");
			this.userService.edituserhead(session,image,sevepath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}
	public String edit_user(){
		try {
			this.userService.editUserInfo(userBean,user_info,session);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return info();
	}
	
	public String mycomment(){
		try {
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			request.setAttribute("categoryList", this.categoryService.list(session));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			
			//request.setAttribute("newcommentcount", this.commentService.getUsernewcomment(session));
			//收到的评论
			String s=request.getParameter("old");
			if(s==null)
				request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			else
				request.setAttribute("mycommentlistold",this.commentService.getCommentlistBymy(session,"s"));
			this.commentService.markread(session);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "mycomment";
	}
	public UserBean getUserBean() {
		return userBean;
	}

	public void setUserBean(UserBean userBean) {
		this.userBean = userBean;
	}
	public UserinfoBean getUser_info() {
		return user_info;
	}
	public void setUser_info(UserinfoBean user_info) {
		this.user_info = user_info;
	}
	public OperateImage getImage() {
		return image;
	}
	public void setImage(OperateImage image) {
		this.image = image;
	}
	

}

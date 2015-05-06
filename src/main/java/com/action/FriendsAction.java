package com.action;

import java.io.PrintWriter;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.Gson;
import com.model.Messages;
import com.service.imp.BBsService;
import com.service.imp.CategoryService;
import com.service.imp.CommentService;
import com.service.imp.FriendsService;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/")
@Action(value="friend" ,results={
		@Result(name="list",location="/user/userfriendslist.jsp"),
		@Result(name="error",location="/index.jsp")
})
public class FriendsAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2730404441271488731L;
	@Autowired
	private FriendsService friendsService;
	@Autowired
	private BBsService bbsSerivce;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private CommentService commentService;
	private String user_account;
	
	public String addfriends() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		try {
			m=this.friendsService.addfriends(session,user_account);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return NONE;
	}
	public String removefriend() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		try {
			m=this.friendsService.removefriends(session,user_account);
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return NONE;
	}
	public String list(){
		try {
			//分类列表
			request.setAttribute("categoryList", this.categoryService.list(session));

			//草稿箱
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			request.setAttribute("friendList", this.friendsService.getbbsinfriend(currentPage,maxrecord,session));
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return "list";
	}
	public String getUser_account() {
		return user_account;
	}

	public void setUser_account(String user_account) {
		this.user_account = user_account;
	}
	
	
}

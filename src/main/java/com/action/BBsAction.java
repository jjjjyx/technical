package com.action;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.Gson;
import com.model.BbsBean;
import com.model.CommentBean;
import com.model.Messages;
import com.service.imp.BBsService;
import com.service.imp.CategoryService;
import com.service.imp.CommentService;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/")
@Action(value="person" ,results={
		@Result(name="newbbs",location="/user/newbbs.jsp"),
		@Result(name="draftbbs",location="/user/draftlist.jsp"),
		@Result(name="index",location="/user/index.jsp"),
		@Result(name="error",location="hello",type="redirectAction"),//name="index",type="redirectAction", location = "person!index"
		@Result(name="bbslist",location="/user/mybbslist.jsp"),
		@Result(name="bbscontent",location="/user/bbscontent.jsp")
		
})
public class BBsAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4616851693310483069L;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private BBsService bbsSerivce;
	@Autowired
	private CommentService commentService;
	private BbsBean bbsBean;
	private String content_str;
	private String bbs_id;
	private String category;
	private CommentBean commentbean;
	/**
	 * 主页
	 * @return
	 */
	public String index(){
		try {
			//分类列表
			request.setAttribute("categoryList", this.categoryService.list(session));
			//收到的评论
			//草稿箱
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			request.setAttribute("allbbsResult", this.bbsSerivce.getAllbbs(currentPage,maxrecord,session));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "index";
	}
	/**
	 * 跳转到创建文章页面
	 * @return
	 * @throws Exception
	 */
	public String newBBS() throws Exception{
		try {
			request.setAttribute("categoryList", this.categoryService.list(session));
			//草稿箱
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			if(null!=bbs_id&&!"".equals(bbs_id))
				request.setAttribute("bbs_content_map",this.bbsSerivce.getBBSBeanById(bbs_id) );
		}catch (NumberFormatException e){
			request.setAttribute("tip", "请不要传入非法参数");
			return ERROR;
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			
		}
		return "newbbs";
	}
	/**
	 * ajax 发布&保存文章
	 * @return
	 * @throws Exception
	 */
	public String saveBBS() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		try {
			m= bbsSerivce.saveBBs(bbsBean,content_str,session);
		} catch (Exception e) {
			e.printStackTrace();
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		//System.out.println(111);
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return NONE;
	}
	/**
	 * 跳转到草稿箱
	 * @return
	 * @throws Exception
	 */
	public String draft() throws Exception{
		try {
			//草稿箱
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			request.setAttribute("categoryList", this.categoryService.list(session));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			request.setAttribute("draftResult", this.bbsSerivce.getBBSByinfo(currentPage,sortField,orderType,maxrecord,session,"d"));
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		return "draftbbs";
	}
	/**
	 * 跳转到我的文章列表页
	 * @return
	 * @throws Exception
	 */
	public String bbsList() throws Exception{
		try {
			if(category!=null&&!"".equals(category))
//				System.out.println(category);
//				if(request.getMethod().equalsIgnoreCase("GET")){
//					this.category=new String(category.getBytes("iso-8859-1"),"UTF-8");
//					System.out.println(request.getMethod()+"方式");
//					}
//				System.out.println(category);
			//草稿箱
			request.setAttribute("draftcount", this.bbsSerivce.getCountByinfo(session,"d"));
			request.setAttribute("categoryList", this.categoryService.list(session));
			//右侧置顶
			request.setAttribute("top_right_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			request.setAttribute("bbsResult", this.bbsSerivce.getBBSByCategory(currentPage,sortField,orderType,maxrecord,session,"r",category));
			request.setAttribute("category",category);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return "bbslist";
	}
	/**
	 * 查看文章内容
	 * @return
	 * @throws Exception
	 */
	public String bbsContent() throws Exception{
		
		try {
			//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
			Map<String,Object> m=new HashMap<String, Object>();
			m.putAll(this.bbsSerivce.getBBSBeanById(bbs_id));
			m.putAll(this.commentService.getCommentList(currentPage, sortField, orderType, maxrecord, bbs_id,request));
			request.setAttribute("bbscontentBean", m);
			
		}catch (NumberFormatException e){
			request.setAttribute("tip", "请不要传入非法参数");
			return ERROR;
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("tip", "发生错误");
			return ERROR;
		}
		return "bbscontent";
	}
	/**
	 * ajax 提交 发表评论
	 * @return
	 * @throws Exception
	 */
	public String saveBBScomment() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		try {
			m= this.commentService.savecomment(this.commentbean,content_str,session,vali,bbs_id);
		}catch (NumberFormatException e){
			request.setAttribute("tip", "请不要传入非法参数");
			return ERROR;
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
	public String delbbs() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		try {
			System.out.println(bbs_id);
			m= this.bbsSerivce.delbbs(bbs_id);
		}catch (NumberFormatException e){
			request.setAttribute("tip", "请不要传入非法参数");
			return ERROR;
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
	public BbsBean getBbsBean() {
		return bbsBean;
	}

	public void setBbsBean(BbsBean bbsBean) {
		this.bbsBean = bbsBean;
	}

	public String getContent_str() {
		return content_str;
	}

	public void setContent_str(String content_str) {
		this.content_str = content_str;
	}

	public String getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(String bbs_id) {
		this.bbs_id = bbs_id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) throws UnsupportedEncodingException {
		
		this.category = category;
	}
	public CommentBean getCommentbean() {
		return commentbean;
	}
	public void setCommentbean(CommentBean commentbean) {
		this.commentbean = commentbean;
	}


	
	

}

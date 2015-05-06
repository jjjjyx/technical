package com.action;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;






import com.common.uilt.BaseAction;
import com.service.imp.BBsService;
import com.service.imp.CommentService;
@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Action(value="hello" ,results={
		@Result(name="hello",location="/index.jsp"),
		@Result(name="list",location="/hello.jsp"),
})
public class HelloAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 152648759130361975L;
	private static final Logger logger = Logger
			.getLogger(HelloAction.class);
	@Autowired
	private BBsService bbsSerivce;
	@Autowired
	private CommentService commentService;
	@Override
	public String execute() throws Exception {
		logger.debug("欢迎访问");
		request.setAttribute("top_home_list",this.bbsSerivce.getBBSByTop(currentPage,maxrecord) );
		if(session.getAttribute("user")!=null)
		//收到的评论
			request.setAttribute("mycommentlist",this.commentService.getCommentlistBymy(session));
		return "hello";
		
	}
}

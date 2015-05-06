package com.action;

import java.io.PrintWriter;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.Gson;
import com.model.Messages;
import com.model.UserBean;
import com.service.imp.UserService;
@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Action(value="signin" ,results={
		@Result(name="success",location="/index.jsp"),
		@Result(name="error",location="/hello.jsp"),
		@Result(name="off",location="/back/login.jsp")
})
public class SigninAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private UserBean user;
	private static final Logger logger = Logger
			.getLogger(SigninAction.class);
	@Autowired
	private UserService userService;
	public String login() throws Exception{
		logger.info(user.getUser_account()  + "请求登录");
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		Messages m=new Messages();
		try {
			m= userService.login(user,session);
		} catch (Exception e) {
			e.printStackTrace();
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		
		out.print(gson.toJson(m));
		out.flush();
		out.close();
		return NONE;
	}
	//注销状态
	public String writeoff() throws Exception{
		logger.info(((UserBean)session.getAttribute("user")).getUser_account()+"注销");
		return "off";
	}

	public String outlock() throws Exception{
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		Messages m=new Messages();
		try {
			session.invalidate();
			m.setInfo(true);
			m.setText("已成功退出，感谢您的使用");
		} catch (Exception e) {
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		out.print(gson.toJson(m));
		out.flush();
		out.close();
		return NONE;
	}
	public UserBean getUser() {
		return user;
	}
	public void setUser(UserBean user) {
		this.user = user;
	}
}

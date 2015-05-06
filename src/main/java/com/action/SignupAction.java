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
import com.model.UserBean;
import com.model.UserinfoBean;
import com.service.imp.UserService;

@Controller
@ParentPackage("struts-default")
@Namespace("/")
@Action(value = "signup", results = {
		@Result(name = "one", location = "/signup-two.jsp"),
		@Result(name = "two", location = "/signup-three.jsp"),
		@Result(name = "error", location = "/hello.jsp"),
		@Result(name = "off", location = "/back/login.jsp") })
public class SignupAction extends BaseAction {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4422610638007481866L;
	private UserBean user;
	private UserinfoBean uinfo;
	private String conf_pass;
	private String account;
	private String skip;

	@Autowired
	private UserService userService;

	public String signupone() throws Exception {
			try {
				userService.registration(user, conf_pass);
				request.setAttribute("account", user.getUser_account());
			} catch (Exception e) {
				e.printStackTrace();
			}
		return "one";
	}
	// public String signtow
	public String signuptow() throws Exception {
			if (skip.equals("true")) {
				request.setAttribute("step", 3);
			} else {
				try {
					userService.addUserInfo(user,uinfo);
					request.setAttribute("info", "success");
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		return "two";
	}
	public String isAccount() throws Exception {
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		Messages m = null;
		try {
			m = userService.isAccount(account);
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
	public String getConf_pass() {
		return conf_pass;
	}
	public void setConf_pass(String conf_pass) {
		this.conf_pass = conf_pass;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String getSkip() {
		return skip;
	}
	public void setSkip(String skip) {
		this.skip = skip;
	}
	public UserinfoBean getUinfo() {
		return uinfo;
	}
	public void setUinfo(UserinfoBean uinfo) {
		this.uinfo = uinfo;
	}

}

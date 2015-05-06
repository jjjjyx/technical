package com.action;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.model.UserBean;
import com.service.imp.UserService;

@Controller
@ParentPackage("defaultpackage")
@Namespace("/back")
@Action(value = "hello", results = {
		@Result(name = "loaginback", location = "/back/index.jsp"),
		@Result(name = "error", location = "/hello.jsp"), })
public class BackAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7959938854359736029L;
	@Autowired
	private UserService userService;
	private UserBean user;
	public String loaginback(){
		
		return "loaginback";
	}
	public UserBean getUser() {
		return user;
	}
	public void setUser(UserBean user) {
		this.user = user;
	}
	
}

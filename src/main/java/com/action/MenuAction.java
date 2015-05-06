package com.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.Gson;
import com.service.imp.MenuService;

@Controller
@ParentPackage("defaultpackage")
@Namespace("/back")
@Action(value = "menu", results = {
// @Result(name="list",location="/back/editRole.jsp"),
// @Result(name="menu",location="/back/editRoleMenu.jsp"),
@Result(name = "error", location = "/hello.jsp"), })
public class MenuAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 416203426833429800L;
	@Autowired
	private MenuService menuService;

	public String loadUserMenu() throws Exception{
		PrintWriter out = null;
		try {
			out = response.getWriter();
			List<Map<String, Object>> menuTreeList = this.menuService
					.loadUserMenuTree(session);
			Gson gson = new Gson();
			String jsonStr = gson.toJson(menuTreeList);
			out.print(jsonStr);
		} catch (IOException e) {
			e.printStackTrace();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		out.flush();
		out.close();
		return NONE;
	}

}

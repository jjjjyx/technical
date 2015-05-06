package com.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

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
import com.model.RoleBean;
import com.service.imp.RoleService;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/back")
@Action(value="role" ,results={
		@Result(name="list",location="/back/system/editRole.jsp"),
		@Result(name="menu",location="/back/system/editRoleMenu.jsp"),
		@Result(name="error",location="/hello.jsp"),
})
public class RoleAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 3493591241458205380L;
	private static final Logger logger = Logger
			.getLogger(RoleAction.class);
	private String menuid;

	private String rolename;
	private RoleBean role;
	private String roleid;
	@Autowired
	private RoleService roleService;
	
	public String list() throws Exception{
//		logger.info(((UserBean)session.getAttribute("user")).getMail()+"查看角色列表");
		logger.info("查看角色列表");
		try {
			request.setAttribute("rolelist", roleService.pageResault(currentPage,sortField,orderType,maxrecord,request));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return "list";
	}
	/**
	 * 查看角色列表
	 * @return
	 */
	public String loadRoleMenu(){
		PrintWriter out = null;
		try {
			out = response.getWriter();
			List<Map<String, Object>> menuTreeList = this.roleService
					.loadMenuTree(roleid);
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
	/**
	 * 修改角色权限菜单列表
	 * @return
	 * @throws Exception
	 */
	public String editRoleMenu()throws Exception{
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		Messages m= new Messages();
		try {
			m= this.roleService.editRoleMenu(roleid,menuid);
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
	/**
	 * 修改角色属性
	 * @return
	 * @throws Exception
	 */
	public String editRole() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
//		System.out.println("修改"+this.role.getRole_id());
		try {
			m= this.roleService.editRole(this.role);
		} catch (Exception e) {
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
	 * 删除角色
	 * @return
	 */
	public String delRole() throws Exception{
		//deleltRole
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
//		System.out.println("修改"+this.role.getRole_id());
		try {
			m= this.roleService.deleltRole(roleid);
		} catch (Exception e) {
			m.setInfo(false);
			m.setText(e.getMessage());
			e.printStackTrace();
		}
		//System.out.println(111);
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return NONE;
	}
	/**
	 * 新建角色
	 * @return
	 * @throws Exception
	 */
	public String addRole() throws Exception{
		//System.out.println(54654);
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		Messages m= new Messages();
		try {
			m= this.roleService.addRole(this.role);
		} catch (Exception e) {
			e.printStackTrace();
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return  NONE;
	}
	
	public String getRolename() {
		return rolename;
	}
	public void setRolename(String rolename) {
		this.rolename = rolename;
	}
	public RoleBean getRole() {
		return role;
	}
	public void setRole(RoleBean role) {
		this.role = role;
	}
	public String getRoleid() {
		return roleid;
	}
	public void setRoleid(String roleid) {
		this.roleid = roleid;
	}
	public String getMenuid() {
		return menuid;
	}
	public void setMenuid(String menuid) {
		this.menuid = menuid;
	}
	
}

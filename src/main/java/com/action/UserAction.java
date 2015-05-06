package com.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.model.Messages;
import com.model.UserBean;
import com.service.imp.RoleService;
import com.service.imp.UserService;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/back")
@Action(value="user" ,results={
		@Result(name="list",location="/back/system/userlist.jsp"),
		@Result(name="edit",location="/back/system/edituser.jsp"),
		@Result(name="error",location="/hello.jsp"),
})
public class UserAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 8542035684950417689L;
	private static final Logger logger = Logger
			.getLogger(UserAction.class);
	@Autowired
	private UserService userService;
	@Autowired
	private RoleService roleService;
	

	private String role_id_array;
	
	private String user_id;
	private UserBean user;
	/**
	 * 查看用户列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception{
		logger.info("查看用户列表");
		try {
			System.out.println("字段"+sortField);
			System.out.println("顺序"+orderType);
			request.setAttribute("userlist", this.userService.pageResault(currentPage,sortField,orderType,maxrecord,request));
			request.setAttribute("roleList", this.roleService.getAlllist());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "list";
	}
	/**
	 * 修改用户角色
	 * @return
	 * @throws Exception
	 */
	
	public String editUserRole() throws Exception{
		Messages m=new Messages();
		PrintWriter out = response.getWriter();
		Gson gson = new Gson();
		System.out.println("修改"+user.getUser_account()+"角色为：");
		System.out.println(this.role_id_array);
		try {
			m= this.userService.editUser(user,role_id_array);
		} catch (Exception e) {
			m.setInfo(false);
			m.setText(e.getMessage());
		}
		out.print(gson.toJson(m));
		
		out.flush();
		out.close();
		return NONE;
	}
	/**
	 * 获取用户+角色信息 并且回填
	 * @return
	 * @throws Exception
	 */
	public String loadUserinfo() throws Exception{
		Map<String,Object> mapObj=new HashMap<String,Object>();
		PrintWriter out = null;
		Gson gson =new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {

			public boolean shouldSkipField(FieldAttributes f) {
				String name=f.getName();
				//System.out.println(name);
				if(name.equals("user_pass")||name.equals("user_online")||name.equals("user_offline")||
						name.equals("menuid")||name.equals("info_id"))
					return true;
				return false;
			}

			public boolean shouldSkipClass(Class<?> clazz) {
				// TODO Auto-generated method stub
				return false;
			}
			
		}).create();
		try {
			out=response.getWriter();
			System.out.println(user_id);
			mapObj=this.userService.getUserByID(user_id);
		} catch (Exception e) {
			mapObj.put("info", false);
			mapObj.put("text", e.getMessage());
		}
		out.print(gson.toJson(mapObj));
		
		out.flush();
		out.close();
		
		return NONE;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getRole_id_array() {
		return role_id_array;
	}
	public void setRole_id_array(String role_id_array) {
		this.role_id_array = role_id_array;
	}
	public UserBean getUser() {
		return user;
	}
	public void setUser(UserBean user) {
		this.user = user;
	}

	

}

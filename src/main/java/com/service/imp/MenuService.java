package com.service.imp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dao.MenuDao;
import com.dao.RoleDao;
import com.dao.UserDao;
import com.model.MenuBean;
import com.model.RoleBean;
import com.model.UserBean;
@Service
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class MenuService {
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private UserDao userDao;
	/**
	 * 获取登录用户的所有权限
	 * @param session
	 * @return
	 */
	public List<Map<String, Object>> loadUserMenuTree(HttpSession session) {
		UserBean u= (UserBean)session.getAttribute("user");
		UserBean userBean=userDao.get(u.getUser_account());
		List<Map<String,Object>> userallRole= new ArrayList<Map<String,Object>>();
		Set<RoleBean> roleList= userBean.getRoleid();
		/**
		 * 在bean中实现了Comparable接口，并以id 的String 类型正序排序
		 */
		Set<MenuBean> menulistBean= new TreeSet<MenuBean>();
		for(RoleBean r:roleList){
			menulistBean.addAll(r.getMenuid());
		}
		Map<String,Object> treeNode= null;
		for(MenuBean m:menulistBean){
			treeNode= new HashMap<String, Object>();
			treeNode.put("id",m.getMenuid());
			treeNode.put("name", m.getMenuname());
			treeNode.put("pId", m.getPid());
			treeNode.put("menu_herf", m.getMenuhref());
			treeNode.put("isParent", m.getIsParent());
			if(m.getPid()==0){
				treeNode.put("iconSkin",m.getMenu_icon());
			}
			if(m.getMenuid()==2){
				treeNode.put("open", true);
			}
			userallRole.add(treeNode);
		}
		return userallRole;
	}

}

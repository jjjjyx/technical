package com.service.imp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.common.vo.PageResult;
import com.common.vo.Pageutil;
import com.dao.MenuDao;
import com.dao.RoleDao;
import com.model.MenuBean;
import com.model.Messages;
import com.model.RoleBean;

@Service
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class RoleService {
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private MenuDao menuDao;
	private static final Logger logger = Logger
			.getLogger(RoleService.class);

	@SuppressWarnings("deprecation")
	public PageResult<RoleBean> pageResault(int currentPage, String sortField,
			String orderType, int maxrecord, HttpServletRequest request) {
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<RoleBean> result=null;
		int roleCount = 0; // 总记录数
		String sql="select count(a.role_id) from tb_sys_role a where 1=1";
		/**
		 * 1 .取总记录数
		 * 2 .如果带条件
		 * if...
		 */
		String select_name=request.getParameter("select_name");
		if(select_name!=null&&!"".equals(select_name)){
			StringBuffer sbHql= new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.role_name like '%");
			sbHql.append(select_name);
			sbHql.append("%'");
			sql+=sbHql.toString();
			request.setAttribute("select_name", select_name);
		}
		JdbcTemplate jdbcT=roleDao.getJdbcTemplate();
		roleCount=jdbcT.queryForInt(sql);
		
		/**
		 * 获取当前分页的list
		 * 1.排序
		 * 2.查询条件
		 */
		sql = "Select a From RoleBean a where 1=1";
		if(select_name!=null&&!"".equals(select_name)){
			StringBuffer sbHql= new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.role_name like '%");
			sbHql.append(select_name);
			sbHql.append("%'");
			sql+=sbHql.toString();
		}
		if (sortField != null && !"".equals(sortField) && orderType != null
				&&!"".equals(orderType)) {
			sql = sql + " order by a." + sortField + " " + orderType + "";
		} else {
			sql = sql + " order by a.role_id asc";
		}
		List<RoleBean> l=roleDao.find(sql, (currentPage - 1) * maxrecord, maxrecord);
//		System.out.println(l);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,request.getRequestURI(),sortField,orderType);
		result = new PageResult<RoleBean>(l, pageutil);
		return result;
	}

	public Messages editRole(RoleBean role) {
		Messages m = new Messages();
		if(null!=role.getRole_id()&&!"".equals(role.getRole_id())
				&&null!=role.getRole_name()&&!"".equals(role.getRole_name())){
			RoleBean roleBean = roleDao.get(role.getRole_id());
			if(roleBean!=null){
				logger.info("用户++对角色"+roleBean.getRole_name()+"进行修改");
				roleBean.setRole_name(role.getRole_name());
				roleBean.setRole_remark(role.getRole_remark());
				roleDao.update(roleBean);
				m.setInfo(true);
				return m;
			}
		}
		m.setInfo(false);
		m.setText("参数不正常，修改失败，重新尝试");
		return m;
	}

	@SuppressWarnings("deprecation")
	public Messages addRole(RoleBean role) {
		Messages m = new Messages();
		String sql = null;
		if (role.getRole_name() != null && !"".equals(role.getRole_name())) {
			sql = "select count(a.role_name) from tb_sys_role a where 1=1 and a.role_name='"
					+ role.getRole_name().trim() + "'";
			JdbcTemplate jdbcT=roleDao.getJdbcTemplate();
			if(jdbcT.queryForInt(sql)==0){
				roleDao.save(role);
				m.setInfo(true);
			}else{
				m.setInfo(false);
				m.setText("name不可重复,请新输入");
			}
		}else{
			m.setInfo(false);
			m.setText("参数不正确，新建失败，重新尝试");
		}
		return m;
	}

	public List<Map<String, Object>> loadMenuTree(String roleid) {
		List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();
		Set<MenuBean> roleMenu = null;
		if(roleid!=null&&!"".equals(roleid)){
			RoleBean roleBean=this.roleDao.get(roleid);
			roleMenu=roleBean.getMenuid();
		}
		Map<String,Object> treeNode= null;
		List<MenuBean> listBean =this.menuDao.loadAll();
		for(MenuBean m:listBean){
			treeNode= new  HashMap<String, Object>();
			treeNode.put("id", m.getMenuid());
			treeNode.put("name", m.getMenuname());
			treeNode.put("isParent",m.getIsParent());
			treeNode.put("pId", m.getPid());
			if(m.getIsParent()){
				treeNode.put("open", true);
//				treeNode.put("halfCheck", false);//强制办勾选
			//	treeNode.put("checked", true);
			}	/*
				 * 如果当前角色菜单包含 m 打勾
				 */
			if(roleMenu.contains(m)) {
				treeNode.put("checked", true);
			}
			treeList.add(treeNode);
		}
		return treeList;
	}

	public Messages editRoleMenu(String roleid, String menuid) throws Exception{
		Messages m = new Messages();
		StringTokenizer tokenizer = new StringTokenizer(menuid, ",");
		/**
		 * 1：删除角色之前的菜单权限。
		 */
		RoleBean roleBean=this.roleDao.get(roleid);
		Set<MenuBean> roleBeanMenu=roleBean.getMenuid();
		roleBeanMenu.clear();
		/**
		 * 2：增加角色现在的菜单权限。
		 */
		roleBeanMenu=roleBean.getMenuid();
		while (tokenizer.hasMoreElements()) {
			roleBeanMenu.add(this.menuDao.get(Integer.parseInt(tokenizer.nextElement().toString().trim())));
		}
		roleDao.update(roleBean);
		m.setInfo(true);
		return m;
	}

	public List<RoleBean> getAlllist() {
		return this.roleDao.loadAll();
	}
	public Messages deleltRole(String role_id){
		Messages m= new Messages();
		if(role_id!=null&&!"".equals(role_id)){
			String sql="delete from tb_sys_user_role where role_id='"+role_id+"'";
			/**
			 * 删除用户角色表
			 */
			JdbcTemplate jdbc=this.roleDao.getJdbcTemplate();
			jdbc.update(sql);
			/**
			 * 删除角色菜单表
			 */
			sql="delete from tb_sys_role_menu where role_id='"+role_id+"'";
			jdbc.update(sql);
			/**
			 * 删除角色
			 */
			sql="delete from tb_sys_role where role_id='"+role_id+"'";
			jdbc.update(sql);
			m.setInfo(true);
		}else{
			m.setInfo(false);
			m.setText("删除出错，原因：参数错误");
		}
		return m;
	}
//	public void deleltMenu(){
//		MenuBean r= this.menuDao.get(55);
//		this.menuDao.delete(r);
//	}
//	public static void main(String[] args) {
//		ApplicationContext context = new ClassPathXmlApplicationContext(
//				"applicationContext.xml");
//		RoleService roleService = (RoleService) context.getBean("roleService");
//		try {//eed8bd924c8a2482014c8a250c8b0000
//			roleService.deleltRole("eed8bdfb4c93881a014c9388d5460001");
//		} catch (Exception e) {
//			e.printStackTrace();
//			System.out.println(11111111);
//		}
//	}
	
	
}

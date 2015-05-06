package com.service.imp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dao.CategoryDao;
import com.dao.UserDao;
import com.model.CategoryBean;
import com.model.Messages;
import com.model.UserBean;

@Service
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class CategoryService {
	@Autowired
	private CategoryDao  categoryDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 取分类 列表+ 分类下的文章
	 * @param session
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public List<Map<String,String>> list(HttpSession session) {
		// TODO Auto-generated method stub
		UserBean u=(UserBean)session.getAttribute("user");
		u=userDao.get(u.getUser_account());
		
		Set<CategoryBean> s= u.getCategory_id();
		
		String sql ="select count(1) from tb_bbs a where 1=1 and a.user_id='"+u.getUser_account()+"' and a.bbs_info='r' ";
		List<Map<String,String>> l= new ArrayList<Map<String,String>>();
		Map<String,String> m= null;
		String sql2=null;
		for(CategoryBean c:s){
			m=new HashMap<String, String>();
			m.put("name", c.getCategory_name());
			sql2=sql+" and a.category='"+c.getCategory_name()+"'";
			m.put("catecount", String.valueOf(this.jdbcTemplate.queryForInt(sql2)));
			l.add(m);
		}
		//System.out.println(l);
		return l;
	}
	/**
	 * 新增一个分类
	 * @param category
	 * @param session
	 * @return
	 */
	public Map<String, Object> addcategory(CategoryBean category,HttpSession session) {
		// TODO Auto-generated method stub
		Map<String, Object> map= new HashMap<String, Object>();
		Messages m= new Messages();
		
		UserBean u=(UserBean)session.getAttribute("user");
		u=userDao.get(u.getUser_account());
		if(null!=category.getCategory_name()&&!"".equals(category.getCategory_name())){
			category.setUser_id(u);
			categoryDao.save(category);

			m.setInfo(true);
			m.setText("添加成功");
			map.put("obj", category);
		}else{
			m.setInfo(false);
			m.setText("不可添加空值");
		}
		
		map.put("messages", m);
		
		return map;
	}


}

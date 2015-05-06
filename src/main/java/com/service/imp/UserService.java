package com.service.imp;

import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.imageio.ImageIO;
import javax.imageio.ImageReadParam;
import javax.imageio.ImageReader;
import javax.imageio.stream.ImageInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.common.uilt.Md5Utils;
import com.common.vo.PageResult;
import com.common.vo.Pageutil;
import com.dao.CategoryDao;
import com.dao.RoleDao;
import com.dao.UserDao;
import com.dao.UserinfoDao;
import com.model.CategoryBean;
import com.model.Messages;
import com.model.OperateImage;
import com.model.RoleBean;
import com.model.UserBean;
import com.model.UserinfoBean;

@Service
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class UserService {
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserinfoDao userinfoDao;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private CategoryDao categoryDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private static final Logger logger = Logger.getLogger(UserService.class);

	@SuppressWarnings("deprecation")
	public PageResult<UserBean> pageResault(int currentPage, String sortField,
			String orderType, int maxrecord, HttpServletRequest request)
			throws Exception {
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<UserBean> result = null;
		int roleCount = 0; // 总记录数
		String sql = "select count(a.user_account) from tb_sys_user a where 1=1";

		/**
		 * 1 .取总记录数 2 .如果带条件 if...
		 */
		String select_mail = request.getParameter("select_mail");
		String select_name = request.getParameter("select_name");
		String select_load_go = request.getParameter("select_load_go");
		String select_load_end = request.getParameter("select_load_end");

		if (select_mail != null && !"".equals(select_mail)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_account like '%");
			sbHql.append(select_mail);
			sbHql.append("%'");
			sql += sbHql.toString();
			request.setAttribute("select_mail", select_mail);
		}
		if (select_name != null && !"".equals(select_name)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_name like '%");
			sbHql.append(select_name);
			sbHql.append("%'");
			sql += sbHql.toString();
			request.setAttribute("select_name", select_name);
		}
		if (select_load_go != null && !"".equals(select_load_go)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_online > to_date('");
			sbHql.append(select_load_go);
			sbHql.append("','yyyy-mm-dd')");
			sql += sbHql.toString();
			request.setAttribute("select_load_go", select_load_go);
		}
		if (select_load_end != null && !"".equals(select_load_end)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_online < to_date('");
			sbHql.append(select_load_end);
			sbHql.append("','yyyy-mm-dd')");
			sql += sbHql.toString();
			request.setAttribute("select_load_end", select_load_end);
		}
		System.out.println(sql);
		JdbcTemplate jdbcT = userDao.getJdbcTemplate();
		roleCount = jdbcT.queryForInt(sql);
		/**
		 * 获取当前分页的list 1.排序 2.查询条件
		 */
		sql = "Select a From UserBean a where 1=1";
		if (select_mail != null && !"".equals(select_mail)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_account like '%");
			sbHql.append(select_mail);
			sbHql.append("%'");
			sql += sbHql.toString();
		}
		if (select_name != null && !"".equals(select_name)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_name like '%");
			sbHql.append(select_name);
			sbHql.append("%'");
			sql += sbHql.toString();
		}
		if (select_load_go != null && !"".equals(select_load_go)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_online > to_date('");
			sbHql.append(select_load_go);
			sbHql.append("','yyyy-mm-dd')");
			sql += sbHql.toString();

		}
		if (select_load_end != null && !"".equals(select_load_end)) {
			StringBuffer sbHql = new StringBuffer();
			sbHql.append(" and");
			sbHql.append(" a.user_online < to_date('");
			sbHql.append(select_load_end);
			sbHql.append("','yyyy-mm-dd')");
			sql += sbHql.toString();

		}
		if (sortField != null && !"".equals(sortField) && orderType != null
				&& !"".equals(orderType)) {
			sql = sql + " order by a." + sortField + " " + orderType + "";
		} else {
			sql = sql + " order by a.user_account asc";
		}
		System.out.println(sql);
		List<UserBean> l = userDao.find(sql, (currentPage - 1) * maxrecord,
				maxrecord);
		// System.out.println(l);

		Pageutil pageutil = new Pageutil(currentPage, maxrecord, roleCount,
				request.getRequestURI(), sortField, orderType);
		result = new PageResult<UserBean>(l, pageutil);
		return result;
	}

	public Messages login(UserBean user, HttpSession session) throws Exception {

		Messages m = new Messages();
		UserBean u = userDao.get(user.getUser_account());
		if (u != null) {
			if (user.getUser_pass().equals(Md5Utils.JM(u.getUser_pass()))) {
				// userDao.update(user);
				/**
				 * 判断是否管理员
				 */
				u.setUser_online(new Date());
				userDao.update(u);
				m.setInfo(true);
				m.setText("登录成功");
				logger.info(u.getUser_account() + "\t登录成功");
				session.setAttribute("user", u);
			} else {
				m.setInfo(false);
				m.setText("密码错误");
				// logger.info(u.getUser_mail() + "\t登录失败，原因：密码错误");
			}
		} else {
			m.setInfo(false);
			m.setText("账号未注册");
		}
		return m;
	}

	public Map<String, Object> getUserByID(String uers_id) {
		UserBean u = userDao.get(uers_id);
		Map<String, Object> m = new HashMap<String, Object>();
		if (u != null) {
			m.put("info", true);
			m.put("user", u);
		} else {
			m.put("info", false);
			m.put("test", "啊哦，出了点小问题，请重新刷新页面");
		}
		return m;
	}

	/**
	 * 修改用户角色
	 * 
	 * @param user
	 * @param role_id_array
	 * @return
	 */
	public Messages editUser(UserBean user, String role_id_array) {
		Messages m = new Messages();
		StringTokenizer tokenizer = new StringTokenizer(role_id_array, ",");

		UserBean u = userDao.get(user.getUser_account());
		if (u != null) {
			Set<RoleBean> userRole = u.getRoleid();
			userRole.clear();
			userRole = u.getRoleid();
			while (tokenizer.hasMoreElements()) {
				userRole.add(this.roleDao.get(tokenizer.nextElement()
						.toString().trim()));
			}
			this.userDao.update(u);
			m.setInfo(true);
		} else {
			m.setInfo(false);
			m.setText("啊哦，出了点小问题，请重新刷新页面");
		}

		return m;
	}

	public void exit(UserBean value) {
		UserBean u = this.userDao.get(value.getUser_account());
		u.setUser_offline(new Date());
		this.userDao.update(u);

	}

	public Messages registration(UserBean user, String conf_pass) {
		Messages m = new Messages();
		if (user.getUser_account() != null
				&& !"".equals(user.getUser_account())) {
			if (user.getUser_pass().equals(conf_pass)) {
				user.setUser_pass(Md5Utils.KL(Md5Utils.MD52(conf_pass)));
				user.setRegister_date(new Date());
				// System.out.println(user.getUser_account());
				// System.out.println(user.getCommon_mail());
				// System.out.println(user.getUser_pass());
				UserinfoBean ui = new UserinfoBean();
				ui.setUserbean(user);
				user.setUser_info(ui);
				this.userDao.save(user);

				CategoryBean c = new CategoryBean();
				c.setCategory_name("语言学习");
				c.setUser_id(user);
				categoryDao.save(c);
			}
			m.setInfo(true);
			m.setText("注册成功，请填写想详细信息，也可以跳过");
		} else {
			m.setInfo(false);
			m.setText("注册失败，信息不完整");
		}
		return m;
	}

	public Messages isAccount(String account) {
		Messages m = new Messages();
		UserBean u = userDao.get(account);
		if (u != null) {
			m.setInfo(false);
			m.setText("账号已经被注册");
		} else {
			m.setInfo(true);
		}
		return m;
	}

	public Messages addUserInfo(UserBean user, UserinfoBean uinfo) {
		Messages m = new Messages();
		UserBean userBean = this.userDao.get(user.getUser_account());
		if (userBean != null) {
			userBean.setUser_name(user.getUser_name());
			uinfo.setUserbean(userBean);
			this.userinfoDao.save(uinfo);
			m.setInfo(true);
			m.setText("设置完毕");
		} else {
			m.setInfo(false);
			m.setText("啊哦，出了点小问题，请重新刷新页面");
		}
		return m;
	}

	public Map<String, Object> getUserInfoById(HttpSession session) {
		UserBean u = (UserBean) session.getAttribute("user");
		StringBuffer sql = new StringBuffer();
		// select t.*,(select u.user_name from tb_sys_user u where
		// u.user_account=t.user_account) user_name from tb_sys_user_info t
		sql.append("select t.*,(")
				.append("select u.user_name from tb_sys_user u where u.user_account=t.user_account")
				.append(") user_name").append(" from tb_sys_user_info t")
				.append(" where t.user_account='").append(u.getUser_account())
				.append("'");

		Map<String, Object> m = this.jdbcTemplate.queryForMap(sql.toString());
		return m;
	}

	public void editUserInfo(UserBean userBean, UserinfoBean user_info,
			HttpSession session) {
		UserBean u = (UserBean) session.getAttribute("user");
		u = this.userDao.get(u.getUser_account());

		u.setUser_name(userBean.getUser_name());
		UserinfoBean uf = u.getUser_info();
		uf.setAddress(user_info.getAddress());
		uf.setAge(user_info.getAge());
		uf.setBirthday(user_info.getBirthday());
		uf.setBloodtype(user_info.getBloodtype());
		uf.setConstellation(user_info.getConstellation());
		uf.setHome(user_info.getHome());
		uf.setJob(user_info.getJob());
		uf.setLiving(user_info.getLiving());
		uf.setMaritalstatus(user_info.getMaritalstatus());
		uf.setPhone(user_info.getPhone());
		uf.setQqnum(user_info.getQqnum());
		uf.setSex(user_info.getSex());
		this.userinfoDao.update(uf);

	}

	public void edituserhead(HttpSession session, OperateImage image,
			String sevepath) throws Exception {
		FileInputStream is = null;
		ImageInputStream iis = null;
		File savefile = null;
		File oldfile=null;
		System.out.println(22222);
		try {
			// 读取图片文件
			oldfile= new File(image.getSrcpath());
			is = new FileInputStream(oldfile);
			/*
			 * 返回包含所有当前已注册 ImageReader 的 Iterator，这些 ImageReader 声称能够解码指定格式。
			 * 参数：formatName - 包含非正式格式名称 . （例如 "jpeg" 或 "tiff"）等 。
			 */
			Iterator<ImageReader> it = ImageIO
					.getImageReadersByFormatName("jpg");
			ImageReader reader = it.next();
			// 获取图片流
			iis = ImageIO.createImageInputStream(is);
			/*
			 * <p>iis:读取源.true:只向前搜索 </p>.将它标记为 ‘只向前搜索’。
			 * 此设置意味着包含在输入源中的图像将只按顺序读取，可能允许 reader 避免缓存包含与以前已经读取的图像关联的数据的那些输入部分。
			 */
			reader.setInput(iis, true);
			/*
			 * <p>描述如何对流进行解码的类<p>.用于指定如何在输入时从 Java Image I/O
			 * 框架的上下文中的流转换一幅图像或一组图像。用于特定图像格式的插件 将从其 ImageReader 实现的
			 * getDefaultReadParam 方法中返回 ImageReadParam 的实例。
			 */
			ImageReadParam param = reader.getDefaultReadParam();
			/*
			 * 图片裁剪区域。Rectangle 指定了坐标空间中的一个区域，通过 Rectangle 对象
			 * 的左上顶点的坐标（x，y）、宽度和高度可以定义这个区域。
			 */
			Rectangle rect = new Rectangle(image.getX(), image.getY(),
					image.getWidth(), image.getHeight());
			// 提供一个 BufferedImage，将其用作解码像素数据的目标。
			param.setSourceRegion(rect);
			/*
			 * 使用所提供的 ImageReadParam 读取通过索引 imageIndex 指定的对象，并将 它作为一个完整的
			 * BufferedImage 返回。
			 */
			BufferedImage bi = reader.read(0, param);
			// 保存新图片
			savefile = new File(sevepath,oldfile.getName());
			System.out.println(22222);
			ImageIO.write(bi, "jpg", savefile);
			is.close();
			iis.close();
			System.out.println("文件相对路径"+"/headimg/"+savefile.getName());
			UserBean userBean =(UserBean)session.getAttribute("user");
			userBean=this.userDao.get(userBean.getUser_account());
			
			userBean.setUser_head_path("/headimg/"+savefile.getName());
			this.userDao.update(userBean);
			session.setAttribute("user", userBean);
			oldfile.delete();//删除旧文件
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		

	}

}

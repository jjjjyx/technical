package com.service.imp;

import java.io.BufferedReader;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;
import java.sql.Clob;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.hibernate.LobHelper;
import org.hibernate.LockOptions;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.common.vo.PageResult;
import com.common.vo.Pageutil;
import com.dao.BbsContentDao;
import com.dao.BbsDao;
import com.dao.CategoryDao;
import com.dao.CommentDao;
import com.dao.UserDao;
import com.model.BbsBean;
import com.model.BbsContentBean;
import com.model.CategoryBean;
import com.model.CommentBean;
import com.model.Messages;
import com.model.UserBean;

@Service(value="bbsSerivce")
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class BBsService {
	@Autowired
	private BbsDao bbsDao;
	@Autowired
	private BbsContentDao bbsContentDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private CategoryDao  categoryDao;
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 获取分类下的文章
	 * 
	 * @param currentPage 当前分页
	 * @param sortField 排序字段
	 * @param orderType 排序类型
	 * @param maxrecord	分页大小
	 * @param session 获取当前登录的用户
	 * @param info	 文章状态
	 * @param category	分类
	 * @return 结果集
	 */
	
	@SuppressWarnings("deprecation")
	public PageResult<BbsBean> getBBSByCategory(int currentPage, String sortField,
			String orderType, int maxrecord, HttpSession session,
			String info, String category) {
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<BbsBean> result= null;
		int roleCount = 0; // 总记录数
		UserBean u= (UserBean)session.getAttribute("user");
		/**
		 * 取总记录
		 */
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.bbs_info='"+
				info+"' and a.user_id='"+u.getUser_account()+"'";
		if(null!=category&&!"".equals(category)){
			sql+="and a.category='"+category+"'";
		}
		roleCount=this.jdbcTemplate.queryForInt(sql);
		/**
		 * 取分页list
		 * 排序
		 */
		sql = "Select a From BbsBean a where 1=1 and a.bbs_info='"+
				info+"' and a.userid='"+u.getUser_account()+"'";
		if(null!=category&&!"".equals(category)){
			sql+="and a.category='"+category+"'";
		}
		if (sortField != null && !"".equals(sortField) && orderType != null
				&&!"".equals(orderType)) {
			sql = sql + " order by a." + sortField + " " + orderType + "";
		} else {
			sql = sql + " order by a.bbs_id asc";
		}
		
		List<BbsBean> l= bbsDao.find(sql, (currentPage - 1) * maxrecord, maxrecord);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,null,sortField,orderType);
		result= new PageResult<BbsBean>(l, pageutil, null);
		return result;
	}

	@SuppressWarnings("deprecation")
	public Integer getCountByinfo(HttpSession session, String info) {
		int roleCount = 0; // 总记录数
		UserBean u= (UserBean)session.getAttribute("user");
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.bbs_info='"+info+"' and a.user_id='"+u.getUser_account()+"'";
		roleCount=this.jdbcTemplate.queryForInt(sql);
		return roleCount;
	}
	/**
	 * 获取草稿箱
	 * @param currentPage 当前页
	 * @param sortField  排序字段
	 * @param orderType  顺序倒序
	 * @param maxrecord  分页大小
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public PageResult<BbsBean> getBBSByinfo(int currentPage, String sortField,
			String orderType, int maxrecord,HttpSession session,String info) {
		
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<BbsBean> result= null;
		int roleCount = 0; // 总记录数
		UserBean u= (UserBean)session.getAttribute("user");
		/**
		 * 取总记录
		 */
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.bbs_info='"+info+"' and a.user_id='"+u.getUser_account()+"'";
		roleCount=this.jdbcTemplate.queryForInt(sql);
		
		/**
		 * 取分页list
		 * 排序
		 */
		sql = "Select a From BbsBean a where 1=1 and a.bbs_info='"+info+"' and a.userid='"+u.getUser_account()+"'";
		
		if (sortField != null && !"".equals(sortField) && orderType != null
				&&!"".equals(orderType)) {
			sql = sql + " order by a." + sortField + " " + orderType + "";
		} else {
			sql = sql + " order by a.bbs_id asc";
		}
		
		List<BbsBean> l= bbsDao.find(sql, (currentPage - 1) * maxrecord, maxrecord);
//		System.out.println(l);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,null,sortField,orderType);
		result= new PageResult<BbsBean>(l, pageutil, null);
		return result;
	}
	
	/**
	 * 获取 一个文章，可以编辑或者显示
	 * @param editbbs_id
	 * @return
	 */
	public Map<String,Object> getBBSBeanById(String editbbs_id) {
		Map<String, Object> map= new HashMap<String, Object>();
		BbsContentBean bbsc=bbsContentDao.get(Long.parseLong(editbbs_id));
		if (bbsc != null) {
			Clob clob = bbsc.getBbs_content();
			BbsBean bbs= bbsc.getBbs();
			map.put("bbsId", bbs.getBbs_id());
			map.put("bbsTitle", bbs.getBbs_title());//标题
			map.put("bbsCategory",bbs.getCategory());//类别
			map.put("bbscreatetime", bbs.getCreate_time());//发布时间
			map.put("bbsauthor", bbs.getUserid().getUser_account());//作者
			map.put("authorheadsrc", bbs.getUserid().getUser_head_path());//作者头像
			try {
				StringBuffer contentBuffer = new StringBuffer();
				Reader reader = clob.getCharacterStream();
				BufferedReader bufferedReader = new BufferedReader(reader);
				String line = null;
				while ((line = bufferedReader.readLine()) != null) {
					contentBuffer.append(line);
					contentBuffer.append("\n");
				}
				map.put("bbsContent", contentBuffer.toString());
				

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return map;
	}
	
	/**
	 * 保存 or 发布
	 * @param bbsBean
	 * @param content_str
	 * @param session
	 * @return
	 * @throws Exception
	 */
	public Messages saveBBs(BbsBean bbsBean, String content_str,
			HttpSession session) throws Exception {
		Messages m= new Messages();
		UserBean u= (UserBean)session.getAttribute("user");
		u=this.userDao.get(u.getUser_account());
		bbsBean.setUserid(u);
		bbsBean.setCreate_time(new Date());
		bbsBean.setTop_home(false);
		/**
		 * 获取原生session 进行clob 字段操作
		 */
		Session sql_session=sessionFactory.getCurrentSession();
		LobHelper lobHelper = sql_session.getLobHelper();
		Clob temp_clob=lobHelper.createClob(" ");
		
		BbsContentBean bbsc= new BbsContentBean();
		bbsc.setBbs(bbsBean);
		bbsc.setBbs_content(temp_clob);
		
		bbsBean.setBbs_content_id(bbsc);
		/**
		 * 开启字符到clob 输入输入流
		 */
		Reader reader = null;
		BufferedReader bufferedReader = null;
		Writer writer = null;
		try {
			//System.out.println(null==bbsBean.getBbs_id());
			if(null==bbsBean.getBbs_id()){//新建
				sql_session.save(bbsc);
				sql_session.flush();
				
				sql_session.refresh(bbsc, LockOptions.UPGRADE);
				
			}else{//这里有问题--已修复
				//修改
				BbsBean b=bbsDao.get(bbsBean.getBbs_id());
				
				b.setBbs_title(bbsBean.getBbs_title());
				b.setCreate_time(new Date());
				b.setAdd_content_src(bbsBean.getAdd_content_src());
				b.setCategory(bbsBean.getCategory());
				b.setBbs_info(bbsBean.getBbs_info());
				bbsc=b.getBbs_content_id();
				bbsc.setBbs_content(temp_clob);
			}
			java.sql.Clob content_clob =bbsc.getBbs_content();
			
			writer = content_clob.setCharacterStream(0);
			reader = new StringReader(content_str);
			bufferedReader = new BufferedReader(reader);
			String line = null;
			
			while ((line = bufferedReader.readLine()) != null) {
				writer.write(line);
				writer.write("\n");
			}
			writer.flush();
			
			sql_session.update(bbsc);
			sql_session.flush();
			m.setInfo(true);
		} catch (Exception e) {
			m.setInfo(false);
			m.setText(e.getMessage());
			throw e;
		}
		return m;
	}
	/**
	 * 删除一个文章
	 * 只是将其设置为垃圾状态
	 * @param bbs_id
	 * @return
	 */
	public Messages delbbs(String bbs_id) {
		Messages m= new Messages();
		BbsBean bbsBean=this.bbsDao.get(Long.parseLong(bbs_id));
		bbsBean.setBbs_info("t");//t  为垃圾状态
		this.bbsDao.update(bbsBean);
		m.setInfo(true);
		m.setText("成功删除");
		return m;
	}

	/**
	 * 获取置顶文章列表
	 * @param currentPage
	 * @param maxrecord
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public PageResult<Map<String,Object>> getBBSByTop(int currentPage,  int maxrecord) {
		// TODO Auto-generated method stub
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 4;
		PageResult<Map<String,Object>> result= null;
		int roleCount = 0; // 总记录数
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.top_home=1 and a.bbs_info='r'";
		roleCount=this.jdbcTemplate.queryForInt(sql);
		
		StringBuffer sb= new StringBuffer();
		sb.append("select * from (");
		sb.append("select rownum rn, b.*");
		sb.append("from (select TS.*");
		
		sb.append(" ,(select tbuser.user_head_path from tb_sys_user tbuser where 1=1 and tbuser.user_account=ts.user_id) as user_head_path");
		sb.append(" from TB_BBS TS");
		sb.append(" where 1 = 1 and ts.top_home=1");
		sb.append(" and ts.bbs_info = 'r'");
		sb.append(" order by ts.create_time desc) b");
		sb.append(" where rownum <= ");
		sb.append(currentPage*maxrecord);
		sb.append(") t");
		sb.append(" where t.rn >=");
		sb.append((currentPage-1)*maxrecord+1);
		
		List<Map<String,Object>> l=this.jdbcTemplate.queryForList(sb.toString());
//		System.out.println(l);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,null,null,null);
		result= new PageResult<Map<String,Object>>(l, pageutil, null);
		return result;
	}
	/**
	 * 获取全部文章列表
	 * 
	 * @param currentPage
	 * @param maxrecord
	 * @param session
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public PageResult<Map<String,Object>> getAllbbs(int currentPage,  int maxrecord, HttpSession session) {
		//String 
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<Map<String,Object>> result= null;
		int roleCount = 0; // 总记录数
		UserBean u= (UserBean)session.getAttribute("user");
		/**
		 * 取总记录
		 */
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.bbs_info='r'";
		roleCount=this.jdbcTemplate.queryForInt(sql);
		
		/**
		 * 取分页list
		 * 排序
		 */
		//第一种方法
//		select b.*,a.friend from tb_bbs b left join (
//	       select c.bbs_id ,1 as friend from tb_bbs c where user_id in(
//	                       select t.friend_account from tb_sys_user_friends t where t.userid ='xsqtest'
//	                       )
//	       ) a on a.bbs_id= b.bbs_id
//第二种方法
//select TS.*, 
//case when TS.USER_ID in (select FRIEND_ACCOUNT from TB_SYS_USER_FRIENDS a where a.USERID='xsqtest') then 1 
//else 0 end IsBelongToMyFriend
//from TB_BBS TS
		//排序
//		select *
//		  from (select rownum rn, b.*
//		          from (select TS.*,case when TS.USER_ID in
//		                              (select FRIEND_ACCOUNT  from TB_SYS_USER_FRIENDS a  where a.USERID = 'xsqtest') then 1
//		                         else  0
//		                       end IsBelongToMyFriend
//		                  from TB_BBS TS
//		                 where 1 = 1
//		                   and ts.bbs_info = 'r'
//		                 order by ts.create_time desc) b
//		         where rownum <= 20) t
//		 where t.rn >= 11
		StringBuffer sb= new StringBuffer();
		sb.append("select * from (");
		sb.append("select rownum rn, b.*");
		sb.append("from (select TS.*,");
		if(null!=u){
			sb.append(" case when TS.USER_ID in").
				append(" (select FRIEND_ACCOUNT  from TB_SYS_USER_FRIENDS a  where a.USERID = '");
			sb.append(u.getUser_account());
			sb.append("') then 1");
			sb.append(" else  0");
			sb.append("end IsBelongToMyFriend");
		}else{
			sb.append("0 as IsBelongToMyFriend");
		}//,(select count(tbc.comment_id) from tb_comment tbc where 1=1 and tbc.bbs_id=ts.bbs_id) as commentcount
		sb.append(" ,(select count(tbc.comment_id) from tb_comment tbc where 1=1 and tbc.bbs_id=ts.bbs_id) as commentcount");
		sb.append(" ,(select tbuser.user_head_path from tb_sys_user tbuser where 1=1 and tbuser.user_account=ts.user_id) as user_head_path");
		sb.append(" from TB_BBS TS");
		sb.append(" where 1 = 1");
		sb.append(" and ts.bbs_info = 'r'");
		sb.append(" order by ts.create_time desc) b");
		sb.append(" where rownum <= ");
		sb.append(currentPage*maxrecord);
		sb.append(") t");
		sb.append(" where t.rn >=");
		sb.append((currentPage-1)*maxrecord+1);

		
//		System.out.println(sb.toString());
		List<Map<String,Object>> l=this.jdbcTemplate.queryForList(sb.toString());
//		System.out.println(l);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,null,null,null);
		result= new PageResult<Map<String,Object>>(l, pageutil, null);
		return result;

	}



	public void test(){
		UserBean u= new UserBean();
		u=userDao.get("admin");
		
		BbsBean bbs= new BbsBean();
		bbs.setBbs_title("testsd44");
		bbs.setCreate_time(new Date());
		bbs.setUserid(u);
		BbsContentBean bbsc= new BbsContentBean();
		
		bbs.setBbs_content_id(bbsc);
		bbsc.setBbs(bbs);
		
		bbsContentDao.save(bbsc);
		
		CommentBean c= new CommentBean();
		c.setBbs_id(bbs);
		c.setComment_time(new Date());
		c.setComment_user_id(u);
		commentDao.save(c);
	}
	public void test2(){
		UserBean u= new UserBean();
		u=userDao.get("admin");
		
		CategoryBean c= new CategoryBean();
		c.setCategory_name("Hibernate");
		c.setUser_id(u);
		categoryDao.save(c);
	}
	public void Select(){
		UserBean u=userDao.get("admin");
		Set<BbsBean> s=u.getBbs_id();

		BbsContentBean bb= null;
		Set<CommentBean> s1= u.getComment_id();
		System.out.println(s.toString());
		Set<CategoryBean> s2= u.getCategory_id();
		for(BbsBean b:s){
			System.out.println(b.getBbs_id()+":"+b.getBbs_title());
			s1=b.getComment_id();
			for(CommentBean c:s1){
				System.out.println("文章的评论"+c.getComment_id()+":"+c.getComment_time());
			}
			bb=b.getBbs_content_id();
			System.out.println(bb.getBbs_id());
		}
		
		s1=u.getComment_id();
		for(CommentBean c:s1){
			System.out.println("用户的评论"+c.getComment_id()+":"+c.getComment_time());
		}
		
		for(CategoryBean cc:s2)
			System.out.println("用户所有分类："+cc.getCategory_name());
		
	}
	@SuppressWarnings("resource")
	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationContext.xml");
		BBsService bbsService = (BBsService) context.getBean("bbsSerivce");
		try {
			bbsService.Select();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.println(11111111);
		}
	}


}

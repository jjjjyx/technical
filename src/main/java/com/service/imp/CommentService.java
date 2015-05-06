package com.service.imp;

import java.io.BufferedReader;
import java.io.Reader;
import java.io.StringReader;
import java.io.Writer;
import java.sql.Clob;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.LobHelper;
import org.hibernate.LockOptions;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.common.uilt.DateUtil;
import com.common.vo.Pageutil;
import com.dao.BbsDao;
import com.dao.CommentDao;
import com.dao.UserDao;
import com.google.gson.Gson;
import com.model.BbsBean;
import com.model.CommentBean;
import com.model.Messages;
import com.model.UserBean;

@Service(value="commentService")
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class CommentService {
	@Autowired
	private BbsDao bbsDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private CommentDao commentDao;
	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 保存评论
	 * @param commentBean 评论信息
	 * @param content_str 内容流
	 * @param session  当前登录的用户的
	 * @param vali 验证码
	 * @param bbs_id  评论的文章
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public Messages savecomment(CommentBean commentBean, String content_str,
			HttpSession session, String vali,String bbs_id) throws Exception {
		Messages m= new Messages();
		String vc=(String)session.getAttribute("vc");
		if(vc!=null)
			if(!vc.equalsIgnoreCase(vali)){
				m.setInfo(false);
				m.setText("验证码不正确");
				return m;
			}
	
		
		Session sql_session=sessionFactory.getCurrentSession();
		LobHelper lobHelper = sql_session.getLobHelper();
		Clob temp_clob=lobHelper.createClob(" ");
		
		//获取登录的user
		UserBean u=(UserBean)session.getAttribute("user");
		u=this.userDao.get(u.getUser_account());
		BbsBean bbs=this.bbsDao.get(Long.parseLong(bbs_id));
		commentBean.setComment_user_id(u);
		commentBean.setComment_time(new Date());
		commentBean.setBbs_id(bbs);
		commentBean.setComment_content(temp_clob);
		commentBean.setIsread(true);
		
		 // 最大楼数
		String sql = "select max(a.comment_layer) from tb_comment a where 1=1 ";
		Long roleCount=new Long(jdbcTemplate.queryForInt(sql));
		commentBean.setComment_layer(roleCount+1);
		/**
		 * 开启字符到clob 输入输入流
		 */
		Reader reader = null;
		BufferedReader bufferedReader = null;
		Writer writer = null;
		try {
			sql_session.save(commentBean);
			sql_session.flush();
			sql_session.refresh(commentBean, LockOptions.UPGRADE);
			
			java.sql.Clob content_clob =commentBean.getComment_content();
			
			writer = content_clob.setCharacterStream(0);
			reader = new StringReader(content_str);
			bufferedReader = new BufferedReader(reader);
			String line = null;
			while ((line = bufferedReader.readLine()) != null) {
				writer.write(line);
				writer.write("\n");
			}
			writer.flush();
			
			sql_session.update(commentBean);
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
	 * 获取 某文章的所有评论
	 * 
	 * @param currentPage
	 * @param sortField
	 * @param orderType
	 * @param maxrecord
	 * @param bbs_id
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("deprecation")
	public Map<String,Object> getCommentList(int currentPage, String sortField,
			String orderType, int maxrecord, String bbs_id, HttpServletRequest request) throws Exception {
		Map<String,Object> m= new HashMap<String,Object>();
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		int roleCount = 0; // 总记录数
		String sql = "select count(a.comment_id) from tb_comment a where 1=1 and a.bbs_id="+Long.parseLong(bbs_id)+"";
		roleCount=this.jdbcTemplate.queryForInt(sql);
		/**
		 * 取分页list
		 * 排序
		 */
		//sql = "Select a From CommentBean a where 1=1 and a.bbs_id="+Long.parseLong(bbs_id)+" order by a.comment_time asc";
		StringBuffer sb = new StringBuffer();
		sb.append("select * from (");
		sb.append("select rownum rn, b.*");
		sb.append(" from (select a.*,(");
		sb.append(" select tsu.user_head_path from tb_sys_user tsu where tsu.user_account=a.comment_user_id) as user_hear_src");
		sb.append(" from tb_comment a where a.bbs_id=");
		sb.append(bbs_id);
		sb.append(" order by a.comment_time asc) b");
		sb.append(" where rownum <= ");
		sb.append(currentPage*maxrecord);
		sb.append(") t");
		sb.append(" where t.rn >=");
		sb.append((currentPage-1)*maxrecord+1);
		List<Map<String,Object>> l = this.jdbcTemplate.queryForList(sb.toString());
		m.put("list", l);
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,request.getRequestURI(),sortField,orderType);
		Gson gson = new Gson();
		m.put("pageinfo",gson.toJson(pageutil));
		Messages m1= new Messages();
		m1.setInfo(true);
		m1.setText("获取成功");
		m.put("messages", m1);
		
		return m;
	}
	/**
	 * 获取用户的最新消息
	 * @param session
	 * @return
	 * @throws ParseException 
	 */
	public List<Map<String,Object>> getCommentlistBymy(HttpSession session) throws ParseException {
		UserBean u= (UserBean)session.getAttribute("user");

		StringBuffer sb=new StringBuffer();
		sb.append("select to_char(t.comment_time,'yyyy-MM-dd HH24:mi:ss') as comment_time");
		sb.append(" ,t.comment_pname,t.isread,t.comment_user_id,t.bbs_id,t.comment_id,t.comment_content");
		sb.append(",(select tbbbs.bbs_title from tb_bbs tbbbs where tbbbs.bbs_id=t.bbs_id) as bbs_title");
		sb.append(",(select tbuser.user_head_path from tb_sys_user tbuser where tbuser.user_account=t.comment_user_id) as user_head_path");
		sb.append(" from tb_comment t");
		sb.append(" where t.comment_pname ='");
		sb.append(u.getUser_account());
		sb.append("' and t.comment_user_id not in ('");
		sb.append(u.getUser_account());
		sb.append("')");
		sb.append(" and t.isread=1");
		List<Map<String,Object>> l=this.jdbcTemplate.queryForList(sb.toString());
		for(Map<String,Object> map:l){
			String s=(String)map.get("comment_time");
			try {
				map.put("comment_time", DateUtil.getQuot(DateUtil.Stringformatdate(s)));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return l;
	}
	public void markread(HttpSession session){
		UserBean u= (UserBean)session.getAttribute("user");
		String sql="update tb_comment t set t.isread=0 where t.comment_pname='"+u.getUser_account()+"'";
		this.jdbcTemplate.update(sql);
	}
	/**
	 * 获取用户的全部消息
	 */

	public List<Map<String,Object>> getCommentlistBymy(HttpSession session, String string) {
		UserBean u= (UserBean)session.getAttribute("user");

		StringBuffer sb=new StringBuffer();
		sb.append("select to_char(t.comment_time,'yyyy-MM-dd HH24:mi:ss') as comment_time");
		sb.append(" ,t.comment_pname,t.isread,t.comment_user_id,t.bbs_id,t.comment_id,t.comment_content");
		sb.append(",(select tbbbs.bbs_title from tb_bbs tbbbs where tbbbs.bbs_id=t.bbs_id) as bbs_title");
		sb.append(",(select tbuser.user_head_path from tb_sys_user tbuser where tbuser.user_account=t.comment_user_id) as user_head_path");
		sb.append(" from tb_comment t");
		sb.append(" where t.comment_pname ='");
		sb.append(u.getUser_account());
		sb.append("' and t.comment_user_id not in ('");
		sb.append(u.getUser_account());
		sb.append("')");
		List<Map<String,Object>> l=this.jdbcTemplate.queryForList(sb.toString());
		for(Map<String,Object> map:l){
			String s=(String)map.get("comment_time");
			try {
				map.put("comment_time", DateUtil.getQuot(DateUtil.Stringformatdate(s)));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return l;
	}
	
//	@SuppressWarnings("deprecation")
//	public Integer getUsernewcomment(HttpSession session){
//		String sql="select count(t.comment_id) from tb_comment t where t.comment_pname ='"+
//				((UserBean)session.getAttribute("user")).getUser_account()+"' and t.isread=1";
//		
//		return this.jdbcTemplate.queryForInt(sql);
//	}
	
}

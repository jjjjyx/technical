package com.service.imp;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.common.vo.PageResult;
import com.common.vo.Pageutil;
import com.dao.BbsDao;
import com.dao.FriendsDao;
import com.dao.UserDao;
import com.model.Messages;
import com.model.UserBean;
import com.model.UserFriends;
@Service
@Transactional(rollbackFor = { RuntimeException.class }, propagation = Propagation.REQUIRED)
public class FriendsService {
	@Autowired
	private FriendsDao friendsDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private BbsDao bbsDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 增加一个关注
	 * @param session
	 * @param user_account
	 * @return
	 */
	public Messages addfriends(HttpSession session, String user_account) {
		// TODO Auto-generated method stub
		Messages m= new Messages();
		m.setInfo(true);
		UserBean u=(UserBean)session.getAttribute("user");
		u=this.userDao.get(u.getUser_account());
		UserFriends uf= new UserFriends();
		uf.setUserid(u);
		uf.setFriend_account(user_account);
		this.friendsDao.save(uf);
		m.setText("添加成功，您以后可以在主页看到TA 的最新信息");
		return m;
	}
	/**
	 * 获取用户的所有关注用户的bbs
	 * @param currentPage
	 * @param maxrecord
	 * @param session
	 * @return
	 */
	@SuppressWarnings("deprecation")
	public PageResult<Map<String,Object>> getbbsinfriend(int currentPage,int maxrecord, HttpSession session) {
		//String 
		if (currentPage <= 0) {
			currentPage = 1;
		}
		if (maxrecord <= 0)
			maxrecord = 10;
		PageResult<Map<String,Object>> result= null;
		int roleCount = 0; // 总记录数
		/**
		 * 取总记录
		 */
		UserBean u=(UserBean) session.getAttribute("user");
		//select a.* from tb_bbs a where 1=1 and a.bbs_info='r' and a.user_id in(select b.friend_account from tb_sys_user_friends b where b.userid='xsqtest')
		String sql = "select count(a.bbs_id) from tb_bbs a where 1=1 and a.bbs_info='r' and a.user_id in(select b.friend_account from tb_sys_user_friends b where b.userid='"+u.getUser_account()+"')";//and a.user_id in ()
		
		roleCount=this.jdbcTemplate.queryForInt(sql);
		
		/**
		 * 取分页list
		 * 排序
		 */
		//sql = "Select a From BbsBean a where 1=1 and a.bbs_info='r' and a.userid in(select b.friend_account from UserFriends b where b.userid='"+u.getUser_account()+"') order by a.create_time desc";
		StringBuffer sb= new StringBuffer();
		sb.append("select * from (");
		sb.append("select rownum rn, b.*");
		sb.append("from (select TS.*");
		sb.append(" ,(select count(tbc.comment_id) from tb_comment tbc where 1=1 and tbc.bbs_id=ts.bbs_id) as commentcount");
		sb.append(" ,(select tbuser.user_head_path from tb_sys_user tbuser where tbuser.user_account=ts.user_id) as user_head_path");
		sb.append(" from TB_BBS TS");
		sb.append(" where 1 = 1");
		sb.append(" and ts.bbs_info = 'r'");
		sb.append(" and TS.user_id in(select uf.friend_account from tb_sys_user_friends uf where uf.userid='"+u.getUser_account()+"')");
		sb.append(" order by ts.create_time desc) b");
		sb.append(" where rownum <= ");
		sb.append(currentPage*maxrecord);
		sb.append(") t");
		sb.append(" where t.rn >=");
		sb.append((currentPage-1)*maxrecord+1);
		List<Map<String,Object>> l= this.jdbcTemplate.queryForList(sb.toString());
		Pageutil pageutil= new Pageutil(currentPage,maxrecord,roleCount,null,null,null);
		result= new PageResult<Map<String,Object>>(l, pageutil, null);
		return result;

	}
	/**
	 * 取消关注
	 * @param session
	 * @param user_account
	 * @return
	 */
	public Messages removefriends(HttpSession session, String user_account) {
		Messages m= new Messages();
		UserBean u=(UserBean)session.getAttribute("user");
		
		String sql="delete from tb_sys_user_friends t where t.userid='"+u.getUser_account()+"' and t.friend_account in('"+user_account+"')";
		this.jdbcTemplate.update(sql);
		m.setInfo(true);
		m.setText("成功删除");
		return m;
	}

}

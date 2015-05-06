package com.model;


import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

import com.common.an.UserTitle;

@Entity
@Table(name="tb_sys_user")
public class UserBean implements Serializable{
	/**
	 */
	private static final long serialVersionUID = -6310409516301779226L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "assigned")
	@GeneratedValue(generator = "idGenerator")
	@UserTitle(title="账号")
	private String user_account;
	private String user_pass;
	@UserTitle(title="真实姓名")
	private String user_name;
	private String user_head_path; 	//头像路径
	@UserTitle(title="登录时间")
	private Date user_online;		// 上次登录时间
	private Date user_offline;		// 上次离线时间

	private Date register_date; //注册时间
	private String common_mail; //常用邮箱
	//角色
	@ManyToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	@Fetch(FetchMode.SELECT)
	@JoinTable(name = "tb_sys_user_role", joinColumns = { 
	@JoinColumn(name = "user_account") }, 
		inverseJoinColumns = { @JoinColumn(name = "role_id") })
	private Set<RoleBean> roleid;
	
	//文章标题 
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="userid")
	@Fetch(FetchMode.SELECT)
	private Set<BbsBean> bbs_id;
	
	//关注列表 
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="userid")
	@Fetch(FetchMode.SELECT)
	private Set<UserFriends> friends;
	
	//评论
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="comment_user_id")
	@Fetch(FetchMode.SELECT)
	private Set<CommentBean> comment_id;
	//类别
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="user_id")
	@Fetch(FetchMode.SELECT)
	@OrderBy(value="category_name")
	private Set<CategoryBean> category_id;
	
	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn
	private UserinfoBean user_info;
	
	public Set<RoleBean> getRoleid() {
		return roleid;
	}
	public void setRoleid(Set<RoleBean> roleid) {
		this.roleid = roleid;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_head_path() {
		return user_head_path;
	}
	public void setUser_head_path(String user_head_path) {
		this.user_head_path = user_head_path;
	}
	public Date getUser_online() {
		return user_online;
	}
	public void setUser_online(Date user_online) {
		this.user_online = user_online;
	}
	public Date getUser_offline() {
		return user_offline;
	}
	public void setUser_offline(Date user_offline) {
		this.user_offline = user_offline;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((user_account == null) ? 0 : user_account.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		UserBean other = (UserBean) obj;
		if (user_account == null) {
			if (other.user_account != null)
				return false;
		} else if (!user_account.equals(other.user_account))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "UserBean [user_name=" + user_name + "]";
	}
	public String getUser_account() {
		return user_account;
	}
	public void setUser_account(String user_account) {
		this.user_account = user_account;
	}
	public Date getRegister_date() {
		return register_date;
	}
	public void setRegister_date(Date register_date) {
		this.register_date = register_date;
	}
	public String getCommon_mail() {
		return common_mail;
	}
	public void setCommon_mail(String common_mail) {
		this.common_mail = common_mail;
	}
	public Set<BbsBean> getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(Set<BbsBean> bbs_id) {
		this.bbs_id = bbs_id;
	}
	public Set<CommentBean> getComment_id() {
		return comment_id;
	}
	public void setComment_id(Set<CommentBean> comment_id) {
		this.comment_id = comment_id;
	}
	public Set<CategoryBean> getCategory_id() {
		return category_id;
	}
	public void setCategory_id(Set<CategoryBean> category_id) {
		this.category_id = category_id;
	}
	public Set<UserFriends> getFriends() {
		return friends;
	}
	public void setFriends(Set<UserFriends> friends) {
		this.friends = friends;
	}
	public UserinfoBean getUser_info() {
		return user_info;
	}
	public void setUser_info(UserinfoBean user_info) {
		this.user_info = user_info;
	}
	

}

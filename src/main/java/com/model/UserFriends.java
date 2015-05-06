package com.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="tb_sys_user_friends")
public class UserFriends implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 7278865275011171322L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	private String id;
	private String friend_account;
	
	
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="userid")//加入一列作为外键
	private UserBean userid;
	public String getFriend_account() {
		return friend_account;
	}
	public void setFriend_account(String friend_account) {
		this.friend_account = friend_account;
	}
	public UserBean getUserid() {
		return userid;
	}
	public void setUserid(UserBean userid) {
		this.userid = userid;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((friend_account == null) ? 0 : friend_account.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		UserFriends other = (UserFriends) obj;
		if (friend_account == null) {
			if (other.friend_account != null)
				return false;
		} else if (!friend_account.equals(other.friend_account))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	
}

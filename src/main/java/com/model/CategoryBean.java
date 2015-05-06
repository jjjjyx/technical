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
@Table(name="t_category")
/**
 * 文章类别表
 * @author lenove-x
 *
 */
public class CategoryBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2911386540689577013L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	private String category_id;
	private String category_name;
	
	
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="user_id")//加入一列作为外键
	private UserBean user_id;
	

	public String getCategory_id() {
		return category_id;
	}
	public void setCategory_id(String category_id) {
		this.category_id = category_id;
	}

	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public UserBean getUser_id() {
		return user_id;
	}
	public void setUser_id(UserBean user_id) {
		this.user_id = user_id;
	}

	
}

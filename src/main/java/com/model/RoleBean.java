package com.model;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "tb_sys_role")
public class RoleBean implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 891503338649954665L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "uuid")
	@GeneratedValue(generator = "idGenerator")
	private String role_id;
	private String role_name;
	private String role_remark;
	@ManyToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL)
	@Fetch(FetchMode.SELECT)
	@JoinTable(name = "tb_sys_role_menu", joinColumns = { 
	@JoinColumn(name = "role_id") }, 
	inverseJoinColumns = { @JoinColumn(name = "menu_id") })
	private Set<MenuBean> menuid;
	
	public String getRole_id() {
		return role_id;
	}

	public void setRole_id(String role_id) {
		this.role_id = role_id;
	}

	public String getRole_name() {
		return role_name;
	}

	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}

	public String getRole_remark() {
		return role_remark;
	}

	public void setRole_remark(String role_remark) {
		this.role_remark = role_remark;
	}

	public Set<MenuBean> getMenuid() {
		return menuid;
	}

	public void setMenuid(Set<MenuBean> menuid) {
		this.menuid = menuid;
	}

}

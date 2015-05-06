//package com.model;
//
//import java.io.Serializable;
//
//import javax.persistence.Entity;
//import javax.persistence.GeneratedValue;
//import javax.persistence.Id;
//import javax.persistence.Table;
//
//import org.hibernate.annotations.GenericGenerator;
//import org.hibernate.annotations.Parameter;
//
//@Entity
//@Table(name = "tb_sys_usersetinfo")
//public class UserSettingInfoBean implements Serializable{
//	/**
//	 * 
//	 */
//	private static final long serialVersionUID = -5043980237462513587L;
//	@Id
//	@GenericGenerator(name = "idGenerator", strategy = "sequence", parameters = { @Parameter(name = "sequence", value = "user_info_id") })
//	@GeneratedValue(generator = "idGenerator")
//	private Long info_id;
//	private String user_account;
//	private String setting_key;
//	private String setting_value;
//
//	public Long getInfo_id() {
//		return info_id;
//	}
//
//	public void setInfo_id(Long info_id) {
//		this.info_id = info_id;
//	}
//
//	public String getUser_account() {
//		return user_account;
//	}
//
//	public void setUser_account(String user_account) {
//		this.user_account = user_account;
//	}
//
//	public String getSetting_key() {
//		return setting_key;
//	}
//
//	public void setSetting_key(String setting_key) {
//		this.setting_key = setting_key;
//	}
//
//	public String getSetting_value() {
//		return setting_value;
//	}
//
//	public void setSetting_value(String setting_value) {
//		this.setting_value = setting_value;
//	}
//
//}

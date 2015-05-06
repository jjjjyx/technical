package com.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.common.an.UserTitle;
@Entity
@Table(name="tb_sys_user_info")
public class UserinfoBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2897565707479126243L;
	@Id
	@GeneratedValue(generator = "pkGenerator")
	@GenericGenerator(name = "pkGenerator", 
			strategy = "foreign", 
			parameters = @Parameter(name = "property", value = "userbean"))
	private String user_account;
	@OneToOne(cascade=CascadeType.ALL, mappedBy="user_info")
	private UserBean userbean;
	@UserTitle(title="性别")
	private String sex; 			//性别 0女 1男
	@UserTitle(title="年龄")
	private Integer  age; 			//年龄
	@UserTitle(title="生日")
	private String birthday; 		//生日
	@UserTitle(title="星座")
	private String constellation; 	//星座
	@UserTitle(title="现居住")
	private String living;			//现居住
	@UserTitle(title="婚姻状况")
	private String maritalstatus;	//婚姻状况
	@UserTitle(title="血型")
	private String bloodtype;		//血型
	@UserTitle(title="家乡")
	private String home;			//家乡
	@UserTitle(title="职业")
	private String job;				//职业
	@UserTitle(title="地址")
	private String address;			//地址
	@UserTitle(title="手机")
	private String phone;			//手机
	@UserTitle(title="qq")
	private String qqnum;			//qq
	public String getUser_account() {
		return user_account;
	}
	public void setUser_account(String user_account) {
		this.user_account = user_account;
	}
	public UserBean getUserbean() {
		return userbean;
	}
	public void setUserbean(UserBean userbean) {
		this.userbean = userbean;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getConstellation() {
		return constellation;
	}
	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}
	public String getLiving() {
		return living;
	}
	public void setLiving(String living) {
		this.living = living;
	}
	public String getMaritalstatus() {
		return maritalstatus;
	}
	public void setMaritalstatus(String maritalstatus) {
		this.maritalstatus = maritalstatus;
	}
	public String getBloodtype() {
		return bloodtype;
	}
	public void setBloodtype(String bloodtype) {
		this.bloodtype = bloodtype;
	}
	public String getHome() {
		return home;
	}
	public void setHome(String home) {
		this.home = home;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getQqnum() {
		return qqnum;
	}
	public void setQqnum(String qqnum) {
		this.qqnum = qqnum;
	}
	
	
}

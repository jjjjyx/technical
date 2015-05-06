package com.model;

import java.io.Serializable;
import java.sql.Clob;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name="tb_comment")
/**
 * 评论表
 * @author lenove-x
 *
 */
public class CommentBean implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4717481170155055736L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "sequence", parameters = { @Parameter(name = "sequence", value = "comment_id") })
	@GeneratedValue(generator = "idGenerator")
	private Long comment_id;
	private Clob comment_content;
	private Date comment_time;
	private Long comment_pid;
	private String comment_pname;//回复谁
	private Long comment_layer;
	private Boolean isread;
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="comment_user_id")//加入一列作为外键
	private UserBean comment_user_id;//评论人
	
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="bbs_id")//加入一列作为外键
	private BbsBean bbs_id; 
	@Transient
	private String comment_content_str;
	
	public Long getComment_id() {
		return comment_id;
	}
	public void setComment_id(Long comment_id) {
		this.comment_id = comment_id;
	}
	public Clob getComment_content() {
		return comment_content;
	}
	public void setComment_content(Clob comment_content) {
		this.comment_content = comment_content;
	}
	public Date getComment_time() {
		return comment_time;
	}
	public void setComment_time(Date comment_time) {
		this.comment_time = comment_time;
	}
	public UserBean getComment_user_id() {
		return comment_user_id;
	}
	public void setComment_user_id(UserBean comment_user_id) {
		this.comment_user_id = comment_user_id;
	}
	public BbsBean getBbs_id() {
		return bbs_id;
	}
	public void setBbs_id(BbsBean bbs_id) {
		this.bbs_id = bbs_id;
	}
	public Long getComment_pid() {
		return comment_pid;
	}
	public void setComment_pid(Long comment_pid) {
		this.comment_pid = comment_pid;
	}
	public String getComment_content_str() {
		return comment_content_str;
	}
	public void setComment_content_str(String comment_content_str) {
		this.comment_content_str = comment_content_str;
	}
	public Long getComment_layer() {
		return comment_layer;
	}
	public void setComment_layer(Long comment_layer) {
		this.comment_layer = comment_layer;
	}
	public String getComment_pname() {
		return comment_pname;
	}
	public void setComment_pname(String comment_pname) {
		this.comment_pname = comment_pname;
	}
	public Boolean getIsread() {
		return isread;
	}
	public void setIsread(Boolean isread) {
		this.isread = isread;
	}
	
}

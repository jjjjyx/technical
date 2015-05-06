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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "tb_bbs")
public class BbsBean implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2414160495430997551L;
	@Id
	@GenericGenerator(name = "idGenerator", strategy = "sequence", parameters = { @Parameter(name = "sequence", value = "bbs_id") })
	@GeneratedValue(generator = "idGenerator")
	private Long bbs_id;
	private String bbs_title;
	private Date create_time;
	private String add_content_src;
	private String bbs_info;
	private Boolean top_home;
	
	//文章类别
	private String category;
	
	@ManyToOne(cascade=CascadeType.ALL,fetch=FetchType.EAGER)
    @JoinColumn(name="user_id")//加入一列作为外键
	private UserBean userid;

	// 内容 one-TO-one
	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn
	private BbsContentBean bbs_content_id;
	
	//评论
	@OneToMany(fetch=FetchType.LAZY,cascade=CascadeType.ALL,mappedBy="bbs_id")
	@Fetch(FetchMode.SELECT)
	private Set<CommentBean> comment_id;
	
	public void setBbs_id(Long bbs_id) {
		this.bbs_id = bbs_id;
	}

	public Long getBbs_id() {
		return bbs_id;
	}

	public String getBbs_title() {
		return bbs_title;
	}

	public void setBbs_title(String bbs_title) {
		this.bbs_title = bbs_title;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}
	public UserBean getUserid() {
		return userid;
	}

	public void setUserid(UserBean userid) {
		this.userid = userid;
	}

	public BbsContentBean getBbs_content_id() {
		return bbs_content_id;
	}

	public void setBbs_content_id(BbsContentBean bbs_content_id) {
		this.bbs_content_id = bbs_content_id;
	}

	public Set<CommentBean> getComment_id() {
		return comment_id;
	}

	public void setComment_id(Set<CommentBean> comment_id) {
		this.comment_id = comment_id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAdd_content_src() {
		return add_content_src;
	}

	public void setAdd_content_src(String add_content_src) {
		this.add_content_src = add_content_src;
	}

	public String getBbs_info() {
		return bbs_info;
	}

	public void setBbs_info(String bbs_info) {
		this.bbs_info = bbs_info;
	}

	public Boolean getTop_home() {
		return top_home;
	}

	public void setTop_home(Boolean top_home) {
		this.top_home = top_home;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.bbs_title;
	}

	
}

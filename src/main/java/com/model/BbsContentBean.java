package com.model;

import java.io.Serializable;
import java.sql.Clob;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

@Entity
@Table(name = "tb_bbs_content")
public class BbsContentBean implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -972706950965396427L;
	@Id
	@GeneratedValue(generator = "pkGenerator")
	@GenericGenerator(name = "pkGenerator", 
			strategy = "foreign", 
			parameters = @Parameter(name = "property", value = "bbs"))
	private Long bbs_id;
	@Lob
	@Column(name = "bbs_content", columnDefinition = "CLOB")
	private Clob bbs_content;
	@OneToOne(cascade=CascadeType.ALL, mappedBy="bbs_content_id")
	private BbsBean bbs;
	@Transient
	private String bbs_content_str;
	

	public Long getBbs_id() {
		return bbs_id;
	}

	public void setBbs_id(Long bbs_id) {
		this.bbs_id = bbs_id;
	}

	public BbsBean getBbs() {
		return bbs;
	}

	public void setBbs(BbsBean bbs) {
		this.bbs = bbs;
	}

	public Clob getBbs_content() {
		return bbs_content;
	}

	public void setBbs_content(Clob bbs_content) {
		this.bbs_content = bbs_content;
	}

	public String getBbs_content_str() {
		return bbs_content_str;
	}

	public void setBbs_content_str(String bbs_content_str) {
		this.bbs_content_str = bbs_content_str;
	}
	

}

package com.common.uilt;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.apache.struts2.util.ServletContextAware;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware,
		ServletResponseAware, ServletContextAware {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected HttpSession session;
	protected ServletContext servletContext;
	protected int currentPage;//当前第几页
	protected int maxrecord;//分页大小
	protected String orderType;//排序类型
	protected String sortField;//排序字段
	protected String vali;//验证码


	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		if (this.request != null) {
			this.session = this.request.getSession();
		}
	}

	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
	}

	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getMaxrecord() {
		return maxrecord;
	}

	public void setMaxrecord(int maxrecord) {
		this.maxrecord = maxrecord;
	}

	public String getOrderType() {
		return orderType;
	}

	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}

	public String getSortField() {
		return sortField;
	}

	public void setSortField(String sortField) {
		this.sortField = sortField;
	}

	public String getVali() {
		return vali;
	}

	public void setVali(String vali) {
		this.vali = vali;
	}
	
	
}

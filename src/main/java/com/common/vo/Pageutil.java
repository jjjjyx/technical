package com.common.vo;

public class Pageutil {
	private int currentPage;//当前第几页
	private int maxrecord;//分页大小
	private String pageUrl;//链接
	private String sortField;//排序字段
	private String orderType;//顺序
	
	
	private int allResult;
	/**
	 * 计算部分
	 */
	
	private int allPage;// 总分页数
	private int per;// 上一页页码
	private int next; // 下一页页码

	public Pageutil() {
		// TODO Auto-generated constructor stub
		this.currentPage=1;
		this.maxrecord=10;

	}
	/**
	 * 
	 * @param currentPage 	当前页码
	 * @param maxrecord		分页大小
	 * @param allResult		总记录个数
	 * @param pageUrl		链接
	 */
	public Pageutil(int currentPage, int maxrecord, int allResult,
			String pageUrl,String sortField,String orderType) {
		this.currentPage = currentPage;
		this.maxrecord = maxrecord;
		this.allResult = allResult;
		this.pageUrl = pageUrl;
		this.orderType=orderType;
		this.sortField=sortField;
		
		// 计算总分页数
		if (allResult % maxrecord == 0) {
			allPage = allResult / maxrecord;
		} else {
			allPage = allResult / maxrecord + 1;
		}
		
		// 计算上一页页码页
		this.per = 1;
		if (currentPage > 1) {
			this.per = currentPage - 1;
		}
		// 计算下一页页码页
		this.next = allPage;
		if (currentPage < allPage - 1) {
			this.next = currentPage + 1;
		}
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
	
	
	public String getSortField() {
		return sortField;
	}
	public void setSortField(String sortField) {
		this.sortField = sortField;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}

	public int getAllResult() {
		return allResult;
	}

	public void setAllResult(int allResult) {
		this.allResult = allResult;
	}

	public int getAllPage() {
		return allPage;
	}
	public void setAllPage(int allPage) {
		this.allPage = allPage;
	}
	public int getPer() {
		return per;
	}
	public void setPer(int per) {
		this.per = per;
	}
	public int getNext() {
		return next;
	}
	public void setNext(int next) {
		this.next = next;
	}

	
	
	

}

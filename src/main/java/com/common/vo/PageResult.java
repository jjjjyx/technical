package com.common.vo;

import java.util.List;

import com.google.gson.Gson;

/**
 * 根据DAO层返回的当前页数据对象List、数据对象总记录数与原Service层接收到的当前页，当前分页、页面最大数据条数
 * 
 * 计算总分页数、上一页页码、下一页页码
 * 
 * @author HeHangjie
 * 
 * @param <T>D
 */
public class PageResult<T> {
	private List<T> currentList; // 当前页的结果集

	//private Pageutil pageutil= new Pageutil();//分页信息集
	private Pageutil pageutil;
	private String pageutiljson;

	
	public PageResult(List<T> currentList, Pageutil pageutil) {
		this.currentList = currentList;
		Gson gson = new Gson();
		
		this.pageutiljson=gson.toJson(pageutil);
	}
	
	
	public PageResult(List<T> currentList, Pageutil pageutil,
			String aa) {
		super();
		this.currentList = currentList;
		this.pageutil = pageutil;
	}


	public List<T> getCurrentList() {
		return currentList;
	}
	public void setCurrentList(List<T> currentList) {
		this.currentList = currentList;
	}
	public String getPageutiljson() {
		return pageutiljson;
	}
	public void setPageutiljson(String pageutiljson) {
		this.pageutiljson = pageutiljson;
	}


	public Pageutil getPageutil() {
		return pageutil;
	}


	public void setPageutil(Pageutil pageutil) {
		this.pageutil = pageutil;
	}

	
}

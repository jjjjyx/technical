package com.action;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.common.uilt.BaseAction;
import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.model.CategoryBean;
import com.model.Messages;
import com.service.imp.CategoryService;
@Controller
@ParentPackage("defaultpackage")
@Namespace("/")
@Action(value="category" ,results={
		@Result(name="list",location="/hello.jsp")
})
public class CategoryAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3094472355433843485L;
	@Autowired
	private CategoryService categoryService;
	private CategoryBean category;
	
	
	public String addcategory() throws Exception{
		PrintWriter out = response.getWriter();
		Gson gson =new GsonBuilder().setExclusionStrategies(new ExclusionStrategy() {

			public boolean shouldSkipField(FieldAttributes f) {
				String name=f.getName();
				//System.out.println(name);
				if(name.equals("user_id"))
					return true;
				return false;
			}

			public boolean shouldSkipClass(Class<?> clazz) {
				// TODO Auto-generated method stub
				return false;
			}
			
		}).create();
		Map<String,Object> m= new HashMap<String,Object>();
		try {
			m= this.categoryService.addcategory(category,session);
		} catch (Exception e) {
			e.printStackTrace();
			Messages m2= new Messages();
			m2.setInfo(false);
			m2.setText(e.getMessage());
			m.put("messages", m2);
		}
		
		out.print(gson.toJson(m));
		out.flush();
		out.close();
		return NONE;
	}
	public CategoryBean getCategory() {
		return category;
	}
	public void setCategory(CategoryBean category) {
		this.category = category;
	}

}

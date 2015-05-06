package com.common.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.model.UserBean;

public class Reception implements Filter{
	protected FilterConfig ftConfig;
	protected String ignoreURL = null;
	protected ArrayList<String> alIgnoreURL = new ArrayList<String>();
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) arg0;
		HttpServletResponse resp = (HttpServletResponse) arg1;
		HttpSession session=req.getSession();
		String toPage = req.getSession().getServletContext().getContextPath();//+"/index.jsp";
		String requestUrl = req.getRequestURI();//获取访问的url
		System.out.println("被拦截");
		if (!isIgnoreURL(requestUrl, req.getContextPath() + java.io.File.pathSeparator)){
			UserBean u=(UserBean)session.getAttribute("user");
			System.out.println("被拦截");
			if(null==u){
				toPage+="/hello";
				resp.sendRedirect(toPage);
			}else
				chain.doFilter(req, resp);
		}else{
			System.out.println("没被拦截");
			
		}
		chain.doFilter(req, resp);
		System.out.println("被拦截2");
		
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.ftConfig = filterConfig;
		this.ignoreURL = ftConfig.getInitParameter("ignoreURL");
		StringTokenizer tokenizer = new StringTokenizer(ignoreURL, ",");
		//按照','来分割字符串
		while (tokenizer.hasMoreElements()) {
			alIgnoreURL.add(tokenizer.nextElement().toString());
		}
		
	}
	public boolean isIgnoreURL(String url, String contextPath) {
		System.out.println("访问的链接"+url);
		System.out.println("项目路径"+contextPath);
		for (int i = 0; i < this.alIgnoreURL.size(); i++) {
			System.out.println("拦截目标："+this.alIgnoreURL.get(i));
			System.out.println("拦截成功？："+(url.indexOf(this.alIgnoreURL.get(i)) != -1));
			if (url.indexOf(this.alIgnoreURL.get(i)) != -1) {
				return false;
			}
			if (url.equals(contextPath + "/")) {
				return false;
			}
		}
		return true;
	}
}

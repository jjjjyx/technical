package com.service.imp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.dao.UserDao;
import com.model.UserBean;

@Component(value = "testService")
@Transactional(rollbackFor = {Exception.class }, propagation = Propagation.REQUIRED)
public class TestService {
	@Autowired
	UserDao userDao;
	public boolean save() {
		boolean is = false;
		
			UserBean userBean = new UserBean();
			userBean.setUser_account("声明试事务");
			userBean.setUser_pass("123");
			userDao.save(userBean);
			@SuppressWarnings("unused")
			int i = 10 / 0;
			is=true;
		
			return is;
			
	}
	@SuppressWarnings("resource")
	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext(
				"applicationContext.xml");
		TestService testService = (TestService) context.getBean("testService");
		try {
			System.out.println(testService.save());
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(11111111);
		}
		

	}
}

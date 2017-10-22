package com.erp.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringUtil {

	private static ApplicationContext ctx = new ClassPathXmlApplicationContext(
			"applicationContext.xml");

	public static Object getBean(String beanName) {
		return ctx.getBean(beanName);
	}
}

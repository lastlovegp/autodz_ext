package com.erp.framework.util;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

/**
 * Session容器
 * 
 * @author 熊春
 * @since 2009-09-03
 * @see HttpSessionBindingListener
 */
public class SessionContainer implements HttpSessionBindingListener {

	/**
	 * 登陆用户对象
	 */
	private String endDate;

	public SessionContainer() {
		super();
	}

	/**
	 * 清除会话容器缓存对象
	 */
	public void cleanUp() {
		endDate = null;
	}

	public void valueBound(HttpSessionBindingEvent event) {
		// System.out.println("会话创建了");
	}

	public void valueUnbound(HttpSessionBindingEvent event) {
		// System.out.println("会话销魂了");
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
}

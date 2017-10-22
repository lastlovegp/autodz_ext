package com.erp.framework.util;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionBindingListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * Session监听器 完成对Seesion会话资源的实时监控
 * 
 * @author 熊春
 * @since 2010-09-03
 * @see HttpSessionBindingListener
 */
public class SessionListener implements HttpSessionListener {

	private static Log log = LogFactory.getLog(SessionListener.class);

	/**
	 * 实现HttpSessionListener接口，完成session创建事件控制 说明：此时的Session状态为无效会话，
	 * 只有用户成功登录系统后才将此Session写入EAHTTPSESSION表作为有效SESSION来管理
	 */
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		log.info("创建了一个Session连接:" + session.getId() + " "
				+ DateUtil.getCurrentTime());
	}

	/**
	 * 实现HttpSessionListener接口，完成session销毁事件控制
	 */
	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession session = event.getSession();
		log.info("销毁了一个Session连接:" + session.getId() + " "
				+ SysUtils.getCurrentTime());
	}



}

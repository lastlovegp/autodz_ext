package com.base.common.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.NoSuchBeanDefinitionException;

import com.base.common.SysConstants;
import com.erp.framework.util.ApplicationContextUtils;


public class SpringBeanLoader {
	private static Log log = LogFactory.getLog(SpringBeanLoader.class);


	/**
	 * 获取一个SpringBean服务
	 *
	 * @param pBeanId
	 *            Spring配置文件名中配置的SpringID号
	 * @return Object 返回的SpringBean实例
	 */
	public static Object getSpringBean(String pBeanId) {
		Object springBean = null;
		try {
			springBean = ApplicationContextUtils.getBean(pBeanId);
		} catch (NoSuchBeanDefinitionException e) {
			log.error(SysConstants.Exception_Head + "Spring配置文件中没有匹配到ID号为:[" + pBeanId
					+ "]的SpringBean组件,请检查!");
			log.error(e.getMessage());
		}
		return springBean;
	}
}

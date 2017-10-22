package com.erp.framework.util;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.erp.entity.data.mng.Eacode;
import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;
import com.erp.service.ResourceService;

/**
 * 系统启动监听器
 * 
 * @author XiongChun
 * @since 2010-04-13
 */
public class SystemInitListener implements ServletContextListener {
	private static Log log = LogFactory.getLog(SystemInitListener.class);
	private boolean success = true;

	public void contextDestroyed(ServletContextEvent sce) {

	}

	public void contextInitialized(ServletContextEvent sce) {
		systemStartup(sce.getServletContext());
	}

	/**
	 * 应用平台启动
	 */
	private void systemStartup(ServletContext servletContext) {
		PropertiesHelper pHelper = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.CFG);
		long start = System.currentTimeMillis();
		success = true;
		String appRootPath = servletContext.getContextPath();

		log.info("appRootPath:" + appRootPath);

		try {
			ApplicationContext applicationContext = WebApplicationContextUtils
					.getRequiredWebApplicationContext(servletContext);
			ApplicationContextUtils.setContext(applicationContext);

		} catch (Exception ex) {
			success = false;
			ex.printStackTrace();
		}

		if (success) {
			log.info("系统开始启动字典装载程序...");
			log.info("开始加载字典...");			

			ResourceService resurceService = (ResourceService) ApplicationContextUtils
					.getBean("resourceService");

			try {
				List<Eacode> codeList = resurceService.getDicList(null);
				servletContext.setAttribute("EACODELIST", codeList);

				Dto dto = new BaseDto();

				
				

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		long timeSec = (System.currentTimeMillis() - start) / 1000;
		log.info("********************************************");
		if (success) {
			log.info("系统集成与应用开发平台启动成功[" + SysUtils.getCurrentTime() + "]");
			log.info("启动总耗时: " + timeSec / 60 + "分 " + timeSec % 60 + "秒 ");
		} else {
			log.error("系统集成与应用开发平台启动失败[" + SysUtils.getCurrentTime() + "]");
			log.error("启动总耗时: " + timeSec / 60 + "分" + timeSec % 60 + "秒");
		}
		log.info("********************************************");
	}

}

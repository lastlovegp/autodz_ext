package com.erp.framework.properties;

import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;

/**
 * Properties文件静态工厂
 *
 * @author XiongChun
 * @since 2009-08-2
 */
public class PropertiesFactory {
	private static Log log = LogFactory.getLog(PropertiesFactory.class);
	/**
	 * 属性文件实例容器
	 */
	private static Dto container = new BaseDto();

	static {
		ClassLoader classLoader = Thread.currentThread()
				.getContextClassLoader();
		if (classLoader == null) {
			classLoader = PropertiesFactory.class.getClassLoader();
		}
		// 加载属性文件ui_templte.properties
		try {
			InputStream is = classLoader
					.getResourceAsStream("ui_templte.properties");
			PropertiesHelper ph = new PropertiesHelper(is);
			container.put(PropertiesFile.UI_TEMPLTE, ph);

			// 配置文件
			is = classLoader.getResourceAsStream("cfg.properties");
			ph = new PropertiesHelper(is);
			container.put(PropertiesFile.CFG, ph);

			is = classLoader.getResourceAsStream("config.properties");
			ph = new PropertiesHelper(is);
			container.put(PropertiesFile.CALL_CFG, ph);
		} catch (Exception e1) {
			log.error(SysConstants.Exception_Head
					+ "加载属性文件ui_templte.properties出错!");
			e1.printStackTrace();
		}

	}

	/**
	 * 获取属性文件实例
	 *
	 * @param pFile
	 *            文件类型
	 * @return 返回属性文件实例
	 */
	public static PropertiesHelper getPropertiesHelper(String pFile) {
		PropertiesHelper ph = (PropertiesHelper) container.get(pFile);
		return ph;
	}
}

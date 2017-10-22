package com.base.common.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;

import com.base.common.service.BaseManager;
import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;
import com.erp.framework.util.DataFormat;
import com.erp.framework.util.DataObjectUtils;

public class BaseManagerImpl implements BaseManager {

	protected static PropertiesHelper pHelper = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.CFG);

	protected String strs2SqlStr(String strs) throws Exception {
		if (DataFormat.isEmpty(strs)) {
			return "";
		}
		String[] str = strs.split(",");
		StringBuilder rtnStr = new StringBuilder();
		for (int i = 0; i < str.length; i++) {
			rtnStr.append("'").append(str[i]).append("',");
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(",") != -1) {
			rtnString = rtnStr.toString().substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnString;

	}
	
	protected String int2SqlStr(String strs) throws Exception {
		if (DataFormat.isEmpty(strs)) {
			return "";
		}
		String[] str = strs.split(",");
		StringBuilder rtnStr = new StringBuilder();
		for (int i = 0; i < str.length; i++) {
			rtnStr.append(str[i]).append(",");
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(",") != -1) {
			rtnString = rtnStr.toString().substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnString;

	}

	protected void saveFile(File saveFile, File uploadFile) throws IOException {
		// 此路径下已存在同名文件,是否要覆盖或给客户端提示信息由你自己决定
		FileOutputStream os = new FileOutputStream(saveFile);
		FileInputStream fis = new FileInputStream(uploadFile);
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0) {
			os.write(buffer, 0, len);
		}
		os.flush();
		os.close();
	}

	/**
	 * 把map拷贝到object中,对时间设置默认值
	 * 
	 * @param object
	 * @param map
	 * @throws AppException
	 */
	protected void mapToObject(Object object, Map map) throws Exception {
		DataObjectUtils.mapToObject(object, map);

	}

	/**
	 * 把map拷贝到object中,不对时间设置默认值
	 * 
	 * @param object
	 * @param map
	 * @throws AppException
	 */
	protected void mapToObject2(Object object, Map map) throws Exception {
		DataObjectUtils.mapToObject2(object, map);
	}

}

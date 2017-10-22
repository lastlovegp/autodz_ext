/*
 * Created on 2005-3-3
 * $Id: ExceptionUtil.java,v 1.2 2005/05/27 09:38:36 liuwen Exp $
 *
 * Copyright 2005 Shanghai Huateng Software, Limited. All rights reserved.
 * HUATENG PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 * $Log: ExceptionUtil.java,v $
 * Revision 1.2  2005/05/27 09:38:36  liuwen
 * no message
 *
 * Revision 1.1.1.1  2005/05/24 06:04:49  liuwen
 * init.
 *
 * Revision 1.1.1.2  2005/05/23 10:52:25  yujianjun
 * no message
 *
 * Revision 1.1.1.1  2005/05/16 08:52:12  yujianjun
 * no message
 *
 * Revision 1.1  2005/04/04 03:36:24  liuwen
 * no message
 *
 * Revision 1.1.1.1  2005/03/21 06:21:06  liuwen
 * Initialization.
 *
 */
package com.erp.framework.util;

import com.erp.framework.exceptions.CommonException;

/**
 * @author liu_wen@huateng.com
 * @version $$Revision: 1.2 $$
 *
 * 异常工具类.
 * @see com.erp.framework.exceptions.CommonException.
 */
public class ExceptionUtil {
	/**
	 * 根据参数构造CommonException并将生成的异常抛出.
	 *
	 * @param msg
	 *            异常的消息
	 * @param key
	 *            异常的键值
	 * @param t
	 *            异常
	 * @param objs
	 * @throws CommonException
	 */
	public static void throwCommonException(String msg, String key, Throwable t, Object[] objs) throws CommonException {
		CommonException ce = new CommonException(msg, t);
		ce.setKey(key);
		ce.setObjs(objs);
		throw ce;
	}

	public static void throwCommonException(String msg, String key, Throwable t) throws CommonException {
		CommonException ce = new CommonException(msg, t);
		ce.setKey(key);
		throw ce;
	}

	public static void throwCommonException(String msg, String key) throws CommonException {
		CommonException ce = new CommonException(msg);
		ce.setKey(key);
		throw ce;
	}

	public static void throwCommonException(String key) throws CommonException {
		CommonException ce = new CommonException("异常中的key值为:" + key);
		ce.setKey(key);
		throw ce;
	}

	public static void throwCommonException(String msg, String key, Object[] objs) throws CommonException {
		CommonException ce = new CommonException(msg);
		ce.setKey(key);
		ce.setObjs(objs);
		throw ce;
	}

	public static void throwAppException(String msg, String key) throws CommonException {
		CommonException ce = new CommonException(msg);
		ce.setKey(key);
		throw ce;
	}
}
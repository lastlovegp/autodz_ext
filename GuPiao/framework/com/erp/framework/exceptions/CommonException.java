/*
 * Created on 2005-2-6
 *
 * $Id: CommonException.java,v 1.2 2005/05/25 08:47:30 liuwen Exp $
 *
 * Copyright 2005 Shanghai Huateng Software, Limited. All rights reserved.
 * HUATENG PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 *
 */

package com.erp.framework.exceptions;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @author liu_wen@huateng.com
 * @version $Revision: 1.2 $ ��
 */
public class CommonException extends Exception {
	/**
	 * error key, see struts's ApplicationResources
	 */
	private String key;
	private String errMessage;

	/**
	 * the real value of the param in the error messages. for example
	 *
	 */
	private Object[] objs = null;

	public CommonException() {
		super();
	}

	public CommonException(String errorMsg) {
		super(errorMsg);
		this.errMessage = errorMsg;
	}

	public CommonException(String errorMsg, Throwable t) {
		super(errorMsg, t);
		this.errMessage = errorMsg;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getKey() {
		return this.key;
	}

	public Object[] getObjs() {
		return objs;
	}

	public void setObjs(Object[] objs) {
		this.objs = objs;
	}

	public String message() {
		return new ToStringBuilder(this).append("message", this.getMessage())
				.append("key", key).toString();
	}

	public String toString() {
		return message();
	}

	public String getErrMessage() {
		return errMessage;
	}

	public void setErrMessage(String errMessage) {
		this.errMessage = errMessage;
	}

}
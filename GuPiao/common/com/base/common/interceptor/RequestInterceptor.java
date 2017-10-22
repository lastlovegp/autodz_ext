package com.base.common.interceptor;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;

public class RequestInterceptor implements Interceptor {

	private static final long serialVersionUID = 1L;

	private static final Logger LOG = LoggerFactory.getLogger(RequestInterceptor.class);

	public static final String USER_SESSION_KEY = "SessionContainer";

	public void destroy() {
	}

	public void init() {
	}

	public String intercept(ActionInvocation invocation) throws Exception {

		LOG.debug("event loged");

		return invocation.invoke();
	}

}

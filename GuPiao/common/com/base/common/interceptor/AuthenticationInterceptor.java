package com.base.common.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.dispatcher.SessionMap;

import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;
import com.erp.framework.util.SessionContainer;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.opensymphony.xwork2.util.logging.Logger;
import com.opensymphony.xwork2.util.logging.LoggerFactory;

public class AuthenticationInterceptor implements Interceptor {

	private static final long serialVersionUID = 1L;

	private static final Logger log = LoggerFactory
			.getLogger(AuthenticationInterceptor.class);

	public static final String USER_SESSION_KEY = "SessionContainer";

	private PropertiesHelper pHelper = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.CFG);

	public void destroy() {
	}

	public void init() {

	}

	public String intercept(ActionInvocation invocation) throws Exception {
		log.debug("Authenticating user");
		try {
			ActionContext ctx = invocation.getInvocationContext();
			HttpServletRequest request = (HttpServletRequest) ctx
					.get(ServletActionContext.HTTP_REQUEST);
			
			//过滤类型
			String filterType = (String)request.getParameter("filterType"); 
			if ("no".equals(filterType)) {
				return invocation.invoke();
			}

			SessionMap session = (SessionMap) ctx.getContext().get(
					ActionContext.SESSION);
			if (session == null) {
				return Action.LOGIN;
			}

			SessionContainer sessionContainer = (SessionContainer) session
					.get(USER_SESSION_KEY);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

		return invocation.invoke();

	}


}

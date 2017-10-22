/*
 * $Header: /home/plis/batch/cvs/cvsdvp/BocomplJAR/JavaSource/com/erp.framework/session/SessionManager.java,v 1.12 2005/05/12 02:51:29 wu_zhiqiang Exp $
 * $Revision: 1.12 $
 * $Date: 2005/05/12 02:51:29 $
 *
 * ===================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2003-2004 Huateng Software System.  All rights
 * reserved.
 * ===================================================================
 */

package com.erp.framework.session;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.base.common.SysConstants;


/**
 *
 * @author James wu
 * @version 1.0.0
 */

public class SessionManager {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(SessionManager.class);

	// Property
	private static SessionManager instance = null;

	protected SessionManager() {
	}

	public static SessionManager getInstance() {
		if (logger.isDebugEnabled()) {
			logger.debug("getInstance() - start"); //$NON-NLS-1$
		}

		if (null == instance) {
			instance = new SessionManager();
		}

		if (logger.isDebugEnabled()) {
			logger.debug("getInstance() - end"); //$NON-NLS-1$
		}
		return instance;
	}

	public HttpSession getNewSession(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getNewSession(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(true);
		long currentTime = System.currentTimeMillis();
		if (true == session.isNew())
			session.setAttribute("sessionCreationTime", String
					.valueOf(currentTime));
		logger.debug("Start sessionLastAccessedTime");
		session.setAttribute("sessionLastAccessedTime", String
				.valueOf(currentTime));
		logger.debug("sessionLastAccessedTime = "
				+ session.getAttribute("sessionLastAccessedTime"));

		// String strBetweenSessionTime =
		// System.getProperty("sessionBetweenSessionTime") ;
		// long timeOut = Long.valueOf(strBetweenSessionTime).longValue() / 1000
		// ;
		// session.setMaxInactiveInterval((int)timeOut) ;

		if (logger.isDebugEnabled()) {
			logger.debug("getNewSession(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return session;
	}

	public HttpSession getSession(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSession(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession returnHttpSession = req.getSession(false);
		if (logger.isDebugEnabled()) {
			logger.debug("getSession(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnHttpSession;
	}

	public void getSessionAndRefresh(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionAndRefresh(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null != session) {
			long currentTime = System.currentTimeMillis();
			if (true == session.isNew())
				session.setAttribute("sessionCreationTime", String
						.valueOf(currentTime));
			session.setAttribute("sessionLastAccessedTime", String
					.valueOf(currentTime));
		}

		if (logger.isDebugEnabled()) {
			logger.debug("getSessionAndRefresh(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return;
	}

	public String getSessionID(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionID(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return null;
		String returnString = session.getId();
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionID(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnString;
	}

	public String getSessionIDFromContext(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIDFromContext(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return null;
		String returnString = session.getAttribute(
				SysConstants.WEB_SESSION_ID).toString();
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIDFromContext(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnString;
	}

	public boolean isValid(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("isValid(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		boolean returnboolean = req.isRequestedSessionIdValid();
		if (logger.isDebugEnabled()) {
			logger.debug("isValid(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnboolean;
	}

	public boolean isExpired(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("isExpired(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		// if(true) return false; //TODO: �����ô���

		// HttpSession session = req.getSession(false);
		// if (null == session)
		// return true;
		//
		// // SESSION ID �Ƿ���
		// long currentTime = System.currentTimeMillis();
		// String strLastAccessedTime =
		// session.getAttribute("sessionLastAccessedTime").toString();
		// String strBetweenSessionTime =
		// System.getProperty("sessionBetweenSessionTime");
		// long lastAccessedTime =
		// Long.valueOf(strLastAccessedTime).longValue();
		// long betweenSessionTime =
		// Long.valueOf(strBetweenSessionTime).longValue();
		//
		// // System.out.println("strLastAccessedTime=<"+lastAccessedTime+">");
		// // System.out.println("currentTime=<"+currentTime+">");
		// //
		// System.out.println("betweenTime=<"+(currentTime-lastAccessedTime)+">");
		//
		// if (currentTime > (lastAccessedTime + betweenSessionTime))
		// return true;
		//
		// // У���Ƿ����SESSION ID���
		// String sessionID =
		// session.getAttribute(SystemConstant.WEB_SESSION_ID).toString();
		// if (null == sessionID)
		// return true;
		//
		// // У���Ƿ�����û��û����
		// UserSessionInfo userSessionInfo = (UserSessionInfo)
		// getSessionObject(req, LoginManagerOP.OUT_USER_SESSION_INFO);
		// if (null == userSessionInfo)
		// return true;
		//
		// if (logger.isDebugEnabled()) {
		// logger.debug("isExpired(HttpServletRequest) - end"); //$NON-NLS-1$
		// }
		// return false;

		return true;

	}

	public boolean destroySessionData(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("destroySessionData(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return false;
		String strAttrName = null;
		Enumeration names = session.getAttributeNames();
		while (names.hasMoreElements()) {
			strAttrName = (String) names.nextElement();
			session.removeAttribute(strAttrName);
		}

		if (logger.isDebugEnabled()) {
			logger.debug("destroySessionData(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return true;
	}

	public boolean destroySession(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("destroySession(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return false;
		session.invalidate();

		if (logger.isDebugEnabled()) {
			logger.debug("destroySession(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return true;
	}

	/**
	 * Session data manage For session data
	 */
	/**
	 * Retrieve a session object based on the request and the attribute name.
	 */
	public Object getSessionObject(HttpServletRequest req, String attrName) {
		if (logger.isDebugEnabled()) {
			logger
					.debug("getSessionObject(HttpServletRequest, String) - start"); //$NON-NLS-1$
		}

		Object sessionObj = null;
		HttpSession session = req.getSession(false);
		if (null == session)
			return sessionObj;
		sessionObj = session.getAttribute(attrName);

		if (logger.isDebugEnabled()) {
			logger.debug("getSessionObject(HttpServletRequest, String) - end"); //$NON-NLS-1$
		}
		return sessionObj;
	}

	/**
	 * Set a session object based on the request and the attribute name.
	 */
	public boolean setSessionObject(HttpServletRequest req, String attrName,
			Object value) {
		if (logger.isDebugEnabled()) {
			logger
					.debug("setSessionObject(HttpServletRequest, String, Object) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return false;
		session.setAttribute(attrName, value);

		if (logger.isDebugEnabled()) {
			logger
					.debug("setSessionObject(HttpServletRequest, String, Object) - end"); //$NON-NLS-1$
		}
		return true;
	}

	/**
	 * Remove a session object based on the request and the attribute name.
	 */
	public boolean removeSessionObject(HttpServletRequest req, String attrName) {
		if (logger.isDebugEnabled()) {
			logger
					.debug("removeSessionObject(HttpServletRequest, String) - start"); //$NON-NLS-1$
		}

		HttpSession session = req.getSession(false);
		if (null == session)
			return false;
		session.removeAttribute(attrName);

		if (logger.isDebugEnabled()) {
			logger
					.debug("removeSessionObject(HttpServletRequest, String) - end"); //$NON-NLS-1$
		}
		return true;
	}

	/**
	 * Returns the current session identifier string as an HTML hidden field.
	 *
	 * @return String - The <I>session id</I> field html.
	 */
	public String getSessionIdHtmlField(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIdHtmlField(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		String returnString = "<input type=\"hidden\" name=\""
				+ SysConstants.WEB_SESSION_ID + "\" value=\""
				+ this.getSessionIDFromContext(req) + "\">";
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIdHtmlField(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnString;
	}

	/**
	 * Returns the current session identifier string as a URL parameter.
	 *
	 * @return String - The <I>session id</I> parameter.
	 */
	public String getSessionIdParameter(HttpServletRequest req) {
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIdParameter(HttpServletRequest) - start"); //$NON-NLS-1$
		}

		String returnString = SysConstants.WEB_SESSION_ID + "="
				+ this.getSessionIDFromContext(req);
		if (logger.isDebugEnabled()) {
			logger.debug("getSessionIdParameter(HttpServletRequest) - end"); //$NON-NLS-1$
		}
		return returnString;
	}

}

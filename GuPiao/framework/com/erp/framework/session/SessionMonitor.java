/*
 * $Header: /home/plis/batch/cvs/cvsdvp/BocomplWeb/JavaSource/com/erp.framework/session/SessionMonitor.java,v 1.2 2005/01/07 08:23:10 wu_zhiqiang Exp $
 * $Revision: 1.2 $
 * $Date: 2005/01/07 08:23:10 $
 *
 * ===================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2003-2004 Huateng Software System.  All rights
 * reserved.
 * ===================================================================
 */

package com.erp.framework.session;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * Session �����ࣻ
 *
 * @author James wu
 * @version 1.0.0
 */


public class SessionMonitor implements HttpSessionListener {

	public void sessionCreated(HttpSessionEvent se){
		//System.out.println("SessionMonitor:sessionCreated()");
	}

	public void sessionDestroyed(HttpSessionEvent se){
		//System.out.println("SessionMonitor:sessionDestroyed()");

		//�����������������Ϊ������session.invalidate()
		//���������ﲻ��Ҫ���SESSION���,
		//���ǿ������������ϵͳ�к����SESSION�������ϵͳ��Դ
		// TODO:

		/*
		//ʹsession��Ч���ͷ���Դ
		HttpSession session = se.getSession() ;
		String strAttrName = null ;
		Enumeration names = session.getAttributeNames() ;
		while(names.hasMoreElements()){
			strAttrName = (String)names.nextElement() ;
			session.removeAttribute(strAttrName);
		}
		session.invalidate() ;
		*/
	}

}
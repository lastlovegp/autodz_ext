/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */
package com.erp.framework.util.ftp;

import java.io.FileInputStream;
import java.io.InputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.log4j.spi.ErrorCode;

import com.erp.framework.exceptions.CommonException;
import com.erp.framework.util.ExceptionUtil;

/**
 * @author <a href="mailto:liu_wen@huateng.com">Liu Wen</a>
 * @version $Revision: 1.12 $
 * @date 2005-7-28
 *
 * Helper class of ftp client.
 */
public class FTPClientHelper {
	public final static Log log = LogFactory.getLog(FTPClientHelper.class);

	/**
	 * ��ʱʱ��. ȱʡΪ30��.
	 */
	private int timeout = 30000;

	/**
	 * �������
	 */
	private String hostname;

	/**
	 * �û����
	 */
	private String userName;

	/**
	 * ����
	 */
	private String password;

	/**
	 * ��������
	 */
	private String fileType = "binary";

	/**
	 * �ļ�Ŀ¼.
	 */
	private String fileDir = "";

	/**
	 * ��ѯ����ļ�Ŀ¼.
	 */
	private String inqDir = "";

	/**
	 * �ӷ�������ȡ�ļ�.
	 *
	 * @param fileName
	 * @param callback
	 * @throws CommonException
	 */
	public void getFile(String fileName, FTPClientCallback callback)
			throws CommonException {
		/*
		 * FTPClient ftpClient = new FTPClient(); FTPClientConfig clientConfig =
		 * new FTPClientConfig(FTPClientConfig.SYST_UNIX);
		 * ftpClient.configure(clientConfig); boolean login = false;
		 *
		 * try { if (log.isDebugEnabled()) { log.debug("���ӷ�����:" + hostname); }
		 *
		 * ftpClient.setDefaultTimeout(timeout);
		 * ftpClient.setDataTimeout(timeout);
		 *
		 * ftpClient.connect(hostname); int reply = ftpClient.getReplyCode(); if
		 * (!FTPReply.isPositiveCompletion(reply)) {
		 * ExceptionUtil.throwCommonException("FTP�������ܾ�����, ���ش���:" +
		 * reply, ErrorCode.ERROR_CODE_FTP); }
		 *
		 * if (log.isDebugEnabled()) { log.debug("��¼������:" + hostname); }
		 * login = ftpClient.login(userName, password); if (!login) {
		 * ExceptionUtil.throwCommonException("FTP�������ܾ��û���¼.",
		 * ErrorCode.ERROR_CODE_FTP); }
		 *
		 * if (fileType.equalsIgnoreCase("binary")) { if (log.isDebugEnabled()) {
		 * log.debug("���ô�������binary"); }
		 * ftpClient.type(FTP.BINARY_FILE_TYPE); } else { if
		 * (log.isDebugEnabled()) { log.debug("���ô�������ascii"); }
		 * ftpClient.type(FTP.ASCII_FILE_TYPE); }
		 *
		 * if (log.isDebugEnabled()) { log.debug("��ȡ�ļ�" + fileName); }
		 * InputStream inputStream = ftpClient.retrieveFileStream(fileName); if
		 * (null == inputStream) { reply = ftpClient.getReplyCode();
		 * ExceptionUtil.throwCommonException("��FTP��������ȡ�ļ�" + fileName +
		 * "ʧ��,�������:" + reply, ErrorCode.ERROR_CODE_FTP); } try {
		 * callback.doFtp(inputStream);
		 *
		 * if (false == ftpClient.completePendingCommand()) {
		 * ExceptionUtil.throwCommonException("�ر�FTP����ʧ��,�������:" +
		 * ftpClient.getReplyCode(), ErrorCode.ERROR_CODE_FTP); } } finally {
		 * try { if (null != inputStream) { inputStream.close(); } } catch
		 * (Throwable t) { }; }
		 *  } catch (CommonException ce) { throw ce; } catch (Exception ex) {
		 * ExceptionUtil.throwCommonException(ex.getMessage(),
		 * ErrorCode.ERROR_CODE_FTP, ex); } finally { try { if (login) {
		 * ftpClient.logout(); } if (ftpClient.isConnected()) {
		 * ftpClient.disconnect(); } } catch (Throwable t) { }; }
		 */

		InputStream is = null;
		try {
			// Ϊ��ʾ��Ҫ��FTP��ʽΪ�򿪱����ļ�2007-11-21
			// String urlString = "ftp://" + userName + ":" + password + "@" +
			// hostname + fileName;
			// if ( log.isDebugEnabled() ){
			// log.debug("url is " + urlString);
			// }
			// URL url = new URL(urlString);
			// URLConnection urlc = url.openConnection();
			// is = urlc.getInputStream();
			is = new FileInputStream(fileName);

			callback.doFtp(is);
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (null != is) {
				try {
					is.close();
				} catch (Exception ex) {
				}
				;
			}
		}
	}

	/**
	 * @return Returns the fileType.
	 */
	public String getFileType() {
		return fileType;
	}

	/**
	 * @param fileType
	 *            The fileType to set.
	 */
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	/**
	 * @return Returns the hostname.
	 */
	public String getHostname() {
		return hostname;
	}

	/**
	 * @param hostname
	 *            The hostname to set.
	 */
	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	/**
	 * @return Returns the password.
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password
	 *            The password to set.
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return Returns the userName.
	 */
	public String getUserName() {
		return userName;
	}

	/**
	 * @param userName
	 *            The userName to set.
	 */
	public void setUserName(String userName) {
		this.userName = userName;
	}

	/**
	 * @return Returns the fileDir.
	 */
	public String getFileDir() {
		return fileDir;
	}

	/**
	 * @param fileDir
	 *            The fileDir to set.
	 */
	public void setFileDir(String fileDir) {
		this.fileDir = fileDir;
	}

	/**
	 * @return Returns the timeout.
	 */
	public int getTimeout() {
		return timeout;
	}

	/**
	 * @param timeout
	 *            The timeout to set.
	 */
	public void setTimeout(int timeout) {
		this.timeout = timeout;
	}

	/**
	 * @return Returns the inqDir.
	 */
	public String getInqDir() {
		return inqDir;
	}

	/**
	 * @param inqDir
	 *            The inqDir to set.
	 */
	public void setInqDir(String inqDir) {
		this.inqDir = inqDir;
	}
}
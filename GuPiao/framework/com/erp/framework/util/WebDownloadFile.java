/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */
package com.erp.framework.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

/**
 * @author <a href="mailto:liu_wen@huateng.com">Liu Wen</a>
 * @version $Revision: 1.3 $
 * @date 2005-8-5
 *
 */

public class WebDownloadFile {
	public WebDownloadFile() {
	}

	public static void downloadFile(HttpServletResponse response, File file,
			String displayName) throws Exception {
		OutputStream out = null;
		FileInputStream fis = null;
		try {
			response.setContentType("application/octet-stream");
			String urlFileName = URLEncoder.encode(displayName, "utf-8");

			response.setHeader("Content-Disposition", "attachment;filename=\""
					+ urlFileName);

			long fileLength = file.length();

			System.out.println("fileLength is " + fileLength);
			response.setContentLength((int) fileLength);

			out = response.getOutputStream();
			// read file and write stream
			fis = new FileInputStream(file);

			//Util.copyStream(fis, out);
			while (true) {
				int in = fis.read();
				if (-1 == in) {
					break;
				}
				out.write(in);
			}
			out.flush();
		} finally {
			if (null != out) {
				try {
					out.close();
				} catch (Throwable ex) {
				}
			}

			if (null != fis) {
				try {
					fis.close();
				} catch (Exception e) {
				}
			}

		}//--finally
	}

}
/*
 * $Id: FileUploadAction.java 476710 2006-11-19 05:05:14Z mrdon $
 *
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package com.base.common.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

import org.apache.poi.util.IOUtils;
import org.apache.struts2.ServletActionContext;

import com.base.common.bean.Dto;
import com.erp.framework.util.DataFormat;

/**
 * Show case File Upload example's action. <code>FileUploadAction</code>
 * 
 */
public class FileUploadAction extends BaseAction {

	private static final long serialVersionUID = 5156288255337069381L;

	private File upload;
	private String fileName;
	private String savePath;

	public Dto getUploadDto(Dto dto) {
		dto.put("fileName", getFileName());
		dto.put("savePath", getSavePath());
		return dto;
	}

	// since we are using <s:file name="upload" .../> the file name will be
	// obtained through getter/setter of <file-tag-name>FileName
	public String getUploadFileName() {
		return fileName;
	}

	public void setUploadFileName(String fileName) {
		this.fileName = fileName;
	}

	// since we are using <s:file name="upload" ... /> the File itself will be
	// obtained through getter/setter of <file-tag-name>
	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String saveFile() throws Exception {
		File uploadFile = getUpload();
		
		String realSavePath = "";
		if (uploadFile != null) {
			FileInputStream in = new FileInputStream(uploadFile);
			 realSavePath = ServletActionContext.getServletContext()
					.getRealPath(
							"/" + getSavePath() + "\\" + getUploadFileName());

			File file = new File(realSavePath);
			File parent = file.getParentFile();
			if (parent != null && !parent.exists()) {
				parent.mkdirs();
			}

			FileOutputStream out = new FileOutputStream(realSavePath);
			IOUtils.copy(in, out);
		}
		
		return realSavePath;

	}


	// public boolean isAllowTypes(String[] types) {
	// if (types == null && types.length == 0) {
	// return true;
	// }
	// String fileType = DataFormat.trim(this.getUploadContentType());
	// for (String type : types) {
	// if (fileType.indexOf(type) != -1) {
	// return true;
	// }
	// }
	// return false;
	// }
	//
	// protected void saveFile(FileOutputStream os, FileInputStream fis)
	// throws IOException {
	// byte[] buffer = new byte[1024];
	// int len = 0;
	// while ((len = fis.read(buffer)) > 0) {
	// os.write(buffer, 0, len);
	// }
	// os.flush();
	// os.close();
	// }

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSavePath() {
		return DataFormat.isEmpty(savePath) ? "upload" : savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

}

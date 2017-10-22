/*
 * $Id: MultipleFileUploadUsingListAction.java 660522 2008-05-27 14:08:00Z jholmes $
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
// START SNIPPET: entire-file
package com.base.common.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.util.IOUtils;
import org.apache.struts2.ServletActionContext;

import com.base.common.bean.Dto;

/**
 * Showcase action - multiple file upload using List
 *
 * @version $Date: 2008-05-27 16:08:00 +0200 (Tue, 27 May 2008) $ $Id:
 *          MultipleFileUploadUsingListAction.java 660522 2008-05-27 14:08:00Z
 *          jholmes $
 */
public class MultipleFileUploadUsingListAction extends BaseAction {

	private List<File> uploads = new ArrayList<File>();
	private List<String> uploadFileNames = new ArrayList<String>();
	private List<String> uploadContentTypes = new ArrayList<String>();

	private String savePath;

	public void saveFile() throws Exception {
		String name = "";
		for (int i = 0; i < getUploads().size(); i++) {
			FileInputStream in = new FileInputStream(getUpload().get(i));
			name = getUploadFileName().get(i);
			String realSavePath = ServletActionContext.getServletContext()
					.getRealPath("/" + getSavePath() + "\\" + name);

			File file = new File(realSavePath);
			File parent = file.getParentFile();
			if (parent != null && !parent.exists()) {
				parent.mkdirs();
			}

			FileOutputStream out = new FileOutputStream(realSavePath);
			// 将数据拷贝到上传目录，这里没有必要使用缓冲流，因为IOUtils工具类已经使用了缓存
			IOUtils.copy(in, out);

		}

	}

	public Dto getUploadDto(Dto dto) {
		dto.put("uploadFileNames", getUploadFileNames());
		dto.put("savePath", getSavePath());
		return dto;
	}

	public List<File> getUpload() {
		return this.uploads;
	}

	public List<File> getUploads() {
		return uploads;
	}

	public void setUploads(List<File> uploads) {
		this.uploads = uploads;
	}

	public List<String> getUploadFileNames() {
		return uploadFileNames;
	}

	public void setUploadFileNames(List<String> uploadFileNames) {
		this.uploadFileNames = uploadFileNames;
	}

	public List<String> getUploadContentTypes() {
		return uploadContentTypes;
	}

	public void setUploadContentTypes(List<String> uploadContentTypes) {
		this.uploadContentTypes = uploadContentTypes;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public void setUpload(List<File> uploads) {
		this.uploads = uploads;
	}

	public List<String> getUploadFileName() {
		return this.uploadFileNames;
	}

	public void setUploadFileName(List<String> uploadFileNames) {
		this.uploadFileNames = uploadFileNames;
	}

	public List<String> getUploadContentType() {
		return this.uploadContentTypes;
	}

	public void setUploadContentType(List<String> contentTypes) {
		this.uploadContentTypes = contentTypes;
	}
}
// END SNIPPET: entire-file
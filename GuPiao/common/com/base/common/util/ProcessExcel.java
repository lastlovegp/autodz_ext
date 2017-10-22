package com.base.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ProcessExcel {

	private Workbook wb = null;

	public ProcessExcel(String filePath) throws IOException {
		try {
			if (filePath.endsWith("xls")) {
				wb = new HSSFWorkbook(new FileInputStream(new File(filePath)));
			} else {
				wb = new XSSFWorkbook(filePath);
			}
		} catch (Exception e) {
			wb = new XSSFWorkbook(filePath);
		}

	}

	public ProcessExcel(File file) throws Exception {
		try {
			if (file.getName().endsWith("xls")) {
				wb = new HSSFWorkbook(new FileInputStream(file));
			} else {
				wb = new XSSFWorkbook(new FileInputStream(file));
			}
		} catch (Exception e) {
			wb = new XSSFWorkbook(new FileInputStream(file));
		}
	}

	public Workbook getWb() {
		return wb;
	}

	public void setWb(Workbook wb) {
		this.wb = wb;
	}

}

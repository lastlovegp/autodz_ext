package com.erp.bean;

import com.erp.framework.poi.excel.annotation.Excel;
import com.erp.framework.poi.excel.annotation.ExcelTarget;

@ExcelTarget(id = "gpExport")
public class GpExport {

	@Excel(exportName = "代码")
	private String code;// 企业编号

	@Excel(exportName = "名称")
	private String name;// 客户编号

	@Override
	public String toString() {
		return "GpExport [code=" + code + ", name=" + name + "]";
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}

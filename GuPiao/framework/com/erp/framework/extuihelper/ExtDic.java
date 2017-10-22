package com.erp.framework.extuihelper;

import java.io.Serializable;

import com.erp.framework.util.DataFormat;

/**
 * EXTui 专用数据字典
 * 
 * @author Administrator
 * 
 */
public class ExtDic implements Serializable {

	// fields
	private String field;
	private String fieldname;

	private String code;
	private String codetype;
	private String codedesc;

	/**
	 * Constructor for required fields
	 */
	public ExtDic(String field, String fieldname, String code, String codetype,
			String codedesc) {
		this.setField(field);
		this.setFieldname(fieldname);
		this.setCode(code);
		this.setCodetype(DataFormat.trim(codetype));
		this.setCodedesc(codedesc);
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getFieldname() {
		return fieldname;
	}

	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}

	public String getCodetype() {
		return codetype;
	}

	public void setCodetype(String codetype) {
		this.codetype = codetype;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getCodedesc() {
		return codedesc;
	}

	public void setCodedesc(String codedesc) {
		this.codedesc = codedesc;
	}

}
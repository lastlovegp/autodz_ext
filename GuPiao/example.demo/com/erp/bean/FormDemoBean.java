package com.erp.bean;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtXtype;

public class FormDemoBean {

	private String text;

	@Ef(xtype = ExtXtype.XTYPE_RADION_GROUP,id="idno",
			columns = "2", itemWidth = 260, checkGroupStr = "01,02")
	private String idno;

	@Ef(xtype = "cmbdic", dicDefine = "01:服务业;02:制造业;03:贸易", multiSelect=true, id="email")
	private String email;
	
	@Ef(xtype = ExtXtype.XTYPE_CMB_REMORT, fields = "'rmddesc','rmdtype'", id="rmdtype",
			url = "getRemindType_remind_base.do",
			displayField = "rmddesc", valueField = "rmdtype")
	private String rmdtype;

	@Ef(inputType = "password")
	private String password;

	private int intInput;
	private double floatInput;

	private String readOnly;

	@Ef(xtype = ExtXtype.XTYPE_CMB_GRID, url = "getCodeData_Code_base.do",
			innerTpl = "{field}-{fieldname}", fields = "'field','fieldname'",
			displayField = "fieldname", valueField = "field")
	private String enable;

	private String prdtypename;
	

	public String getRmdtype() {
		return rmdtype;
	}

	public void setRmdtype(String rmdtype) {
		this.rmdtype = rmdtype;
	}

	public String getPrdtypename() {
		return prdtypename;
	}

	public void setPrdtypename(String prdtypename) {
		this.prdtypename = prdtypename;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getprdtypename() {
		return prdtypename;
	}

	public void setprdtypename(String prdtypename) {
		this.prdtypename = prdtypename;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getIdno() {
		return idno;
	}

	public void setIdno(String idno) {
		this.idno = idno;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getReadOnly() {
		return readOnly;
	}

	public int getIntInput() {
		return intInput;
	}

	public void setIntInput(int intInput) {
		this.intInput = intInput;
	}

	public double getFloatInput() {
		return floatInput;
	}

	public void setFloatInput(double floatInput) {
		this.floatInput = floatInput;
	}

	public void setReadOnly(String readOnly) {
		this.readOnly = readOnly;
	}

	public String getEnable() {
		return enable;
	}

	public void setEnable(String enable) {
		this.enable = enable;
	}

}

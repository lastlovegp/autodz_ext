package com.erp.entity.data.mng;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.framework.extuihelper.ExtXtype;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "eacode")
@Et(beanId = "codeid", beanName = "code")
public class Eacode implements java.io.Serializable {

	// Fields
	@Ef(xtype = "hidden", fseq = 1)
	private String codeid;

	@Ef(width = 200, fseq = 2, qryType = "like")
	private String field;

	private String fieldname;

	private String code;
	@Ef(qryType = "like")
	private String codedesc;
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicCode = "ENABLED", defValue = "1")
	private String enabled;

	private int sortno;

	@Ef(hidden = true, xtype = "hidden")
	private String codetype;

	@Ef(qryType = "like")
	private String remark;

	/** default constructor */
	public Eacode() {
	}

	/** minimal constructor */
	public Eacode(String codeid, String field, String fieldname, String code,
			String codedesc, String enabled) {
		this.codeid = codeid;
		this.field = field;
		this.fieldname = fieldname;
		this.code = code;
		this.codedesc = codedesc;
		this.enabled = enabled;
	}

	/** full constructor */
	public Eacode(String codeid, String field, String fieldname, String code,
			String codedesc, String enabled, int sortno, String remark) {
		this.codeid = codeid;
		this.field = field;
		this.fieldname = fieldname;
		this.code = code;
		this.codedesc = codedesc;
		this.enabled = enabled;
		this.sortno = sortno;
		this.remark = remark;
	}

	public String getCodetype() {
		return codetype;
	}

	public void setCodetype(String codetype) {
		this.codetype = codetype;
	}

	// Property accessors
	@Id
	@Column(name = "CODEID", unique = true, nullable = false, length = 8)
	public String getCodeid() {
		return this.codeid;
	}

	public void setCodeid(String codeid) {
		this.codeid = codeid;
	}

	@Column(name = "FIELD", nullable = false, length = 15)
	public String getField() {
		return this.field;
	}

	public void setField(String field) {
		this.field = field;
	}

	@Column(name = "FIELDNAME", nullable = false, length = 20)
	public String getFieldname() {
		return this.fieldname;
	}

	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}

	@Column(name = "CODE", nullable = false, length = 10)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "CODEDESC", nullable = false, length = 100)
	public String getCodedesc() {
		return this.codedesc;
	}

	public void setCodedesc(String codedesc) {
		this.codedesc = codedesc;
	}

	@Column(name = "ENABLED", nullable = false, length = 2)
	public String getEnabled() {
		return this.enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	@Column(name = "SORTNO")
	public int getSortno() {
		return this.sortno;
	}

	public void setSortno(int sortno) {
		this.sortno = sortno;
	}

	@Column(name = "REMARK", length = 200)
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
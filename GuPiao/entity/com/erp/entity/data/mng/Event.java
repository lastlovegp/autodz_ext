package com.erp.entity.data.mng;

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
@Table(name = "event")
@Et(beanId = "id", beanName = "Event")
public class Event implements java.io.Serializable {

	
	@Ef(fseq = 1, xtype = "hidden",colExclude=true)
	private int id;
	
	@Ef(width = 400, xtype = "textarea",fseq = 1)
	private String title;
	
	@Ef(width = 400, xtype = "textarea", fseq = 2,colExclude=true)
	private String remark;
	
	@Ef(fseq=4,readOnly=true)
	private String uptime;
	
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "0:有效;1:失效;", fseq = 2)
	private String statue;

	@Id
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getUptime() {
		return uptime;
	}

	public void setUptime(String uptime) {
		this.uptime = uptime;
	}

	public String getStatue() {
		return statue;
	}

	public void setStatue(String statue) {
		this.statue = statue;
	}

}
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
@Table(name = "gpparam")
@Et(beanId = "code", beanName = "Gpparam")
public class Gpparam implements java.io.Serializable {

	@Ef(exclude = "1")
	private String code;

	@Ef(exclude = "1")
	private String jydate;

	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "0:安全模式;1:风险模式;2:激进模式;", fseq = 1)
	private String tranmode;
	
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "1:打开;0:关闭;", defValue = "0", fseq = 2)
	private String tranflag;
	
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "1:打开;0:关闭;", defValue = "0")
	private String jjspflag;
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "1:打开;0:关闭;", defValue = "0")
	private String slspflag;	

	@Id
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}


	public String getTranflag() {
		return tranflag;
	}

	public void setTranflag(String tranflag) {
		this.tranflag = tranflag;
	}

	public String getTranmode() {
		return tranmode;
	}

	public void setTranmode(String tranmode) {
		this.tranmode = tranmode;
	}


	public String getJjspflag() {
		return jjspflag;
	}

	public void setJjspflag(String jjspflag) {
		this.jjspflag = jjspflag;
	}

	public String getSlspflag() {
		return slspflag;
	}

	public void setSlspflag(String slspflag) {
		this.slspflag = slspflag;
	}

	public String getJydate() {
		return jydate;
	}

	public void setJydate(String jydate) {
		this.jydate = jydate;
	}

}
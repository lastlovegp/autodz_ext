package com.erp.bean;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.framework.extuihelper.ExtXtype;

/**
 * 股票统计
 * 
 * @author Administrator
 */
@Et(beanName = "gpquery")
public class Gpquery {

	@Ef(fseq = 1,itemWidth = 120)
	private String code;
	@Ef(fseq = 2,itemWidth = 160)
	private String name;
	@Ef(fseq = 3,itemWidth = 130)
	private String hy;
	
	@Ef(itemWidth = 160)
	private String gn;
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "0:关闭;1:开通", itemWidth = 130, defValue = "1",fseq=5)
	private String sta;


	public String getGn() {
		return gn;
	}

	public void setGn(String gn) {
		this.gn = gn;
	}

	public String getHy() {
		return hy;
	}

	public void setHy(String hy) {
		this.hy = hy;
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

	public String getSta() {
		return sta;
	}

	public void setSta(String sta) {
		this.sta = sta;
	}

}

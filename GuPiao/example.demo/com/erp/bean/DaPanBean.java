package com.erp.bean;

import com.erp.bean.trantag.Get;
import com.erp.framework.extuihelper.Et;

@Et(beanName = "daPanBean")
public class DaPanBean implements java.io.Serializable {
	@Get(key = "同花顺", end = "休市")
	private String dpd;// 企业名称
	@Get(key = "东方财富网", end = "休市")
	private String dpzf;// 联系人

	@Override
	public String toString() {
		return "daPanBean [dpd=" + dpd + ", dpzf=" + dpzf + "]";
	}

	public String getDpd() {
		return dpd;
	}

	public void setDpd(String dpd) {
		this.dpd = dpd;
	}

	public String getDpzf() {
		return dpzf;
	}

	public void setDpzf(String dpzf) {
		this.dpzf = dpzf;
	}

}
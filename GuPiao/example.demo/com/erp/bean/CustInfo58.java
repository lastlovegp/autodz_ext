package com.erp.bean;

import com.erp.bean.trantag.Get;
import com.erp.framework.extuihelper.Et;

@Et(beanName = "custInfo58")
public class CustInfo58 implements java.io.Serializable {
	@Get(key = "公司名称",end="加入")
	private String cmpname;// 企业名称
	@Get(key = "联系人",end="联系我时")
	private String lxr;// 联系人
	private String dh;// 电话
	@Get(key = "联系地址")
	private String addr;// 地址
	@Get(key = "公司简介",end="公司视频")
	private String gsjj;// 公司简介

	@Override
	public String toString() {
		return "CustInfo58 [cmpname=" + cmpname + ", lxr=" + lxr + ", dh=" + dh
				+ ", addr=" + addr + ", gsjj=" + gsjj + "]";
	}

	public String getCmpname() {
		return cmpname;
	}

	public void setCmpname(String cmpname) {
		this.cmpname = cmpname;
	}

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getDh() {
		return dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getGsjj() {
		return gsjj;
	}

	public void setGsjj(String gsjj) {
		this.gsjj = gsjj;
	}

}
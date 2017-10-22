package com.erp.bean;

import com.erp.bean.trantag.Get;
import com.erp.framework.extuihelper.Et;

@Et(beanName = "alcust")
public class AlibabaCustInfo implements java.io.Serializable {
	@Get(key = "第_年",direct="pre")
	private String cmpname;// 企业名称
	@Get(key = "企业类型")
	private String qylx;// 企业类型
	@Get(key = "主营行业")
	private String bstype;// 主营行业
	@Get(key = "主营产品或服务")
	private String zycp;// 主营产品
	@Get(key = "经营模式")
	private String jyms;// 经营模式
	@Get(key = "员工人数")
	private String cmppeoples;// 员工人数
	@Get(key = "成立时间")
	private String clsj;// 公司成立时间
	@Get(key = "年营业额")
	private String yye;// 年营业额
	@Get(key = "注册资金")
	private String rgfund;// 注册资金
	@Get(key = "公司主页")
	private String webside;// 网站网址
	@Get(key = "法定代表人")
	private String frdb;// 法人代表
	@Get(key = "联系人")
	private String lxr;// 联系人
	@Get(key = "职位")
	private String zw;// 职位
	@Get(key = "联系电话")
	private String lxrsj;// 联系人手机
	@Get(key = "固定电话")
	private String dh;// 电话
	@Get(key = "传真")
	private String cz;// 传真
	@Get(key = "邮编")
	private String yb;// 邮编
	@Get(key = "实际经营地址")
	private String addr;// 地址
	@Get(key = "公司简介")
	private String gsjj;// 公司简介

	@Override
	public String toString() {
		return "AlidataInfo [" + ", " + "cmpname=" + cmpname + ", qylx=" + qylx
				+ ", bstype=" + bstype + ", zycp=" + zycp + ", jyms=" + jyms
				+ ", cmppeoples=" + cmppeoples + ", clsj=" + clsj + ", yye="
				+ yye + ", rgfund=" + rgfund + ", webside=" + webside
				+ ", frdb=" + frdb + ", lxr=" + lxr + ", zw=" + zw + ", lxrsj="
				+ lxrsj + ", dh=" + dh + ", cz=" + cz + ", yb=" + yb
				+ ", addr=" + addr + ", gsjj=" + gsjj + "]";
	}

	public String getCmpname() {
		return cmpname;
	}

	public void setCmpname(String cmpname) {
		this.cmpname = cmpname;
	}

	public String getQylx() {
		return qylx;
	}

	public void setQylx(String qylx) {
		this.qylx = qylx;
	}

	public String getBstype() {
		return bstype;
	}

	public void setBstype(String bstype) {
		this.bstype = bstype;
	}

	public String getZycp() {
		return zycp;
	}

	public void setZycp(String zycp) {
		this.zycp = zycp;
	}

	public String getJyms() {
		return jyms;
	}

	public void setJyms(String jyms) {
		this.jyms = jyms;
	}

	public String getCmppeoples() {
		return cmppeoples;
	}

	public void setCmppeoples(String cmppeoples) {
		this.cmppeoples = cmppeoples;
	}

	public String getClsj() {
		return clsj;
	}

	public void setClsj(String clsj) {
		this.clsj = clsj;
	}

	public String getYye() {
		return yye;
	}

	public void setYye(String yye) {
		this.yye = yye;
	}

	public String getRgfund() {
		return rgfund;
	}

	public void setRgfund(String rgfund) {
		this.rgfund = rgfund;
	}

	public String getWebside() {
		return webside;
	}

	public void setWebside(String webside) {
		this.webside = webside;
	}

	public String getFrdb() {
		return frdb;
	}

	public void setFrdb(String frdb) {
		this.frdb = frdb;
	}

	public String getLxr() {
		return lxr;
	}

	public void setLxr(String lxr) {
		this.lxr = lxr;
	}

	public String getZw() {
		return zw;
	}

	public void setZw(String zw) {
		this.zw = zw;
	}

	public String getLxrsj() {
		return lxrsj;
	}

	public void setLxrsj(String lxrsj) {
		this.lxrsj = lxrsj;
	}

	public String getDh() {
		return dh;
	}

	public void setDh(String dh) {
		this.dh = dh;
	}

	public String getCz() {
		return cz;
	}

	public void setCz(String cz) {
		this.cz = cz;
	}

	public String getYb() {
		return yb;
	}

	public void setYb(String yb) {
		this.yb = yb;
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
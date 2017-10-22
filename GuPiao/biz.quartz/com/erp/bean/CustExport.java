package com.erp.bean;

import com.erp.framework.poi.excel.annotation.Excel;
import com.erp.framework.poi.excel.annotation.ExcelTarget;

@ExcelTarget(id = "custExport")
public class CustExport {
	private String cmpid;// 企业编号
	private String custid;// 客户编号
	
	@Excel(exportName="公司名")
	private String cmpname;// 企业名称
	@Excel(exportName="企业类型")
	private String qylx;// 企业类型
	@Excel(exportName="主营行业")
	private String bstype;// 主营行业
	@Excel(exportName="主营产品")
	private String zycp;// 主营产品
	@Excel(exportName="经营模式")
	private String jyms;// 经营模式
	@Excel(exportName="员工人数")
	private String cmppeoples;// 员工人数
	@Excel(exportName="成立时间")
	private String clsj;// 公司成立时间
	@Excel(exportName="年营业额")
	private String yye;// 年营业额
	@Excel(exportName="注册资金")
	private String rgfund;// 注册资金
	@Excel(exportName="搜索来源")
	private String webside;// 网站网址
	@Excel(exportName="备注")
	private String gsjj;// 公司简介
	@Excel(exportName="法人")
	private String frdb;// 法人代表
	@Excel(exportName="联系人")
	private String lxr;// 联系人
	@Excel(exportName="职位")
	private String zw;// 职位
	@Excel(exportName="手机")
	private String lxrsj;// 联系人手机
	@Excel(exportName="座机")
	private String dh;// 电话
	@Excel(exportName="传真")
	private String cz;// 传真
	@Excel(exportName="邮编")
	private String yb;// 邮编
	@Excel(exportName="地址")
	private String addr;// 地址
	

	@Override
	public String toString() {
		return "CustExport [cmpid=" + cmpid + ", custid=" + custid
				+ ", cmpname=" + cmpname + ", qylx=" + qylx + ", bstype="
				+ bstype + ", zycp=" + zycp + ", jyms=" + jyms
				+ ", cmppeoples=" + cmppeoples + ", clsj=" + clsj + ", yye="
				+ yye + ", rgfund=" + rgfund + ", webside=" + webside
				+ ", gsjj=" + gsjj + ", frdb=" + frdb + ", lxr=" + lxr
				+ ", zw=" + zw + ", lxrsj=" + lxrsj + ", dh=" + dh + ", cz="
				+ cz + ", yb=" + yb + ", addr=" + addr + "]";
	}

	public String getCmpid() {
		return cmpid;
	}

	public void setCmpid(String cmpid) {
		this.cmpid = cmpid;
	}

	public String getCustid() {
		return custid;
	}

	public void setCustid(String custid) {
		this.custid = custid;
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

	public String getGsjj() {
		return gsjj;
	}

	public void setGsjj(String gsjj) {
		this.gsjj = gsjj;
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

}

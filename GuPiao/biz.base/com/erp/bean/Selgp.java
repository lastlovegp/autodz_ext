package com.erp.bean;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.util.GPUtil;

/**
 * 股票统计
 * 
 * @author Administrator
 */
@Et(beanId = "code", beanName = "gp")
public class Selgp  {

	@Ef(fseq = 1, width = 70)
	private String code; // 股票代码
	@Ef(fseq = 2, width = 100)
	private String name;
	@Ef(fseq = 3)
	private double dqj; // 当前价
	@Ef(fseq = 4)
	private double zhangfu; // 涨幅
	@Ef(fseq = 8)
	private String gn = "";

	@Ef(colExclude = true)
	private int seltype; // 选择类型
	@Ef(colExclude = true)
	private int gpseq;
	@Ef(fseq = 8)
	private String time;
	@Ef(colExclude = true)
	private String sta = "0"; // 0:有效 1：无效

	@Override
	public String toString() {
		return "Selgp [code=" + code + ", name=" + name + ", zhangfu="
				+ zhangfu + ", seltype=" + seltype + ", time=" + time + ", gn="
				+ gn + "]";
	}
	
	public String getSta() {
		return sta;
	}

	public void setSta(String sta) {
		this.sta = sta;
	}

	public String getGn() {
		return gn;
	}

	public void setGn(String gn) {
		this.gn = gn;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGpseq() {
		return gpseq;
	}

	public void setGpseq(int gpseq) {
		this.gpseq = gpseq;
	}

	public int getSeltype() {
		return seltype;
	}

	public void setSeltype(int seltype) {
		this.seltype = seltype;
	}

	public double getDqj() {
		return dqj;
	}

	public void setDqj(double dqj) {
		this.dqj = dqj;
	}

	public double getZhangfu() {
		return zhangfu;
	}

	public void setZhangfu(double zhangfu) {
		this.zhangfu = zhangfu;
	}

	public String getTime() {
		return GPUtil.getTime(this.time);
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}



}

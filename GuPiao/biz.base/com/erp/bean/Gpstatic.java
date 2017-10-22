package com.erp.bean;

import com.erp.util.GPUtil;

/**
 * 股票统计
 * 
 * @author Administrator
 */
public class Gpstatic {

	private String code; // 股票代码
	private String name;
	private double zrZhangFu; // 昨日涨幅
	private double kpZhangFu; // 开盘涨幅
	private double dqj; // 当前价
	private double jj; // 当前均价
	private double zf; // 震幅
	private double zhangfu; // 涨幅
	private double zdZhangFu; // 今日最低涨幅
	private double zgZhangFu; // 今日最高涨幅
	private String time; // 交易时间
	private String gn = ""; // 概念
	private double zrspj; // 昨日收盘价；
	private int gpseq = 20; // 优先级
	private double ltg; // 流通股
	private double syl; // 市盈率
	private double sumzf; // 5日涨幅
	private String jkflag;
	
	public String getJkflag() {
		return jkflag;
	}

	public void setJkflag(String jkflag) {
		this.jkflag = jkflag;
	}

	public double getSumzf() {
		return sumzf;
	}

	public void setSumzf(double sumzf) {
		this.sumzf = sumzf;
	}

	public double getLtg() {
		return ltg;
	}

	public void setLtg(double ltg) {
		this.ltg = ltg;
	}

	public double getSyl() {
		return syl;
	}

	public void setSyl(double syl) {
		this.syl = syl;
	}

	public double getZrspj() {
		return zrspj;
	}

	public void setZrspj(double zrspj) {
		this.zrspj = zrspj;
	}

	public double getKpZhangFu() {
		return kpZhangFu;
	}

	public void setKpZhangFu(double kpZhangFu) {
		this.kpZhangFu = kpZhangFu;
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

	public double getZgZhangFu() {
		return GPUtil.tranDouble(zgZhangFu);
	}

	public void setZgZhangFu(double zgZhangFu) {
		this.zgZhangFu = zgZhangFu;
	}

	public double getZdZhangFu() {
		return GPUtil.tranDouble(zdZhangFu);
	}

	public void setZdZhangFu(double zdZhangFu) {
		this.zdZhangFu = zdZhangFu;
	}

	public double getZrZhangFu() {
		return zrZhangFu;
	}

	public void setZrZhangFu(double zrZhangFu) {
		this.zrZhangFu = zrZhangFu;
	}

	public double getDqj() {
		return dqj;
	}

	public void setDqj(double dqj) {
		this.dqj = dqj;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public double getZhangfu() {
		return GPUtil.tranDouble(zhangfu);
	}

	public void setZhangfu(double zhangfu) {
		this.zhangfu = zhangfu;
	}

	public double getZf() {
		return zf;
	}

	public void setZf(double zf) {
		this.zf = zf;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getJj() {
		return jj;
	}

	public void setJj(double jj) {
		this.jj = jj;
	}

}

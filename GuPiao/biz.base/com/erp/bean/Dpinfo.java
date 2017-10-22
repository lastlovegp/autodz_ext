package com.erp.bean;

/**
 * 大盘统计
 * 
 * @author Administrator
 */
public class Dpinfo {

	private String code; // 股票代码
	private double zs; // 上次指数
	private double lastzs; // 上次指数
	private int type; // 大盘类型
	private double zhangFu;

	public double getZhangFu() {
		return zhangFu;
	}

	public void setZhangFu(double zhangFu) {
		this.zhangFu = zhangFu;
	}

	public double getZs() {
		return zs;
	}

	public void setZs(double zs) {
		this.zs = zs;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getLastzs() {
		return lastzs;
	}

	public void setLastzs(double lastzs) {
		this.lastzs = lastzs;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

}

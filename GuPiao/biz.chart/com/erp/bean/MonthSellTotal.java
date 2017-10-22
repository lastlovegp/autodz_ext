package com.erp.bean;

import com.erp.framework.extuihelper.Et;

@Et(beanName = "monthSellTotal")
public class MonthSellTotal implements java.io.Serializable {

	private String month;
	private double amt;

	public MonthSellTotal() {
		super();
	}

	public MonthSellTotal(String month, double amt) {
		this.month = month;
		this.amt = amt;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public double getAmt() {
		return amt;
	}

	public void setAmt(double amt) {
		this.amt = amt;
	}

}

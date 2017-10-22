package com.erp.bean;

import com.erp.framework.extuihelper.Et;

@Et(beanName = "sellTotal")
public class SellTotal implements java.io.Serializable {

	private String custname;
	private double amt;

	public SellTotal() {
		super();
	}

	public SellTotal(String custname, double amt) {
		this.custname = custname;
		this.amt = amt;
	}

	public String getCustname() {
		return custname;
	}

	public void setCustname(String custname) {
		this.custname = custname;
	}

	public double getAmt() {
		return amt;
	}

	public void setAmt(double amt) {
		this.amt = amt;
	}

}

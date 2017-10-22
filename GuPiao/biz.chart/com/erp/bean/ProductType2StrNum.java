package com.erp.bean;

import com.erp.framework.extuihelper.Et;

@Et(beanName = "productType2StrNum")
public class ProductType2StrNum implements java.io.Serializable {

	private String name;
	private double strAmt;

	public ProductType2StrNum() {
		super();
	}

	public ProductType2StrNum(String name, double strAmt) {
		this.name = name;
		this.strAmt = strAmt;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getStrAmt() {
		return strAmt;
	}

	public void setStrAmt(double strAmt) {
		this.strAmt = strAmt;
	}

}

package com.erp.bean;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtXtype;

public class FilterBean {

	@Ef(groupIndex=1,gseq=1,groupItemNum=5,groupWithFieldsetFlag=true,xtype="displayfield",defValue="sdf")
	private String q1;
	private String qt11;
	private String qt12;
	private String qt13;
	private String qt14;

	@Ef(groupIndex=2,gseq=1,groupItemNum=3,xtype="displayfield",defValue="sdf")
	private String q2;
	private String qt21;
	private String qt22;

	@Ef(groupIndex=3,gseq=1,groupItemNum=3,xtype="displayfield",defValue="sdf")
	private String q3;
	private String qt31;
	private String qt32;

	@Ef(groupIndex=4,gseq=1,groupItemNum=3,xtype="displayfield",defValue="sdf")
	private String q4;
	private String qt41;
	private String qt42;

	public String getQt11() {
		return qt11;
	}

	public void setQt11(String qt11) {
		this.qt11 = qt11;
	}

	public String getQt12() {
		return qt12;
	}

	public void setQt12(String qt12) {
		this.qt12 = qt12;
	}

	public String getQt13() {
		return qt13;
	}

	public void setQt13(String qt13) {
		this.qt13 = qt13;
	}

	public String getQt14() {
		return qt14;
	}

	public void setQt14(String qt14) {
		this.qt14 = qt14;
	}

	public String getQt21() {
		return qt21;
	}

	public void setQt21(String qt21) {
		this.qt21 = qt21;
	}

	public String getQt22() {
		return qt22;
	}

	public void setQt22(String qt22) {
		this.qt22 = qt22;
	}

	public String getQt31() {
		return qt31;
	}

	public void setQt31(String qt31) {
		this.qt31 = qt31;
	}

	public String getQt32() {
		return qt32;
	}

	public void setQt32(String qt32) {
		this.qt32 = qt32;
	}

	public String getQt41() {
		return qt41;
	}

	public void setQt41(String qt41) {
		this.qt41 = qt41;
	}

	public String getQt42() {
		return qt42;
	}

	public void setQt42(String qt42) {
		this.qt42 = qt42;
	}

	public String getQ1() {
		return q1;
	}

	public void setQ1(String q1) {
		this.q1 = q1;
	}

	public String getQ2() {
		return q2;
	}

	public void setQ2(String q2) {
		this.q2 = q2;
	}

	public String getQ3() {
		return q3;
	}

	public void setQ3(String q3) {
		this.q3 = q3;
	}

	public String getQ4() {
		return q4;
	}

	public void setQ4(String q4) {
		this.q4 = q4;
	}

}

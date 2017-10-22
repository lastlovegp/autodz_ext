package com.erp.framework.extuihelper;

import java.util.Date;

@Et(beanName = "test", beanId = "a2")
public class TestBean {

	@Ef(groupIndex = 2, gseq = 2, flex = 13)
	private String company;

	@Ef(isSubBean = "1", groupIndex = 3, showFields = "name,address")
	private SubBean sub;

	@Ef(xtype = ExtXtype.XTYPE_CMB_GRID, url = "getCodeData_Code_base.do",container = "fcn_test",
	innerTpl = "{field}-{fieldname}", fields = "'field','fieldname'",itemWidth=400,
	displayField = "fieldname", valueField = "field")
	private String a2;

	@Ef(id = "a3", qryFlag = true)
	private String a3;

	@Ef(xtype = "cmbtree", qryFlag = true)
	private String a3Name;


	private String a4;

	@Ef(groupIndex = 5, gseq = 1, xtype = "image",
			src = "http://www.sencha.com/img/20110215-feat-html5.png")
	private String a5;

	@Ef(xtype = "htmleditor")
	private String a6;

	@Ef(container = "fcn_test")
	private String a7;

	@Ef(container = "fcn_test")
	private String a8;

	@Ef(container = "sitem_price")
	private float price;

	private int menupath;

	@Ef(groupIndex = 3)
	private long bb;

	@Ef(container = "sitem_price", groupIndex = 2)
	private Date lastChange;

	@Ef(xtype = "hidden")
	private boolean expanded;

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public float getPrice() {
		return price;
	}

	public void setPrice(float price) {
		this.price = price;
	}

	public int getMenupath() {
		return menupath;
	}

	public void setMenupath(int menupath) {
		this.menupath = menupath;
	}

	public long getBb() {
		return bb;
	}

	public void setBb(long bb) {
		this.bb = bb;
	}

	public Date getLastChange() {
		return lastChange;
	}

	public void setLastChange(Date lastChange) {
		this.lastChange = lastChange;
	}

	public boolean isExpanded() {
		return expanded;
	}

	public void setExpanded(boolean expanded) {
		this.expanded = expanded;
	}

	public SubBean getSub() {
		return sub;
	}

	public void setSub(SubBean sub) {
		this.sub = sub;
	}

	public String getA2() {
		return a2;
	}

	public void setA2(String a2) {
		this.a2 = a2;
	}

	public String getA3() {
		return a3;
	}

	public void setA3(String a3) {
		this.a3 = a3;
	}

	public String getA4() {
		return a4;
	}

	public void setA4(String a4) {
		this.a4 = a4;
	}

	public String getA5() {
		return a5;
	}

	public void setA5(String a5) {
		this.a5 = a5;
	}

	public String getA6() {
		return a6;
	}

	public void setA6(String a6) {
		this.a6 = a6;
	}

	public String getA7() {
		return a7;
	}

	public void setA7(String a7) {
		this.a7 = a7;
	}

	public String getA8() {
		return a8;
	}

	public void setA8(String a8) {
		this.a8 = a8;
	}

	public String getA3Name() {
		return a3Name;
	}

	public void setA3Name(String name) {
		a3Name = name;
	}

}
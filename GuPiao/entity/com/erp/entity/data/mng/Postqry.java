package com.erp.entity.data.mng;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtXtype;

public class Postqry implements java.io.Serializable {

	@Ef(id = "buynum", itemWidth = 150, hideLabel = true, fseq = 1, 
			xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "300:300;500:500;1000:1000;2000:2000;5000:5000", defQryValue = "300")
	private String buynum;
	
	@Ef(id = "buyprice", itemWidth = 150, hideLabel = true, fseq = 2)		
	private double buyprice;
	
	
	public double getBuyprice() {
		return buyprice;
	}

	public void setBuyprice(double buyprice) {
		this.buyprice = buyprice;
	}

	public String getBuynum() {
		return buynum;
	}

	public void setBuynum(String buynum) {
		this.buynum = buynum;
	}

}
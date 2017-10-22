package com.erp.entity.data.mng;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtXtype;


public class Jumpqry implements java.io.Serializable {
	
	@Ef(id="buynum",itemWidth=150,hideLabel=true,fseq=1,
			xtype = ExtXtype.XTYPE_CMB_DIC, 
			dicDefine = "300:300;500:500;1000:1000"					
					,defQryValue="300")
	private String buynum;
	
	@Ef(id="qrycon",itemWidth=150,hideLabel=true,fseq=2,
			xtype = ExtXtype.XTYPE_CMB_DIC, 
			dicDefine = "1:全量看板"					
					,defQryValue="1")
	private String qrycon;
	

	public String getBuynum() {
		return buynum;
	}

	public void setBuynum(String buynum) {
		this.buynum = buynum;
	}

	public String getQrycon() {
		return qrycon;
	}

	public void setQrycon(String qrycon) {
		this.qrycon = qrycon;
	}
	
	
	
}
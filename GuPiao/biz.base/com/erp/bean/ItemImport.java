package com.erp.bean;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.framework.extuihelper.ExtXtype;

@Et(beanName = "itemImport")
public class ItemImport implements java.io.Serializable {

	@Ef(id = "gnDesc", fseq = 2,xtype = ExtXtype.XTYPE_CMB_DIC, dicCode = "GN")
	private String gnDesc;

	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD, renderer = "gpTmpDown", defValue = "gpdown", fseq = 1)
	private String gpTemple;

	@Ef(xtype = ExtXtype.XTYPE_FILE_FIELD, colExclude = true, itemWidth = 400, fseq = 3)
	private String url;

	public String getGnDesc() {
		return gnDesc;
	}

	public void setGnDesc(String gnDesc) {
		this.gnDesc = gnDesc;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

}
package com.erp.entity.data.mng;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.framework.extuihelper.ExtXtype;

@Entity
@Table(name = "jjlog")
@Et(beanId = "id", beanName = "jjlog")
public class Jjlog implements java.io.Serializable{

	@Ef(fseq=1,exclude="1")
	private int id; 
	@Ef(xtype = ExtXtype.XTYPE_CMB_DIC, dicDefine = "5:卖出;6:买入", defValue = "1",fseq=2,width=60)
	private String type;
	
	@Ef(fseq=3,width=460)
	private String log;
	@Ef(fseq=4,width=200)
	private String logtime;
	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getLog() {
		return log;
	}

	public void setLog(String log) {
		this.log = log;
	}

	public String getLogtime() {
		return logtime;
	}

	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}

	


}

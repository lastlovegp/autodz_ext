package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

@Entity
@Table(name = "股票池")
public class Gpstore implements java.io.Serializable {

	@Ef(fseq=1)
	private String code;
	@Ef(fseq=2,readOnly=true)
	private String name;
	
	@Id
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	

}

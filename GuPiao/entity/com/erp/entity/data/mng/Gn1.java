package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;

@Entity
@Table(name = "gn1")
@Et(beanId = "code", beanName = "Gn")
public class Gn1 {

	@Ef(readOnly=true)
	private String code;
	@Ef(readOnly=true)
	private String name;
	private boolean sel;

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

	public boolean isSel() {
		return sel;
	}

	public void setSel(boolean sel) {
		this.sel = sel;
	}

}

package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "gpsel")
public class Gpsel implements java.io.Serializable {

	private String code;
	private String name;
	private String date;

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


	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}

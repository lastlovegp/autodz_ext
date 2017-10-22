package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;


@Entity
@Table(name = "todaysel")
public class Todaysel {

	private int id;	
	private String type;		
	private String bk;		
	private String date;
	
	@Id
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
	public String getBk() {
		return bk;
	}
	public void setBk(String bk) {
		this.bk = bk;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	

}

package com.erp.entity.data.mng;

import static javax.persistence.GenerationType.IDENTITY;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "gpjxhis")
public class Gpjxhis implements java.io.Serializable {

	private long id;
	private String code;
	private double jj5;
	private double jj10;
	private double jj20;
	private double jj30;
	private double jj50;
	private double atr;
	private double ddd;
	private double ema10;
	private Date upddate;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public double getDdd() {
		return ddd;
	}

	public void setDdd(double ddd) {
		this.ddd = ddd;
	}
	
	public double getEma10() {
		return ema10;
	}

	public void setEma10(double ema10) {
		this.ema10 = ema10;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getJj5() {
		return jj5;
	}

	public void setJj5(double jj5) {
		this.jj5 = jj5;
	}

	public double getJj10() {
		return jj10;
	}

	public void setJj10(double jj10) {
		this.jj10 = jj10;
	}

	public double getJj20() {
		return jj20;
	}

	public void setJj20(double jj20) {
		this.jj20 = jj20;
	}

	public double getJj30() {
		return jj30;
	}

	public void setJj30(double jj30) {
		this.jj30 = jj30;
	}

	public double getJj50() {
		return jj50;
	}

	public void setJj50(double jj50) {
		this.jj50 = jj50;
	}

	public double getAtr() {
		return atr;
	}

	public void setAtr(double atr) {
		this.atr = atr;
	}

	public Date getUpddate() {
		return upddate;
	}

	public void setUpddate(Date upddate) {
		this.upddate = upddate;
	}

}

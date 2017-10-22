package com.erp.entity.data.mng;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "gptoday")
public class Gptoday implements java.io.Serializable {

	private long id;
	private String code;
	private double kpj;
	private double dqj;
	private double zrspj;
	private double jrzgj;
	private double jrzdj;
	private double cj_num;
	private double cj_amt;
	private double zf;
	private double zhengf;
	private double jj;
	private double hsl;
	private double tr;

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getKpj() {
		return kpj;
	}

	public void setKpj(double kpj) {
		this.kpj = kpj;
	}

	public double getDqj() {
		return dqj;
	}

	public void setDqj(double dqj) {
		this.dqj = dqj;
	}

	public double getZrspj() {
		return zrspj;
	}

	public void setZrspj(double zrspj) {
		this.zrspj = zrspj;
	}

	public double getJrzgj() {
		return jrzgj;
	}

	public void setJrzgj(double jrzgj) {
		this.jrzgj = jrzgj;
	}

	public double getJrzdj() {
		return jrzdj;
	}

	public void setJrzdj(double jrzdj) {
		this.jrzdj = jrzdj;
	}

	public double getCj_num() {
		return cj_num;
	}

	public void setCj_num(double cj_num) {
		this.cj_num = cj_num;
	}

	public double getCj_amt() {
		return cj_amt;
	}

	public void setCj_amt(double cj_amt) {
		this.cj_amt = cj_amt;
	}

	public double getZf() {
		return zf;
	}

	public void setZf(double zf) {
		this.zf = zf;
	}

	public double getZhengf() {
		return zhengf;
	}

	public void setZhengf(double zhengf) {
		this.zhengf = zhengf;
	}

	public double getJj() {
		return jj;
	}

	public void setJj(double jj) {
		this.jj = jj;
	}

	public double getHsl() {
		return hsl;
	}

	public void setHsl(double hsl) {
		this.hsl = hsl;
	}

	public double getTr() {
		return tr;
	}

	public void setTr(double tr) {
		this.tr = tr;
	}

}
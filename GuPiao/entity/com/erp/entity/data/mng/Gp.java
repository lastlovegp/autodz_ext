package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "gp")
public class Gp implements java.io.Serializable {

	private String code;
	private String name;
	private String hy;
	private double mgsy;
	private double ltsz;
	private double zsz;
	private double sjl;
	private double syl;
	
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
	public String getHy() {
		return hy;
	}
	public void setHy(String hy) {
		this.hy = hy;
	}
	public double getMgsy() {
		return mgsy;
	}
	public void setMgsy(double mgsy) {
		this.mgsy = mgsy;
	}
	public double getLtsz() {
		return ltsz;
	}
	public void setLtsz(double ltsz) {
		this.ltsz = ltsz;
	}
	public double getZsz() {
		return zsz;
	}
	public void setZsz(double zsz) {
		this.zsz = zsz;
	}
	public double getSjl() {
		return sjl;
	}
	public void setSjl(double sjl) {
		this.sjl = sjl;
	}
	public double getSyl() {
		return syl;
	}
	public void setSyl(double syl) {
		this.syl = syl;
	}

}
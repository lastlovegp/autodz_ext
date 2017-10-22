package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "全局筛选")
public class Jumprec implements java.io.Serializable {
	@Ef(fseq = 1, width = 70)
	private String code;
	@Ef(fseq = 2, width = 80)
	private String name;
	@Ef(fseq = 3,width = 20)
	private double zf;
	@Ef(fseq = 4,width = 20)
	private double price;
	@Ef(fseq = 5)
	private double ltzb;
	@Ef(fseq = 6)
	private String hy;
	@Ef(fseq = 7,width = 20)
	private double ltsz;
	@Ef(fseq = 8,width = 20)
	private double syl;
	@Ef(fseq = 9,width = 120)
	private String zfrec;
	@Ef(fseq = 10,width = 8)
	private double rsi6;
	@Ef(fseq = 11,width = 8)
	private double rsi12;
	@Ef(fseq = 12,width = 80)
	private String jcdate;
	@Ef(fseq = 13,width = 5)
	private int iscxg ;

	@Id
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public double getRsi12() {
		return rsi12;
	}
	public void setRsi12(double rsi12) {
		this.rsi12 = rsi12;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getZfrec() {
		return zfrec;
	}
	public void setZfrec(String zfrec) {
		this.zfrec = zfrec;
	}
	public String getName() {
		return name;
	}
	public double getRsi6() {
		return rsi6;
	}
	public void setRsi6(double rsi6) {
		this.rsi6 = rsi6;
	}
	public double getZf() {
		return zf;
	}
	public void setZf(double zf) {
		this.zf = zf;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	
	public int getIscxg() {
		return iscxg;
	}
	public void setIscxg(int iscxg) {
		this.iscxg = iscxg;
	}
	public String getJcdate() {
		return jcdate;
	}
	public void setJcdate(String jcdate) {
		this.jcdate = jcdate;
	}
	
	public double getLtzb() {
		return ltzb;
	}
	public void setLtzb(double ltzb) {
		this.ltzb = ltzb;
	}
	public String getHy() {
		return hy;
	}
	public void setHy(String hy) {
		this.hy = hy;
	}
	public double getLtsz() {
		return ltsz;
	}
	public void setLtsz(double ltsz) {
		this.ltsz = ltsz;
	}
	public double getSyl() {
		return syl;
	}
	public void setSyl(double syl) {
		this.syl = syl;
	}
	
	
	
	
	

}
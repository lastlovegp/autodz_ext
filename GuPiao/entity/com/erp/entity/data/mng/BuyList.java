package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

@Entity
@Table(name = "买入清单")
public class BuyList implements java.io.Serializable{
	
	@Ef(fseq=1,width=60)
	private String code; 	
	@Ef(fseq=2,width=60)
	private String name; 	
	@Ef(width=145,fseq=3)
	private String indate; 
	@Ef(width=145,fseq=4)
	private String outdate;
	@Ef(width=10)
	private int inxh;	
	@Ef(width=5)
	private int available;
	@Ef(width=5)
	private int available_today;
	@Ef(width=10)
	private double vwap;
	@Ef(width=10)
	private double sumzf;
	@Ef(width=10)
	private double fpnl;
	
	@Id
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	public double getSumzf() {
		return sumzf;
	}
	public void setSumzf(double sumzf) {
		this.sumzf = sumzf;
	}
	public String getName() {
		return this.name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}
	public String getOutdate() {
		return outdate;
	}
	
	public void setOutdate(String outdate) {
		this.outdate = outdate;
	}
	public int getInxh() {
		return inxh;
	}
	public void setInxh(int inxh) {
		this.inxh = inxh;
	}
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	public int getAvailable_today() {
		return available_today;
	}
	public void setAvailable_today(int available_today) {
		this.available_today = available_today;
	}
	public double getVwap() {
		return vwap;
	}
	public void setVwap(double vwap) {
		this.vwap = vwap;
	}
	public double getFpnl() {
		return fpnl;
	}
	public void setFpnl(double fpnl) {
		this.fpnl = fpnl;
	}
	
	

}

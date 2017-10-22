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
@Table(name = "bar")
public class Bar implements java.io.Serializable {

	private long id;
	private int type;
	private double amount;
	private double bar_type;
	private double close;
	private double high;
	private double low;
	private double open;
	private double pre_close;
	private String sec_id;
	private String tdate;
	private String ttime;
	private double volume;

	
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", unique = true, nullable = false)
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public String getTdate() {
		return tdate;
	}

	public void setTdate(String tdate) {
		this.tdate = tdate;
	}

	public String getTtime() {
		return ttime;
	}

	public void setTtime(String ttime) {
		this.ttime = ttime;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public double getBar_type() {
		return bar_type;
	}

	public void setBar_type(double bar_type) {
		this.bar_type = bar_type;
	}

	public double getClose() {
		return close;
	}

	public void setClose(double close) {
		this.close = close;
	}

	public double getHigh() {
		return high;
	}

	public void setHigh(double high) {
		this.high = high;
	}

	public double getLow() {
		return low;
	}

	public void setLow(double low) {
		this.low = low;
	}

	public double getOpen() {
		return open;
	}

	public void setOpen(double open) {
		this.open = open;
	}

	public double getPre_close() {
		return pre_close;
	}

	public void setPre_close(double pre_close) {
		this.pre_close = pre_close;
	}

	public String getSec_id() {
		return sec_id;
	}

	public void setSec_id(String sec_id) {
		this.sec_id = sec_id;
	}


	public double getVolume() {
		return volume;
	}

	public void setVolume(double volume) {
		this.volume = volume;
	}

}
package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Et;

@Entity
@Table(name = "store")
@Et(beanId = "code", beanName = "store")
public class Store implements java.io.Serializable {

	private String code;
	private double total;
	private double gpsz;
	private double zjye;
	private double ykje;
	private double ykl;
	private double pamt;
	private double syl;

	@Id
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

	public double getGpsz() {
		return gpsz;
	}

	public void setGpsz(double gpsz) {
		this.gpsz = gpsz;
	}

	public double getZjye() {
		return zjye;
	}

	public void setZjye(double zjye) {
		this.zjye = zjye;
	}

	public double getYkje() {
		return ykje;
	}

	public void setYkje(double ykje) {
		this.ykje = ykje;
	}

	public double getYkl() {
		return ykl;
	}

	public void setYkl(double ykl) {
		this.ykl = ykl;
	}

	public double getPamt() {
		return pamt;
	}

	public void setPamt(double pamt) {
		this.pamt = pamt;
	}

	public double getSyl() {
		return syl;
	}

	public void setSyl(double syl) {
		this.syl = syl;
	}

}

package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "gn5zf")
public class Gn5zf implements java.io.Serializable {

	@Ef(fseq=1)
	private int gn;
	@Ef(fseq=2)
	private double zf;
	
	@Id
	public int getGn() {
		return gn;
	}
	public void setGn(int gn) {
		this.gn = gn;
	}
	public double getZf() {
		return zf;
	}
	public void setZf(double zf) {
		this.zf = zf;
	}
	
	


}
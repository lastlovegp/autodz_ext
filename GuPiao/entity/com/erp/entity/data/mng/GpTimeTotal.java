package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.erp.framework.extuihelper.Ef;

@Entity
@Table(name = "股票分时走势")
public class GpTimeTotal implements java.io.Serializable {

	@Ef(fseq = 1, width = 60)
	private String code;

	@Ef(fseq = 2, width = 60)
	private String name;

	@Ef(width = 10,fseq = 3)
	private double zf;
	@Ef(width = 145, fseq = 4)
	private String gndesc;
	@Ef(width = 145, fseq = 5)
	private String ttime;

	@Id
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getZf() {
		return zf;
	}

	public void setZf(double zf) {
		this.zf = zf;
	}

	public String getGndesc() {
		return gndesc;
	}

	public void setGndesc(String gndesc) {
		this.gndesc = gndesc;
	}

	public String getTtime() {
		return ttime;
	}

	public void setTtime(String ttime) {
		this.ttime = ttime;
	}

}

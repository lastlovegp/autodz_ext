package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;

@Entity
@Table(name = "hy")
public class Hy {

	@Ef(readOnly=true)
	private String hy;
	@Ef(readOnly=true)
	private int qz;
	private boolean sel;

	@Id
	public String getHy() {
		return hy;
	}

	public void setHy(String hy) {
		this.hy = hy;
	}

	public int getQz() {
		return qz;
	}

	public void setQz(int qz) {
		this.qz = qz;
	}

	public boolean isSel() {
		return sel;
	}

	public void setSel(boolean sel) {
		this.sel = sel;
	}

}

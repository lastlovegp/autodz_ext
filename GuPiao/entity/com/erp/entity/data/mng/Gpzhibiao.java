package com.erp.entity.data.mng;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtXtype;

/**
 * Eacode entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "gpzhibiao")
public class Gpzhibiao implements java.io.Serializable {

	@Ef(exclude="1")
	private long id;
	@Ef(exclude="1")
	private int type;
	
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=1)
	private String code;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=2)
	private double dp_rsi_6;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=3)
	private double dp_zf3;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=4)
	private double dp_zf;
	
	
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=5)
	private double zf5;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=6)
	private double zf10;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=7)
	private double zf30;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=8)
	private double rsi_6;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=9)
	private double rsi_12;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=10)
	private double rsi_24;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=11)
	private double pj_15_zhengfu;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=12)
	private double pj_30_zhengfu;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=13)
	private double tp_bar_num;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=14)
	private double syx_bar_num;	
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=15)
	private double fszb;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=16)
	private String fszb_ext;
	@Ef(xtype = ExtXtype.XTYPE_DISPLAY_FIELD,fseq=17)
	private String date;

	@Id
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public int getType() {
		return type;
	}
	
	public double getFszb() {
		return fszb;
	}

	public void setFszb(double fszb) {
		this.fszb = fszb;
	}

	public String getFszb_ext() {
		return fszb_ext;
	}

	public void setFszb_ext(String fszb_ext) {
		this.fszb_ext = fszb_ext;
	}

	public void setType(int type) {
		this.type = type;
	}

	public double getDp_rsi_6() {
		return dp_rsi_6;
	}

	public void setDp_rsi_6(double dp_rsi_6) {
		this.dp_rsi_6 = dp_rsi_6;
	}

	public double getDp_zf3() {
		return dp_zf3;
	}

	public void setDp_zf3(double dp_zf3) {
		this.dp_zf3 = dp_zf3;
	}

	public double getDp_zf() {
		return dp_zf;
	}

	public void setDp_zf(double dp_zf) {
		this.dp_zf = dp_zf;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getZf5() {
		return zf5;
	}

	public void setZf5(double zf5) {
		this.zf5 = zf5;
	}

	public double getZf30() {
		return zf30;
	}

	public void setZf30(double zf30) {
		this.zf30 = zf30;
	}

	public double getRsi_6() {
		return rsi_6;
	}

	public void setRsi_6(double rsi_6) {
		this.rsi_6 = rsi_6;
	}

	public double getRsi_24() {
		return rsi_24;
	}

	public void setRsi_24(double rsi_24) {
		this.rsi_24 = rsi_24;
	}

	public double getPj_15_zhengfu() {
		return pj_15_zhengfu;
	}

	public void setPj_15_zhengfu(double pj_15_zhengfu) {
		this.pj_15_zhengfu = pj_15_zhengfu;
	}

	public double getTp_bar_num() {
		return tp_bar_num;
	}

	public void setTp_bar_num(double tp_bar_num) {
		this.tp_bar_num = tp_bar_num;
	}

	public double getSyx_bar_num() {
		return syx_bar_num;
	}

	public void setSyx_bar_num(double syx_bar_num) {
		this.syx_bar_num = syx_bar_num;
	}

	public double getZf10() {
		return zf10;
	}

	public void setZf10(double zf10) {
		this.zf10 = zf10;
	}

	public double getRsi_12() {
		return rsi_12;
	}

	public void setRsi_12(double rsi_12) {
		this.rsi_12 = rsi_12;
	}

	public double getPj_30_zhengfu() {
		return pj_30_zhengfu;
	}

	public void setPj_30_zhengfu(double pj_30_zhengfu) {
		this.pj_30_zhengfu = pj_30_zhengfu;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
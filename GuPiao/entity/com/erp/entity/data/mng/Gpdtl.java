package com.erp.entity.data.mng;

import javax.persistence.Id;

import com.erp.util.GPUtil;

public class Gpdtl implements java.io.Serializable{

	/**
	 * 0：”大秦铁路”，股票名字； 1：”27.55″，今日开盘价； 2：”27.25″，昨日收盘价； 3：”26.91″，当前价格；
	 * 4：”27.55″，今日最高价； 5：”26.20″，今日最低价； 6：”26.91″，竞买价，即“买一”报价；
	 * 7：”26.92″，竞卖价，即“卖一”报价；
	 * 8：”22114263″，成交的股票数，由于股票交易以一百股为基本单位，所以在使用时，通常把该值除以一百；
	 * 9：”589824680″，成交金额，单位为“元”，为了一目了然，通常以“万元”为成交金额的单位，所以通常把该值除以一万；
	 * 10：”4695″，“买一”申请4695股，即47手； 11：”26.91″，“买一”报价； 12：”57590″，“买二”
	 * 13：”26.90″，“买二” 14：”14700″，“买三” 15：”26.89″，“买三” 16：”14300″，“买四”
	 * 17：”26.88″，“买四” 18：”15100″，“买五” 19：”26.87″，“买五”
	 * 20：”3100″，“卖一”申报3100股，即31手； 21：”26.92″，“卖一”报价 (22, 23), (24, 25),
	 * (26,27), (28, 29)分别为“卖二”至“卖四的情况” 30：”2008-01-11″，日期； 31：”15:05:32″，时间；
	 */
	private String id;
	private String name; // 股票名字
	private String code; // 代码
	private double kpj;// 今日开盘价
	private double kpZhangfu; //开盘涨幅
	private double zrspj; // 昨日收盘价；
	private double dqj; // 当前价格
	private double jrzgj; // 今日最高价；
	private double jrzdj; // 今日最低价；
	private double jbj; // 竞买价，即“买一”报价；
	private double jsj; // 竞卖价，即“卖一”报价；
	private long cjgps; // 成交的股票数，由于股票交易以一百股为基本单位，所以在使用时，通常把该值除以一百；
	private double cjje; // 成交金额，单位为“元”，为了一目了然，通常以“万元”为成交金额的单位，所以通常把该值除以一万；

	private double bgps1; // 买一股票数
	private double bgj1; // 买一价格
	private double bgps2; // 买一股票数
	private double bgj2; // 买一价格
	private double bgps3; // 买一股票数
	private double bgj3; // 买一价格
	private double bgps4; // 买一股票数
	private double bgj4; // 买一价格
	private double bgps5; // 买一股票数
	private double bgj5; // 买一价格

	private double sgps1; // 买一股票数
	private double sgj1; // 买一价格
	private double sgps2; // 买一股票数
	private double sgj2; // 买一价格
	private double sgps3; // 买一股票数
	private double sgj3; // 买一价格
	private double sgps4; // 买一股票数
	private double sgj4; // 买一价格
	private double sgps5; // 买一股票数
	private double sgj5; // 买一价格

	private String date; // 时间
	
	
//开盘涨幅
	public double getKpZhangfu() {
		return GPUtil.tranDouble((this.getKpj() - this.getZrspj()) / this
				.getZrspj()) * 100;
	}

	//最高涨幅
	public double getZgZhangFu() {
		return GPUtil.tranDouble((this.getJrzgj() - this.getZrspj()) / this
				.getZrspj()) * 100;
	}

    //最低涨幅
	public double getZdZhangFu() {
		return GPUtil.tranDouble((this.getJrzdj() - this.getZrspj()) / this
				.getZrspj()) * 100;
	}


	// 　公式;涨跌幅=(今日收盘价-昨日收盘价)/昨日收盘价*100%。
	public double getZhangfu() {
		return GPUtil.tranDouble((this.getDqj() - this.getZrspj()) / this
				.getZrspj()) * 100;
	}

	public double getBgps1() {
		return bgps1;
	}

	public void setBgps1(double bgps1) {
		this.bgps1 = bgps1;
	}

	public double getBgj1() {
		return bgj1;
	}

	public void setBgj1(double bgj1) {
		this.bgj1 = bgj1;
	}

	public double getBgps2() {
		return bgps2;
	}

	public void setBgps2(double bgps2) {
		this.bgps2 = bgps2;
	}

	public double getBgj2() {
		return bgj2;
	}

	public void setBgj2(double bgj2) {
		this.bgj2 = bgj2;
	}

	public double getBgps3() {
		return bgps3;
	}

	public void setBgps3(double bgps3) {
		this.bgps3 = bgps3;
	}

	public double getBgj3() {
		return bgj3;
	}

	public void setBgj3(double bgj3) {
		this.bgj3 = bgj3;
	}

	public double getBgps4() {
		return bgps4;
	}

	public void setBgps4(double bgps4) {
		this.bgps4 = bgps4;
	}

	public double getBgj4() {
		return bgj4;
	}

	public void setBgj4(double bgj4) {
		this.bgj4 = bgj4;
	}

	public double getBgps5() {
		return bgps5;
	}

	public void setBgps5(double bgps5) {
		this.bgps5 = bgps5;
	}

	public double getBgj5() {
		return bgj5;
	}

	public void setBgj5(double bgj5) {
		this.bgj5 = bgj5;
	}

	public double getSgps1() {
		return sgps1;
	}

	public void setSgps1(double sgps1) {
		this.sgps1 = sgps1;
	}

	public double getSgj1() {
		return sgj1;
	}

	public void setSgj1(double sgj1) {
		this.sgj1 = sgj1;
	}

	public double getSgps2() {
		return sgps2;
	}

	public void setSgps2(double sgps2) {
		this.sgps2 = sgps2;
	}

	public double getSgj2() {
		return sgj2;
	}

	public void setSgj2(double sgj2) {
		this.sgj2 = sgj2;
	}

	public double getSgps3() {
		return sgps3;
	}

	public void setSgps3(double sgps3) {
		this.sgps3 = sgps3;
	}

	public double getSgj3() {
		return sgj3;
	}

	public void setSgj3(double sgj3) {
		this.sgj3 = sgj3;
	}

	public double getSgps4() {
		return sgps4;
	}

	public void setSgps4(double sgps4) {
		this.sgps4 = sgps4;
	}

	public double getSgj4() {
		return sgj4;
	}

	public void setSgj4(double sgj4) {
		this.sgj4 = sgj4;
	}

	public double getSgps5() {
		return sgps5;
	}

	public void setSgps5(double sgps5) {
		this.sgps5 = sgps5;
	}

	public double getSgj5() {
		return sgj5;
	}

	public void setSgj5(double sgj5) {
		this.sgj5 = sgj5;
	}

	public double getZf() {
		return GPUtil.tranDouble((this.getJrzgj() - this.getJrzdj())
				/ this.getZrspj()) * 100;
	}


	public String getCode() {
		return code;
	}

	@Id
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getKpj() {
		return kpj;
	}

	public void setKpj(double kpj) {
		this.kpj = kpj;
	}

	public double getZrspj() {
		return zrspj;
	}

	public void setZrspj(double zrspj) {
		this.zrspj = zrspj;
	}

	public double getDqj() {
		return dqj;
	}

	public void setDqj(double dqj) {
		this.dqj = dqj;
	}

	public double getJrzdj() {
		return jrzdj;
	}

	public void setJrzdj(double jrzdj) {
		this.jrzdj = jrzdj;
	}

	public double getJbj() {
		return jbj;
	}

	public void setJbj(double jbj) {
		this.jbj = jbj;
	}

	public double getJsj() {
		return jsj;
	}

	public void setJsj(double jsj) {
		this.jsj = jsj;
	}

	public long getCjgps() {
		return cjgps;
	}

	public void setCjgps(long cjgps) {
		this.cjgps = cjgps;
	}

	public double getCjje() {
		return cjje;
	}

	public void setCjje(double cjje) {
		this.cjje = cjje;
	}

	public double getJrzgj() {
		return jrzgj;
	}

	public void setJrzgj(double jrzgj) {
		this.jrzgj = jrzgj;
	}

}

package com.erp.bean;

import java.util.List;

public class GpChartData {

	private List<String> dates;

	private List<double[]> values;

	private List<String> minutes;

	private List<double[]> minValues;

	private List<GpTranChartData> tranValues;

	private List<Double> jj5;

	private List<Double> jj10;
	
	private List<Double> ddd;
	
	private List<Double> ema10;
	
	private List<Double> zf;
	
	private double pre_close;
	
	
	public List<Double> getZf() {
		return zf;
	}

	public void setZf(List<Double> zf) {
		this.zf = zf;
	}

	public List<Double> getDdd() {
		return ddd;
	}

	public void setDdd(List<Double> ddd) {
		this.ddd = ddd;
	}

	public double getPre_close() {
		return pre_close;
	}
	
	public List<Double> getEma10() {
		return ema10;
	}

	public void setEma10(List<Double> ema10) {
		this.ema10 = ema10;
	}

	public void setPre_close(double pre_close) {
		this.pre_close = pre_close;
	}

	public List<String> getMinutes() {
		return minutes;
	}

	public void setMinutes(List<String> minutes) {
		this.minutes = minutes;
	}

	public List<double[]> getMinValues() {
		return minValues;
	}

	public void setMinValues(List<double[]> minValues) {
		this.minValues = minValues;
	}

	public List<String> getDates() {
		return dates;
	}

	public void setDates(List<String> dates) {
		this.dates = dates;
	}

	public List<double[]> getValues() {
		return values;
	}

	public void setValues(List<double[]> values) {
		this.values = values;
	}

	public List<GpTranChartData> getTranValues() {
		return tranValues;
	}

	public void setTranValues(List<GpTranChartData> tranValues) {
		this.tranValues = tranValues;
	}

	public List<Double> getJj5() {
		return jj5;
	}

	public void setJj5(List<Double> jj5) {
		this.jj5 = jj5;
	}

	public List<Double> getJj10() {
		return jj10;
	}

	public void setJj10(List<Double> jj10) {
		this.jj10 = jj10;
	}

}

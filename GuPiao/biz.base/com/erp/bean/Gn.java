package com.erp.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
import com.erp.util.GPUtil;

/**
 * 概念
 * 
 * @author Administrator
 */
@Et(beanId = "code", beanName = "gn")
public class Gn {
	private String code; // 股票代码
	private String name;
	@Ef(exclude = "1")
	private List<String> gpCodes = new ArrayList<String>();
	@Ef(exclude = "1")
	private Map<String,Double> jkGps = new HashMap<String,Double>();
	private double zfAvg;
	private double zfAvg5r;
	
	public double getZfAvg() {
		double avgZf = 0.0;
		for (Double zf:jkGps.values()) {
			avgZf += zf;
		}
		if (jkGps.size() > 0) {
			return GPUtil.tranDouble(avgZf/jkGps.size());
		} else {
			return 0;
		}
		
	}
	public Map<String, Double> getJkGps() {
		return jkGps;
	}
	public void setJkGps(Map<String, Double> jkGps) {
		this.jkGps = jkGps;
	}
	
	public void setZfAvg(double zfAvg) {
		this.zfAvg = zfAvg;
	}
	public double getZfAvg5r() {
		return zfAvg5r;
	}
	public void setZfAvg5r(double zfAvg5r) {
		this.zfAvg5r = zfAvg5r;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<String> getGpCodes() {
		return gpCodes;
	}
	public void setGpCodes(List<String> gpCodes) {
		this.gpCodes = gpCodes;
	}
	
}
	

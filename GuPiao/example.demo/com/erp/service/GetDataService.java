package com.erp.service;

import java.util.List;

import com.erp.bean.AlibabaCustInfo;

public interface GetDataService {

	public List<AlibabaCustInfo> getGYSData(String url) throws Exception;

	

}
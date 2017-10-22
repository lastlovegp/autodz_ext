package com.erp.service;

import java.util.List;

import com.erp.entity.data.mng.Store;
import com.erp.entity.data.mng.Gpdtl;

public interface GetGpDataFromSina {


	public List<Gpdtl> getGGDataFromSina(String code) throws Exception;
	public List<Store> getDpdtlFromSina(String code) throws Exception;


}
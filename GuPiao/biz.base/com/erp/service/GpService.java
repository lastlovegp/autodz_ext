package com.erp.service;

import com.base.common.PageQueryResult;
import com.base.common.bean.Dto;
import com.erp.entity.dao.BaseDAO;

public interface GpService {


	public void setJdbcBaseDao(BaseDAO baseDao);
	public BaseDAO getJdbcBaseDao();
	public PageQueryResult getGpBaseList(Dto inDto) throws Exception;
	public void saveGpBase(Dto inDto) throws Exception;
	public Dto importGpData(Dto inDto) throws Exception;



}
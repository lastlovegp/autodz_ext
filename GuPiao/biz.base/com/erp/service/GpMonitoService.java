package com.erp.service;

import java.util.List;

import com.base.common.PageQueryResult;
import com.base.common.bean.Dto;
import com.erp.bean.GpChartData;
import com.erp.entity.dao.BaseDAO;
import com.erp.entity.data.mng.Event;
import com.erp.entity.data.mng.Gpparam;
import com.erp.entity.data.mng.Gpzhibiao;


public interface GpMonitoService {

	public BaseDAO getJdbcBaseDao();
	public void setJdbcBaseDao(BaseDAO baseDao);
	public PageQueryResult getJjlogList(Dto dto) throws Exception;
	public PageQueryResult getPositionList(Dto inDto) throws Exception;
	public PageQueryResult getTranhisList(Dto inDto) throws Exception;
	public PageQueryResult getStoreList(Dto inDto) throws Exception;
	public GpChartData getDailyBarData(Dto inDto) throws Exception;
	public GpChartData getMinuteBarData(Dto inDto) throws Exception;
	public Gpparam getGpparams(Dto inDto) throws Exception;
	public void saveGpParam(Dto inDto) throws Exception;
	
	public PageQueryResult getJumprecList(Dto inDto) throws Exception;
	public void saveEvent(Dto inDto) throws Exception;
	public List<Event> queryEventList(Dto inDto) throws Exception;
	public void saveCostData(Dto inDto) throws Exception;
	
	public PageQueryResult getGPStoreList(Dto inDto) throws Exception;
	public void saveGpStore(Dto inDto) throws Exception;
	public Gpzhibiao getZhibiao(Dto inDto) throws Exception;
	public void reTestCode(Dto inDto) throws Exception;
	public void saveHyData(Dto inDto) throws Exception;
	public PageQueryResult getHyList(Dto inDto) throws Exception;
	public void saveGnData(Dto inDto) throws Exception;
	public PageQueryResult getGnList(Dto inDto) throws Exception;
	public void updateGPCost(Dto inDto) throws Exception;
}
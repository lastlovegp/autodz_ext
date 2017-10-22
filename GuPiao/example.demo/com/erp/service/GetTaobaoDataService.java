package com.erp.service;

import java.util.List;

import com.base.common.bean.Dto;
import com.taobao.api.domain.Trade;
import com.taobao.api.response.ItemsOnsaleGetResponse;
import com.taobao.api.response.SellercatsListGetResponse;
import com.taobao.api.response.TradesSoldGetResponse;
import com.taobao.api.response.TradesSoldIncrementGetResponse;


public interface GetTaobaoDataService {


	public SellercatsListGetResponse getSellercatsList(String nick) throws Exception;

	public void synCats(Dto dto) throws Exception;

	public ItemsOnsaleGetResponse getProductList() throws Exception;

	public void synProduct(Dto dto) throws Exception;

	public TradesSoldGetResponse getOrderList(Dto param) throws Exception;

	public void synOrder(Dto dto) throws Exception;

	public  TradesSoldIncrementGetResponse getIncrementOrderList(Dto param) throws Exception;

	public void synOrder(List<Trade> list) throws Exception;

	public String getTaobaoEnv();



}
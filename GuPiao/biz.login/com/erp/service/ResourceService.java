package com.erp.service;

import java.util.List;

import com.base.common.PageQueryResult;
import com.base.common.bean.Dto;
import com.erp.entity.data.mng.Eacode;

public interface ResourceService {

	public List<Eacode> getDicList(Dto inDto) throws Exception;

	public PageQueryResult queryDicList(Dto inDto) throws Exception;


	public String codeConvert(String codes, String field);

	public void saveCode(Dto inDto) throws Exception;




}
package com.erp.service.impl;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.base.common.service.impl.BaseManagerImpl;
import com.erp.bean.Dpinfo;
import com.erp.bean.Gpstatic;
import com.erp.service.GpSelectService;

/**
 * 股票处理类
 * 
 */
@Service(value = "gpSelectService")
public class GpSelectServiceImpl extends BaseManagerImpl implements
		GpSelectService {

	private Log log = LogFactory.getLog(GpSelectServiceImpl.class);


	@Override
	public int gpZfLineSel(Gpstatic gs, Dpinfo dp) throws Exception {

		return 1;
	}

}

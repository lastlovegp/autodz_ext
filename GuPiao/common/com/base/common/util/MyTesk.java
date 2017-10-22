package com.base.common.util;

import java.util.TimerTask;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class MyTesk extends TimerTask{

	protected Log log = LogFactory.getLog(MyTesk.class);
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		log.info("定时任务启动");
	}

}

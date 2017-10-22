package com.erp.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.base.common.action.BaseAction;

@Controller
@Scope("prototype")
public class JqmAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	public String index() throws Exception {

		return SUCCESS;
	}

	public String baiduMap() throws Exception {

		return SUCCESS;
	}

	public String config() throws Exception {

		return SUCCESS;
	}

	public String contact() throws Exception {

		return SUCCESS;
	}

	public String workTask() throws Exception {

		return SUCCESS;
	}


}

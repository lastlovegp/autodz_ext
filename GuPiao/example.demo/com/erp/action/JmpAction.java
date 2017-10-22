package com.erp.action;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.base.common.action.BaseAction;

@Controller
@Scope("prototype")
public class JmpAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	protected Log log = LogFactory.getLog(JmpAction.class);


	public String button() throws Exception {
		return SUCCESS;
	}

	public String forms() throws Exception {
		return SUCCESS;
	}

	public String grids() throws Exception {
		return SUCCESS;
	}

}

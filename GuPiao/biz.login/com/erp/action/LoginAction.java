package com.erp.action;

import java.util.ResourceBundle;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.base.common.SysConstants;
import com.base.common.action.BaseAction;
import com.erp.framework.extuihelper.ExtUiHelper;
import com.erp.framework.util.SysUtils;
import com.erp.service.ResourceService;

/**
 * @Controller用于将控制层的类标识为 Spring Bean。
 * @author Administrator
 * 
 */
@Controller
@Scope("prototype")
public class LoginAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	@Resource(name = "resourceService")
	private ResourceService resourceService;

	private String account;
	private String password;
	private String randomInput;
	private String smsCode;

	protected Log log = LogFactory.getLog(LoginAction.class);

	public String loginInit() throws Exception {
		ExtUiHelper eh = new ExtUiHelper();
		if (eh.resMap.get(SysConstants.MESSAGE_RES) == null) {
			ResourceBundle msgRes = getTexts(SysConstants.MESSAGE_RES);
			eh.resMap.put(SysConstants.MESSAGE_RES, msgRes);
		}
		if (eh.resMap.get(SysConstants.ERRMSG_RES) == null) {
			ResourceBundle errRes = getTexts(SysConstants.ERRMSG_RES);
			eh.resMap.put(SysConstants.ERRMSG_RES, errRes);
		}
		return SUCCESS;
	}

	public String loginCheck() {
		password = SysUtils.encryptBasedDes(password);
		log.info("帐户[" + account + "]正尝试登陆系统...");
		
		try {
			resourceService.saveCode(getUiDto());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	public String loginOut() throws Exception {

		return SUCCESS;
	}

	public String sign() throws Exception {
		String loginFlag = (String) getSession().getAttribute(
				SysConstants.LOGIN_FLAG);
		log.info("loginFlag####:" + loginFlag);
		if ("true".equals(loginFlag)) {
			return "main";
		}
		return SUCCESS;
	}

	public String getRandomInput() {
		return randomInput;
	}

	public void setRandomInput(String randomInput) {
		this.randomInput = randomInput;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSmsCode() {
		return smsCode;
	}

	public void setSmsCode(String smsCode) {
		this.smsCode = smsCode;
	}

	public Log getLog() {
		return log;
	}

	public void setLog(Log log) {
		this.log = log;
	}

}

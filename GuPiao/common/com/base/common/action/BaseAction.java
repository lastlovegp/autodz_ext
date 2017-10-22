package com.base.common.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.erp.framework.extuihelper.ExtUiCfg;
import com.erp.framework.extuihelper.ExtUiHelper;
import com.erp.framework.extuihelper.ExtXtype;
import com.erp.framework.extuihelper.FieldContainer;
import com.erp.framework.extuihelper.UiUtil;
import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;
import com.erp.framework.util.DataObjectUtils;
import com.erp.framework.util.SessionContainer;
import com.erp.framework.util.WebUtils;
import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport {
	
	protected Log log = LogFactory.getLog(BaseAction.class);

	private String contextPath = "";

	private Dto requestDto = null;

	private Dto uiDto = new BaseDto();
	protected List<Object> objList = new ArrayList<Object>();
	protected ExtUiCfg cfg = new ExtUiCfg();

	protected static PropertiesHelper pHelper = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.CFG);

	private static final long serialVersionUID = 1L;

	/**
	 * 将请求参数封装为Dto
	 * 
	 * @param request
	 * @return
	 */
	protected static Dto getPraramsAsDto(HttpServletRequest request) {
		return WebUtils.getPraramsAsDto(request);
	}

	protected String getItemStr(Object bean, String uiType) {
		String str = ExtUiHelper.getCommExtUiStr(bean, uiType, cfg,
				getRequest());

		// ET 定义
		UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
		this.objList.add(bean);

		return str;
	}

	protected String getQryItemStr(Object bean) {
		String queryItem = "";
		try {
			cfg.preQryName = "qry";
			queryItem = ExtUiHelper.getQueryItemStr(bean, cfg, 
					getRequest());
			// ET 定义
			UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
			this.objList.add(bean);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return queryItem;
	}

	/**
	 * 复杂布局
	 * 
	 * @param obj
	 */
	protected void createCiLay(Object obj) {
		Set<Integer> cnames = ExtUiHelper.getNamessByContainerOfObj(obj);
		FieldContainer fc = null;
		FieldContainer pc = new FieldContainer();
		pc.setLayout("vbox");
		for (int cn : cnames) {
			fc = new FieldContainer();
			fc.setParContainer(pc);
			fc.setName(ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER + "_" + cn);
			fc.setLayout("hbox");
			cfg.getContrainList().add(fc);
		}
		cfg.mc = pc;
	}

	protected void setFormUi(Object bean) {
		Dto uiDto = getUiDto();
		// 设置布局
		if ("ci".equals(this.cfg.uiType)) {
			this.createCiLay(bean);
		}
		UiUtil.setFormUi(bean, cfg, this.getRequest(), uiDto);
		// ET 定义
		UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
		this.objList.add(bean);
	}

	protected void setQueryFormUi(Object bean) {
		// 设置布局
		if ("ci".equals(this.cfg.uiType)) {
			this.createCiLay(bean);
		} else {
			cfg.uiType="qi";
		}

		Dto uiDto = getUiDto();
		// 查询FORM定义
		try {
			UiUtil.setQueryFormUi(bean, cfg, getRequest(), uiDto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// ET 定义
		UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
		this.objList.add(bean);
	}

	protected void setGridUi(Object bean) {
		Dto uiDto = getUiDto();
		UiUtil.setGridUi(bean, cfg, getRequest(), this.getUiDto());
		// ET 定义
		UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
		this.objList.add(bean);
	}

	protected void setGridWithQryUi(Object bean, Object qryObj) {
		Dto uiDto = getUiDto();
		this.cfg.setGridWithQryFlag(true);
		this.cfg.preQryName = "grid_qry";
		try {
			UiUtil.setGridWithQryUi(bean, qryObj, cfg, getRequest(),
					this.getUiDto());
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// ET 定义
		UiUtil.et2Dto(bean, cfg, uiDto, getRequest());
		this.objList.add(bean);
	}

	/**
	 * 字典转换
	 * 
	 * @param request
	 * @return
	 */
	protected void tranCode2Desc() {
		String desc = ExtUiHelper.getCodeDescStr(objList, this.getRequest(),
				cfg);

		// 控件引用
		this.getUiDto().put("codeTrans", desc);
		
		//log.info("this.getUiDto():" + this.getUiDto().toString());
		
	}

	/**
	 * 把map拷贝到object中,对时间设置默认值
	 * 
	 * @param object
	 * @param map
	 * @throws AppException
	 */
	protected void mapToObject(Object object, Map map) throws Exception {
		DataObjectUtils.mapToObject(object, map);

	}

	/**
	 * 把map拷贝到object中,不对时间设置默认值
	 * 
	 * @param object
	 * @param map
	 * @throws AppException
	 */
	protected void mapToObject2(Object object, Map map) throws Exception {
		DataObjectUtils.mapToObject2(object, map);
	}

	/**
	 * 获取代码对照值
	 * 
	 * @param field
	 *            代码类别
	 * @param code
	 *            代码值
	 * @param request
	 * @return
	 */
	protected String getCodeDesc(String pField, String pCode,
			HttpServletRequest request) {
		return WebUtils.getCodeDesc(pField, pCode, request);
	}

	protected String getParamValue(String key) {
		return WebUtils.getSysParamMap(getRequest()).get(key);
	}

	/**
	 * 根据代码类别获取代码表列表
	 * 
	 * @param field
	 * @param request
	 * @return
	 */
	protected List getCodeListByField(String pField, HttpServletRequest request) {
		return WebUtils.getCodeListByField(pField, request);
	}

	/**
	 * 输出响应
	 * 
	 * @param str
	 * @throws IOException
	 */
	protected void write(String str, HttpServletResponse response)
			throws IOException {
		response.setContentType("text/html");
		response.setCharacterEncoding("utf-8");
		response.getWriter().write(str);
		response.getWriter().flush();
		response.getWriter().close();
	}

	protected SessionContainer getSessionContainer(HttpServletRequest request) {
		SessionContainer sessionContainer = (SessionContainer) this
				.getSessionAttribute(request, SysConstants.SESSION_KEY);
		if (sessionContainer == null) {
			sessionContainer = new SessionContainer();
			HttpSession session = request.getSession(true);
			session.setAttribute(SysConstants.SESSION_KEY, sessionContainer);
		}
		return sessionContainer;
	}

	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	public String getContextPath() {
		return this.getRequest().getContextPath();
	}

	public Dto getRequestDto() {
		return WebUtils.getPraramsAsDto(this.getRequest());
	}

	/**
	 * 获取一个Session属性对象
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	protected Object getSessionAttribute(HttpServletRequest request,
			String sessionKey) {
		Object objSessionAttribute = null;
		HttpSession session = request.getSession(false);
		if (session != null) {
			objSessionAttribute = session.getAttribute(sessionKey);
		}
		return objSessionAttribute;
	}

	/**
	 * 设置一个Session属性对象
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	protected void setSessionAttribute(HttpServletRequest request,
			String sessionKey, Object objSessionAttribute) {
		HttpSession session = request.getSession();
		if (session != null)
			session.setAttribute(sessionKey, objSessionAttribute);
	}

	/**
	 * 移除Session对象属性值
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	protected void removeSessionAttribute(HttpServletRequest request,
			String sessionKey) {
		HttpSession session = request.getSession();
		if (session != null)
			session.removeAttribute(sessionKey);
	}

	/**
	 * 
	 * 交易成功提示信息
	 * 
	 * @param pMsg
	 *            提示信息
	 * @param pResponse
	 * @return
	 * @throws IOException
	 */
	protected void setOkTipMsg(String pMsg, HttpServletResponse response)
			throws IOException {
		Dto outDto = new BaseDto(SysConstants.TRUE, pMsg);
		write(outDto.toJson(), response);
	}

	/**
	 * 
	 * 交易失败提示信息(特指：业务交易失败并不是请求失败)<br>
	 * 和Form的submit中的failur回调对应,Ajax.request中的failur回调是值请求失败
	 * 
	 * @param pMsg
	 *            提示信息
	 * @param pResponse
	 * @return
	 * @throws IOException
	 */
	protected void setErrTipMsg(String pMsg, HttpServletResponse response)
			throws IOException {
		Dto outDto = new BaseDto(SysConstants.FALSE, pMsg);
		write(outDto.toJson(), response);
	}

	public Dto getUiDto() {
		return uiDto;
	}

	public void setUiDto(Dto uiDto) {
		this.uiDto = uiDto;
	}

}

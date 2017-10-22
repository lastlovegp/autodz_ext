package com.erp.framework.extuihelper;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.base.common.bean.Dto;
import com.erp.framework.util.DataFormat;

public class UiUtil {

	/**
	 * grid 用
	 * 
	 * @param btnStr
	 * @param preName
	 * @param emptyStr
	 * @param req
	 * @param dto
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 */
	public static void setGridWithQryUi(Object obj, Object qryObj,
			ExtUiCfg cfg, HttpServletRequest req, Dto dto) throws InstantiationException, IllegalAccessException {

		String tbarStr = "";
		StringBuilder rtnStr = new StringBuilder();
		String cName = obj.getClass().getSimpleName();
		Et et = ExtUiHelper.getEt(obj.getClass());
		if (et != null) {
			cName = et.beanName();
		}

		dto.put(cName + "Fstr", ExtUiHelper.getCommExtUiStr(obj, "f", cfg, req));
		if (cfg.isCellCanEdit()) {
			cfg.setGetGridNewRowFlag(true);
			dto.put(cName + "GridNewRowStr",
					ExtUiHelper.getCommExtUiStr(obj, "f", cfg, req));
		}

		dto.put(cName + "Cstr", ExtUiHelper.getCommExtUiStr(obj, "c", cfg, req));

		cfg.setPreStr("_grid");
		tbarStr = ExtUiHelper.createBtnStr(cfg.getGridBar(),
				cName + cfg.getPreStr(), req);
				

		// 默认简单查询
		if (cfg.isGridWithQryFlag() && DataFormat.isEmpty(cfg.getGridQryStr())
				&& qryObj == null && StringUtils.isBlank(cfg.getGridQryStr())) {
			rtnStr.append(tbarStr)
					.append(ExtUiHelper.BTN_LINK_RIGHT)
					.append(ExtUiHelper.getSimpleQueryItemStr(true,
							cfg.getSimpleQryEmptyText(), req));
			dto.put(cName + "Qrycdn",
					ExtUiHelper.getQryConditionStr(obj, null, cfg));
		} else if (cfg.isGridWithQryFlag()) {
			if (!DataFormat.isEmpty(tbarStr))
				rtnStr.append(tbarStr).append(ExtUiHelper.BTN_LINK_RIGHT);

			String queryItemStr = cfg.getGridQryStr();
			if (StringUtils.isBlank(queryItemStr)) {
				try {
					if (qryObj != null) {
						cfg.preQryName = "grid_qry";
						if (qryObj.equals(obj)) {
							cfg.uiType = "qi";
							queryItemStr = ExtUiHelper.getQueryItemStr(obj,
									cfg, req);
						} else {
							queryItemStr = ExtUiHelper.getQueryItemStr(qryObj,
									cfg, req);

						}
					}

				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} 
						
			rtnStr.append(queryItemStr)
					.append(ExtUiHelper.BTN_LINK_LEFT)
					.append(ExtUiHelper.createBtnStr(
							"query,reset" + cfg.getExtBars(),
							cName + cfg.getPreStr(), req));

			// if (dto.get(cName + "Qrycdn") == null) {
			// if (qryObj != null) {
			// dto.put(cName + "Qrycdn",
			// ExtUiHelper.getQryConditionStr(qryObj, null, cfg));
			// } else {
			// dto.put(cName + "Qrycdn",
			// ExtUiHelper.getQryConditionStr(obj, null, cfg));
			// }
			// }
			//
			// if (dto.get(cName + "QryReset") == null) {
			// if (qryObj != null) {
			// dto.put(cName + "QryReset",
			// ExtUiHelper.getQryConditionResetStr(qryObj, cfg));
			// } else {
			// dto.put(cName + "QryReset",
			// ExtUiHelper.getQryConditionResetStr(obj, cfg));
			// }
			// }
		} else if (qryObj != null) {
			tbarStr +=",'-',"+ ExtUiHelper.getQueryItemStr(qryObj, cfg, req);
			
		}
		

		if (!DataFormat.isEmpty(rtnStr.toString())) {
			dto.put(cName + "Tbar", rtnStr.toString());
		} else {
			dto.put(cName + "Tbar", tbarStr);
		}

		cfg.initParam();

	}

	/**
	 * grid 用
	 * 
	 * @param btnStr
	 * @param preName
	 * @param emptyStr
	 * @param req
	 * @param dto
	 */
	public static void setGridUi(Object obj, ExtUiCfg cfg,
			HttpServletRequest req, Dto dto) {
		cfg.setGridWithQryFlag(false);
		try {
			setGridWithQryUi(obj, cfg.getQryObj(), cfg, req, dto);
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * grid 查询条件用
	 * 
	 * @param btnStr
	 * @param preName
	 * @param emptyStr
	 * @param req
	 * @param dto
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	public static void setGridQryDefine(Object obj, ExtUiCfg cfg, Dto dto,
			HttpServletRequest req) throws InstantiationException,
			IllegalAccessException {

		Et et = ExtUiHelper.getEt(obj.getClass());
		String cname = obj.getClass().getSimpleName();
		if (et != null) {
			cname = et.beanName();
		}

		cfg.setGridQryStr(ExtUiHelper.getQueryItemStr(obj, cfg, req));

		dto.put(cname + "Qrycdn",
				ExtUiHelper.getQryConditionStr(obj, null, cfg));

		dto.put(cname + "QryReset",
				ExtUiHelper.getQryConditionResetStr(obj, cfg));

		cfg.setHiddenItems("");
		cfg.setShowItems("");
		cfg.getDyShowItems().clear();

	}

	/**
	 * grid 用
	 * 
	 * @param btnStr
	 * @param preName
	 * @param emptyStr
	 * @param req
	 * @param dto
	 */
	public static void et2Dto(Object obj, ExtUiCfg cfg, Dto dto,
			HttpServletRequest req) {
		Et et = ExtUiHelper.getEt(obj.getClass());
		String u_beanName = "";
		String cName = obj.getClass().getSimpleName();
		if (et == null) {
			u_beanName = cName;
		} else {
			cName = et.beanName();
			if (cName.trim().length() > 0) {
				u_beanName = String.valueOf(cName.charAt(0)).toUpperCase()
						+ cName.substring(1, cName.length());
			}
			dto.put(cName + "BeanId", et.beanId());
		}

		dto.put(cName + "Bean", cName);
		dto.put(cName + "UBean", u_beanName);
		dto.put("actionName", cfg.getActionName());
		dto.put("packageName", cfg.getPackageName());

	}

	/**
	 * from UI
	 * 
	 * @param obj
	 * @param cfg
	 * @param req
	 * @param dto
	 */
	public static void setFormUi(Object obj, ExtUiCfg cfg,
			HttpServletRequest req, Dto dto) {
		Et et = ExtUiHelper.getEt(obj.getClass());
		String cname = obj.getClass().getSimpleName();
		if (et != null) {
			cname = et.beanName();
		}

		dto.put(cname + "Tools", ExtUiHelper.getToolsStr(cfg));

		dto.put(cname + "Istr",
				ExtUiHelper.getCommExtUiStr(obj, cfg.uiType, cfg, req));

		cfg.setPreStr("_form");
		if (!dto.containsKey(cname + "FormTbar")) {
			dto.put(cname + "FormTbar",
					ExtUiHelper.createBtnStr(cfg.getFormBar(),
							cname + cfg.getPreStr(), req));
		}

		cfg.initParam();
	}

	/**
	 * from UI
	 * 
	 * @param obj
	 * @param cfg
	 * @param req
	 * @param dto
	 * @throws IllegalAccessException
	 * @throws InstantiationException
	 */
	public static void setQueryFormUi(Object obj, ExtUiCfg cfg,
			HttpServletRequest req, Dto dto) throws InstantiationException,
			IllegalAccessException {
		Et et = ExtUiHelper.getEt(obj.getClass());
		String cname = obj.getClass().getSimpleName();
		if (et != null) {
			cname = et.beanName();
		}
		cfg.preQryName = "qry";
		dto.put(cname + "QryIstr", ExtUiHelper.getQueryItemStr(obj, cfg, req));

		cfg.setPreStr("_qry");
		dto.put(cname + "QryFormTbar", ExtUiHelper.createBtnStr("query,reset",
				cname + cfg.getPreStr(), req));
	}

}

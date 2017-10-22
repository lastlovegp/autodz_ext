package com.erp.framework.util;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;

import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.erp.entity.data.mng.Eacode;
import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.ExtDic;
import com.erp.framework.extuihelper.ReflectionUtils;

/**
 * 和Web层相关的实用工具类
 * 
 * @author 熊春
 * @since 2008-09-22
 */
public class WebUtils {
	/**
	 * 获取一个SessionContainer容器,如果为null则创建之
	 * 
	 * @param form
	 * @param obj
	 */
	public static SessionContainer getSessionContainer(
			HttpServletRequest request) {
		SessionContainer sessionContainer = (SessionContainer) request
				.getSession().getAttribute(SysConstants.SESSION_KEY);
		if (sessionContainer == null) {
			sessionContainer = new SessionContainer();
			HttpSession session = request.getSession(true);
			session.setAttribute(SysConstants.SESSION_KEY, sessionContainer);
		}
		return sessionContainer;
	}

	/**
	 * 获取一个SessionContainer容器,如果为null则创建之
	 * 
	 * @param form
	 * @param obj
	 */
	public static SessionContainer getSessionContainer(HttpSession session) {
		SessionContainer sessionContainer = (SessionContainer) session
				.getAttribute("SessionContainer");
		if (sessionContainer == null) {
			sessionContainer = new SessionContainer();
			session.setAttribute("SessionContainer", sessionContainer);
		}
		return sessionContainer;
	}

	/**
	 * 获取一个Session属性对象
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	public static Object getSessionAttribute(HttpServletRequest request,
			String sessionKey) {
		Object objSessionAttribute = null;
		HttpSession session = request.getSession(false);
		if (session != null) {
			objSessionAttribute = session.getAttribute(sessionKey);
		}
		return objSessionAttribute;
	}

	public static Map<String, String> getCodeMap(Object inObj, String fieldName) {
		Ef ef = null;

		Map<String, String> rtnMap = new HashMap<String, String>();
		List<Field> fList = ReflectionUtils.getDeclaredField(inObj);
		String[] sc;
		for (Field f : fList) {
			ef = null;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (f.getName().equals(fieldName) && ef != null
						&& !"".equals(ef.dicDefine())) {
					for (String a : ef.dicDefine().split(";")) {
						sc = a.split(":");

						rtnMap.put(sc[0], sc[1]);
					}
				}
			}
		}
		return rtnMap;
	}

	public static String getCodeDescStr(Object inObj, String fieldName,
			String codes) {

		if (StringUtils.isBlank(codes)) {
			return "";
		}
		Map<String, String> rtnMap = getCodeMap(inObj, fieldName);

		String rtnStr = "";
		for (String code : codes.split(",")) {
			rtnStr += rtnMap.get(code) + ",";
		}

		if (!"".equals(rtnStr)) {
			rtnStr = rtnStr.substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnStr;
	}

	public static String getCodeShowValue(Object inObj, String fieldName,
			String codes) {

		if (StringUtils.isBlank(codes)) {
			return "";
		}
		Map<String, String> rtnMap = getCodeMap(inObj, fieldName);

		String rtnStr = "";
		for (String code : codes.split(",")) {
			rtnStr += "'" + code+ "',";
		}

		if (!"".equals(rtnStr)) {
			rtnStr = rtnStr.substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnStr;
	}

	/**
	 * 设置一个Session属性对象
	 * 
	 * @param request
	 * @param sessionName
	 * @return
	 */
	public static void setSessionAttribute(HttpServletRequest request,
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
	public static void removeSessionAttribute(HttpServletRequest request,
			String sessionKey) {
		HttpSession session = request.getSession();
		if (session != null)
			session.removeAttribute(sessionKey);
	}

	/**
	 * 获取Grid新增和编辑过的脏数据
	 * 
	 * @return
	 */
	public static List getGridDirtyData(HttpServletRequest request, String type) {
		List list = new ArrayList();
		String modifyRecs = request.getParameter(type);
		if (SysUtils.isEmpty(modifyRecs)) {
			return list;
		}
		modifyRecs = modifyRecs.substring(1, modifyRecs.length() - 1);
		String[] modifyDatas = modifyRecs.split("},");
		for (int i = 0; i < modifyDatas.length; i++) {
			if (i != modifyDatas.length - 1) {
				modifyDatas[i] += "}";
			}
			Dto dto = JsonHelper.parseSingleJson2Dto(modifyDatas[i]);
			list.add(dto);
		}
		return list;
	}

	/**
	 * 将请求参数封装为Dto
	 * 
	 * @param request
	 * @return
	 */
	public static Dto getPraramsAsDto(HttpServletRequest request) {
		Dto dto = new BaseDto();
		Map<String, String[]> map = request.getParameterMap();
		Iterator keyIterator = (Iterator) map.keySet().iterator();
		Map<String, String> keys = new HashMap<String, String>();
		String[] ks;

		String[] values = null;
		String value = "";
		Set<String> filSet = null;
		while (keyIterator.hasNext()) {
			value = "";
			values = null;
			String key = (String) keyIterator.next();
			if ("_dc".equals(key))
				continue;
			values = map.get(key);
			if (values.length == 1) {
				value = values[0];
			} else {
				filSet = new HashSet<String>();
				for (int i = 0; i < values.length; i++) {
					if (values[i] !=null && !"".equals(values[i])) {
						filSet.add(values[i]);
					}
				}
				for (String s : filSet) {
					value += s + ",";
				}
				value = value.substring(0, value.lastIndexOf(","));
			}

			key = key.replaceAll("-inputEl", "").replaceAll("qry_", "");
			ks = key.split("_");
			if (ks.length > 1) {
				keys.put(
						ks[0],
						value
								+ ","
								+ (keys.get(ks[0]) != null ? keys.get(ks[0])
										: ""));
			} else {
				dto.put(key, value);
			}
		}

		String tmpStr = "";
		String tmpKey = "";
		for (Iterator it = keys.keySet().iterator(); it.hasNext();) {
			tmpKey = (String) it.next();
			tmpStr = keys.get(tmpKey);
			tmpStr = tmpStr.substring(0, tmpStr.lastIndexOf(","));
			keys.put(tmpKey, tmpStr);
		}

		dto.putAll(keys);

		List modifyList = getGridDirtyData(request, "modifyRecs");
		if (!modifyList.isEmpty()) {
			dto.put(SysConstants.GRID_MODIFYED_REC, modifyList);
		}
		List delList = getGridDirtyData(request, "delRecs");
		if (!delList.isEmpty()) {
			dto.put(SysConstants.GRID_DELED_REC, delList);
		}

		List modifyList1 = getGridDirtyData(request, "modifyRecs1");
		if (!modifyList1.isEmpty()) {
			dto.put("modifyRecs1", modifyList1);
		}
		List delList1 = getGridDirtyData(request, "delRecs1");
		if (!delList1.isEmpty()) {
			dto.put("delRecs1", delList1);
		}


		return dto;
	}
	
	private static String convertUtf8(String s) {
		String rtnStr = null;
		byte[] tmp;
		try {
			tmp = s.getBytes("iso-8859-1");
			rtnStr = new String(tmp,"utf-8");
		} catch (Exception e) {
			
		}
		return rtnStr;
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
	public static String getCodeDesc(String pField, String pCode,
			HttpServletRequest request) {
		List codeList = (List) request.getSession().getServletContext()
				.getAttribute("EACODELIST");
		String codedesc = null;
		for (int i = 0; i < codeList.size(); i++) {
			Dto codeDto = (BaseDto) codeList.get(i);
			if (pField.equalsIgnoreCase(codeDto.getAsString("field"))
					&& pCode.equalsIgnoreCase(codeDto.getAsString("code")))
				codedesc = codeDto.getAsString("codedesc");
		}
		return codedesc;
	}

	/**
	 * 获取系统参数表
	 * 
	 * @param field
	 *            代码类别
	 * @param code
	 *            代码值
	 * @param request
	 * @return
	 */
	public static Map<String, String> getSysParamMap(HttpServletRequest request) {
		return (Map<String, String>) request.getSession().getServletContext()
				.getAttribute("PARAMMAP");

	}

	/**
	 * 根据代码类别获取代码表列表
	 * 
	 * @param codeType
	 * @param request
	 * @return
	 */
	public static List<ExtDic> getCodeListByField(String pField,
			HttpServletRequest request) {
		List<Eacode> codeList = (List<Eacode>) request.getSession()
				.getServletContext().getAttribute("EACODELIST");

		List<ExtDic> rtnList = new ArrayList<ExtDic>();
		ExtDic dic = null;
		for (Eacode code : codeList) {
			if (code.getField().equalsIgnoreCase(pField)) {
				dic = new ExtDic(code.getField(), code.getFieldname(),
						code.getCode(), code.getCodetype(), code.getCodedesc());
				rtnList.add(dic);
			}
		}
		return rtnList;
	}

	/**
	 * 获取全局参数值
	 * 
	 * @param pParamKey
	 *            参数键名
	 * @return
	 */
	public static String getParamValue(String pParamKey,
			HttpServletRequest request) {
		String paramValue = "";
		ServletContext context = request.getSession().getServletContext();
		if (SysUtils.isEmpty(context)) {
			return "";
		}
		List paramList = (List) context.getAttribute("PARAMLIST");
		for (int i = 0; i < paramList.size(); i++) {
			Dto paramDto = (BaseDto) paramList.get(i);
			if (pParamKey.equals(paramDto.getAsString("paramkey"))) {
				paramValue = paramDto.getAsString("paramvalue");
			}
		}
		return paramValue;
	}

	/**
	 * 获取全局参数
	 * 
	 * @return
	 */
	public static List getParamList(HttpServletRequest request) {
		ServletContext context = request.getSession().getServletContext();
		if (SysUtils.isEmpty(context)) {
			return new ArrayList();
		}
		return (List) context.getAttribute("EAPARAMLIST");
	}

	/**
	 * 获取指定Cookie的值
	 * 
	 * @param cookies
	 *            cookie集合
	 * @param cookieName
	 *            cookie名字
	 * @param defaultValue
	 *            缺省值
	 * @return
	 */
	public static String getCookieValue(Cookie[] cookies, String cookieName,
			String defaultValue) {
		if (cookies == null) {
			return defaultValue;
		}
		for (int i = 0; i < cookies.length; i++) {
			Cookie cookie = cookies[i];
			if (cookieName.equals(cookie.getName()))
				return (cookie.getValue());
		}
		return defaultValue;
	}

}

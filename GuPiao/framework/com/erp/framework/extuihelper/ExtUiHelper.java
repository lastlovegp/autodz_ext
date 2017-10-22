package com.erp.framework.extuihelper;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;

import com.base.common.ExtUiConstants;
import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;
import com.erp.framework.util.DataFormat;
import com.erp.framework.util.SessionContainer;
import com.erp.framework.util.WebUtils;

/**
 * 
 * @author Administrator
 * 
 */
public class ExtUiHelper {

	/**
	 * 按钮背景图片定义
	 */
	private static Map<String, String> btnIconClsMap = new HashMap<String, String>();

	private static Map<String, List<Field>> filedCacehMap = new HashMap<String, List<Field>>();

	private static PropertiesHelper pHelper = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.CFG);

	// 资源文件
	public static Map<String, ResourceBundle> resMap = new HashMap<String, ResourceBundle>();
	private static ResourceBundle msgRb = null;
	private static ResourceBundle errRb = null;

	public static final String BTN_LINK_LEFT = ",'-',";
	public static final String BTN_LINK_RIGHT = ",'->',";

	static {
		btnIconClsMap.put("save", "acceptIcon");
		btnIconClsMap.put("login", "acceptIcon");
		btnIconClsMap.put("sure", "acceptIcon");
		btnIconClsMap.put("mail", "rss_go");
		btnIconClsMap.put("createOrder", "acceptIcon");
		btnIconClsMap.put("custext", "page_excelIcon");
		btnIconClsMap.put("saveAdd", "page_addIcon");
		btnIconClsMap.put("add", "page_addIcon");
		btnIconClsMap.put("copy", "comments_addIcon");
		btnIconClsMap.put("del", "page_delIcon");
		btnIconClsMap.put("synData", "arrow_refreshIcon");
		btnIconClsMap.put("setBox", "acceptIcon");
		btnIconClsMap.put("custboxset", "acceptIcon");
		btnIconClsMap.put("reAssign", "page_edit_1Icon");
		btnIconClsMap.put("edit", "page_edit_1Icon");
		btnIconClsMap.put("query", "previewIcon");
		btnIconClsMap.put("getFromPage", "acceptIcon");
		btnIconClsMap.put("advQuery", "previewIcon");
		btnIconClsMap.put("refresh", "arrow_refreshIcon");
		btnIconClsMap.put("reset", "tbar_synchronizeIcon");
		btnIconClsMap.put("close", "deleteIcon");
		btnIconClsMap.put("sendMail", "rss_go");
		btnIconClsMap.put("export", "page_excelIcon");
		btnIconClsMap.put("upload", "uploadIcon");
		btnIconClsMap.put("uploadImage", "uploadIcon");
		btnIconClsMap.put("showImage", "uploadIcon");
		btnIconClsMap.put("readonly", "acceptIcon");
		btnIconClsMap.put("print", "printerIcon");
		btnIconClsMap.put("submit", "uploadIcon");
		btnIconClsMap.put("killSession", "page_delIcon");
		btnIconClsMap.put("toUrl", "acceptIcon");
		btnIconClsMap.put("toPrd", "uploadIcon");
		btnIconClsMap.put("epaySyn", "arrow_refreshIcon");
		btnIconClsMap.put("taobaoSyn", "arrow_refreshIcon");
		btnIconClsMap.put("prdList", "arrow_refreshIcon");
		btnIconClsMap.put("custTrace", "arrow_refreshIcon");
		btnIconClsMap.put("showCust", "arrow_refreshIcon");
		btnIconClsMap.put("chgPrdType", "acceptIcon");
		btnIconClsMap.put("detailImage", "acceptIcon");

		btnIconClsMap.put("addRow", "page_addIcon");
		btnIconClsMap.put("delRow", "page_delIcon");
		btnIconClsMap.put("total", "page_addIcon");
		btnIconClsMap.put("synchro", "arrow_refreshIcon");
		btnIconClsMap.put("selMenu", "acceptIcon");
		btnIconClsMap.put("import", "acceptIcon");
		btnIconClsMap.put("selRole", "acceptIcon");
		btnIconClsMap.put("selOperate", "acceptIcon");
		btnIconClsMap.put("nextrec", "app_rightIcon");
		btnIconClsMap.put("prerec", "app_leftIcon");
		btnIconClsMap.put("selectValue", "acceptIcon");

		// createWarrant,endToNextTerm

		btnIconClsMap.put("addParent", "page_addIcon");
		btnIconClsMap.put("addSub", "page_addIcon");
		btnIconClsMap.put("synDate", "arrow_refreshIcon");

		btnIconClsMap.put("stfEdit", "page_addIcon");

		btnIconClsMap.put("call", "control_play_blue");
		btnIconClsMap.put("callzj", "control_play_blue");
		btnIconClsMap.put("callClose", "disconnectIcon");
		btnIconClsMap.put("sendMsg", "message_editIcon");
		btnIconClsMap.put("send", "acceptIcon");

	}

	private static String getMsgText(String key) {
		String rString = "";
		if (msgRb == null)
			msgRb = resMap.get(ExtUiConstants.MESSAGE_RES);
		if (msgRb != null) {
			try {
				rString = msgRb.getString(key);
			} catch (Exception e) {
				rString = key;
			}
		}
		if (DataFormat.isEmpty(rString)) {
			rString = key;
		}

		return rString;
	}

	private static String getErrText(String key) {
		String rString = "";
		if (errRb == null)
			errRb = resMap.get(ExtUiConstants.ERRMSG_RES);
		if (errRb != null) {
			try {
				rString = errRb.getString(key);
			} catch (Exception e) {
				rString = key;
			}

		}
		if (DataFormat.isEmpty(rString)) {
			rString = key;
		}

		return rString;
	}

	/**
	 * @param entityClass
	 * @return
	 */
	public static Et getEt(Class<?> entityClass) {
		Et et = null;
		if (entityClass.isAnnotationPresent(Et.class)) {
			et = entityClass.getAnnotation(Et.class);
		} else {
		}
		return et;
	}

	/**
	 * 获取名字对
	 * 
	 * @param entityClass
	 * @return
	 */
	private static Map<String, Ef> getEfNameEfMap(Class<?> entityClass) {
		Field[] fields = entityClass.getDeclaredFields();
		Ef ef = null;
		Map map = new HashMap();
		for (Field f : fields) {
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);
				map.put(f.getName(), ef);
			}
		}
		return map;
	}

	/**
	 * 
	 * @param list
	 * @param sortType
	 *            f:按字段 g:按字段分组
	 */
	private static void sortFieldList(List<Field> list, String sortType,
			String uiType) {
		Ef ef = null;
		Map map = new HashMap();
		int i = 100;
		int j = 2000;
		for (Field f : list) {

			if (isBaseFilter(f.getName())) {
				continue;
			}

			i++;
			j++;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (ExtUiConstants.FLAG_ON.equals(ef.exclude())) {
					continue;
				}

				if ("g".equals(sortType)) {
					if (map.containsKey(ef.gseq())) {
						map.put(i, f);
					} else {
						map.put(ef.gseq() == 999 ? ef.fseq() : ef.gseq(), f);
					}
				} else {
					if ("hidden".equals(ef.xtype()) && "i".equals(uiType)) {
						map.put(j, f);
					} else {
						if (map.containsKey(ef.fseq())) {
							map.put(i, f);
						} else {
							map.put(ef.fseq(), f);
						}
					}

				}

			} else {
				map.put(i, f);
			}
		}

		List<Map.Entry<Integer, Field>> infoIds = new ArrayList<Map.Entry<Integer, Field>>(
				map.entrySet());

		Collections.sort(infoIds, new Comparator<Map.Entry<Integer, Field>>() {
			public int compare(Map.Entry<Integer, Field> o1,
					Map.Entry<Integer, Field> o2) {
				return (o1.getKey() - o2.getKey());
			}
		});

		list.clear();
		for (int f = 0; f < infoIds.size(); f++) {
			list.add(infoIds.get(f).getValue());
		}

	}

	/**
	 * 
	 * @param obj
	 * @return
	 */
	private static Map<Integer, Ef> getObjGroupFields(Object obj, ExtUiCfg cfg) {
		List<Field> fList = ReflectionUtils.getDeclaredField(obj);
		Ef ef = null;
		Map<Integer, Ef> rtnMap = new HashMap<Integer, Ef>();
		for (Field f : fList) {

			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (cfg != null && !StringUtils.isBlank(cfg.getHiddenItems())) {
					List<String> sList = Arrays.asList(cfg.getHiddenItems()
							.split(","));
					if (sList.contains(f.getName()))
						continue;
				}

				if (ef.groupIndex() > 0 && ef.gseq() == 1) {
					rtnMap.put(ef.groupIndex(), ef);
				}

			}

		}

		return rtnMap;
	}

	/**
	 * 列分组获取
	 * 
	 * @param obj
	 * @param cfg
	 * @return
	 */
	private static Map<String, List<Field>> getObjColumnGroupFields(Object obj,
			ExtUiCfg cfg) {
		List<Field> fList = ReflectionUtils.getDeclaredField(obj);
		return getObjColumnGroupFields(fList, cfg);
	}

	public static String getToolsStr(ExtUiCfg cfg) {
		if (cfg == null)
			return "";
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String ctr = ui_temple.getValue(ExtUiConstants.TOOLS_TEMPLE);
		String[] ts = cfg.tools.split(",");
		String tname = "";
		String rtnStr = "";
		String objName = "";
		for (String t : ts) {
			if ("refresh".equals(t)) {
				tname = "刷新";
			} else if ("help".equals(t)) {
				tname = "帮助";
			} else if ("search".equals(t)) {
				tname = "帮助";
			} else if ("expand".equals(t)) {
				tname = "展开";
			} else {
				tname = t;
			}
			objName = cfg.objName;
			if (StringUtils.isBlank(objName)) {
				objName = "unDefine";
			}
			rtnStr += ctr.replaceAll("#type#", t).replaceAll("#name#", objName)
					.replaceAll("#typename#", tname);
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(",") != -1) {
			rtnString = rtnStr.toString().substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnString;
	}

	private static Map<String, List<Field>> getObjColumnGroupFields(
			List<Field> fList, ExtUiCfg cfg) {
		Ef ef = null;
		Map<String, List<Field>> rtnMap = new HashMap<String, List<Field>>();
		for (Field f : fList) {

			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (cfg != null && !StringUtils.isBlank(cfg.getHiddenItems())) {

					List<String> sList = Arrays.asList(cfg.getHiddenItems()
							.split(","));
					if (sList.contains(f.getName()))
						continue;

				}

				if (!DataFormat.isEmpty(ef.columnGroup())) {
					if (rtnMap.containsKey(ef.columnGroup())) {
						rtnMap.get(ef.columnGroup()).add(f);
					} else {
						List<Field> efList = new ArrayList<Field>();
						efList.add(f);
						rtnMap.put(ef.columnGroup(), efList);
					}

				}

			}

		}

		return rtnMap;
	}

	/**
	 * 
	 * @param obj
	 * @param filters
	 * @return
	 */
	private static List<Field> getObjFields(Object obj, String[] filters,
			String uiType, String preStr, ExtUiCfg cfg) {
		List<Field> fList = null;
		Et et = getEt(obj.getClass());
		if (pHelper.getValue("runMode", "1").equals("1")) {
			if (filedCacehMap.containsKey(obj.getClass().getName())) {
				fList = filedCacehMap.get(obj.getClass().getName());
			} else {
				fList = ReflectionUtils.getDeclaredField(obj);
				if (et != null && et.isCache()) {
					filedCacehMap.put(obj.getClass().getName(), fList);
				}
			}
		} else {
			fList = ReflectionUtils.getDeclaredField(obj);
		}

		Ef ef = null;
		List<Field> rlist = new ArrayList<Field>();
		List filterList = new ArrayList();
		if (filters != null) {
			filterList = Arrays.asList(filters);
		}
		boolean isDyField = false;
		for (Field f : fList) {

			// 动态显示用
			isDyField = false;
			if (cfg != null && cfg.getDyShowItems().contains(f.getName())) {
				isDyField = true;
			}

			if (isBaseFilter(f.getName())) {
				continue;
			}

			if (filterList != null && !filterList.isEmpty()
					&& !filterList.contains(f.getName())) {
				continue;
			}

			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);
				if (ExtUiConstants.FLAG_ON.equals(ef.exclude())) {
					continue;
				}

				if ("i".equals(uiType) || "ci".equals(uiType)) {

					if (ExtXtype.XTYPE_ACTION_COLUMN.equals(ef.xtype())) {
						continue;
					}

					if (DataFormat.isEmpty(preStr) && ef.itemExclude()
							&& !isDyField) {
						continue;
					}
				}

				if ("c".equals(uiType)) {

					if (ef.colExclude() && !isDyField) {
						continue;
					}
				}

			}

			rlist.add(f);
		}

		return rlist;
	}

	/**
	 * 
	 * @param obj
	 * @return
	 */
	private static Map getSortFieldMap(Object obj) {
		List<Field> fList = ReflectionUtils.getDeclaredField(obj);
		Ef ef = null;
		Map map = new HashMap();
		int i = 100;
		for (Field f : fList) {

			if (isBaseFilter(f.getName())) {
				continue;
			}

			i++;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (ExtUiConstants.FLAG_ON.equals(ef.exclude())) {
					continue;
				}
				if (map.containsKey(ef.fseq())) {
					map.put(i, f);
				} else {
					map.put(ef.fseq(), f);
				}

			} else {
				map.put(i, f);
			}
		}

		return map;
	}

	/**
	 * 
	 * @param itype
	 * @param types
	 * @return
	 */
	public static boolean hasThisType(String itype, String types) {
		String[] ttypes = types.split(",");

		if (ttypes.length == 1) {
			if (itype.toLowerCase().toLowerCase()
					.indexOf(ttypes[0].toLowerCase()) != -1) {
				return true;
			}
		}

		for (int i = 0; i < ttypes.length; i++) {
			if (itype.toLowerCase().toLowerCase()
					.indexOf(ttypes[i].toLowerCase()) != -1) {
				return true;
			}
		}

		return false;
	}

	/**
	 * 无用字段过滤
	 * 
	 * @param fieldName
	 * @return
	 */
	private static boolean isBaseFilter(String fieldName) {
		if ("REF".equals(fieldName) || fieldName.indexOf("PROP_") != -1
				|| "serialVersionUID".equals(fieldName)
				|| "hashCode".equals(fieldName)) {
			return true;
		}

		return false;
	}

	private static String createStaticStr(String text) {
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String appendTmp = ui_temple.getValue(ExtUiConstants.APPEND_STR_TEMPLE);

		return appendTmp.replaceAll("#text#", text);
	}

	/**
	 * 按钮工具条生成
	 * 
	 * @param btns
	 * @param request
	 * @return
	 */
	public static String createBtnStr(String btns, String preStr,
			HttpServletRequest request) {
		if (DataFormat.isEmpty(btns))
			return "";

		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String btnTmp = ui_temple.getValue(ExtUiConstants.BTN_TEMPLE);
		List<String> btnList = Arrays.asList(btns.split(","));

		SessionContainer sContainer = (SessionContainer) request.getSession()
				.getAttribute(SysConstants.SESSION_KEY);

		String menuid = (String) request.getParameter("menuid");

		if (DataFormat.isEmpty(preStr))
			preStr = "";

		// {text:'#text#',id:'#id#'},
		StringBuilder rtnStr = new StringBuilder();
		String iconCls = "";
		String btnStr = "";
		boolean readonly = false;
		List scopeBtnsList = null;
		for (int i = 0; i < btnList.size(); i++) {
			btnStr = btnList.get(i);

			if ("->".equals(btnStr)) {
				rtnStr.append("'->',");
				continue;
			}

			iconCls = btnIconClsMap.get(btnStr);
			if (DataFormat.isEmpty(iconCls)) {
				iconCls = "";
			}
			rtnStr.append(btnTmp.replaceAll("#text#", getMsgText(btnStr))
					.replaceAll("#id#", "btn" + preStr + "_" + btnStr)
					.replaceAll("#iconCls#", iconCls)
					.replaceAll("#disabled#", String.valueOf(readonly)));
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(",'-',") != -1) {
			rtnString = rtnStr.toString().substring(0,
					rtnStr.lastIndexOf(",'-',"));
		}

		return rtnString;
	}

	/**
	 * 
	 * @param btns
	 * @param request
	 * @return
	 */
	private static String createGridPanelStr(Object obj, GridPanel gp,
			String colStr) {
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String gridpaneltmp = ui_temple
				.getValue(ExtUiConstants.GRIDPANEL_TEMPLE);

		StringBuilder rtnStr = new StringBuilder();
		Et et = getEt(obj.getClass());

		String tmpStr = gridpaneltmp
				.replaceAll("#store#", gp.store())
				.replaceAll("#height#", String.valueOf(gp.height()))
				.replaceAll("#width#", String.valueOf(gp.width()))
				.replaceAll("#title#", gp.title())
				.replaceAll("#id#", gp.id())
				.replaceAll("#rowNumberer#", gp.rowNumberer())
				.replaceAll("#actioncolumn#", gp.actioncolumn())
				.replaceAll("#beanName#", gp.beanName())
				.replaceAll("#gridSumParam#",
						gp.gridSumFlag() ? gp.gridSumParam() : "")
				.replaceAll("#groupingParam#",
						gp.groupingFlag() ? gp.groupingParam() : "")
				.replaceAll("#columns#", colStr);

		if (gp.cellEditFlag() && !DataFormat.isEmpty(gp.cellEditing())) {
			tmpStr = tmpStr.replaceAll("#cellEditParam#", gp.cellEditParam())
					.replaceAll("#cellEditing#", gp.cellEditing());
		} else {
			tmpStr = tmpStr.replaceAll("#cellEditParam#", "");
		}

		rtnStr.append(tmpStr);

		return rtnStr.toString();
	}

	/**
	 * 查询条件建立
	 * 
	 * @param object
	 * @param queryParam
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public static String getQueryItemStr(Object object, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {
		cfg.preQryName = "qry";
		String queryItemStr = ExtUiHelper.getCommExtUiStr(object, cfg.uiType,
				cfg, request);
		return queryItemStr;
	}

	/**
	 * 
	 * @param obj
	 * @return
	 */
	private static List<Field> getQryConditionList(Object obj, ExtUiCfg cfg) {
		// 从EF 定义中获取
		List<Field> fieldList = ReflectionUtils.getDeclaredField(obj);
		List<Field> rtnList = new ArrayList<Field>();
		Ef ef = null;
		for (Field f : fieldList) {
			ef = null;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);
				if (ef.qryFlag() && !ExtXtype.XTYPE_CMB_TREE.equals(ef.xtype())) {

					if (cfg == null) {
						rtnList.add(f);
					} else if (cfg != null
							&& !StringUtils.isBlank(cfg.getHiddenItems())) {
						List<String> sList = Arrays.asList(cfg.getHiddenItems()
								.split(","));
						if (!sList.contains(f.getName()))
							rtnList.add(f);

					}

				}
			}
		}

		return rtnList;
	}

	/**
	 * 
	 * @param obj
	 * @return
	 */
	public static String getQryConditionStr(Object obj, String preStr,
			ExtUiCfg cfg) {

		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String conditionTmp = ui_temple
				.getValue(ExtUiConstants.QRY_CONDITION_TEMPLE);
		List<Field> qList = getQryConditionList(obj, cfg);
		String tmpStr = preStr;
		if (DataFormat.isEmpty(tmpStr)) {
			tmpStr = "qry";
		}

		StringBuilder rtnStr = new StringBuilder();
		for (Field f : qList) {
			rtnStr.append(conditionTmp.replaceAll("#qryField#", f.getName())
					.replaceAll(
							"#qryValue#",
							"Ext.getCmp('" + tmpStr + "_" + f.getName()
									+ "').getValue()"));
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(",") != -1) {
			rtnString = rtnStr.toString().substring(0, rtnStr.lastIndexOf(","));
		}

		return rtnString;

	}

	public static String getQryConditionResetStr(Object obj, ExtUiCfg cfg) {

		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String conditionTmp = ui_temple
				.getValue(ExtUiConstants.QUERY_RESET_TEMPLE);
		List<Field> qList = getQryConditionList(obj, cfg);

		StringBuilder rtnStr = new StringBuilder();
		for (Field f : qList) {
			rtnStr.append(conditionTmp.replaceAll("#field#",
					"qry_" + f.getName()));
		}

		String rtnString = "";
		if (rtnStr.toString().indexOf(";") != -1) {
			rtnString = rtnStr.toString().substring(0, rtnStr.lastIndexOf(";"));
		}

		return rtnString;

	}

	/**
	 * 
	 * @param hql
	 * @param field
	 * @return
	 */
	private static String getQryFieldPreStr(StringBuilder hql, String field) {
		int index = hql.lastIndexOf("." + field);
		if (index == -1)
			return "po";
		int bi = index - 2;
		String string = hql.substring(bi, index);
		return string;
	}

	/**
	 * 
	 * @param obj
	 * @return
	 */
	public static String getQryResultStr(Object obj, String qryParams,
			StringBuilder hql, Dto inDto, List<String> excludeFields) {

		String qryFieldValue = "";
		String preStr = "po";

		List<Field> qList = null;
		if (obj != null) {
			qList = getQryConditionList(obj, null);
		}

		if (!StringUtils.isBlank(qryParams)) {
			if (qList == null || qList.isEmpty()) {
				qList = getFieldsByDefine(obj, qryParams, "");
			}
		}

		Ef ef = null;
		for (Field f : qList) {
			if (excludeFields != null && excludeFields.contains(f.getName())) {
				continue;
			}

			qryFieldValue = inDto.getAsString(f.getName());
			if (DataFormat.isEmpty(qryFieldValue)) {
				continue;
			}

			preStr = "po";
			ef = null;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);

				if (!DataFormat.isEmpty(qryFieldValue)) {
					hql.append(" and ").append(preStr).append(".")
							.append(f.getName()).append(" ")
							.append(ef.qryType());

					if (hasThisType(f.getType().getName(),
							"float,double,int,long,BigDecimal")) {
						hql.append(qryFieldValue);
					} else {

						if (hasThisType(f.getType().getName(), "date")) {
							qryFieldValue = DataFormat.dateToString(inDto
									.getAsDate(f.getName()));
						}

						if ("like".equals(ef.qryType())) {
							hql.append(" '%").append(qryFieldValue)
									.append("%'");
						} else {
							hql.append("'").append(qryFieldValue).append("'");
						}
					}
				}
			} else {
				if (!DataFormat.isEmpty(qryFieldValue)) {
					hql.append(" and ").append(preStr).append(".")
							.append(f.getName()).append("=");

					if (hasThisType(f.getType().getName(),
							"float,double,int,long,BigDecimal")) {
						hql.append(qryFieldValue);
					} else {

						if (hasThisType(f.getType().getName(), "date")) {
							qryFieldValue = DataFormat.dateToString(inDto
									.getAsDate(f.getName()));
						}
						hql.append("'").append(qryFieldValue).append("'");
					}
				}
			}

		}

		return hql.toString();
	}

	/**
	 * 简单查询条件
	 * 
	 * @param enableEvent
	 * @param emptyText
	 * @param request
	 * @return
	 */
	public static String getSimpleQueryItemStr(boolean enableEvent,
			String emptyText, HttpServletRequest request) {

		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String queryTmp = ui_temple.getValue(ExtUiConstants.QUERY_PARAM_TEMPLE);
		queryTmp = queryTmp.replaceAll("#emptyText#", emptyText);
		if (enableEvent) {
			String eventStr = ui_temple.getValue(
					ExtUiConstants.KEY_EVENTS_TEMPLE).replaceAll("#method#",
					"querySimpleParam()");
			queryTmp = strAppend(queryTmp, eventStr + "})", "})");
		}

		return queryTmp;
	}

	/**
	 * 数据字典项获取
	 * 
	 * @param obj
	 * @param preStr
	 * @param cfg
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public static String getCodeDescStr(List<Object> objList,
			HttpServletRequest request, ExtUiCfg cfg) {
		Ef ef = null;
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String codeTran = ui_temple
				.getValue(ExtUiConstants.CODE_DESC_TRANS_TEMPLE);
		String codeDesc = ui_temple.getValue(ExtUiConstants.CODE_DESC_TEMPLE);

		StringBuilder codeTranStr = new StringBuilder();
		StringBuilder codeDescStr = new StringBuilder();
		Set dicSet = new HashSet();
		String dicCode = "";
		for (Object obj : objList) {
			List<Field> fList = ReflectionUtils.getDeclaredField(obj);
			for (Field f : fList) {
				codeTranStr.delete(0, codeTranStr.length());
				dicCode = "";
				ef = null;
				if (f.isAnnotationPresent(Ef.class)) {
					ef = f.getAnnotation(Ef.class);
					dicCode = ef.dicCode();
					if (!DataFormat.isEmpty(dicCode)) {
						if (cfg.getCodeMap().get(dicCode) != null) {
							dicCode = cfg.getCodeMap().get(dicCode);
						}
					}
					if (ExtXtype.XTYPE_CMB_DIC.equals(ef.xtype())) {
						if (!DataFormat.isEmpty(dicCode)) {
							if (dicSet.contains(dicCode)) {
								continue;
							}

							List<ExtDic> dicList = WebUtils.getCodeListByField(
									dicCode, request);
							for (ExtDic dic : dicList) {
								codeTranStr.append(codeDesc.replaceAll(
										"#code#", dic.getCode()).replaceAll(
										"#codedesc#", dic.getCodedesc()));
							}
							codeDescStr.append(codeTran.replaceAll("#field#",
									dicCode).replaceAll("#codeDesc#",
									codeTranStr.toString()));
							dicSet.add(dicCode);
						} else if (!DataFormat.isEmpty(ef.dicDefine())) {

							if (dicSet.contains(f.getName())) {
								continue;
							}

							String[] data0 = ef.dicDefine().split(";");
							String[] data2;
							for (int i = 0; i < data0.length; i++) {
								data2 = data0[i].split(":");
								codeTranStr.append(codeDesc.replaceAll(
										"#code#", data2[0]).replaceAll(
										"#codedesc#", data2[1]));
							}

							codeDescStr.append(codeTran.replaceAll("#field#",
									f.getName()).replaceAll("#codeDesc#",
									codeTranStr.toString()));

							dicSet.add(f.getName());
						}

					}
				}

			}
		}

		return codeDescStr.toString();
	}

	/**
	 * 
	 * @param obj
	 * @param preStr
	 * @param cfg
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getFieldStr(Object obj, String preStr,
			String[] filters, ExtUiCfg cfg) throws InstantiationException,
			IllegalAccessException {
		Ef ef = null;
		Et et = getEt(obj.getClass());
		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String ftr = ui_temple.getValue(ExtUiConstants.FIELD_TEMPLTE);
		if (cfg.isGetGridNewRowFlag()) {
			ftr = ui_temple.getValue(ExtUiConstants.GRID_NEW_ROW_TEMPLE);
		}

		String isSubBean = "";
		String fieldStr = "";
		String fname = "";
		String mapName = "";
		String showFields = "";
		String fPreStr = DataFormat.trim(preStr);

		List filterList = new ArrayList();
		if (filters != null) {
			filterList = Arrays.asList(filters);
		}

		List<Field> fList = ReflectionUtils.getDeclaredField(obj);
		for (Field f : fList) {

			if (isBaseFilter(f.getName())) {
				continue;
			}

			if (!filterList.isEmpty() && !filterList.contains(f.getName())) {
				continue;
			}

			isSubBean = "";
			fieldStr = "";
			showFields = "";
			fname = f.getName();
			mapName = "".equals(fPreStr) ? f.getName() : fPreStr + "."
					+ f.getName();

			ef = null;
			if (f.isAnnotationPresent(Ef.class)) {
				ef = f.getAnnotation(Ef.class);
				if (ExtUiConstants.FLAG_ON.equals(ef.exclude())) {
					continue;
				}
				if (ExtXtype.XTYPE_FILE_FIELD.equals(ef.xtype())) {
					continue;
				}

				isSubBean = ef.isSubBean();
				showFields = ef.showFields();

				if (!cfg.isGetGridNewRowFlag()
						&& ExtUiConstants.FLAG_ON.equals(isSubBean)) {
					if ("all".equals(showFields)) {
						fieldStr = getFieldStr(f.getType().newInstance(),
								f.getName(), null, cfg)
								+ ",";
					} else {
						String[] filteStrings = showFields.split(",");
						fieldStr = getFieldStr(f.getType().newInstance(),
								f.getName(), filteStrings, cfg)
								+ ",";
					}

				}
			}

			if (DataFormat.isEmpty(fieldStr)) {
				if (hasThisType(f.getType().getName(), "int,long")) {

					if (cfg.isGetGridNewRowFlag()) {
						fieldStr = ftr.replaceAll("#fieldName#", f.getName())
								.replaceAll("#value#", "0");
					} else {
						fieldStr = ftr.replaceAll("#name#", f.getName())
								.replaceAll("#type#", "int")
								.replaceAll("#dateFormat#", "");
					}
				} else if (hasThisType(f.getType().getName(),
						"float,double,BigDecimal")) {

					if (cfg.isGetGridNewRowFlag()) {
						fieldStr = ftr.replaceAll("#fieldName#", f.getName())
								.replaceAll("#value#", "0.0");
					} else {
						fieldStr = ftr.replaceAll("#name#", f.getName())
								.replaceAll("#type#", "float")
								.replaceAll("#dateFormat#", "");
					}
				} else if (hasThisType(f.getType().getName(), "date,Timestamp")) {
					if (cfg.isGetGridNewRowFlag()) {
						fieldStr = ftr.replaceAll("#fieldName#", f.getName())
								.replaceAll("#value#",
										"Ext.Date.clearTime(new Date())");
					} else {
						fieldStr = ftr.replaceAll("#name#", f.getName())
								.replaceAll("#type#", "date")
								.replaceAll("#dateFormat#", "Y-m-d H:i:s");
					}
				} else if (hasThisType(f.getType().getName(), "boolean")) {
					if (cfg.isGetGridNewRowFlag()) {
						fieldStr = ftr.replaceAll("#fieldName#", f.getName())
								.replaceAll("#value#", "false");
					} else {
						fieldStr = ftr.replaceAll("#name#", f.getName())
								.replaceAll("#type#", "bool")
								.replaceAll("#dateFormat#", "");
					}
				} else {
					if (cfg.isGetGridNewRowFlag()) {
						fieldStr = ftr.replaceAll("#fieldName#", f.getName())
								.replaceAll(
										"#value#",
										ef != null ? "'" + ef.defValue() + "'"
												: "''");
					} else {
						fieldStr = ftr.replaceAll("#name#", f.getName())
								.replaceAll("#type#", "string")
								.replaceAll("#dateFormat#", "");
					}
				}

				fieldStr = fieldStr.replaceAll("#mapping#", mapName);
			}

			fStr.append(fieldStr);

		}

		String rtnString = "";
		if (fStr.toString().indexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		if (cfg.isGetGridNewRowFlag()) {
			String newModeObj = ui_temple
					.getValue(ExtUiConstants.MODE_NEW_ROW_TEMPLE);
			String beanName = obj.getClass().getSimpleName();
			if (et != null) {
				beanName = et.beanName();
			}
			rtnString = newModeObj.replaceAll("#modeName#", beanName + "Model")
					.replaceAll("#newItem#", rtnString);
		}

		return rtnString;
	}

	/**
	 * 
	 * @param fields
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public static String createRowExpandStr(String fields)
			throws InstantiationException, IllegalAccessException {
		Ef ef = null;
		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String rowExpandStr = ui_temple
				.getValue(ExtUiConstants.ROW_EXPANDER_TEMPLE);

		String[] strs = fields.split(",");

		for (int i = 0; i < strs.length; i++) {
			fStr.append(rowExpandStr.replaceAll("#namestr#",
					getMsgText(strs[i])).replaceAll("#name#", strs[i]));
		}

		String rtnString = "";
		if (fStr.toString().indexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		return rtnString;
	}

	/**
	 * 
	 * @param fType
	 * @return
	 */
	private static String getXtype(String fType) {
		String rtnType = "textfield";
		if (hasThisType(fType, "string")) {
			rtnType = "textfield";
		} else if (hasThisType(fType, "int,long,BigDecimal,float,double")) {
			rtnType = "numberfield";
		} else if (hasThisType(fType, "date")) {
			rtnType = "datefield";
		} else if (hasThisType(fType, "timestamp")) {
			rtnType = "datetimefield";
		} else if (hasThisType(fType, "boolean")) {
			rtnType = "checkbox";
		} else {
			rtnType = "textfield";
		}
		return rtnType;
	}

	/**
	 * ext column, items 字符串生成
	 * 
	 * @param obj
	 * @param uiType
	 * @param cfg
	 * @param request
	 * @return
	 */
	public static String getCommExtUiStr(Object obj, String uiType,
			ExtUiCfg cfg, HttpServletRequest request) {
		String rtnString = "";
		try {
			if ("f".equals(uiType)) {
				rtnString = getFieldStr(obj, "", null, cfg);
			} else if ("c".equals(uiType)) {
				rtnString = getSortColumnStr(obj, null, cfg, request);
			} else if ("i".equals(uiType)) {
				rtnString = getItemStr(obj, cfg, request);
			} else if ("qi".equals(uiType)) {
				rtnString = getItemForQryFlag(obj, cfg, request);
			} else if ("ci".equals(uiType)) {
				rtnString = getItemStrByConType(cfg.mc,
						createContainerItemStr(obj, cfg, request), cfg, request);
			} else if ("si".equals(uiType)) {
				rtnString = getSimpleItemStr(obj, cfg, request);
			}

		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (!StringUtils.isBlank(rtnString)
				&& ",".equals(rtnString.substring(rtnString.length() - 1,
						rtnString.length()))) {
			rtnString = rtnString.substring(0, rtnString.lastIndexOf(","));
		}

		return rtnString;

	}

	/**
	 * table tpl 生成
	 * 
	 * @param list
	 * @param cfg
	 * @param req
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getViewTpl(List<Field> list, ExtUiCfg cfg,
			HttpServletRequest req) throws InstantiationException,
			IllegalAccessException {

		if (cfg == null)
			cfg = new ExtUiCfg();

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String tr = ui_temple.getValue(ExtUiConstants.VIEW_TR_TEMPLE);
		String td = ui_temple.getValue(ExtUiConstants.VIEW_TD_TEMPLE);

		// 排序
		sortFieldList(list, "f", "c");

		String trStr = "";
		String tdStr = "";
		Ef ef = null;
		int cnt = 0;
		String dicCode = "";
		String tpl = "";
		for (Field f : list) {
			ef = f.getAnnotation(Ef.class);
			if (ef != null) {
				dicCode = ef.dicCode();
			}

			tpl = f.getName();
			if (hasThisType(f.getType().getName(), "date")) {
				tpl += ":date";
			}

			if (!DataFormat.isEmpty(dicCode)) {
				tpl = "[" + dicCode + "CodeTrans(values." + f.getName() + ")]";
			}

			if (cfg.viewColumns == 1) {
				tdStr = td.replaceAll("#label#", getMsgText(f.getName()))
						.replaceAll("#name#", tpl);
			} else if (cfg.viewColumns > 1) {
				cnt++;
				tdStr += td.replaceAll("#label#", getMsgText(f.getName()))
						.replaceAll("#name#", tpl);
				if (cnt < cfg.viewColumns) {
					continue;
				}

			}

			trStr = tr.replaceAll("#td#", tdStr);
			tdStr = "";
			cnt = 0;
			fStr.append(trStr);
		}

		if (cnt > 0) {
			trStr = tr.replaceAll("#td#", tdStr);
			tdStr = "";
			cnt = 0;
			fStr.append(trStr);
		}

		return fStr.toString();

	}

	/**
	 * 模板生成
	 * 
	 * @param obj
	 * @param cfg
	 * @param req
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public static String getViewTpl(Object obj, ExtUiCfg cfg,
			HttpServletRequest req) throws InstantiationException,
			IllegalAccessException {

		List<Field> list = getObjFields(obj, null, "i", "", cfg);

		return getViewTpl(list, cfg, req);
	}

	/**
	 * grid 列生成
	 * 
	 * @param list
	 * @param filters
	 * @param cfg
	 * @param req
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getSortColumnStrByList(List<Field> list,
			Map<String, List<Field>> groupMap, boolean careGroup,
			String[] filters, ExtUiCfg cfg, HttpServletRequest req)
			throws InstantiationException, IllegalAccessException {

		if (cfg == null)
			cfg = new ExtUiCfg();
		Ef ef = null;
		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String ctr = ui_temple.getValue(ExtUiConstants.COLUMN_TEMPLTE);
		if (cfg.isCellCanEdit()) {
			ctr = ui_temple.getValue(ExtUiConstants.COLUMN_EDIT_TEMPLTE);
		}

		String ctitem = ui_temple
				.getValue(ExtUiConstants.COLUMN_EDIT_ITEM_TEMPLTE);

		// 排序
		sortFieldList(list, "f", "c");

		String id = "";
		int flex = 0;
		boolean sortable = true;
		String renderer = "";
		String format = "";
		int width = 100;
		int fseqno = 0;
		String colStr = "";
		boolean hidden = false;
		boolean colExclude = false;
		boolean readOnly = false;
		boolean locked = false;
		String text = "";
		String columnGroup = "";
		String isSubBean = "";
		String showFields = "";
		boolean allowBlank = true;
		String summaryType = "";
		String summaryRenderer = "";
		String xtype = "";
		String dicCode = "";
		List filterList = new ArrayList();
		if (filters != null) {
			filterList = Arrays.asList(filters);
		} else {
			if (cfg != null) {
				if (!StringUtils.isBlank(cfg.getShowItems())) {
					filterList.addAll(Arrays.asList(cfg.getShowItems().split(
							",")));
				}
			} else {
				filterList = null;
			}
		}

		Field tf = null;
		List<String> cGroupCheckList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {

			flex = 0;
			sortable = true;
			dicCode = "";
			renderer = "";
			format = "";
			columnGroup = "";
			allowBlank = true;
			xtype = "";
			width = 100;
			fseqno = 0;
			hidden = false;
			locked = false;
			colExclude = false;
			readOnly = false;
			colStr = "";
			text = "";
			isSubBean = "";
			showFields = "";
			summaryType = "";
			summaryRenderer = "";
			tf = list.get(i);

			if (isBaseFilter(tf.getName())) {
				continue;
			}

			// 动态过滤
			if (filterList != null && !filterList.isEmpty()
					&& !filterList.contains(tf.getName())) {
				continue;
			}

			if (cfg != null && !StringUtils.isBlank(cfg.getHiddenItems())) {
				List<String> sList = Arrays.asList(cfg.getHiddenItems().split(
						","));
				if (sList.contains(tf.getName()))
					continue;

			}

			ef = tf.getAnnotation(Ef.class);

			if (ef != null) {
				columnGroup = ef.columnGroup();
				// 列分组用
				if (careGroup && !DataFormat.isEmpty(columnGroup)) {
					List<Field> gList = groupMap.get(columnGroup);
					if (!cGroupCheckList.contains(columnGroup)) {
						String tmpString = getSortColumnStrByList(gList,
								groupMap, false, filters, cfg, req);
						String cGroupTmp = ui_temple
								.getValue(ExtUiConstants.COLUMNGROUP_TEMPLE);
						colStr = cGroupTmp.replaceAll("#columnGroup#",
								columnGroup).replaceAll("#columns#", tmpString);
						fStr.append(colStr);
						cGroupCheckList.add(columnGroup);
					}
					continue;
				}

				flex = ef.flex();
				id = ef.id();
				sortable = ef.sortable();
				renderer = ef.renderer();
				text = ef.text();
				locked = ef.locked();
				format = ef.format();
				dicCode = ef.dicCode();
				if (!DataFormat.isEmpty(dicCode)) {
					if (cfg.getCodeMap().get(dicCode) != null) {
						dicCode = cfg.getCodeMap().get(dicCode);
					}
				}
				width = ef.width();
				readOnly = ef.readOnly();
				summaryType = ef.summaryType();
				summaryRenderer = ef.summaryRenderer();
				if (readOnly) {
					ctr = ui_temple.getValue(ExtUiConstants.COLUMN_TEMPLTE);
				} else if (cfg.isCellCanEdit()) {
					ctr = ui_temple
							.getValue(ExtUiConstants.COLUMN_EDIT_TEMPLTE);
				}

				colExclude = ef.colExclude();

				// 动态显示用
				if (cfg != null && cfg.getDyShowItems().contains(tf.getName())) {
					colExclude = false;
				}

				// 列过滤
				if (colExclude) {
					continue;
				}

				if (ExtXtype.XTYPE_FILE_FIELD.equals(ef.xtype())) {
					continue;
				}
				fseqno = ef.fseq();
				xtype = ef.xtype();
				allowBlank = ef.allowBlank();

				// 字典转换
				if (ExtXtype.XTYPE_CMB_DIC.equals(xtype)) {
					if (!DataFormat.isEmpty(dicCode)) {
						renderer = dicCode + "CodeTrans";
					} else if (!DataFormat.isEmpty(ef.dicDefine())) {
						renderer = tf.getName() + "CodeTrans";
					}
				}

				// treeGrid 特殊字段用
				if ("treecolumn".equals(xtype)) {
					if (cfg == null) {
						xtype = "";
					} else if (!cfg.isTreeGrid()) {
						xtype = "";
					}
				}

				hidden = ef.hidden();

				isSubBean = ef.isSubBean();
				showFields = ef.showFields();

				// 递归子对象字段
				if (ExtUiConstants.FLAG_ON.equals(isSubBean)) {
					if ("all".equals(showFields)) {
						colStr = getSortColumnStr(tf.getType().newInstance(),
								null, cfg, req) + ",";
					} else {
						String[] filteStrings = showFields.split(",");
						colStr = getSortColumnStr(tf.getType().newInstance(),
								filteStrings, cfg, req) + ",";
					}
				}

			}

			if (hasThisType(tf.getType().getName(),
					"int,long,BigDecimal,float,double")) {
				width = 60;
			}

			// 动态显示用
			if (cfg != null && cfg.getDyShowItems().contains(tf.getName())) {
				hidden = false;
			}

			// 控制只读
			if (cfg.getReadOnlyItems().contains(tf.getName())) {
				ctr = ui_temple.getValue(ExtUiConstants.COLUMN_TEMPLTE);
				readOnly = true;
			} else if (cfg.isCellCanEdit() && !readOnly) {
				ctr = ui_temple.getValue(ExtUiConstants.COLUMN_EDIT_TEMPLTE);
			}

			/**
			 * 设置默认是
			 */
			if (DataFormat.isEmpty(renderer)) {
				renderer = "''";
			}

			if (DataFormat.isEmpty(id)) {
				id = tf.getName();
			}

			if (DataFormat.isEmpty(text)) {
				text = tf.getName();
			}

			if (DataFormat.isEmpty(colStr)) {
				// 不可编辑行
				if (!cfg.isCellCanEdit() || readOnly) {
					if (hasThisType(tf.getType().getName(), "date")) {
						renderer = "Ext.util.Format.dateRenderer('Y-m-d')";
					}

					if (hasThisType(tf.getType().getName(), "Timestamp")) {
						renderer = "Ext.util.Format.dateRenderer('Y-m-d H:i:s')";
					}

					colStr = ctr.replaceAll("#renderer#", renderer)
							.replaceAll("#text#", getMsgText(text))
							.replaceAll("#sortable#", String.valueOf(sortable))
							.replaceAll("#hidden#", String.valueOf(hidden))
							.replaceAll("#dataIndex#", tf.getName())
							.replaceAll("#width#", String.valueOf(width));

					// treeGrid 用
					if ("treecolumn".equals(xtype)) {
						colStr = strAppend(colStr, ",xtype: 'treecolumn'},",
								"},");
					}

					/**
					 * 表格合计
					 */
					if (!DataFormat.isEmpty(summaryType)) {
						if (!ef.isCustSummaryType()) {
							colStr = strAppend(colStr, ",summaryType: '"
									+ summaryType + "'},", "},");
						} else {
							colStr = strAppend(colStr, ",summaryType: "
									+ summaryType + "},", "},");
						}

					}
					if (!DataFormat.isEmpty(summaryRenderer)) {
						colStr = strAppend(colStr, ",summaryRenderer: "
								+ summaryRenderer + "},", "},");
					}
					// 列锁定
					if (locked) {
						colStr = strAppend(colStr, ",locked:true},", "},");
					}

					if (ExtXtype.XTYPE_ACTION_COLUMN.equals(xtype)) {
						String at = ui_temple
								.getValue(ExtUiConstants.ACTION_TEMPLE);
						String ai = ui_temple
								.getValue(ExtUiConstants.ACTION_ICON_TEMPLE);
						String ac = ui_temple
								.getValue(ExtUiConstants.ACTION_GETCLASS_TEMPLE);
						if ("i".equals(ef.actionType())) {
							String aai = ai.replaceAll("#icon#", ef.icon())
									.replaceAll("#tooltip#", ef.tooltip())
									.replaceAll("#actionName#", tf.getName());
							at = at.replaceAll("#items#", aai);
						} else if ("c".equals(ef.actionType())) {
							String aac = ac.replaceAll("#actionName#",
									tf.getName());
							at = at.replaceAll("#items#", aac);
						}

						colStr = at;
					}

				} else {
					xtype = DataFormat.isEmpty(xtype) ? getXtype(tf.getType()
							.getName()) : xtype;

					if ("datefield".equals(xtype)) {
						renderer = "Ext.util.Format.dateRenderer('Y-m-d')";
						format = "Y-m-d";
					} else if ("datetimefield".equals(xtype)) {
						xtype = "datefield";
						renderer = "Ext.util.Format.dateRenderer(Y-m-d H:i:s')";
						format = "Y-m-d ";
					}

					colStr = ctr.replaceAll("#hidden#", String.valueOf(hidden))
							.replaceAll("#header#", getMsgText(text))
							.replaceAll("#renderer#", renderer)
							.replaceAll("#dataIndex#", tf.getName());

					/**
					 * 表格合计
					 */
					if (!DataFormat.isEmpty(summaryType)) {
						colStr = strAppend(colStr, ",summaryType: '"
								+ summaryType + "'},", "},");
					}
					if (!DataFormat.isEmpty(summaryRenderer)) {
						colStr = strAppend(colStr, ",summaryRenderer: "
								+ summaryRenderer + "},", "},");
					}

					if (width != 0) {
						colStr = strAppend(colStr,
								",width: " + String.valueOf(width) + "},", "},");
					}

					// 列锁定
					if (locked) {
						colStr = strAppend(colStr, ",locked:true},", "},");
					}

					// 数据字典处理
					if (ExtXtype.XTYPE_CMB_DIC.equals(xtype)
							|| ExtXtype.XTYPE_CMB_REMORT.equals(xtype)
							|| ExtXtype.XTYPE_CMB_GRID.equals(xtype)) {
						List<Field> dicList = new ArrayList<Field>();
						dicList.add(tf);
						String citemString = convertItemStr(dicList, null,
								false, cfg, req);
						colStr = colStr.replaceAll("#editor#", citemString);

					} else {
						String citemString = ctitem
								.replaceAll("#xtype#", xtype)
								.replaceAll("#allowBlank#",
										String.valueOf(allowBlank))
								.replaceAll("#format#", format);

						if (ef != null && !DataFormat.isEmpty(ef.minValue())) {
							citemString = strAppend(citemString, ",minValue:"
									+ ef.minValue() + "}", "}");
						}

						if (ef != null && !DataFormat.isEmpty(ef.maxValue())) {
							citemString = strAppend(citemString, ",maxValue:"
									+ ef.maxValue() + "}", "}");
						}

						if (ef != null && !DataFormat.isEmpty(ef.defValue())) {
							citemString = strAppend(citemString,
									",value:" + ef.defValue() + "}", "}");
						}

						colStr = colStr.replaceAll("#editor#", citemString);

					}

				}

			}

			fStr.append(colStr);

		}

		String rtnString = "";
		if (fStr.toString().indexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		return rtnString;

	}

	/**
	 * 列生成
	 * 
	 * @param object
	 * @param filters
	 * @param cfg
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getSortColumnStr(Object object, String[] filters,
			ExtUiCfg cfg, HttpServletRequest req)
			throws InstantiationException, IllegalAccessException {

		List<Field> list = getObjFields(object, null, "c", "", cfg);

		Map<String, List<Field>> groupMap = getObjColumnGroupFields(list, cfg);

		return getSortColumnStrByList(list, groupMap, true, filters, cfg, req);

	}

	private static String strAppend(String oldStr, String addStr, String preStr) {
		if (oldStr.indexOf(preStr) == -1) {
			return oldStr;
		}

		if (DataFormat.isEmpty(preStr)) {
			preStr = "},";
		}
		String rtnstr = oldStr.substring(0, oldStr.lastIndexOf(preStr));
		rtnstr += addStr;
		return rtnstr;
	}

	/**
	 * item 分组
	 * 
	 * @param fList
	 * @return
	 */
	private static Map<Integer, List<Field>> groupAllField(List<Field> fList,
			ExtUiCfg cfg) {
		// 分组，隐藏自动分一组
		Map<Integer, List<Field>> gMap = new LinkedHashMap<Integer, List<Field>>();
		Ef ef = null;
		List<Field> l = null;
		int total = 0;
		Map<Integer, Integer> nMap = new HashMap<Integer, Integer>();
		boolean isDyField = false;
		int groupItemNum = 0;
		for (Field f : fList) {
			isDyField = false;
			groupItemNum = 0;
			// 动态显示用
			if (cfg != null && cfg.getDyShowItems().contains(f.getName())) {
				isDyField = true;
			}

			ef = f.getAnnotation(Ef.class);
			if (ef != null) {
				groupItemNum = ef.groupItemNum();

				if (cfg.getGroupItemNumMap().containsKey(f.getName())) {
					groupItemNum = cfg.getGroupItemNumMap().get(f.getName());
				}

				if (ef.gseq() == 1 && groupItemNum != 0)
					nMap.put(ef.groupIndex(), groupItemNum);

				if (ef.xtype().equals("hidden") && !isDyField) {
					if (gMap.get(9999) == null) {
						l = new ArrayList<Field>();
						l.add(f);
						gMap.put(9999, l);
					} else {
						l = gMap.get(9999);
						l.add(f);
						gMap.put(9999, l);
					}
				} else {
					if (ef.groupIndex() != 0) {
						if (gMap.get(ef.groupIndex()) == null) {
							l = new ArrayList<Field>();
							l.add(f);
							gMap.put(ef.groupIndex(), l);
						} else {
							l = gMap.get(ef.groupIndex());
							l.add(f);
							gMap.put(ef.groupIndex(), l);
						}
					} else {
						if (gMap.get(98) == null) {
							l = new ArrayList<Field>();
							l.add(f);
							gMap.put(98, l);
						} else {
							l = gMap.get(98);
							l.add(f);
							gMap.put(98, l);
						}
					}
					total++;
				}
			} else {
				if (gMap.get(98) == null) {
					l = new ArrayList<Field>();
					l.add(f);
					gMap.put(98, l);
				} else {
					l = gMap.get(98);
					l.add(f);
					gMap.put(98, l);
				}
				total++;
			}
		}

		int gcnt = gMap.size();
		if (gMap.get(98) != null) {
			gcnt = gcnt - 1;
		}

		if (gMap.get(9999) != null) {
			gcnt = gcnt - 1;
		}

		if (gcnt <= 0)
			gcnt = 1;

		if (gcnt == 1) {
			// return null;
		}

		int perGcnt = total / gcnt;
		List checkList = new ArrayList();
		List<Field> groupList = gMap.get(98);
		int gindex = 0;
		int addCnt = 0;
		int pgCnt = 0;
		for (Iterator it = gMap.keySet().iterator(); it.hasNext();) {
			gindex = (Integer) it.next();
			if (gindex == 98 || gindex == 9999)
				continue;

			pgCnt++;
			if (groupList == null) {
				continue;
			}
			for (Field f : groupList) {

				if (checkList.contains(f.getName())) {
					continue;
				}

				if (nMap.get(gindex) != null && nMap.get(gindex) != 0
						&& gMap.get(gindex).size() == nMap.get(gindex)) {
					break;
				} else {

					if (nMap.get(gindex) != null && nMap.get(gindex) != 0
							&& gMap.get(gindex).size() < nMap.get(gindex)) {
						perGcnt = nMap.get(gindex);
					}

					if (pgCnt < gcnt) {
						if (gMap.get(gindex).size() == perGcnt
								|| gMap.get(98).size() == addCnt) {
							break;
						}
					} else {
						if (gMap.get(98).size() == addCnt) {
							break;
						}
					}

				}

				if (!gMap.get(gindex).contains(f)) {
					gMap.get(gindex).add(f);
					checkList.add(f.getName());
					addCnt++;
				}

			}
		}

		gMap.remove(98);

		// 排序
		return gMap;
	}

	/**
	 * 字典列表
	 * 
	 * @param list
	 * @param dicTemple
	 * @return
	 */
	private static String createDicData(List<ExtDic> list, String dicTemple) {
		StringBuffer fStr = new StringBuffer();
		for (ExtDic dic : list) {
			fStr.append(dicTemple.replaceAll("#code#", dic.getCode())
					.replaceAll("#codedesc#", dic.getCodedesc())
					.replaceAll("#codetype#", dic.getCodetype()));
		}
		String rtnString = "";
		if (fStr.toString().lastIndexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}
		return rtnString;
	}

	/**
	 * 
	 * @param defineDicStr
	 *            ag: 2:aa;3:cc
	 * @param dicTemple
	 * @return code: '#code#', codedesc: '#codedesc#'
	 */
	private static String createDicData(String defineDicStr, String dicTemple) {
		StringBuffer fStr = new StringBuffer();
		String[] data0 = defineDicStr.split(";");
		String[] data2;
		for (int i = 0; i < data0.length; i++) {
			data2 = data0[i].split(":");
			fStr.append(dicTemple.replaceAll("#code#", data2[0])
					.replaceAll("#codetype#", "")
					.replaceAll("#codedesc#", data2[1]));
		}

		String rtnString = "";
		if (fStr.toString().lastIndexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}
		return rtnString;
	}

	/**
	 * 字典下拉字符串
	 * 
	 * @param list
	 * @param dicTemple
	 * @return
	 */
	private static String createDicCmpStr(String dicData, Field tf,
			String dicCmpTemple, Ef ef, ExtUiCfg cfg) {
		int width = ef.itemWidth();
		if (cfg != null && width == 0) {
			width = cfg.itemWidth;
		}

		String storeTmp = "";

		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);

		String dicCode = ef.dicCode();
		if (!DataFormat.isEmpty(dicCode)) {
			if (cfg.getCodeMap().get(dicCode) != null) {
				dicCode = cfg.getCodeMap().get(dicCode);
			}
		}

		if (DataFormat.isEmpty(dicCode) && DataFormat.isEmpty(ef.dicDefine())) {
			storeTmp = ui_temple.getValue(ExtUiConstants.EMPLOY_STORE_TEMPLE);
		} else {
			storeTmp = ui_temple.getValue(ExtUiConstants.DIC_STORE_TEMPLE);
		}

		String rtnString = dicCmpTemple
				.replaceAll("#fieldLabel#", getMsgText(tf.getName()))
				.replaceAll("#dicStore#", storeTmp)
				.replaceAll("#anchor#", ef.anchor())
				.replaceAll("#hideLabel#", String.valueOf(ef.hideLabel()))
				.replaceAll("#field#", tf.getName())
				.replaceAll("#width#", String.valueOf(width))
				.replaceAll("#multiSelect#", String.valueOf(ef.multiSelect()))
				.replaceAll("#editable#", String.valueOf(ef.editable()))
				.replaceAll("#readOnly#", String.valueOf(ef.readOnly()))
				.replaceAll("#data#", dicData)
				.replaceAll("#value#", ef.defValue())
				.replaceAll("#disabled#", String.valueOf(ef.disabled()));
		return rtnString;
	}

	/**
	 * 返回容器名对一个的字段列表
	 * 
	 * @param object
	 * @param container
	 * @return
	 */
	private static List<Field> getFieldsByContainer(Object object,
			FieldContainer container) {
		List<Field> list = getObjFields(object, null, "ci", null, null);
		Ef ef = null;
		List<Field> rtnList = new ArrayList<Field>();
		for (Field f : list) {
			ef = f.getAnnotation(Ef.class);
			if (ef != null) {
				if (ef.container().equals(container.getName())) {
					rtnList.add(f);
				}
			}
		}
		return rtnList;
	}

	/**
	 * 返回指定字段名对应的列表
	 * 
	 * @param object
	 * @param defineFields
	 * @return
	 */
	private static List<Field> getFieldsByDefine(Object object,
			String defineFields, String preName) {
		List<Field> list = ReflectionUtils.getDeclaredField(object);
		List defineList = Arrays.asList(defineFields.split(","));
		Ef ef = null;
		List<Field> rtnList = new ArrayList<Field>();
		for (Field f : list) {
			if (defineList.contains(f.getName())) {
				rtnList.add(f);
			}
		}
		return rtnList;
	}

	/**
	 * @param object
	 * @param defineFields
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemForQryFlag(Object object, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {

		List<Field> iList = new ArrayList<Field>();

		// 从EF 定义中获取
		if (StringUtils.isBlank(cfg.queryParam)) {
			List<Field> fieldList = ReflectionUtils.getDeclaredField(object);

			Ef ef = null;
			for (Field f : fieldList) {
				ef = null;
				if (f.isAnnotationPresent(Ef.class)) {
					ef = f.getAnnotation(Ef.class);
					if (ef.qryFlag()) {
						iList.add(f);
					}
				}
			}
		} else {
			iList = getFieldsByDefine(object, cfg.queryParam, cfg.preQryName);
		}

		// 排序
		sortFieldList(iList, "f", "i");

		String itemString = "";
		if (iList != null && !iList.isEmpty()) {
			itemString = convertItemStr(iList, null, true, cfg, request);
		}

		return itemString;

	}

	/**
	 * @param object
	 * @param defineFields
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemStrByDefine(Object object, ExtUiCfg cfg,
			List<Field> fList, String inputItemStr, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {

		String itemString = "";
		if (DataFormat.isEmpty(inputItemStr)) {
			if (fList != null && !fList.isEmpty()) {
				itemString = convertItemStr(fList, null, true, cfg, request);
			} else if (object != null && !StringUtils.isBlank(cfg.queryParam)) {
				itemString = convertItemStr(
						getFieldsByDefine(object, cfg.queryParam,
								cfg.preQryName), null, true, cfg, request);
			}
		} else {
			itemString = inputItemStr;
		}

		return itemString;

	}

	/**
	 * 返回对象包含所有的容器分组集合
	 * 
	 * @param object
	 * @return
	 */
	private static Map<String, List<Field>> getFieldsByContainerOfObj(
			Object object) {
		List<Field> list = getObjFields(object, null, "ci", null, null);
		return getFieldsByContainer(list);
	}

	private static Map<String, List<Field>> getFieldsByContainer(
			List<Field> list) {
		Ef ef = null;
		List<Field> rtnList = null;
		Map<String, List<Field>> rtnMap = new HashMap<String, List<Field>>();
		for (Field f : list) {
			ef = f.getAnnotation(Ef.class);
			if (ef != null) {
				if (!DataFormat.isEmpty(ef.container())) {
					if (rtnMap.containsKey(ef.container())) {
						rtnMap.get(ef.container()).add(f);
					} else {
						rtnList = new ArrayList<Field>();
						rtnList.add(f);
						rtnMap.put(ef.container(), rtnList);
					}
				}
			}
		}
		return rtnMap;
	}

	/**
	 * 返回指定容器的 ITEM STR
	 * 
	 * @param object
	 * @param container
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemStrOfContainer(Object object,
			FieldContainer container, ExtUiCfg cfg, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {
		List<Field> list = getFieldsByContainer(object, container);
		return convertItemStr(list, null, false, cfg, request);
	}

	private static String getItemStrOfContainer(List<Field> flist,
			FieldContainer container, ExtUiCfg cfg, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {
		return convertItemStr(flist, null, false, cfg, request);
	}

	public static Set<Integer> getNamessByContainerOfObj(Object object) {
		List<Field> list = getObjFields(object, null, "ci", null, null);
		return getNamesByContainer(list);
	}

	private static Set<Integer> getNamesByContainer(List<Field> list) {
		Ef ef = null;
		Set<Integer> cNames = new HashSet<Integer>();
		int seq = 0;
		String str;
		for (Field f : list) {
			ef = f.getAnnotation(Ef.class);
			if (ef != null) {
				if (!DataFormat.isEmpty(ef.container())) {
					str = ef.container().replaceAll("fcn_", "");
					try {
						seq = Integer.parseInt(str);
					} catch (Exception e) {

					}
					cNames.add(seq);
				}
			}
		}

		Arrays.sort(cNames.toArray());
		return cNames;
	}

	/**
	 * 得到 fieldset 模板类型
	 * 
	 * @param ftmpType
	 * @return
	 */
	private static String getItemStrUseFieldset(String ftmpType) {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String fTmp = "";

		if (ExtXtype.CONTARNER_TYPE_FIELDSET_CHECK.equals(ftmpType)) {
			fTmp = ui_temple
					.getValue(ExtUiConstants.ITEM_FIELDSET_CHECKBOX_TEMPLE);
		} else if (ExtXtype.CONTARNER_TYPE_FIELDSET_COLLAP.equals(ftmpType)) {
			fTmp = ui_temple
					.getValue(ExtUiConstants.ITEM_FIELDSET_COLLAP_TEMPLE);
		} else if (ExtXtype.CONTARNER_TYPE_FIELDSET.equals(ftmpType)) {
			fTmp = ui_temple.getValue(ExtUiConstants.ITEM_FIELDSET_TEMPLE);
		} else {
			fTmp = ui_temple.getValue(ExtUiConstants.ITEM_FIELDSET_TEMPLE);
		}

		return fTmp;
	}

	/**
	 * 
	 * @param object
	 * @param container
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemStrUseFieldset(Object object,
			List<Field> fList, String inputItemStr, FieldContainer container,
			ExtUiCfg cfg, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String fTmp = getItemStrUseFieldset(container.getContainType());

		String itemString = "";
		if (DataFormat.isEmpty(inputItemStr)) {
			if (fList != null && !fList.isEmpty()) {
				itemString = getItemStrOfContainer(fList, container, cfg,
						request);
			} else {
				itemString = getItemStrOfContainer(object, container, cfg,
						request);
			}
		} else {
			itemString = inputItemStr;
		}

		String rtnStr = fTmp.replaceAll("#title#", container.getTitle())
				.replaceAll("#items#", itemString)
				.replaceAll("#layout#", container.getLayout());

		return rtnStr;
	}

	/**
	 * 
	 * @param object
	 * @param containerCfg
	 * @param itemStr
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemStrUseFieldcontainert(Object object,
			List<Field> flist, String inputItemStr, FieldContainer container,
			ExtUiCfg cfg, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String fTmp = ui_temple
				.getValue(ExtUiConstants.HBOX_FIELDCONTARNER_TEMPLE);

		String itemString = "";
		if (DataFormat.isEmpty(inputItemStr)) {
			if (flist != null && !flist.isEmpty()) {
				itemString = getItemStrOfContainer(flist, container, cfg,
						request);
			} else {
				itemString = getItemStrOfContainer(object, container, cfg,
						request);
			}
		} else {
			itemString = inputItemStr;
		}

		String rtnStr = fTmp.replaceAll("#fieldLabel#",
				getMsgText(container.getTitle())).replaceAll("#items#",
				itemString);

		if (DataFormat.isEmpty(container.getLayout())) {
			return rtnStr;
		} else {
			rtnStr = strAppend(rtnStr, ",layout: '" + container.getLayout()
					+ "'},", "},");
		}

		return rtnStr;
	}

	/**
	 * 
	 * @param container
	 * @param inputItemStr
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	public static String getItemStrByConType(FieldContainer container,
			String inputItemStr, ExtUiCfg cfg, HttpServletRequest request)
			throws InstantiationException, IllegalAccessException {
		StringBuilder rtnItemStr = new StringBuilder();

		if (container == null) {
			if (cfg.mc == null) {
				cfg.mc = new FieldContainer();
			}
			container = cfg.mc;
		}

		if (container.isFieldset()) {
			rtnItemStr.append(getItemStrUseFieldset(null, null, inputItemStr,
					container, cfg, request));
		} else if (container.getContainType().equals(
				ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER)) {
			rtnItemStr.append(getItemStrUseFieldcontainert(null, null,
					inputItemStr, container, cfg, request));
		} else {
			String tempStr = getItemStrByDefine(null, cfg, null, inputItemStr,
					request);

			rtnItemStr.append(tempStr).append(",");
		}

		return rtnItemStr.toString();
	}

	/**
	 * 
	 * @param object
	 * @param cfg
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String createContainerItemStr(Object object, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {
		Map<String, List<Field>> map = getFieldsByContainerOfObj(object);
		List<Field> fList = null;
		StringBuilder itemStr = new StringBuilder();
		for (FieldContainer container : cfg.getContrainList()) {
			fList = map.get(container.getName());
			if (fList != null) {
				if (container.isFieldset()) {
					String tmpStr = getItemStrUseFieldset(object, fList, "",
							container, cfg, request);
					if (container.getParContainer() != null) {
						if (tmpStr.toString().indexOf(",") != -1) {
							tmpStr = tmpStr.toString().substring(0,
									tmpStr.lastIndexOf(","));
						}
						itemStr.append(getItemStrByConType(
								container.getParContainer(), tmpStr, cfg,
								request));
					} else {
						itemStr.append(tmpStr);
					}

				} else if (container.getContainType().equals(
						ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER)) {
					String tmpStr = getItemStrUseFieldcontainert(object, fList,
							"", container, cfg, request);
					if (container.getParContainer() != null) {
						if (tmpStr.toString().indexOf(",") != -1) {
							tmpStr = tmpStr.toString().substring(0,
									tmpStr.lastIndexOf(","));
						}
						itemStr.append(getItemStrByConType(
								container.getParContainer(), tmpStr, cfg,
								request));
					} else {
						itemStr.append(tmpStr);
					}
				} else if (container.getContainType().equals(
						ExtXtype.CONTARNER_TYPE_SIMPLAE_ITEM)) {
					String tmpStr = getItemStrByDefine(object, cfg, fList,
							null, request);
					if (container.getParContainer() != null) {
						itemStr.append(getItemStrByConType(
								container.getParContainer(), tmpStr, cfg,
								request));
					} else {
						itemStr.append(tmpStr).append(",");
					}

				} else if (container.getContainType().equals(
						ExtXtype.CONTARNER_TYPE_COMTARINER)) {
					String tempStr = getItemStrByDefine(object, cfg, fList,
							null, request);
					PropertiesHelper ui_temple = PropertiesFactory
							.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);

					String hboxStr = ui_temple
							.getValue(ExtUiConstants.ITEM_FORM_GROUP_TEMPLE);
					if (container.getParContainer() != null) {
						tempStr = hboxStr.replaceAll("#items#", tempStr);
						itemStr.append(getItemStrByConType(
								container.getParContainer(), tempStr, cfg,
								request));
					} else {
						itemStr.append(hboxStr).append(",");
					}
				}
			}
		}

		String rtnString = "";
		if (itemStr.toString().indexOf(",") != -1) {
			rtnString = itemStr.toString().substring(0,
					itemStr.lastIndexOf(","));
		}

		return rtnString;
	}

	/**
	 * 列排版FORM 组件字符串组装
	 * 
	 * @param object
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getItemStr(Object object, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String hboxStr = ui_temple
				.getValue(ExtUiConstants.ITEM_FORM_GROUP_TEMPLE);
		String containerStr = ui_temple
				.getValue(ExtUiConstants.ITEM_CONTAINER_TEMPLE);
		String preName = cfg.preQryName;

		List<Field> list = getObjFields(object, null, "i", preName, cfg);

		// 容器组
		Map<String, List<Field>> contarnMaplist = getFieldsByContainer(list);

		Map<Integer, List<Field>> map = new HashMap<Integer, List<Field>>();
		Map<Integer, Ef> gMap = new HashMap<Integer, Ef>();

		String tmpStr = "";
		// 未分组
		map = groupAllField(list, cfg);
		gMap = getObjGroupFields(object, cfg);
		if (map == null || map.isEmpty() || map.size() == 1) {
			// 排序
			sortFieldList(list, "f", "i");
			tmpStr = convertItemStr(list, contarnMaplist, true, cfg, request);
			return tmpStr;
		}

		List gList = null;
		int gseq = 0;
		Ef gEf = null;
		for (Iterator it = map.keySet().iterator(); it.hasNext();) {
			gseq = (Integer) it.next();
			gEf = gMap.get(gseq);

			gList = (List) map.get(gseq);
			// 排序下
			sortFieldList(gList, "g", "i");

			tmpStr = convertItemStr(gList, contarnMaplist, true, cfg, request);
			tmpStr = containerStr
					.replaceAll("#items#", tmpStr)
					.replaceAll("#style#", gEf != null ? gEf.style() : "")
					.replaceAll(
							"#hidden#",
							gEf != null ? String.valueOf(gEf.groupHidden())
									: "false")
					.replaceAll("#layout#",
							gEf != null ? gEf.layout() : "'table'");

			if (gEf != null && !"".equals(gEf.groupId())) {
				tmpStr = strAppend(tmpStr, ",id:'" + gEf.groupId() + "'},",
						"},");
			}

			if (gEf != null && gEf.groupWithFieldsetFlag()) {
				String fTmp = getItemStrUseFieldset(gEf.groupFieldsetTmpType());

				tmpStr = fTmp.replaceAll("#title#", gEf.groupTitle())
						.replaceAll("#items#", tmpStr);
			}

			if (gEf != null
					&& gEf.gridPanel() != null
					&& (!DataFormat.isEmpty(gEf.gridPanel().store()) || !DataFormat
							.isEmpty(gEf.gridPanel().outGridPanel()))) {

				if ("0".equals(gEf.gridPanel().dircFlag())) {
					if (DataFormat.isEmpty(gEf.gridPanel().outGridPanel())) {
						tmpStr += createGridPanelStr(
								object,
								gEf.gridPanel(),
								cfg.getGridColsMap().get(
										gEf.gridPanel().beanName()));
					} else {
						tmpStr += gEf.gridPanel().outGridPanel() + ",";
					}

				} else {
					StringBuffer tmpGridStr = new StringBuffer();
					if (DataFormat.isEmpty(gEf.gridPanel().outGridPanel())) {
						tmpGridStr.append(
								createGridPanelStr(
										object,
										gEf.gridPanel(),
										cfg.getGridColsMap().get(
												gEf.gridPanel().beanName())))
								.append(tmpStr);
					} else {
						tmpGridStr.append(gEf.gridPanel().outGridPanel())
								.append(",").append(tmpStr);
					}

					tmpStr = tmpGridStr.toString();
				}

			}

			fStr.append(tmpStr);

		}

		String rtnString = "";
		if (fStr.toString().lastIndexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		String rtnStr = hboxStr.replaceAll("#items#", rtnString);
		if (!DataFormat.isEmpty(cfg.getGroupLayout())) {
			rtnStr = strAppend(rtnStr, ",layout:" + cfg.getGroupLayout() + "}",
					"}");
		}

		return rtnStr;
	}

	/**
	 * 列排版FORM 组件字符串组装
	 * 
	 * @param object
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getSimpleItemStr(Object object, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String preName = cfg.preQryName;

		List<Field> list = getObjFields(object, null, "i", preName, cfg);

		// 容器组
		Map<String, List<Field>> contarnMaplist = getFieldsByContainer(list);

		Map<Integer, List<Field>> map = new HashMap<Integer, List<Field>>();
		Map<Integer, Ef> gMap = new HashMap<Integer, Ef>();

		String tmpStr = "";
		// 排序
		sortFieldList(list, "f", "i");

		tmpStr = convertItemStr(list, contarnMaplist, true, cfg, request);

		return tmpStr;
	}

	/**
	 * 
	 * @param checkGroupStr
	 *            name:inputValue:checked,name:inputValue:checked
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String getCheckGroupStr(Field tf, Ef ef)
			throws InstantiationException, IllegalAccessException {

		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String gStr = ui_temple.getValue(ExtUiConstants.CHCEK_GROUP_TEMPLE);
		String gpStr = ui_temple.getValue("check_group_par_temple");

		String[] strs = ef.checkGroupStr().split(",");
		String[] items = null;
		String keyString = "";
		for (int i = 0; i < strs.length; i++) {
			items = strs[i].split(":");

			if (ef.checkGroupSameName()) {
				keyString = tf.getName() + "_cg";
			} else {
				keyString = tf.getName() + "_" + i;
			}

			fStr.append(gStr
					.replaceAll("#boxLabel#",
							getMsgText(tf.getName() + "_" + i))
					.replaceAll("#name#", keyString)
					.replaceAll("#inputValue#", items[0])
					.replaceAll("#checked#",
							items.length == 2 ? items[1] : "false"));

		}

		String rtnString = "";

		if (fStr.toString().lastIndexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		String gitems = "";
		if (!DataFormat.isEmpty(rtnString)) {
			gitems = gpStr.replaceAll("#fieldLabel#", tf.getName())
					.replaceAll("#xtype#", ef.xtype())
					.replaceAll("#columns#", ef.columns())
					.replaceAll("#vertical#", "true")
					.replaceAll("#width#", String.valueOf(ef.itemWidth()))
					.replaceAll("#items#", rtnString);
		}

		if (!"".equals(ef.margin())) {
			gitems = strAppend(gitems, ",margin:'" + ef.margin() + "'},", "},");
		}

		return gitems;
	}

	/**
	 * 
	 * @param infoIds
	 * @param request
	 * @return
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 */
	private static String convertItemStr(List<Field> infoIds,
			Map<String, List<Field>> containGroupMap,
			boolean careContainGroupMap, ExtUiCfg cfg,
			HttpServletRequest request) throws InstantiationException,
			IllegalAccessException {

		Ef ef = null;
		StringBuffer fStr = new StringBuffer();
		PropertiesHelper ui_temple = PropertiesFactory
				.getPropertiesHelper(PropertiesFile.UI_TEMPLTE);
		String ctr = ui_temple.getValue(ExtUiConstants.ITEM_TEMPLTE);
		if ("grid_qry".equals(cfg.preQryName)) {
			ctr = ui_temple.getValue(ExtUiConstants.QUERY_ITEM_TEMPLTE);
		}

		// 数据字段模板
		String dicdata = ui_temple.getValue(ExtUiConstants.DIC_DATA_TMPLE);

		String dicCmp = ui_temple.getValue(ExtUiConstants.DIC_CMP_TMPLE);
		// 下拉远程 store
		String remortCmb = ui_temple.getValue(ExtUiConstants.REMORT_CMB_TEMPLE);
		String gridCmb = ui_temple.getValue(ExtUiConstants.COMBO_GRID_TEMPLE);
		if (cfg != null && cfg.isCellCanEdit()) {
			dicCmp = ui_temple.getValue(ExtUiConstants.INNER_DIC_DATA_TMPLE);
			remortCmb = ui_temple
					.getValue(ExtUiConstants.INNER_REMORT_CMB_TEMPLE);
			gridCmb = ui_temple
					.getValue(ExtUiConstants.INNER_COMBO_GRID_TEMPLE);
		}

		String tmpValueStr = "#value#";

		String name = "";
		String xtype = "";
		String src = "";
		String format = "";
		String boxLabel = "";
		String container = "";
		boolean allowBlank = true;
		String vtype = "";
		String value = "";
		String labelAlign = "";
		String hideLabel = "";
		String margin = "";
		String renderer = "";
		String inputType = "";
		int itemWidth = cfg.itemWidth;
		int colspan = 0;
		int rowspan = 0;
		String fieldLabel = "";
		String emptyText = "";
		String id = "";
		boolean readOnly = false;
		boolean itemExclude = false;
		boolean disabled = false;
		boolean checked = false;
		boolean multiSelect = false;
		boolean autoLoad = false;
		String itemStr = "";
		String store = "";
		String isSubBean = "";
		String showFields = "";
		String dicField = "";
		String dicDefine = "";
		String displayField = "";
		int pageSize = 10;
		String valueField = "";
		String innerTpl = "";
		int flex = 1;
		int minLength = 0;
		int maxLength = 0;
		String fields = "";
		String url = "";

		Map.Entry<Integer, Field> tMap = null;
		Field tf = null;
		List<String> cGroupCheckList = new ArrayList<String>();
		List<String> sList = new ArrayList<String>();
		List<String> hList = new ArrayList<String>();
		if (cfg != null) {
			if (!StringUtils.isBlank(cfg.getHiddenItems())) {
				hList = Arrays.asList(cfg.getHiddenItems().split(","));
			}

			if (!StringUtils.isBlank(cfg.getShowItems())) {
				sList = Arrays.asList(cfg.getShowItems().split(","));
			}
		}

		for (int i = 0; i < infoIds.size(); i++) {

			xtype = "";
			name = "";
			allowBlank = true;
			vtype = "";
			src = "";
			value = "";
			renderer = "";
			format = "";
			labelAlign = "";
			hideLabel = "";
			inputType = "";
			margin = "";
			readOnly = false;
			itemExclude = false;
			checked = false;
			disabled = false;
			multiSelect = false;
			autoLoad = false;
			itemWidth = cfg.itemWidth;
			pageSize = 10;
			displayField = "";
			container = "";
			store = "";
			valueField = "";
			boxLabel = "";
			innerTpl = "";
			emptyText = "";
			flex = 1;
			fields = "";
			itemStr = "";
			url = "";
			id = "";
			isSubBean = "";
			showFields = "";
			dicField = "";
			dicDefine = "";
			colspan = 0;
			rowspan = 0;

			tf = infoIds.get(i);
			fieldLabel = tf.getName();
			name = tf.getName();
			if (!"".equals(cfg.preQryName)) {
				name = cfg.preQryName + "_" + tf.getName();
			}

			if (hList.contains(tf.getName()))
				continue;

			if (!sList.isEmpty() && !sList.contains(tf.getName()))
				continue;

			if (isBaseFilter(tf.getName())) {
				continue;
			}

			ef = tf.getAnnotation(Ef.class);

			if (ef != null) {

				container = ef.container();
				// 列分组用
				if (careContainGroupMap && !DataFormat.isEmpty(container)
						&& containGroupMap != null
						&& !containGroupMap.isEmpty()) {
					List<Field> gList = containGroupMap.get(container);
					if (!cGroupCheckList.contains(container)) {
						FieldContainer fContainer = new FieldContainer(
								container);
						// fContainer.setLayout("hbox");
						String tmpString = getItemStrUseFieldcontainert(null,
								gList, null, fContainer, cfg, request);
						fStr.append(tmpString);
						cGroupCheckList.add(container);
					}
					continue;
				}

				xtype = ef.xtype().equals(ExtXtype.XTYPE_TREE_COL) ? "" : ef
						.xtype();

				allowBlank = ef.allowBlank();
				vtype = ef.vtype();
				if (cfg != null) {
					value = (!DataFormat.isEmpty(cfg.getDefValueMap().get(
							tf.getName())) ? cfg.getDefValueMap().get(
							tf.getName()) : ef.defValue());
				} else {
					value = ef.defValue();
				}

				// 随机数获取
				if ("random".equals(value)) {
					int v = (int) (Math.random() * 9999);
					while (v < 1000 || String.valueOf(v).contains("3")) {
						v = (int) (Math.random() * 9999);
					}
					value = String.valueOf(v);
					cfg.random = value;
				}

				minLength = ef.minLength();
				maxLength = ef.maxLength();
				inputType = ef.inputType();

				// 控制只读
				if (cfg.getReadOnlyItems().contains(tf.getName())) {
					readOnly = true;
				} else {
					readOnly = ef.readOnly();
				}

				format = ef.format();
				checked = ef.checked();
				margin = ef.margin();
				if (ExtXtype.XTYPE_DISPLAY_FIELD.equals(xtype)) {
					renderer = ef.renderer();
				}
				boxLabel = ef.boxLabel();
				disabled = ef.disabled();
				store = ef.store();
				autoLoad = ef.autoLoad();
				multiSelect = ef.multiSelect();
				colspan = ef.colspan();
				emptyText = ef.emptyText();
				rowspan = ef.rowspan();
				src = ef.src();
				labelAlign = ef.labelAlign();
				hideLabel = String.valueOf(ef.hideLabel());
				displayField = ef.displayField();
				valueField = ef.valueField();
				fields = ef.fields();
				pageSize = ef.pageSize();
				itemExclude = ef.itemExclude();
				flex = ef.flex();

				if (ef.itemWidth() > 0) {
					itemWidth = ef.itemWidth();
				}

				if (ef.xtype().equals("image")) {
					itemWidth = 200;
				}

				id = ef.id();
				url = ef.url();
				if (!StringUtils.isBlank(ef.params())) {
					url += "?" + ef.params();
				}
				innerTpl = ef.innerTpl();
				isSubBean = ef.isSubBean();
				showFields = ef.showFields();
				dicField = ef.dicCode();
				if (!DataFormat.isEmpty(dicField)) {
					dicField = cfg.getCodeMap().get(dicField) != null ? cfg
							.getCodeMap().get(dicField) : ef.dicCode();
				}
				dicDefine = (cfg != null && !DataFormat.isEmpty(cfg
						.getDicDefineMap().get(tf.getName()))) ? cfg
						.getDicDefineMap().get(tf.getName()) : ef.dicDefine();

				// 上传文件
				if (ExtXtype.XTYPE_FILE_FIELD.equals(xtype)) {
					String fileTmp = ui_temple
							.getValue(ExtUiConstants.FILE_TEMPLE);
					itemStr = fileTmp
							.replaceAll("#id#", "file_" + tf.getName())
							.replaceAll("#buttonOnly#",
									String.valueOf(ef.buttonOnly()))
							.replaceAll("#hideLabel#",
									String.valueOf(ef.hideLabel()))
							.replaceAll("#emptyText#",
									getMsgText("emptyText_" + tf.getName()))
							.replaceAll("#width#", String.valueOf(itemWidth))
							.replaceAll("#fieldLabel#",
									getMsgText(tf.getName()))
							.replaceAll("#buttonText#", ef.buttonText());
				}

				// 树控件
				if (ExtXtype.XTYPE_CMB_TREE.equals(xtype)) {
					itemStr = tf.getName() + "ComboxWithTree,";
				}

				// 复杂对象做迭代
				if (ExtUiConstants.FLAG_ON.equals(isSubBean)) {

					if ("all".equals(showFields)) {
						List subFields = getObjFields(tf.getType()
								.newInstance(), null, "i", null, cfg);

						itemStr = convertItemStr(subFields, null, true, cfg,
								request) + ",";
					} else {
						String[] filteStrings = showFields.split(",");
						List subFields = getObjFields(tf.getType()
								.newInstance(), filteStrings, "i", null, cfg);

						itemStr = convertItemStr(subFields, null, true, cfg,
								request) + ",";
					}

				}
			}

			// 动态显示用
			if (cfg != null && cfg.getDyShowItems().contains(tf.getName())) {
				itemExclude = false;
			}

			// ID重命名
			if (!DataFormat.isEmpty(cfg.preQryName)) {
				allowBlank = true;
				readOnly = false;
				if ("qry".equals(cfg.preQryName)) {
					value = ef != null ? ef.defQryValue() : "";
				}

			}

			if ("hidden".equals(xtype)) {
				fieldLabel = "";
			}

			// 未空说明上面已经做处理
			if (!DataFormat.isEmpty(itemStr)) {

			} else {

				// 数据字典处理
				if (ExtXtype.XTYPE_CMB_DIC.equals(xtype)) {
					String dicListStr = "";

					if (!DataFormat.isEmpty(dicDefine)) {
						dicListStr = createDicData(dicDefine, dicdata);
					} else {
						dicListStr = createDicData(
								WebUtils.getCodeListByField(dicField, request),
								dicdata);
					}

					itemStr = createDicCmpStr(dicListStr, tf, dicCmp, ef, cfg);

					if (!DataFormat.isEmpty(value)) {
						itemStr = strAppend(itemStr, ",value: '" + value
								+ "' },", "},");
					}

					itemStr = strAppend(itemStr, ",name:'" + name + "'},", "},");

				} else if ((ExtXtype.XTYPE_CHECK_BOX_GROUP.equals(xtype) || ExtXtype.XTYPE_RADION_GROUP
						.equals(xtype))
						&& !DataFormat.isEmpty(ef.checkGroupStr())) {

					itemStr = itemStr + getCheckGroupStr(tf, ef);

				} else if (ExtXtype.XTYPE_CMB_REMORT.equals(xtype)) {
					// 下拉 remot cmb
					itemStr = remortCmb
							.replaceAll("#fieldLabel#",
									getMsgText(tf.getName()))
							.replaceAll("#displayField#", displayField)
							.replaceAll("#valueField#", valueField)
							.replaceAll("#fields#", fields)
							.replaceAll("#url#", url)
							.replaceAll("#hideLabel#",hideLabel)
							.replaceAll("#multiSelect#",
									String.valueOf(ef.multiSelect()))
							.replaceAll("#editable#",
									String.valueOf(ef.editable()))
							.replaceAll("#autoLoad#",
									String.valueOf(ef.autoLoad()))
							.replaceAll("#typeAhead#",
									String.valueOf(ef.typeAhead()))
							.replaceAll("#width#", String.valueOf(itemWidth))
							.replaceAll("#allowBlank#",
									String.valueOf(allowBlank))
							.replaceAll("#queryCaching#",
									String.valueOf(ef.queryCaching()))
							.replaceAll("#name#", name)
							.replaceAll("#readOnly#", String.valueOf(readOnly))
							.replaceAll("#disabled#", String.valueOf(disabled));

				} else if (ExtXtype.XTYPE_CMB_GRID.equals(xtype)) {
					// 下拉 remot grid
					itemStr = gridCmb
							.replaceAll("#fieldLabel#",
									getMsgText(tf.getName()))
							.replaceAll("#displayField#", displayField)
							.replaceAll("#innerTpl#", innerTpl)
							.replaceAll("#hideLabel#",hideLabel)
							.replaceAll("#multiSelect#",
									String.valueOf(ef.multiSelect()))
							.replaceAll("#valueField#", valueField)
							.replaceAll("#pageSize#", String.valueOf(pageSize))
							.replaceAll("#fields#", fields)
							.replaceAll("#url#", url)
							.replaceAll("#width#", String.valueOf(itemWidth))
							.replaceAll("#allowBlank#",
									String.valueOf(allowBlank))
							.replaceAll("#name#", name)
							.replaceAll("#readOnly#", String.valueOf(readOnly))
							.replaceAll("#disabled#", String.valueOf(disabled));

				} else {
					if (hasThisType(tf.getType().getName(), "date")
							&& ef != null && !DataFormat.isEmpty(ef.defValue())) {
						tmpValueStr = "'#value#'";
					} else {
						tmpValueStr = "#value#";
					}
					itemStr = ctr
							.replaceAll("#name#", name)
							.replaceAll("#fieldLabel#", getMsgText(fieldLabel))
							.replaceAll("#hideLabel#",hideLabel)
							.replaceAll("#allowBlank#",
									String.valueOf(allowBlank))
							.replaceAll("#disabled#", String.valueOf(disabled))
							.replaceAll("#vtype#", vtype)
							.replaceAll(tmpValueStr, value)
							.replaceAll("#emptyText#", emptyText)
							.replaceAll("#width#", String.valueOf(itemWidth))
							.replaceAll("#readOnly#", String.valueOf(readOnly));

					// inputType
					if (!DataFormat.isEmpty(inputType)) {
						itemStr = strAppend(itemStr, ",inputType:'password'},",
								"},");
					}
					
					if (!DataFormat.isEmpty(id)) {
						itemStr = strAppend(itemStr,
								",id:'" + id + "'},", "},");
					}

					if (ef != null && !DataFormat.isEmpty(ef.maxValue())) {
						itemStr = strAppend(itemStr,
								",maxValue:" + ef.maxValue() + "},", "},");
					}

					if (!DataFormat.isEmpty(renderer)) {
						itemStr = strAppend(itemStr, ",renderer:" + renderer
								+ "},", "},");
					}

					if (!DataFormat.isEmpty(margin)) {
						itemStr = strAppend(itemStr, ",margin:'" + margin
								+ "'},", "},");
					}

					if (!DataFormat.isEmpty(store)) {
						itemStr = strAppend(itemStr, ",store:" + ef.store()
								+ "},", "},");
					}

					if (ef != null && ef.hideLabel()) {
						itemStr = strAppend(itemStr, ",hideLabel:true},", "},");
					}

					if (minLength > 0) {
						itemStr = strAppend(itemStr, ",minLength:" + minLength
								+ "},", "},");
					}
					if (maxLength > 0) {
						itemStr = strAppend(itemStr, ",maxLength:" + maxLength
								+ "},", "},");
					}

					if (!DataFormat.isEmpty(src)) {
						itemStr = strAppend(itemStr, ",src:'" + src + "'},",
								"},");
					}

					// checkfield
					if (ExtXtype.XTYPE_CHECK_FIELD.equals(xtype)
							|| ExtXtype.XTYPE_RADION_FIELD.equals(xtype)) {
						itemStr = strAppend(itemStr, ",boxLabel: '" + boxLabel
								+ "' },", "},");
						itemStr = strAppend(itemStr,
								",checked: " + String.valueOf(checked) + " },",
								"},");

					}

					if (DataFormat.isEmpty(xtype)) {
						if (hasThisType(tf.getType().getName(), "string")) {
							itemStr = itemStr
									.replaceAll("#xtype#", "textfield");
						} else if (hasThisType(tf.getType().getName(),
								"int,long,BigDecimal,float,double")) {
							itemStr = itemStr.replaceAll("#xtype#",
									"numberfield");
							itemStr = strAppend(itemStr, ",minValue:0 },", "},");
						} else if (hasThisType(tf.getType().getName(), "date")) {
							itemStr = itemStr
									.replaceAll("#xtype#", "datefield");

							// 日期格式的时候用
							if (!DataFormat.isEmpty(format)) {
								itemStr = strAppend(itemStr, ",format:'"
										+ format + "'},", "},");
							} else {
								itemStr = strAppend(itemStr,
										",format:'Y-m-d'},", "},");
							}
						} else if (hasThisType(tf.getType().getName(),
								"timestamp")) {
							itemStr = itemStr
									.replaceAll("#xtype#", "datefield");
							itemStr = strAppend(itemStr, ",format:'Y-m-d '},",
									"},");
						} else {
							itemStr = itemStr
									.replaceAll("#xtype#", "textfield");
						}
					} else {
						itemStr = itemStr.replaceAll("#xtype#", xtype);
					}

					// 回车事件
					if (ef != null && ef.enableKeyEvents()) {
						String eventStr = ui_temple.getValue(
								ExtUiConstants.KEY_EVENTS_TEMPLE).replaceAll(
								"#method#",
								"query_" + tf.getName() + "_event()");
						itemStr = strAppend(itemStr, eventStr + "},", "},");
					}
				}

			}

			// 查询条件的时候处理下
			if (!DataFormat.isEmpty(cfg.preQryName)) {
				// itemStr = strAppend(itemStr, ",emptyText:'"
				// + getMsgText(tf.getName()) + "' },", "},");
			}

			// 必输时
			if (!allowBlank) {
				itemStr = strAppend(itemStr, ",afterLabelTextTpl:required },",
						"},");
			}

			if (ef != null && ef.xtype().equals("image")) {
				itemStr = strAppend(itemStr, ",height:300 },", "},");
			}

			if ("textarea".equals(xtype) && ef != null && ef.grow()) {
				itemStr = strAppend(itemStr, ",grow:true },", "},");
			}

			if (ef != null && ef.height() > 0) {
				itemStr = strAppend(itemStr, ",height:" + ef.height() + "},",
						"},");
			}

			if (!StringUtils.isBlank(id)) {
				itemStr = strAppend(itemStr, ",id:'" + id + "'},", "},");
			}

			if (!StringUtils.isBlank(labelAlign)) {
				itemStr = strAppend(itemStr, ",labelAlign:'" + labelAlign
						+ "'},", "},");
			}

			// table 方式布局时候用
			if (colspan > 0) {
				itemStr = strAppend(itemStr, ",colspan:" + colspan + "},", "},");
			}

			if (rowspan > 0) {
				itemStr = strAppend(itemStr, ",rowspan:" + rowspan + "},", "},");
			}

			if (ef != null) {
				if (!DataFormat.isEmpty(ef.preStr())) {
					itemStr = createStaticStr(ef.preStr()) + itemStr;
				}

				if (!DataFormat.isEmpty(ef.aftStr())) {
					itemStr += createStaticStr(ef.aftStr());
				}
			}

			fStr.append(itemStr);

		}

		String rtnString = "";
		if (fStr.toString().indexOf(",") != -1) {
			rtnString = fStr.toString().substring(0, fStr.lastIndexOf(","));
		}

		return rtnString;
	}

	public static void main(String[] args) {
		ExtUiCfg cfg = new ExtUiCfg();

		// FieldContainer c2 = new FieldContainer();
		// c2.setName(ExtXtype.CONTARNER_TYPE_FIELDSET_CHECK + "_check22");
		// // c2.setTitle("check");
		// // c2.setLayout("hbox");
		// // cfg.getContrainList().add(c2);
		//
		// FieldContainer c0 = new FieldContainer();
		// c0.setName(ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER + "_test");
		// // c0.setTitle("hello");
		// // c0.setLayout("hbox");
		// c0.setParContainer(c2);
		// cfg.getContrainList().add(c0);
		//
		// FieldContainer c3 = new FieldContainer();
		// c3.setName(ExtXtype.CONTARNER_TYPE_SIMPLAE_ITEM + "_a7");
		// c3.setDefineFields("a7");
		// // c0.setTitle("hello");
		// // c0.setLayout("hbox");
		// // cfg.getContrainList().add(c3);
		//
		// TestBean bean = new TestBean();
		// // System.out.println(getCommExtUiStr(bean, "ci", cfg, null));
		//
		// StringBuilder hql = new StringBuilder(
		// "select new Eamenu(po.id,po.text,po.parentid");
		// try {
		// cfg.setGetGridNewRowFlag(true);
		// System.out.println(createRowExpandStr("aa,bb"));
		// } catch (InstantiationException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } catch (IllegalAccessException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }

		// System.out.print(getCommExtUiStr(new TestBean(), "dic", cfg, null));
		// List<Object> objList = new ArrayList<Object>();
		// objList.add(new TestBean());
		// System.out.println(getCodeDescStr(objList, null));

	}
}

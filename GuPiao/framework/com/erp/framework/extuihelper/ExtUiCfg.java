package com.erp.framework.extuihelper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * EXT UI 参数管理
 * 
 */
public class ExtUiCfg {

	private List<FieldContainer> contrainList = new ArrayList<FieldContainer>();
	public FieldContainer mc = null;

	public String objName = "";
	public String preName = "";
	public String random = "";// 保存随机数
	private String gridQryStr = "";
	private String gridBar = "add,edit,del,refresh";
	private String formBar = "save,close";
	private String formQryBar = "query,reset";
	private String extformBar = "saveAdd,save,copy,close";
	private String extSubFormBar = ",->,prerec,nextrec";
	public String tools = "";
	private String extBars = "";
	private String preStr = "";
	public String preQryName = "";
	public String uiType = "i";
	public int viewColumns = 1; // 模版列数

	private String simpleQryEmptyText = "编号|名称";

	private String actionName = "";
	private String packageName = "";
	private String groupLayout = "'anchor'";
	private Map<String, String> gridColsMap = new HashMap<String, String>();

	public int itemWidth = 200;

	public boolean telIsTran = false;

	/**
	 * 查询对象
	 */
	private Object qryObj;
	public String queryParam = "";
	
	

	/**
	 * 隐藏域集合
	 */
	private String hiddenItems = "";
	private String showItems = "";
	private List dyShowItems = new ArrayList(); // 动态显示（强制的)
	private List readOnlyItems = new ArrayList();

	private Map<String, String> codeMap = new HashMap<String, String>(); // 数据字典匹配
	private Map<String, String> dicDefineMap = new HashMap<String, String>(); // 数据字典定义匹配
	private Map<String, String> dicCodeMap = new HashMap<String, String>(); // 数据字典定义匹配
	private Map<String, String> defValueMap = new HashMap<String, String>(); // 默认值匹配
	private Map<String, Integer> groupItemNumMap = new HashMap<String, Integer>();

	private boolean isTreeGrid = false;
	private boolean cellCanEdit = false;
	private boolean groupWithFieldset = true;
	private boolean gridWithQryFlag = false;
	private boolean getGridNewRowFlag = false;

	public void initParam() {
		contrainList = new ArrayList<FieldContainer>();
		gridQryStr = "";
		itemWidth = 200;
		mc = null;
		preStr = "";
		preQryName = "";
		queryParam = "";
		objName = "";
		tools = "";
		preName = "";
		uiType = "i";
		gridBar = "add,edit,del,refresh";
		extformBar = "saveAdd,save,copy,close";
		readOnlyItems.clear();
		hiddenItems = "";
		showItems = "";
		dyShowItems.clear();
		groupItemNumMap.clear();
		isTreeGrid = false;
		cellCanEdit = false;
		gridWithQryFlag = true;
		getGridNewRowFlag = false;
		groupLayout = "'anchor'";
		qryObj = null;
	}

	public boolean isGroupWithFieldset() {
		return groupWithFieldset;
	}

	public void setGroupWithFieldset(boolean groupWithFieldset) {
		this.groupWithFieldset = groupWithFieldset;
	}

	public Object getQryObj() {
		return qryObj;
	}

	public void setQryObj(Object qryObj) {
		this.qryObj = qryObj;
	}

	public boolean isGridWithQryFlag() {
		return gridWithQryFlag;
	}

	public void setGridWithQryFlag(boolean gridWithQryFlag) {
		this.gridWithQryFlag = gridWithQryFlag;
	}

	public String getPreStr() {
		return preStr;
	}

	public void setPreStr(String preStr) {
		this.preStr = preStr;
	}

	public boolean isCellCanEdit() {
		return cellCanEdit;
	}

	public String getExtformBar() {
		return extformBar + this.extSubFormBar;
	}

	public String getExtSubFormBar() {
		return extSubFormBar;
	}

	public void setExtSubFormBar(String extSubFormBar) {
		this.extSubFormBar = extSubFormBar;
	}

	public void setExtformBar(String extformBar) {
		this.extformBar = extformBar;
	}

	public void setCellCanEdit(boolean cellCanEdit) {
		this.cellCanEdit = cellCanEdit;
	}

	public List getReadOnlyItems() {
		return readOnlyItems;
	}

	public void setReadOnlyItems(List readOnlyItems) {
		this.readOnlyItems = readOnlyItems;
	}

	public boolean isTreeGrid() {
		return isTreeGrid;
	}

	public Map<String, String> getGridColsMap() {
		return gridColsMap;
	}

	public void setGridColsMap(Map<String, String> gridColsMap) {
		this.gridColsMap = gridColsMap;
	}

	public void setTreeGrid(boolean isTreeGrid) {
		this.isTreeGrid = isTreeGrid;
	}

	public String getHiddenItems() {
		return hiddenItems;
	}

	public void setHiddenItems(String hiddenItems) {
		this.hiddenItems = hiddenItems;
	}

	public String getShowItems() {
		return showItems;
	}

	public void setShowItems(String showItems) {
		this.showItems = showItems;
	}

	public List<FieldContainer> getContrainList() {
		return contrainList;
	}

	public void setContrainList(List<FieldContainer> contrainList) {
		this.contrainList = contrainList;
	}

	public String getGridBar() {
		return gridBar;
	}

	public void setGridBar(String gridBar) {
		this.gridBar = gridBar;
	}

	public String getSimpleQryEmptyText() {
		return simpleQryEmptyText;
	}

	public void setSimpleQryEmptyText(String simpleQryEmptyText) {
		this.simpleQryEmptyText = simpleQryEmptyText;
	}

	public String getFormBar() {
		return formBar == null ? getFormQryBar() : formBar;
	}

	public void setFormBar(String formBar) {
		this.formBar = formBar;
	}

	public String getGridQryStr() {
		return gridQryStr;
	}

	public void setGridQryStr(String gridQryStr) {
		this.gridQryStr = gridQryStr;
	}

	public String getActionName() {
		return actionName;
	}

	public String getGroupLayout() {
		return groupLayout;
	}

	public void setGroupLayout(String groupLayout) {
		this.groupLayout = groupLayout;
	}

	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

	public Map<String, String> getCodeMap() {
		return codeMap;
	}

	public void setCodeMap(Map<String, String> codeMap) {
		this.codeMap = codeMap;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}

	public boolean isGetGridNewRowFlag() {
		return getGridNewRowFlag;
	}

	public void setGetGridNewRowFlag(boolean getGridNewRowFlag) {
		this.getGridNewRowFlag = getGridNewRowFlag;
	}

	public Map<String, String> getDefValueMap() {
		return defValueMap;
	}

	public void setDefValueMap(Map<String, String> defValueMap) {
		this.defValueMap = defValueMap;
	}

	public String getExtBars() {
		return extBars;
	}

	public void setExtBars(String extBars) {
		this.extBars = extBars;
	}

	public List getDyShowItems() {
		return dyShowItems;
	}

	public Map<String, Integer> getGroupItemNumMap() {
		return groupItemNumMap;
	}

	public void setDicDefineMap(Map<String, String> dicDefineMap) {
		this.dicDefineMap = dicDefineMap;
	}

	public void setDyShowItems(List dyShowItems) {
		this.dyShowItems = dyShowItems;
	}

	public void setGroupItemNumMap(Map<String, Integer> groupItemNumMap) {
		this.groupItemNumMap = groupItemNumMap;
	}

	public Map<String, String> getDicDefineMap() {
		return dicDefineMap;
	}

	public Map<String, String> getDicCodeMap() {
		return dicCodeMap;
	}

	public void setDicCodeMap(Map<String, String> dicCodeMap) {
		this.dicCodeMap = dicCodeMap;
	}

	public String getFormQryBar() {
		return formQryBar;
	}

	public void setFormQryBar(String formQryBar) {
		this.formQryBar = formQryBar;
	}

}
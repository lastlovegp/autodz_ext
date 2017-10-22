package com.erp.framework.extuihelper;

import com.erp.framework.util.DataFormat;

/**
 * 
 * 字段容器配置参数
 * 
 */
public class FieldContainerCfg {

	private String name = "";
	private String title = "";
	private String layout = "";

	private String defineFields = "";

	private FieldContainer parContainer = null;

	public FieldContainerCfg(String name) {
		super();
		this.name = name;
	}

	public FieldContainerCfg() {
		super();
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContainType() {
		if (name.indexOf(ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER) != -1) {
			return ExtXtype.CONTARNER_TYPE_FIELD_CONTAINER;
		} else if (name.indexOf(ExtXtype.CONTARNER_TYPE_FIELDSET_CHECK) != -1) {
			return ExtXtype.CONTARNER_TYPE_FIELDSET_CHECK;
		} else if (name.indexOf(ExtXtype.CONTARNER_TYPE_FIELDSET_COLLAP) != -1) {
			return ExtXtype.CONTARNER_TYPE_FIELDSET_COLLAP;
		} else if (name.indexOf(ExtXtype.CONTARNER_TYPE_SIMPLAE_ITEM) != -1) {
			return ExtXtype.CONTARNER_TYPE_SIMPLAE_ITEM;
		} else if (name.indexOf(ExtXtype.CONTARNER_TYPE_FIELDSET) != -1) {
			return ExtXtype.CONTARNER_TYPE_FIELDSET;
		} else if (name.indexOf(ExtXtype.CONTARNER_TYPE_COMTARINER) != -1) {
			return ExtXtype.CONTARNER_TYPE_COMTARINER;
		}
		return "";
	}

	public String getLayout() {
		return layout;
	}

	public void setLayout(String layout) {
		this.layout = layout;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isFieldset() {
		if (name.indexOf("fld") != -1) {
			return true;
		}
		return false;
	}

	public String getDefineFields() {
		return defineFields;
	}

	public void setDefineFields(String defineFields) {
		this.defineFields = defineFields;
	}

	public FieldContainer getParContainer() {
		return parContainer;
	}

	public void setParContainer(FieldContainer parContainer) {
		this.parContainer = parContainer;
	}

}
package com.erp.framework.extuihelper;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 字段声明类
 * 
 * @author Administrator
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Ef {

	int flex() default 1;

	boolean sortable() default true; // 是否排序

	String xtype() default ""; // 字段类型

	String vtype() default ""; // 验证类型

	String preStr() default ""; // 前缀

	String aftStr() default ""; // 后缀

	String queryMode() default "";
	
	String labelAlign() default "";

	String inputType() default ""; // 输入类型

	String renderer() default ""; // 渲染对象

	String format() default ""; // 渲染对象

	String store() default ""; // 数据源

	boolean allowBlank() default true; // 是否可为空

	boolean grow() default false; // textarea 用

	boolean queryCaching() default true; // 是否可为空

	boolean typeAhead() default false;

	boolean editable() default false;

	boolean multiSelect() default false;

	boolean autoLoad() default false;

	String minValue() default "";

	String maxValue() default "";

	String emptyText() default "";

	String url() default "";
	String params() default "";

	String src() default "";

	String displayField() default "";

	String valueField() default "";

	String id() default "";

	String fields() default "";

	boolean hidden() default false;

	boolean locked() default false; // 列锁定

	String text() default "";

	String defValue() default "";

	String defQryValue() default ""; // 查询条件用

	String boxLabel() default "boxLabel";

	int width() default 100;

	int itemWidth() default 0;

	String columns() default "";

	String layout() default "'vbox'";

	int height() default 0;

	int colspan() default 0;

	int rowspan() default 0;

	int columnWidth() default 0;

	String checkGroupStr() default "";

	boolean checkGroupSameName() default true;

	int pageSize() default 10;

	String anchor() default "98%";

	String margin() default "";

	boolean readOnly() default false;

	boolean disabled() default false;

	boolean checked() default false;

	String innerTpl() default "";

	String icon() default "";

	String tooltip() default "";

	String actionType() default "c"; // action 类型

	boolean buttonOnly() default false;

	boolean hideLabel() default false;

	String buttonText() default "";

	// 表格合计用
	boolean isCustSummaryType() default false;

	String summaryType() default "";

	String summaryRenderer() default "";

	/**
	 * 下面跟EXT没关系的
	 */
	String exclude() default "0";

	int fseq() default 999;

	boolean colExclude() default false;

	boolean itemExclude() default false;

	String dicCode() default "";// 字典值

	boolean qryFlag() default false; // 查询标志

	String qryType() default "=";// 查询类型 "=,>,< like"

	boolean enableKeyEvents() default false; // 回车事件

	String container() default "";// 属于哪个容器

	String dicDefine() default "";// 字典定义

	int groupIndex() default 0; // 分组编号
	
	String style() default "";// 字典定义

	int groupItemNum() default 0;

	int maxLength() default 0;

	int minLength() default 0;

	boolean groupWithFieldsetFlag() default false;

	String groupFieldsetTmpType() default ExtXtype.CONTARNER_TYPE_FIELDSET;

	String groupTitle() default "groupTitle";
	
	boolean groupHidden() default false;
	String groupId() default "";

	String columnGroup() default "";

	int gseq() default 999;

	String isSubBean() default "0";

	String showFields() default "";

	GridPanel gridPanel() default @GridPanel;

}
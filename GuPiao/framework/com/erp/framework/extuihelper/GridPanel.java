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
public @interface GridPanel {

	String cellEditParam() default ",autoDestroy: true,model:'Plant',frame:true,selModel: {selType: 'cellmodel'}"
			+ ",plugins: [#cellEditing#],";

	boolean cellEditFlag() default false;

	String columnLockedParam() default ",columnLines: true,viewConfig: {stripeRows: true},";

	String bufferedParam() default ",verticalScroller:{variableRowHeight: true},";

	String CheckboxModelParam() default ",selModel: Ext.create('Ext.selection.CheckboxModel'),";

	String pagingtoolbarParam() default ",dockedItems:[{xtype:'pagingtoolbar',store: #store#,dock:'bottom',displayInfo: true}],";

	String rowNumberer() default "new Ext.grid.RowNumberer(),";

	String actioncolumn() default "{menuDisabled: true,sortable: false,xtype: 'actioncolumn',width: 40,"
			+ "items: [{icon:'/CallSell/extjs4/resources/image/ext/add.gif',tooltip: 'add',"
			+ "handler: function(grid, rowIndex, colIndex) {#beanName#addDandler(grid, rowIndex, colIndex); }},"
			+ "{icon : '/CallSell/extjs4/resources/image/ext/delete.gif',tooltip: 'delete',"
			+ "handler: function(grid, rowIndex, colIndex) {#beanName#delDandler(grid, rowIndex, colIndex);}}]},";

	boolean forceFit() default false;

	boolean gridSumFlag() default false;

	String gridSumParam() default "{id: 'summary', ftype: 'summary'}";

	boolean groupingFlag() default false;

	String groupingParam() default "{groupHeaderTpl: '{name}',hideGroupedHeader: true,enableGroupingMenu: false}";

	String tbar() default "[]";

	String cellEditing() default "";

	String outGridPanel() default "";

	String store() default "";

	String id() default "dtlgrid";

	String title() default "title";

	int height() default 400;

	int width() default 500;

	String dircFlag() default "0"; //0:down 1: up

	String beanName() default "";
}
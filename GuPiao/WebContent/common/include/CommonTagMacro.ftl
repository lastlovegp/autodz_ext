<#--global value-->
<#global contextPath = contextPath>
<#---->
<#macro page title require="'*'" enablExt="true" optionSel="false" callOpen="false" voipAccount="" voipPassword="">
<html>
  <head>
    <title>${title}</title>
	<meta http-equiv="keywords" content="erp">
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="description" content="erp system">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache, must-revalidate">
	<meta http-equiv="expires" content="0">
	
	<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/ext_icon.css"/>
	<script type="text/javascript" src="${contextPath}/pages/shared/include-ext.js"></script>
    <script type="text/javascript" src="${contextPath}/js/jquery.js"></script>
	<#if optionSel =="true">
		<script type="text/javascript" src="${contextPath}/pages/shared/options-toolbar.js"></script>
    </#if>
    <link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/ext-custom-css.css"/>
	<script type="text/javascript" src="${contextPath}/commonjs/common.js"></script>
	<script type="text/javascript" src="${contextPath}/commonjs/echarts.js"></script>
	<script type="text/javascript" src="${contextPath}/commonjs/sysConstants.js"></script>
	<script type="text/javascript" src="${contextPath}/locale/ext-lang-zh_CN.js"></script>
	<link rel="stylesheet" type="text/css" href="${contextPath}/pages/ux/css/LiveSearchGridPanel.css" />
    <link rel="stylesheet" type="text/css" href="${contextPath}/pages/ux/statusbar/css/statusbar.css" />
	<#if callOpen =="true">
		<script type="text/javascript" src="http://www.cloopen.com/js/voip/swfobject.js"></script>
		<script type="text/javascript" src="http://www.cloopen.com/js/voip/Cloopen.js"> </script>
	</#if>
  
   </head>
      
	<script language="javascript">
			
		// 路径配置
        require.config({
            paths: {
                echarts: '${contextPath}/dist'
            }
        });
	
	     var voipAccount="${voipAccount}";
	     var voipPassword="${voipPassword}";
		 <#if enablExt =="true">
	          Ext.Loader.setConfig({enabled: true});
		      Ext.Loader.setPath('Ext.ux', '${contextPath}/pages/ux/');
		      Ext.require([
			  		${require}
			  ]);
		      Ext.onReady(function() {
	                 Ext.QuickTips.init();

	                 Ext.apply(Ext.form.field.VTypes,{
				          mobilephone:function(val,field)
						  {
						       return /(^0?[1][3-8][0-9]{9}$)/.test(val);
						  },
						  mobilephoneText:'请输入正确的手机号码',

						  phone: function(v) {
						        return /^\d{3}-\d{8}|\d{4}-\d{7}$/.test(v);
						  },
						  phoneText: '请输入正确的电话号码'
				    });
	          });
         </#if>

		  Ext.define('dicMode', {
	        extend: 'Ext.data.Model',
	        fields: [
	            {type: 'string', name: 'field'},
		        {type: 'string', name: 'fieldname'},
		        {type: 'string', name: 'code'},
		        {type: 'string', name: 'codetype'},
		        {type: 'string', name: 'codedesc'}
	        ]
	      });

          //必输项
		  var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';

		  <#if uiDto?exists>
		    <#if uiDto.codeTrans?exists>
		       ${uiDto.codeTrans}
		    </#if>
		  </#if>


    </script>

 <#nested>
</html>
</#macro>


<#macro mobilePage title >
<!DOCTYPE html>
<html>
	<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${title}</title>
	<link rel="shortcuticon" href="${contextPath}/images/sfavicon.ico">
	<link rel="stylesheet" href="${contextPath}/css/themes/default/jquery.mobile-1.4.1.min.css">
	<script src="${contextPath}/js/jquery.js"></script>
	<script src="${contextPath}/js/jquery.mobile-1.4.1.min.js"></script>
	<script src="${contextPath}/js/cordova-1.5.0.js"></script>
</head>
 <#nested>
</html>
</#macro>

<#macro model name fieldStr idProperty="" >
  	Ext.define('${name}Model', {
        extend: 'Ext.data.Model',
        idProperty: '${name}Model${idProperty}',
        fields: [${fieldStr}]
    });

</#macro>


<#macro store name url fieldStr autoLoad="true" buffered="false"
 pageSize=20 leadingBufferZone=10 idProperty="" sorters="" groupField="">

  	<@Ctg.model name=name fieldStr=fieldStr idProperty=idProperty />

    // create the Data Store
    var ${name}Store = Ext.create('Ext.data.Store', {
        pageSize: ${pageSize},
        autoLoad: ${autoLoad},
        model: '${name}Model',
        <#if sorters!="">
	        sorters: ${sorters},
        </#if>
        <#if groupField!="">
	        groupField: '${groupField}',
        </#if>
        <#if buffered=="true">
          buffered: true,
          leadingBufferZone: ${leadingBufferZone},
        </#if>
        proxy: {
	        type: 'ajax',
            url: '${url}',
            reader: {
	            root: 'items',
	            totalProperty: 'totalCount'
            }
        }
    });
</#macro>

<#--ftype:summary-->
<#macro grid name url fieldStr columnsStr autoLoad="true" pageSize=20
    tbar="" action="" pageFlag="true" gridType="Ext.grid.Panel"
    idProperty="" sorters="" groupField="" rowNumberer="true"
    rowexpander="true" rowBodyTpl="" border="false" 
    columnLines="false" collapsible="false"
    sortableColumns="true" collapsed="false"
    buffered="false" leadingBufferZone="300" hasLocked="false"
    forceFit="false" newrow="" width=700 height=500 checkOnly="false"
    title=""  renderTo="Ext.getBody()" cellEdit="false" checkboxModel="true"
    ftype="" groupHeaderTpl="{name}">

   <@Ctg.store name=name url=url pageSize=pageSize fieldStr=fieldStr buffered=buffered
        autoLoad=autoLoad idProperty=idProperty leadingBufferZone=leadingBufferZone
        sorters=sorters groupField=groupField/>

   	<#if cellEdit=="true">
        var ${name}CellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
		        clicksToEdit: 1
		    });
    </#if>
    var ${name}sm = Ext.create('Ext.selection.CheckboxModel',
      {
        checkOnly:${checkOnly}
      }
    );

    var ${name}Grid = Ext.create('${gridType}', {
    	<#if cellEdit=="true">
        	autoDestroy: true,
        	model: 'Plant',
        	frame: true,
        	selModel: {
		        selType: 'cellmodel'
		    },
        </#if>
        <#if hasLocked=="true">
            viewConfig: {
            	stripeRows: true
        	},
        </#if>
        <#if forceFit=="true">
            forceFit: true, //列表宽度自适应
        </#if>
        plugins: [
            <#if cellEdit=="true">
        		${name}CellEditing
       		</#if>
       		<#if cellEdit=="false" && rowexpander=="true" && rowBodyTpl!="">
	        	{
		            ptype: 'rowexpander',
		            rowBodyTpl : [
		                ${rowBodyTpl}
		            ]
		        }
       		</#if>
        ],
        features: [
	        <#if ftype!="">
	        {
	           id: '${ftype}',
	           ftype: '${ftype}'
	           <#if ftype=="groupingsummary" || ftype=="grouping">
	            ,
	            groupHeaderTpl: '${groupHeaderTpl}',
	            hideGroupedHeader: true,
	            enableGroupingMenu: false
	           </#if>
	        }
	        </#if>
	    ],
        id:'id_${name}Grid',
        columnLines: ${columnLines},
        <#if title!="">
          title: '${title}',
        </#if>
        border:${border},
        titleCollapse : true,
        sortableColumns:${sortableColumns},
        collapsible: ${collapsible},
        collapsed: ${collapsed},
        width: ${width},
        height:${height},
        <#if renderTo!="">
          renderTo: ${renderTo},
        </#if>
        store: ${name}Store,

        <#if buffered=="true">
	        verticalScroller:{
		        variableRowHeight: true
	        },
        </#if>

        columns:[
            <#if rowNumberer=="true">
	           new Ext.grid.RowNumberer(),
	        </#if>

	        <#if action!="">
	          <@Ctg.actioncolumn type=action newrow=newrow beanname=name />,
	        </#if>
	        ${columnsStr}
        ],
        <#if tbar!="">
	            tbar : [
			        ${tbar}
			     ],
	    </#if>
        <#if checkboxModel=="true">
	          selModel: ${name}sm,
	    </#if>
        dockedItems: [
           <#if pageFlag=="true" && buffered=="false">
    		{
		        xtype: 'pagingtoolbar',
		        store: ${name}Store,   // same store GridPanel is using
		        dock: 'bottom',
		        displayInfo: true
	        }
   		  </#if>
        ]
    });
</#macro>

<#-- actioncolumn -->
<#macro actioncolumn type="down" newrow="" beanname="">
    {
        menuDisabled: true,
        sortable: false,
        xtype: 'actioncolumn',
        <#if type=="add,del">
          width: 40,
        <#else>
          width: 20,
        </#if>
        items: [
         <#if type=="del">
          {
	            icon   : '${contextPath}/resources/image/ext/delete.gif',
	            tooltip: '删除',
	            handler: function(grid, rowIndex, colIndex) {
	                grid.getStore().removeAt(rowIndex);
	            }
          }
         <#elseif type=="add">
           {
	            icon   : '${contextPath}/resources/image/ext/add.png',
	            tooltip: '增加',
	            handler: function(grid, rowIndex, colIndex) {
	                var r =${newrow}
			        grid.getStore().insert(0, r);
			        ${beanname}CellEditing.startEditByPosition({row: 0, column: 0});
	            }
        	}
         <#elseif type=="download">
           {
	            icon   : '${contextPath}/resources/image/ext/download.png',
	            tooltip: '下载',
	            handler: function(grid, rowIndex, colIndex) {
	                downloadDandler(grid, rowIndex, colIndex);
	            }
        	}
         <#elseif type=="add,del">
            {
	            icon   : '${contextPath}/resources/image/ext/add.png',
	            tooltip: '增加',
	            handler: function(grid, rowIndex, colIndex) {
	                var r =${newrow}
			        ${beanname}Store.insert(0, r);
			        ${beanname}CellEditing.startEditByPosition({row: 0, column: 0});
	            }
        	},{
	            icon   : '${contextPath}/resources/image/ext/delete.gif',
	            tooltip: '删除',
	            handler: function(grid, rowIndex, colIndex) {
	               if (grid.getStore().count() >1)
	               grid.getStore().removeAt(rowIndex);
	            }
            }
         </#if>
        ]
     }
</#macro>

<#--
layoutType="anchor"
-->
<#macro form name itemStr  title="" width=700 height=500 layoutType="anchor"
    columns=1  autoScroll="false" collapsible="false"  tools="" defaultsFlag="false"
    labelAlign="right" renderTo="Ext.getBody()" readOnly="false" collapsed="false"
    buttons="" tbar="">
    var ${name}Form = Ext.widget({
        xtype: 'form',
        <#if layoutType!="">
			layout: {
		        type: '${layoutType}'
		         <#if layoutType="table">
			        ,columns: ${columns}
		         </#if>
	        },
	    </#if>
        id: 'id_${name}Form',
        tools:[${tools}],
        titleCollapse : true,
        collapsible: ${collapsible},
        frame: true,
        autoScroll : ${autoScroll},
        border:false,
        collapsed: ${collapsed},
        bodyPadding: '0 0 0 0',
        <#if defaultsFlag="true">
           defaults: {
	            readOnly:${readOnly},
	            anchor: '100%',
	            allowBlank: false,
	            msgTarget: 'side',
	            labelWidth: 50
        	},
        </#if>
        <#if renderTo!="">
          renderTo: ${renderTo},
        </#if>
        <#if title!="">
          title: '${title}',
        </#if>
        width: ${width},
        height:${height},
        fieldDefaults: {
        	msgTarget: 'side',
            labelAlign: '${labelAlign}',
            <#if layoutType="column">
			   padding: '2 0 2 2',
		    </#if>
            labelWidth: 60
        },
        items: [${itemStr}]
        <#if tbar!="">
        ,
        tbar : [
        	${tbar}
        ]
        </#if>
        <#if buttons!="">
        	,
          buttons: [${buttons}]
        </#if>
    });
</#macro>

<#macro formGrid name itemStr columnsStr fieldStr url title="" width=700 height=500 
    autoScroll="false" collapsible="false" gridTitle="" formTitle="" gridHeight=300 
    renderTo="Ext.getBody()" collapsed="false"
    buttons="" tbar="">
    
    <@Ctg.store name=name url=url fieldStr=fieldStr />
    
    var ${name}gridForm = Ext.create('Ext.form.Panel', {
        id: '${name}gridForm',
        title: '${title}',
        titleCollapse : true,
        collapsible: ${collapsible},
        frame: true,
        autoScroll : ${autoScroll},
        border:false,
        collapsed: ${collapsed},
        bodyPadding: 5,
       	width: ${width},
        height:${height},
        layout: 'column',    
        <#if renderTo!="">
          renderTo: ${renderTo},
        </#if>
        fieldDefaults: {
            labelAlign: 'left',
            msgTarget: 'side'
        },
        <#if tbar!="">
	        tbar : [
	        	${tbar}
	        ],
        </#if>
        <#if buttons!="">
          buttons: [${buttons}],
        </#if>
        items: [{
            columnWidth: 0.60,
            xtype: 'gridpanel',
            store: ${name}Store,
            height: ${gridHeight},
            forceFit: true,
            title: '${gridTitle}',
            columns: [
                ${columnsStr}
            ],
            listeners: {
                selectionchange: function(model, records) {
                    if (records[0]) {
                        this.up('form').getForm().loadRecord(records[0]);
                    }
                }
            }
        }, {
            columnWidth: 0.4,
            margin: '0 0 0 10',
            xtype: 'fieldset',
            title: '${formTitle}',
            defaults : {
				width : 240,
				labelWidth : 60
			},
            items: [${itemStr}]
            }]
    });

    //${name}gridForm.child('gridpanel').getSelectionModel().select(0);
</#macro>

<#macro callInit callOpen="false" voipAccount="" voipPassword="">
<script type="text/javascript">


var callTime =0;
var callConnFlag = false;
$(document).ready(function(){
    if ("undefined" != (typeof Cloopen)) {
        /*设置为debug模式*/
		//Cloopen.debug();

		/*设置为强制登录模式*/
		Cloopen.forceLogin();
		
        /*以voip账号和密码登录的方式初始化*/
        Cloopen.initByUser('idvideophone'//swf对应的id
                    ,initCallBack//初始化时自定义fun
                    ,notifyCallBack//显示通知的自定义fun
                    ,'${voipAccount}'//voip子账号
					,'${voipPassword}'//voip子账号密码
        );
        
        /*未连接状态*/
        Cloopen.when_idle(function(){
            console.log('未连接...');
        })

        /*正在连接服务器注册*/
        Cloopen.when_connecting(function(){
            console.log('正在连接服务器注册...');
        })

        /*已经注册登录*/
        Cloopen.when_connected(function(){
            callConnFlag = true;
            console.log('通话准备就绪！');
        })

        /*正在呼出*/
        Cloopen.when_outbound(function(){
            console.log('正在呼出...');
        })

         /*通话中*/
        Cloopen.when_active(function(){
            console.log('通话中...');
            stopCount();
            timedCount();
        })

        /*有呼入*/
        Cloopen.when_inbound(function(){
            console.log('有电话呼入...');
        })
        
    }

});


/*计时器*/
var c=0;
var t;
function timedCount()
{
    //hour=parseInt(c/60/60);
    minute=parseInt(c/60%60);
    second=parseInt(c%60);
    if(minute<10){
      mStr = '0'+minute;
    } else{
      mStr =  minute
    }
    if(second<10){
      sStr = '0'+second;
    } else{
      sStr =  second
    }

   callTime = sStr;
   console.log('callTime:' + callTime);

  c=c+1;
  t=setTimeout("timedCount()",1000);
}

/*停止计时器*/
function stopCount()
{
  clearTimeout(t);
  c=0;
}

/*Cloopen显示事件回调通知的自定义函数*/
function notifyCallBack(doFun,msg){
     var call_custid=Ext.getCmp('cmpid').getValue();
     var call_mobile_num = Ext.getCmp('lxrsj').getValue();
     var call_dh_num = Ext.getCmp('dh').getValue();
     if (call_mobile_num == "") {
        call_mobile_num = call_dh_num;
     } 
     //alert(call_custid);
     //alert(call_mobile_num);

	if (doFun == 'invited') {
		// 发起呼叫成功事件
		console.log('发起呼叫成功事件');
		callTime=0;
	}
	else if (doFun == 'invitefailed') {
		// 发起呼叫失败事件
		console.log('发起呼叫失败事件');
	}
	else if (doFun == 'accepted') {
		// 对端应答事件
		console.log('对端应答事件');
		callTime=0;
	}
	else if (doFun == 'ringing') {
		// 来电事件
		console.log('来电事件，号码:'+msg);
	}
	else if (doFun == 'onHangup') {
	    //停止计时
	    stopCount();
		
		//保存通话记录
		if (callTime > 0) {
		     console.log('callTime:'+callTime);
		     console.log('call_custid:'+call_custid);
		     console.log('call_mobile_num:'+call_mobile_num);
		     if (call_mobile_num != "") {
		        saveCallHis(callTime,call_custid,call_mobile_num);
		     }
		     
		}
		
		// 挂机事件
		if (msg == 'normal') {
			console.log('挂机事件: 本端正常挂机');
		}
		else if (msg == 'byed') {
			console.log('挂机事件: 对端正常挂机');
		}
		else if (msg == 'rejected') {
			console.log('挂机事件: 对端拒接');
		}
		else if (msg == 'unallocated') {
			console.log('挂机事件: 呼叫号码为空号');
		}
		else if (msg == 'noresponse') {
			console.log('挂机事件: 呼叫无响应');
		}
		else if (msg == 'noanswer') {
			console.log('挂机事件: 对方无应答');
		}
		else {
			console.log('挂机事件: '+msg);
		}
	} else {
		// 其他未知事件
		console.log(msg);
	}
}

/*Cloopen初始化成功后的自定义函数*/
function initCallBack(){
   console.log('initCallBack:ok');
   callConnFlag = true;
}
</script>
</#macro>


<#-- 树形控件 -->
<#macro tree name url renderTo="Ext.getBody()" fields="'id','text','leaf'"
   expanded="true" multiSelect="false" toolbar="false"
   rootVisible="true" treeId="id" border="false"
   rootText="ExtTree" folderSort="false" dragdrop="false" height=500
   width=200 toolbar="">
    var ${name}TreeStore = Ext.create('Ext.data.TreeStore', {
        fields : [${fields}],
        proxy: {
            type: 'ajax',
            url: '${url}'
        },
        root: {
            text: '${rootText}',
            id : '0',
            expanded: ${expanded}
        }
        <#if folderSort=="true">
	        ,folderSort: true,
	        sorters: [{
	            property: '${treeId}',
	            direction: 'ASC'
	        }]
        </#if>
    });
    var ${name}Tree = Ext.create('Ext.tree.Panel', {
        store: ${name}TreeStore,
        viewConfig: {
         <#if dragdrop=="true">
		        plugins: {
		        	ptype: 'treeviewdragdrop'
		        }
          </#if>
        },
        <#if renderTo!="" >
	       renderTo: ${renderTo},
        </#if>
        height: ${height},
        border:${border},
        width: ${width},
        useArrows: true,
        autoScroll:true,
        multiSelect: ${multiSelect},
        rootVisible: ${rootVisible},
        animate : false

        <#if toolbar=="true" >
		        ,
	        dockedItems: [{
	            xtype: 'toolbar',
	            items: [${toolbar}]
	        }]
        </#if>


    });
</#macro>

<#-- 树形treeGrid控件 -->
<#macro treeGrid name url fields="" columns="" tbar="" renderTo="Ext.getBody()"  title="" collapsible="false"
   height=500 width=200>
    Ext.define('${name}TreeGridMode', {
        extend: 'Ext.data.Model',
        fields: [
            ${fields}
        ]
    });

    var ${name}TreeGridStore = Ext.create('Ext.data.TreeStore', {
        model: '${name}TreeGridMode',
        root: {
            id : '0'
        },
        proxy: {
            type: 'ajax',
            url: '${url}'
        },
        folderSort: true
    });

    var ${name}TreeGrid = Ext.create('Ext.tree.Panel', {
    	<#if title!="" >
	        title: '${title}',
        </#if>
        width: ${width},
        height: ${height},
        <#if renderTo!="" >
	       renderTo: ${renderTo},
        </#if>
        collapsible: ${collapsible},
        useArrows: true,
        forceFit:true,
        rootVisible: false,
        store: ${name}TreeGridStore,
        multiSelect: true,
        singleExpand: true,
        <#if tbar!="">
	            tbar : [
			        ${tbar}
			     ],
	    </#if>
        columns: [${columns}]
    });
</#macro>


<#-- 树形treeGrid控件 -->
<#macro comboTree name url idField fields="'id','text','leaf'" fieldLabel="请选择" renderTo="Ext.getBody()" width=200
   allowBlank="false" emptyText="请选择..." rootText="根目录" expanded="false" userEvent="false">
    var ${name}ComboTree = new Ext.tree.Panel({
		border : false,
		autoScroll : true,
		rootVisible : true,
		animate : false,
		width : 350,
		store : Ext.create('Ext.data.TreeStore', {
					fields : [${fields}],
					proxy : {
						type : 'ajax',
						url : '${url}',
						reader : 'json'
					},
					root : {
						text : '${rootText}',
						id : '0',
						expanded : ${expanded}
					}
				})
	});

	var ${name}ComboxWithTree = new Ext.form.ComboBox({
		id : '${name}',
		store : new Ext.data.SimpleStore({
					fields : [],
					data : [[]]
				}),
		editable : false,
		labelAlign : 'right',
		value : '',
		<#if renderTo!="" >
       		renderTo: ${renderTo},
        </#if>
		emptyText : '${emptyText}',
		fieldLabel : '${fieldLabel}',
		anchor : '98%',
		width:${width},
		mode : 'local',
		triggerAction : 'all',
		maxHeight : 390,
		tpl : "<tpl for='.'><div style='height:390px'><div id='${name}TreeDiv'></div></div></tpl>",
		allowBlank : ${allowBlank}
	});

	// 监听下拉框的下拉展开事件
	${name}ComboxWithTree.on('expand', function() {
	   if (Ext.isEmpty(Ext.getDom('${name}TreeDiv').innerHTML)) {
	      Ext.defer(function() {
    		${name}ComboTree.render(Ext.getDom('${name}TreeDiv'));
		  }, 300, this);
	  }

	});

	${name}ComboTree.on('itemclick', function(view, rec) {
		if (rec) {
		   ${name}ComboxWithTree.setValue(rec.get('text'));

		   if (!Ext.isEmpty(Ext.getCmp('${idField}'))) {
		      Ext.getCmp('${idField}').setValue(rec.get('id'));
	      	  var qryField = Ext.getCmp('qry_${idField}');
	      	  if (!Ext.isEmpty(qryField)) {
	      	      qryField.setValue(rec.get('id'));
	      	  }
		   }

		    <#if userEvent=="true" >
		      ${name}ComboTree_itemclick(rec);
	        </#if>

		    ${name}ComboxWithTree.collapse();
		}
	});
</#macro>

<#-- 下拉 remot store  -->
<#macro RemotCombo name url fieldStr displayField valueField fieldLabel="请选择"  renderTo="Ext.getBody()"
    emptyText="nofind..." remoteFilter="true" hideTrigger="false" >

<@Ctg.store name=name url=url fieldStr=fieldStr autoLoad="false" />

var ${name}RCombo = Ext.create('Ext.form.field.ComboBox', {
    fieldLabel: '${fieldLabel}',
    <#if renderTo!="" >
       		renderTo: ${renderTo},
    </#if>
    displayField: '${displayField}',
    remoteFilter:${remoteFilter},
    hideTrigger:${hideTrigger},
    valueField:'${valueField}',
    store: ${name}Store,
    emptyText : '${emptyText}',
	anchor : '98%',
    typeAhead: true
});
</#macro>

<#-- 下拉grid -->
<#macro comboText name url displayField valueField fieldStr="" innerTpl="" title="请选择" renderTo="Ext.getBody()"
     emptyText="nofind..." loadingText="Searching..." pageSize=10>

    <@Ctg.store name=name url=url autoLoad="false" fieldStr=fieldStr  />

    var ${name}Panel = Ext.create('Ext.panel.Panel', {
        <#if renderTo!="" >
       		renderTo: ${renderTo},
        </#if>
        title: '${title}',
        width: 300,
        bodyPadding: 10,
        layout: 'anchor',
        items: [{
            xtype: 'combo',
            store: ${name}Store,
            displayField: '${displayField}',
        	valueField:'${valueField}',
            typeAhead: false,
            hideLabel: true,
            hideTrigger:true,
            anchor: '98%',
            listConfig: {
                loadingText: '${loadingText}',
                emptyText: '${emptyText}',
                getInnerTpl: function() {
                    return '${innerTpl}';
                }
            },
            pageSize: ${pageSize}
        }, {
            xtype: 'component',
            style: 'margin-top:10px',
            html: 'Live search requires a minimum of 4 characters.'
        }]
    });
</#macro>

<#-- barChart -->
<#macro barChart name store numField cateField numTitle="" cateTitle="" minimum=0 >
	var ${name}Chart = Ext.create('Ext.chart.Chart', {
            id: '${name}ChartCmp',
            xtype: 'chart',
            animate: true,
            shadow: true,
            store: ${store},
            axes: [{
                type: 'Numeric',
                position: 'bottom',
                fields: ['${numField}'],
                label: {
                    renderer: Ext.util.Format.numberRenderer('0,0')
                },
                title: '${numTitle}',
                grid: true,
                minimum: ${minimum}
            }, {
                type: 'Category',
                position: 'left',
                fields: ['${cateField}'],
                title: '${cateTitle}'
            }],
            series: [{
                type: 'bar',
                axis: 'bottom',
                highlight: true,
                tips: {
                  trackMouse: true,
                  width: 140,
                  height: 28,
                  renderer: function(storeItem, item) {
                    this.setTitle(storeItem.get('${cateTitle}') + ': ' + storeItem.get('${numField}'));
                  }
                },
                label: {
                    display: 'insideEnd',
                    field: '${numField}',
                    renderer: Ext.util.Format.numberRenderer('0'),
                    orientation: 'horizontal',
                    color: '#333',
                    'text-anchor': 'middle'
                },
                xField: '${cateTitle}',
                yField: ['${numField}']
            }]
        });
</#macro>

<#-- ColumnChart -->
<#macro columnChart name store numField cateField numTitle="" cateTitle="" minimum=0 >
	var ${name}Chart = Ext.create('Ext.chart.Chart', {
            id: '${name}ChartCmp',
            xtype: 'chart',
            style: 'background:#fff',
            animate: true,
            shadow: true,
            store: ${store},
            axes: [{
                type: 'Numeric',
                position: 'left',
                fields: ['${numField}'],
                label: {
                    renderer: Ext.util.Format.numberRenderer('0,0')
                },
                title: '${numTitle}',
                grid: true,
                minimum: ${minimum}
            }, {
                type: 'Category',
                position: 'bottom',
                fields: ['${cateField}'],
                title: '${cateTitle}'
            }],
            series: [{
                type: 'column',
                axis: 'left',
                highlight: true,
                tips: {
                  trackMouse: true,
                  width: 140,
                  height: 28,
                  renderer: function(storeItem, item) {
                	this.setTitle(storeItem.get('${cateField}') + ': ' + storeItem.get('${numField}'));
                  }
                },
                label: {
                  display: 'insideEnd',
                  'text-anchor': 'middle',
                    field: '${numTitle}',
                    renderer: Ext.util.Format.numberRenderer('0'),
                    orientation: 'vertical',
                    color: '#333'
                },
                xField: '${cateTitle}',
                yField: '${numField}'
            }]
        });
</#macro>


<#-- LineChart -->
<#macro lineChart name store numField cateField numTitle="" cateTitle="" minimum=0 >
	var ${name}Chart = Ext.create('Ext.chart.Chart', {
		xtype : 'chart',
		animate : false,
		store : ${store},
		insetPadding : 30,
		axes : [ {
			type : 'Numeric',
			minimum : 0,
			position : 'left',
			fields : [ '${numField}' ],
			title: '${numTitle}',
			grid : true,
			label : {
				renderer : Ext.util.Format.numberRenderer('0,0'),
				font : '10px Arial'
			}
		}, {
			type : 'Category',
			position : 'bottom',
			fields : [ '${cateField}' ],
			title: '${cateTitle}',
			label : {
				font : '11px Arial',
				renderer : function(name) {
					return name;
				}
			}
		} ],
		series : [ {
			type : 'line',
			axis : 'left',
			xField : '${cateField}',
			yField : '${numField}',
			tips : {
				trackMouse : true,
				width : 110,
				height : 25,
				renderer : function(storeItem, item) {
					this.setTitle(storeItem.get('${numField}')+' '
							+ storeItem.get('${cateField}'));
				}
			},
			style : {
				fill : '#38B8BF',
				stroke : '#38B8BF',
				'stroke-width' : 3
			},
			markerConfig : {
				type : 'circle',
				size : 4,
				radius : 4,
				'stroke-width' : 0,
				fill : '#38B8BF',
				stroke : '#38B8BF'
			}
		} ]
	});
</#macro>


<#-- twoLineChart -->
<#macro tLineChart name store axesFields numField1 numField2 cateField numUnit1="次" numUnit2="分钟" numTitle="" cateTitle="" minimum=0 >
	 var ${name}TLinechart = Ext.create('Ext.chart.Chart', {
            style: 'background:#fff',
            animate: true,
            store: ${store},
            shadow: true,
            theme: 'Category1',
            legend: {
                position: 'right'
            },
            axes: [{
                type: 'Numeric',
                minimum: ${minimum},
                position: 'left',
                fields: [${axesFields}],
                title: '${numTitle}',
                minorTickSteps: 1,
                grid: {
                    odd: {
                        opacity: 1,
                        fill: '#ddd',
                        stroke: '#bbb',
                        'stroke-width': 0.5
                    }
                }
            }, {
                type: 'Category',
                position: 'bottom',
                fields: ['${cateField}'],
                title: '${cateTitle}'
            }],
            series: [{
                type: 'line',
                highlight: {
                    size: 7,
                    radius: 7
                },
                tips : {
					trackMouse : true,
					width : 110,
					height : 25,
					renderer : function(storeItem, item) {
				        var title = '${numUnit1}';
						this.setTitle(storeItem.get('${numField1}')+title);
					}
				},
                axis: 'left',
                xField: '${cateField}',
                yField: '${numField1}',
                markerConfig: {
                    type: 'cross',
                    size: 4,
                    radius: 4,
                    'stroke-width': 0
                }
            }, {
                type: 'line',
                highlight: {
                    size: 7,
                    radius: 7
                },
                tips : {
					trackMouse : true,
					width : 110,
					height : 25,
					renderer : function(storeItem, item) {
						 var title = '${numUnit2}';
						this.setTitle(storeItem.get('${numField2}')+title);
					}
				},
                axis: 'left',
                smooth: true,
                xField: '${cateField}',
                yField: '${numField2}',
                markerConfig: {
                    type: 'circle',
                    size: 4,
                    radius: 4,
                    'stroke-width': 0
                }
            }]
        });
</#macro>

<#-- PieChart -->
<#macro pieChart name store numField cateField numTitle="" cateTitle="" minimum=0 >
	var ${name}Donut = false,
    ${name}Chart = Ext.create('Ext.chart.Chart', {
            xtype: 'chart',
            id: '${name}ChartCmp',
            animate: true,
            store: ${store},
            shadow: true,
            legend: {
                position: 'right'
            },
            insetPadding: 60,
            theme: 'Base:gradients',
            series: [{
                type: 'pie',
                field: '${numField}',
                showInLegend: true,
                donut: ${name}Donut,
                tips: {
                  trackMouse: true,
                  width: 340,
                  height: 28,
                  renderer: function(storeItem, item) {
                    var total = 0;
                    ${store}.each(function(rec) {
                        total += rec.get('${numField}');
                    });
                    this.setTitle(storeItem.get('${cateField}') + '('+Ext.util.Format.round(storeItem.get('${numField}'), 2)
                          + '): ' + Math.round(storeItem.get('${numField}') / total * 100) + '%');
                  }
                },
                highlight: {
                  segment: {
                    margin: 20
                  }
                },
                label: {
                    field: '${cateField}',
                    display: 'rotate',
                    contrast: true,
                    font: '18px Arial'
                }
            }]
        });
</#macro>

<#-- view -->
<#macro view name store tpl renderTo="Ext.getBody()">
 var ${name}View = Ext.create('Ext.view.View', {
        cls: 'patient-view',
        tpl: '<tpl for="."><div class="patient-source"><table><tbody>${tpl}</tbody></table></div></tpl>',
        itemSelector: 'div.patient-source',
        //overItemCls: 'patient-over',
        <#if renderTo!="">
          renderTo: ${renderTo},
        </#if>
        //selectedItemClass: 'patient-selected',
        //singleSelect: true,
        store: ${store}
    });
</#macro>

<#-- image view -->
<#macro imageView store name renderTo="Ext.getBody()"  itemname="itemname" 
    imageurl="imageurl" multiSelect="false">
    var iv${name} = Ext.create('Ext.view.View', {
        deferInitialRefresh: false,
        store: ${store},
        tpl  : Ext.create('Ext.XTemplate',
            '<tpl for=".">',
                '<div class="phone">',
                    (!Ext.isIE6? '<img width="100" height="100" src="${contextPath}/{[values.${imageurl}]}" />' :
                     '<div style="width:200px;height:200px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src=\'${contextPath}/{[values.${imageurl}]}\',sizingMethod=\'scale\')"></div>'),
                    '<br><strong>{${itemname}}</strong>',
                '</div>',
            '</tpl>'
        ),
        id: 'phones',
        itemSelector: 'div.phone',
        overItemCls : 'phone-hover',
        multiSelect : ${multiSelect},
        autoScroll  : true
        <#if renderTo!="" >
           ,renderTo: ${renderTo}
        </#if>
    });
</#macro>

<#-- image view -->
<#macro imagesPanel store name renderTo="Ext.getBody()" title="" itemname="itemname" 
    imageurl="imageurl" width=700 height=500 >
    var ${name}ImagesPanel=  Ext.create('Ext.Panel', {
        id: 'images-view',
        frame: true,
        collapsible: true,
        width: ${width},
        height:${height},
        title: '${title}(0 items selected)',
        <#if renderTo!="" >
       		renderTo: ${renderTo},
        </#if>
        items: Ext.create('Ext.view.View', {
            store: ${store},
            tpl: [
                '<tpl for=".">',
                    '<div class="thumb-wrap" id="{${itemname}:stripTags}">',
                        '<div class="thumb"><img src="{${imageurl}}" title="{${itemname}:htmlEncode}"></div>',
                        '<span class="x-editable">{${itemname}:htmlEncode}</span>',
                    '</div>',
                '</tpl>',
                '<div class="x-clear"></div>'
            ],
            multiSelect: true,
            trackOver: true,
            overItemCls: 'x-item-over',
            itemSelector: 'div.thumb-wrap',
            emptyText: 'No images to display',
            plugins: [
                Ext.create('Ext.ux.DataView.DragSelector', {}),
                Ext.create('Ext.ux.DataView.LabelEditor', {dataIndex: 'itemname'})
            ],
            prepareData: function(data) {
                Ext.apply(data, {
                    shortName: Ext.util.Format.ellipsis(data.name, 15),
                    sizeString: Ext.util.Format.fileSize(data.size),
                    dateString: Ext.util.Format.date(data.lastmod, "m/d/Y g:i a")
                });
                return data;
            },
            listeners: {
                selectionchange: function(dv, nodes ){
                    var l = nodes.length,
                        s = l !== 1 ? 's' : '';
                    this.up('panel').setTitle('Simple DataView (' + l + ' item' + s + ' selected)');
                }
            }
        })
    });

</#macro>

<#-- image view -->
<#macro chartPanel name renderTo="Ext.getBody()" title="" chart="" tbar="" 
    width=700 height=500 >
     var downloadChart = function(chart){
        Ext.MessageBox.confirm('确认下载', '是否保存为图片?', function(choice){
            if(choice == 'yes'){
                chart.save({
                    type: 'image/png'
                });
            }
        });
    };
    var ${name}ChartPanel = Ext.create('widget.panel', {
        title: '${title}',
        layout: 'fit',
        width: ${width},
        height:${height},
        <#if renderTo!="" >
   			renderTo: ${renderTo},
        </#if>
        <#if tbar!="">
            tbar : [
                {
		            text: '保存图片',
		            handler: function(){ downloadChart(callStaticTLinechart); }
		        },
		        ${tbar}
		     ],
	    </#if>
        items: ${chart}
    });

</#macro>

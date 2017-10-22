<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign EventBean= uiDto.EventBean?default('')>
<#assign EventUBean= uiDto.EventUBean?default('')>
<#assign EventBeanId=uiDto.EventBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="事件维护" require="'Ext.ux.RowExpander'">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){
    var curParentId = "0";

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${EventBean}" url="get${EventUBean}Data_${actionName}_${packageName}.do" pageFlag="false" forceFit="true"
         renderTo=""  rowexpander="true" rowBodyTpl="${uiDto.rowExpandTpl}" checkboxModel="false" rowNumberer="false"
         fieldStr="${uiDto.EventFstr}" columnsStr="${uiDto.EventCstr}" tbar="${uiDto.EventTbar}"/>


    <#-- edit form 定义 -->
    <@Ctg.form name="${EventBean}" itemStr="${uiDto.EventIstr}" renderTo=""  />

    <#-- edit window 定义 -->
    var editWin = new Ext.Window({
			    layout : 'fit',
				width : 350,
				height : 300,
				resizable : false,
				draggable : true,
				closeAction : 'hide',
				title : '<span class="commoncss">参数维护</span>',
				modal : false,
				collapsible : true,
				maximizable : false,
				buttonAlign : 'right',
				border : false,
				animCollapse : false,
				y : 20,
				x : document.body.clientWidth / 2 - 420 / 2,
				constrain : true,
				items : [${EventBean}Form],
				buttons : [${uiDto.EventFormTbar}]
			});

	Ext.getCmp('btn${EventBean}_grid_add').on('click',function(){
	    ${EventBean}Form.getForm().reset();
	    editWin.show();
	});


	Ext.getCmp('btn${EventBean}_form_close').on('click',function(){
	    editWin.hide();
	});

	Ext.getCmp('btn${EventBean}_grid_edit').on('click',function(){
	    editInit();
	});

	Ext.getCmp('btn${EventBean}_grid_refresh').on('click',function(){
	    queryData();
	});
	
	Ext.getCmp('btn${EventBean}_grid_del').on('click',function(){
	    deleteItems();
	});

	Ext.getCmp('btn${EventBean}_form_save').on('click',function(){
         saveData('save');
	});		


    function queryData(){
          ${EventBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
							
						 }
		  });
    }
    
    /**
	 * 删除菜单
	 */
	function deleteItems() {
		var rows = ${EventBean}Grid.getSelectionModel().getSelection();
		if (Ext.isEmpty(rows)) {
				Ext.Msg.alert('提示', '请先选中要删除的项目!');
				return;
		}
		var strChecked = jsArray2JsString(rows, 'id');
		Ext.Msg.confirm('请确认', '你真的要删除选中项目吗?', function(btn, text) {
					if (btn == 'yes') {
						//showWaitMsg();
						Ext.Ajax.request({
									url : 'saveEventData_${actionName}_${packageName}.do',
									success : function(response) {
										var resultArray = Ext.JSON
												.decode(response.responseText);
										EventStore.reload();
										Ext.Msg.alert('提示', resultArray.msg);
									},
									failure : function(response) {
										var resultArray = Ext.JSON
												.deparam(response.responseText);
										Ext.Msg.alert('提示', resultArray.msg);
									},
									params : {
										id : strChecked,
										opType: 'del'
									}
								});
					}
				});
	}


	/**
	 * 修改初始化
	 */
	function editInit() {
		var record = ${EventBean}Grid.getSelectionModel().getSelection();

		if (Ext.isEmpty(record)) {
			Ext.Msg.alert('提示', '请先选择您要修改的菜单项目');
			return;
		}

		${EventBean}Form.getForm().loadRecord(record[0]);
		editWin.show();
	}


	/**
	* 保存数据
	*/
	function saveData(opType){
		if (${EventBean}Form.getForm().isValid()) {
			${EventBean}Form.getForm().submit({
						url : 'saveEventData_${actionName}_${packageName}.do',
						waitTitle : '提示',
						method : 'POST',
						waitMsg : '正在保存数据,请稍候.....',
						success : function(form, action) {
	                       Ext.Msg.alert('提示', '保存成功', function() {

						   });
						},
						failure : function(form, action) {
							var errmsg = action.result.msg;
							Ext.Msg.alert('提示', errmsg, function() {
							});
						},
						params : {
							opType : opType
					 	}
			});
		}
	}

	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${EventBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

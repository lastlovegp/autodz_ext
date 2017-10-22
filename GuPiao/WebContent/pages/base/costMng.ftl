<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign positionBean= uiDto.positionBean?default('')>
<#assign positionUBean= uiDto.positionUBean?default('')>
<#assign positionBeanId=uiDto.positionBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>

<@Ctg.page title="成本维护">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${positionBean}" url="get${positionUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageFlag="false" checkboxModel="false" cellEdit="true"
         fieldStr="${uiDto.positionFstr}" columnsStr="${uiDto.positionCstr}" tbar="${uiDto.positionTbar}"/>

	Ext.getCmp('btn${positionBean}_grid_addRow').on('click',function(){
        var r =${uiDto.positionGridNewRowStr}
        ${positionBean}Store.insert(0, r);
        ${positionBean}CellEditing.startEditByPosition({row: 0, column: 0});
	});

	Ext.getCmp('btn${positionBean}_grid_delRow').on('click',function(){
	   ${positionBean}Store.remove(${positionBean}Grid.getSelectionModel().getLastSelected());
	});
	
	Ext.getCmp('btn${positionBean}_grid_save').on('click',function(){
	    saveData();
	});

	Ext.getCmp('btn${positionBean}_grid_refresh').on('click',function(){
	    queryData();
	});


    //简单查询
	function querySimpleParam(){
		queryData();
	}

    function queryData(){
          ${positionBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
					queryParam: Ext.isEmpty(Ext.getCmp('queryParam'))?'':Ext.getCmp('queryParam').getValue()
			    }
		  });
    }

	/**
	 * 删除菜单
	 */
	function saveData() {
		Ext.Ajax.request({
					url : 'saveCostData_${actionName}_${packageName}.do',
					success : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
						${positionBean}Store.reload();
					},
					failure : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					params : {
					    modifyRecs:getDirtydata(positionStore.getModifiedRecords()),
					    delRecs:getDirtydata(positionStore.getRemovedRecords())
					}
				});
	}


	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${positionBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

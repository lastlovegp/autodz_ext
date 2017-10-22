<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign HyBean= uiDto.HyBean?default('')>
<#assign HyUBean= uiDto.HyUBean?default('')>
<#assign HyBeanId=uiDto.HyBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>

<@Ctg.page title="今日行业">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${HyBean}" url="get${HyUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageFlag="true" checkboxModel="false" cellEdit="true"
         fieldStr="${uiDto.HyFstr}" columnsStr="${uiDto.HyCstr}" tbar="${uiDto.HyTbar}"/>	
	
	Ext.getCmp('btn${HyBean}_grid_save').on('click',function(){
	    saveData();
	});

	Ext.getCmp('btn${HyBean}_grid_refresh').on('click',function(){
	    queryData();
	});


    //简单查询
	function querySimpleParam(){
		queryData();
	}

    function queryData(){
          ${HyBean}Store.load({
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
					url : 'saveHyData_${actionName}_${packageName}.do',
					success : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
						${HyBean}Store.reload();
					},
					failure : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					params : {
					    modifyRecs:getDirtydata(HyStore.getModifiedRecords()),
					    delRecs:getDirtydata(HyStore.getRemovedRecords())
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
							items : [${HyBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

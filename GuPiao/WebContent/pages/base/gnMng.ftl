<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign GnBean= uiDto.GnBean?default('')>
<#assign GnUBean= uiDto.GnUBean?default('')>
<#assign GnBeanId=uiDto.GnBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>

<@Ctg.page title="今日行业">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${GnBean}" url="get${GnUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageFlag="true" checkboxModel="false" cellEdit="true"
         fieldStr="${uiDto.GnFstr}" columnsStr="${uiDto.GnCstr}" tbar="${uiDto.GnTbar}"/>	
	
	Ext.getCmp('btn${GnBean}_grid_save').on('click',function(){
	    saveData();
	});

	Ext.getCmp('btn${GnBean}_grid_refresh').on('click',function(){
	    queryData();
	});


    //简单查询
	function querySimpleParam(){
		queryData();
	}

    function queryData(){
          ${GnBean}Store.load({
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
					url : 'saveGnData_${actionName}_${packageName}.do',
					success : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
						${GnBean}Store.reload();
					},
					failure : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					params : {
					    modifyRecs:getDirtydata(GnStore.getModifiedRecords()),
					    delRecs:getDirtydata(GnStore.getRemovedRecords())
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
							items : [${GnBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

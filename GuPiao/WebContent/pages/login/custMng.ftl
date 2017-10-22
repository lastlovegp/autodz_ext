<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>

<@Ctg.page title="客户维护">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="user" url="getUserData_${actionName}_${packageName}.do" pageFlag="true"
         renderTo="" pageSize=20 checkboxModel="true" cellEdit="true"  rowNumberer="false"
         fieldStr="${uiDto.userFstr}" columnsStr="${uiDto.userCstr}" tbar="${uiDto.userTbar}"/>

	Ext.getCmp('btnuser_grid_refresh').on('click',function(){
	    queryData();
	});

	Ext.getCmp('btnuser_grid_save').on('click',function(){
	    saveData();
	});

    //简单查询
	function querySimpleParam(){
		queryData();
	}

    function queryData(){
          userStore.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
					queryParam: Ext.isEmpty(Ext.getCmp('queryParam'))?'':Ext.getCmp('queryParam').getValue()
			    }
		  });
    }

	function saveData() {
		Ext.Ajax.request({
					url : 'saveCustList_${actionName}_${packageName}.do',
					success : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					failure : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					params : {
					    modifyRecs:getDirtydata(userStore.getModifiedRecords())
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
							items : [userGrid]
						}]
			});


});
</script>

</@Ctg.page>

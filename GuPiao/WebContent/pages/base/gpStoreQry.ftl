<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign GpstoreBean= uiDto.GpstoreBean?default('')>
<#assign GpstoreUBean= uiDto.GpstoreUBean?default('')>
<#assign GpstoreBeanId=uiDto.GpstoreBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="股票池查询">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${GpstoreBean}" url="get${GpstoreUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false" cellEdit="true" autoLoad="true" forceFit="true"
         fieldStr="${uiDto.GpstoreFstr}" columnsStr="${uiDto.GpstoreCstr}" tbar="${uiDto.GpstoreTbar}"/>
     
    Ext.getCmp('btn${GpstoreBean}_grid_addRow').on('click',function(){
        var r =${uiDto.GpstoreGridNewRowStr}
        ${GpstoreBean}Store.insert(0, r);
        ${GpstoreBean}CellEditing.startEditByPosition({row: 0, column: 0});
	});

	Ext.getCmp('btn${GpstoreBean}_grid_delRow').on('click',function(){
	   ${GpstoreBean}Store.remove(${GpstoreBean}Grid.getSelectionModel().getLastSelected());
	});
	
	Ext.getCmp('btn${GpstoreBean}_grid_save').on('click',function(){
	    saveData();
	});            
         
    function queryData(){
          ${GpstoreBean}Store.getProxy().url = 'get${GpstoreUBean}Data_${actionName}_${packageName}.do?';
		  ${GpstoreBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    }
		  });	
    }
    
   Ext.getCmp('btnGpstore_grid_refresh').on('click',function(){
		 queryData();
   });
   
   /**
	 * 删除菜单
	 */
	function saveData() {
		Ext.Ajax.request({
					url : 'saveGpstoreData_${actionName}_${packageName}.do',
					success : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
						${GpstoreBean}Store.reload();
					},
					failure : function(response) {
						var resultArray = Ext.JSON
								.decode(response.responseText);
						Ext.Msg.alert('提示', resultArray.msg);
					},
					params : {
					    modifyRecs:getDirtydata(GpstoreStore.getModifiedRecords()),
					    delRecs:getDirtydata(GpstoreStore.getRemovedRecords())
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
							items : [${GpstoreBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

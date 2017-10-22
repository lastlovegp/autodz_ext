<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign storeBean= uiDto.storeBean?default('')>
<#assign storeUBean= uiDto.storeUBean?default('')>
<#assign storeBeanId=uiDto.storeBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="仓位查询">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${storeBean}" url="get${storeUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false"  autoLoad="true" forceFit="true"
         fieldStr="${uiDto.storeFstr}" columnsStr="${uiDto.storeCstr}" tbar="${uiDto.storeTbar}"/>
                 
         
    function queryData(){
          ${storeBean}Store.getProxy().url = 'get${storeUBean}Data_${actionName}_${packageName}.do?';
		  ${storeBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    }
		  });	
    }
    
   Ext.getCmp('btnstore_grid_refresh').on('click',function(){
		 queryData();
   });
     
   
	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${storeBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

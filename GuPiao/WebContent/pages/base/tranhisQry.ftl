<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign tranhisBean= uiDto.tranhisBean?default('')>
<#assign tranhisUBean= uiDto.tranhisUBean?default('')>
<#assign tranhisBeanId=uiDto.tranhisBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="交易历史">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${tranhisBean}" url="get${tranhisUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false"  autoLoad="true" 
         fieldStr="${uiDto.tranhisFstr}" columnsStr="${uiDto.tranhisCstr}" tbar="${uiDto.tranhisTbar}"/>
                 
         
    function queryData(){
          ${tranhisBean}Store.getProxy().url = 'get${tranhisUBean}Data_${actionName}_${packageName}.do?';
		  ${tranhisBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    }
		  });	
    }
    
   Ext.getCmp('btntranhis_grid_refresh').on('click',function(){
		 queryData();
   });
     
   
	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${tranhisBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

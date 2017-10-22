<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign jjlogBean= uiDto.jjlogBean?default('')>
<#assign jjlogUBean= uiDto.jjlogUBean?default('')>
<#assign jjlogBeanId=uiDto.jjlogBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="交易日志">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${jjlogBean}" url="get${jjlogUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false"  autoLoad="true" 
         fieldStr="${uiDto.jjlogFstr}" columnsStr="${uiDto.jjlogCstr}" tbar="${uiDto.jjlogTbar}"/>
                 
         
    function queryData(){
          ${jjlogBean}Store.getProxy().url = 'get${jjlogUBean}Data_${actionName}_${packageName}.do?';
		  ${jjlogBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    }
		  });	
    }
    
   Ext.getCmp('btnjjlog_grid_refresh').on('click',function(){
		 queryData();
   });
     
   
	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${jjlogBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

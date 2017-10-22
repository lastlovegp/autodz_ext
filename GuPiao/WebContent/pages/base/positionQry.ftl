<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign positionBean= uiDto.positionBean?default('')>
<#assign positionUBean= uiDto.positionUBean?default('')>
<#assign positionBeanId=uiDto.positionBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="仓位查询">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${positionBean}" url="get${positionUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false"  autoLoad="true" 
         fieldStr="${uiDto.positionFstr}" columnsStr="${uiDto.positionCstr}" tbar="${uiDto.positionTbar}"/>
                 
         
    function queryData(){
          ${positionBean}Store.getProxy().url = 'get${positionUBean}Data_${actionName}_${packageName}.do?';
		  ${positionBean}Store.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    }
		  });	
    }
    
    
    Ext.getCmp('btnposition_grid_buyin').on('click',function(){
        
        var rows = ${positionBean}Grid.getSelectionModel().getSelection();
		if (Ext.isEmpty(rows)) {
				Ext.Msg.alert('提示', '请先选中要买入的股票!');
				return;
		}
		var code = jsArray2JsString(rows, 'code');
		
		Ext.Ajax.request({
			url : 'buyIn_${actionName}_${packageName}.do',
			success : function(response) {
				var resultArray = Ext.JSON
						.decode(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
			},
			failure : function(response) {
				var resultArray = Ext.JSON
						.deparam(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
			},
			params : {
				code : code,
				buyprice : Ext.getCmp('buyprice').getValue(),				
				num: Ext.getCmp('buynum').getValue()
			}
		});
   });
   
    Ext.getCmp('btnposition_grid_updcost').on('click',function(){
        
        var rows = ${positionBean}Grid.getSelectionModel().getSelection();
		if (Ext.isEmpty(rows)) {
				Ext.Msg.alert('提示', '请先选中要买入的股票!');
				return;
		}
		var code = jsArray2JsString(rows, 'code');
		
		Ext.Ajax.request({
			url : 'updcost_${actionName}_${packageName}.do',
			success : function(response) {
				var resultArray = Ext.JSON
						.decode(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
				queryData();
			},
			failure : function(response) {
				var resultArray = Ext.JSON
						.deparam(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
			},
			params : {
				code : code,
				buyprice : Ext.getCmp('buyprice').getValue(),				
				num: Ext.getCmp('buynum').getValue()
			}
		});
   });
   
    Ext.getCmp('btnposition_grid_sellout').on('click',function(){
        
        var rows = ${positionBean}Grid.getSelectionModel().getSelection();
		if (Ext.isEmpty(rows)) {
				Ext.Msg.alert('提示', '请先选中要买入的股票!');
				return;
		}
		var code = jsArray2JsString(rows, 'code');
		
		Ext.Ajax.request({
			url : 'sellOut_${actionName}_${packageName}.do',
			success : function(response) {
				var resultArray = Ext.JSON
						.decode(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
			},
			failure : function(response) {
				var resultArray = Ext.JSON
						.deparam(response.responseText);
				Ext.Msg.alert('提示', resultArray.msg);
			},
			params : {
				code : code,
				num: Ext.getCmp('buynum').getValue()
			}
		});
   });
    
   Ext.getCmp('btnposition_grid_refresh').on('click',function(){
		 queryData();
   });
   
   Ext.getCmp('btnposition_grid_fengx').on('click',function(){
    	var rec = ${positionBean}Grid.getSelectionModel().getLastSelected();
    	if (rec != null) {    	    
    		window.open('dailyBarFx_gpMonitor_base.do?code='+rec.data.code+'&name='+rec.data.name,'['+rec.data.code+']信号分析');
    	} else {
    	    alert('没有选中记录！');    	    
    	}    	
		
   });
   
    Ext.getCmp('btnposition_grid_retest').on('click',function(){
    
       var rec = ${positionBean}Grid.getSelectionModel().getLastSelected();
    	if (rec != null) {    	    	   
    		Ext.Ajax.request({
					url : 'reTestData_${actionName}_${packageName}.do',
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
					    code:rec.data.code,
					    bdate:rec.data.indate				    
					}
				}); 
    	} else {
    	    alert('没有选中记录！');    	    
    	}    	
    
    		
		
   });
     
   
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

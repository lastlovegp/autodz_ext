<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign JumprecBean= uiDto.JumprecBean?default('')>
<#assign JumprecUBean= uiDto.JumprecUBean?default('')>
<#assign JumprecBeanId=uiDto.JumprecBeanId?default('')>
<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>
<@Ctg.page title="行业查询">
<body>
</body>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- 菜单 grid 定义 -->
    <@Ctg.grid name="${JumprecBean}" url="get${JumprecUBean}Data_${actionName}_${packageName}.do"
         renderTo="" pageSize=20  pageFlag="true"  checkboxModel="false"  autoLoad="true" forceFit="true"
         fieldStr="${uiDto.JumprecFstr}" columnsStr="${uiDto.JumprecCstr}" tbar="${uiDto.JumprecTbar}"/>
    
    var qrycon = '1';
    JumprecStore.on("beforeload",function(){
        //alert(qrycon);
	    Ext.apply(JumprecStore.proxy.extraParams, {qrycon:qrycon});
	});             
         
    
   Ext.getCmp('btnJumprec_grid_reset').on('click',function(){   
         Ext.getCmp('qrycon').reset();
         JumprecStore.loadPage(1);
   }); 
    
   Ext.getCmp('btnJumprec_grid_query').on('click',function(){
   		 qrycon = Ext.getCmp('qrycon').getValue();
		 JumprecStore.getProxy().url = 'get${JumprecUBean}Data_${actionName}_${packageName}.do';
		 JumprecStore.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
							qrycon:Ext.getCmp('qrycon').getValue()
						 }
		  });	
		  
   });
   
   Ext.getCmp('btnJumprec_grid_dbxt').on('click',function(){
         qrycon = 'dbxt';
		 JumprecStore.getProxy().url = 'get${JumprecUBean}Data_${actionName}_${packageName}.do';
		 JumprecStore.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
							qrycon:'dbxt'
						 }
		  });	
		  
   });
   
   Ext.getCmp('btnJumprec_grid_zpyx').on('click',function(){
   		 qrycon = 'zpyx';
		 JumprecStore.getProxy().url = 'get${JumprecUBean}Data_${actionName}_${packageName}.do';
		 JumprecStore.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
							qrycon:'zpyx'
						 }
		  });	
   });
   
     Ext.getCmp('btnJumprec_grid_pzyx').on('click',function(){
         qrycon = 'pzyx';
		 JumprecStore.getProxy().url = 'get${JumprecUBean}Data_${actionName}_${packageName}.do';
		 JumprecStore.load({
	            //回调函数
			    callback: function(records, operation, success) {
			    },
			    params : {
							qrycon:'pzyx'
						 }
		  });
		  
		  Ext.apply(JumprecStore.proxy.extraParams, {qrycon:'pzyx'});	
   });
    
   Ext.getCmp('btnJumprec_grid_gpbuy').on('click',function(){
        
        var rows = ${JumprecUBean}Grid.getSelectionModel().getSelection();
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
				num: Ext.getCmp('buynum').getValue()
			}
		});
   });
     
   
	<#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [${JumprecBean}Grid]
						}]
			});


});
</script>

</@Ctg.page>

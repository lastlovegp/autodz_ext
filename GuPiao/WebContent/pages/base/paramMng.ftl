<#import "/common/include/CommonTagMacro.ftl" as Ctg>

<@Ctg.page title="参数维护">
<script type="text/javascript">
Ext.onReady(function(){

       <@Ctg.form name="Gpparam" height=150 layoutType="table" columns=3  
   			itemStr="${uiDto.GpparamIstr}" tbar="${uiDto.GpparamFormTbar}"    />
   			
	   	GpparamForm.getForm().load({
						url : 'getParam_gpMonitor_base.do',
						waitMsg : '正在加载，请稍等...',
						params : {
								
						},
						success :function(form, action) {
						},
						failure : function(form, action) {
							 Ext.Msg.alert('失败', action.result.msg, function() {
							 	                          
						   	 });
						}
		});
	    

		Ext.getCmp('btnGpparam_form_save').on('click',function(){
	        saveData();
		});
		
		Ext.getCmp('btnGpparam_form_refresh').on('click',function(){
	       	GpparamForm.getForm().load({
						url : 'getParam_gpMonitor_base.do',
						waitMsg : '正在加载，请稍等...',
						params : {
								
						},
						success :function(form, action) {
						},
						failure : function(form, action) {
							 Ext.Msg.alert('失败', action.result.msg, function() {
							 	                          
						   	 });
						}
			});
		});
		
		
		/**
		* 保存数据
		*/
		function saveData(){
			if (GpparamForm.getForm().isValid()) {
				GpparamForm.getForm().submit({
							url : 'saveParamData_gpMonitor_base.do',
							waitTitle : '提示',
							method : 'POST',
							waitMsg : '正在保存数据,请稍候.....',
							success : function(form, action) {
		                       Ext.Msg.alert('提示', '修改成功', function() {
							   });
							},
							failure : function(form, action) {
								var errmsg = action.result.msg;
								Ext.Msg.alert('提示', errmsg, function() {
								});
							},
							params : {
								opType : 'save'
						 	}
				});
			}
		}
   			
     <#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [GpparamForm]
						}]
			});

});
</script>

</@Ctg.page>

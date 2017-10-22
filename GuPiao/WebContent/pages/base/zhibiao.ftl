<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign code= uiDto.code?default('')>
<#assign date= uiDto.date?default('')>
<#assign type= uiDto.type?default('')>
<@Ctg.page title="指标显示">
<script type="text/javascript">
Ext.onReady(function(){

       <@Ctg.form name="Gpzhibiao" title="${code}指标详解" height=150  labelAlign="top"
            defaultsFlag="true" readOnly="true" layoutType="table" columns=4
   			itemStr="${uiDto.GpzhibiaoIstr}" tbar="${uiDto.GpzhibiaoFormTbar}"    />
   			
	   	GpzhibiaoForm.getForm().load({
						url : 'getZhibiao_gpMonitor_base.do',
						waitMsg : '正在加载，请稍等...',
						params : {
								code:'${code}',
								type:'${type}',
								date:'${date}'
						},
						success :function(form, action) {
						},
						failure : function(form, action) {
							 Ext.Msg.alert('失败', action.result.msg, function() {
							 
						   	 });
						}
		});
	    

		Ext.getCmp('btnGpzhibiao_form_save').on('click',function(){
	        saveData();
		});
		
		Ext.getCmp('btnGpzhibiao_form_refresh').on('click',function(){
	       	GpzhibiaoForm.getForm().load({
						url : 'getZhibiao_gpMonitor_base.do',
						waitMsg : '正在加载，请稍等...',
						params : {
						  code:'${code}',
						  type:'${type}',
						  date:'${date}'
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
		}
   			
     <#-- 排版 -->
	var viewport = new Ext.Viewport({
				layout : 'border',
				items : [{
							region : 'center',
							layout : 'fit',
							border : false,
							items : [GpzhibiaoForm]
						}]
			});

});
</script>

</@Ctg.page>

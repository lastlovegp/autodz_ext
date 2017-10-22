<#import "/common/include/CommonTagMacro.ftl" as Ctg>

<#assign userid= uiDto.userInfo.userid?default('')>

<@Ctg.page title="用户维护">
<div id="userInitForm" ></div>
<script type="text/javascript">
Ext.onReady(function(){

	       <@Ctg.form name="user" height=150 layoutType="table" columns=2  renderTo="userInitForm" 
	   			itemStr="${uiDto.userIstr}" buttons="${uiDto.userFormTbar}"    />
	   			
		   	userForm.getForm().load({
							url : 'getUser_user_login.do',
							waitMsg : '正在加载，请稍等...',
							params : {
								userid : '${userid}'
							},
							success :function(form, action) {
							},
							failure : function(form, action) {
								 Ext.Msg.alert('失败', action.result.msg, function() {
		                          
							   	 });
							}
			});
		    
    
    		Ext.getCmp('btnuser_form_save').on('click',function(){
		        saveData();
			});
			
			
			/**
			* 保存数据
			*/
			function saveData(){
				if (userForm.getForm().isValid()) {
					userForm.getForm().submit({
								url : 'saveUserInfo_login_login.do',
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
									opType : 'chg'
							 	}
					});
				}
			}
   			


});
</script>

</@Ctg.page>

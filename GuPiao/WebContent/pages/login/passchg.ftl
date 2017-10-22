<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign pwdChgBean= uiDto.pwdChgBean?default('')>
<#assign pwdChgUBean= uiDto.pwdChgUBean?default('')>
<#assign pwdChgBeanId=uiDto.pwdChgBeanId?default('')>

<#assign actionName= uiDto.actionName?default('')>
<#assign packageName= uiDto.packageName?default('')>


<#assign account= uiDto.userInfo.account?default('')>
<#assign username= uiDto.userInfo.username?default('')>
<#assign userId= uiDto.userInfo.userid?default('')>
<@Ctg.page title="用户密码修改" enablExt="true">
<div id="userInitForm" ></div>
<script type="text/javascript">
Ext.onReady(function(){

    <#-- edit form 定义 -->
    <@Ctg.form name="${pwdChgBean}" width=350 height=200 itemStr="${uiDto.pwdChgIstr}" renderTo="userInitForm" buttons="${uiDto.pwdChgFormTbar}" />


    ${pwdChgBean}Form.getForm().setValues(
	    {
            account: '${account}',
		    username: '${username}'
	    }
    )


	Ext.getCmp('btn${pwdChgBean}_form_save').on('click',function(){
         saveData();
	});


	/**
	* 保存数据
	*/
	function saveData(){
		if (${pwdChgBean}Form.getForm().isValid()) {
			${pwdChgBean}Form.getForm().submit({
						url : 'userPwdChg_${actionName}_${packageName}.do',
						waitTitle : '提示',
						method : 'POST',
						waitMsg : '正在保存数据,请稍候.....',
						success : function(form, action) {
	                       Ext.Msg.alert('提示', action.result.msg, function() {

						   });
						},
						failure : function(form, action) {
							Ext.Msg.alert('提示', action.result.msg, function() {

							});
						},
						params : {
						}
			});
		}
	}



});
</script>

</@Ctg.page>

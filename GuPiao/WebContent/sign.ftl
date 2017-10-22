<#import "/common/include/IndexTagMacro.ftl" as Ctg>
<#import "/common/include/CommonTagMacro.ftl" as ext>
<@Ctg.chead>
	<@Ctg.cbody enSlider = "true">
	
	   <@Ctg.box title="注册&登录">
	     <table cellspacing="10">
	      <tr>
	        <td valign="top"><div id="login_div">&nbsp;</div></td>
	        <td valign="top"><div id="sign_div">&nbsp;</div></td>
	      </tr>
	     </table>
	   </@Ctg.box>
	
	</@Ctg.cbody>
	
	<script type="text/javascript">
	 Ext.onReady(function(){
          <@ext.form name="login" height=170 title="登录" width=350
   			itemStr="${uiDto.login_EauserIstr}" renderTo="login_div" buttons="${uiDto.login_EauserFormTbar}"    />
 
	 	  <@ext.form name="sign" height=170 layoutType="table" columns=2 title="注册" width=520
   			itemStr="${uiDto.EauserIstr}" renderTo="sign_div" buttons="${uiDto.EauserFormTbar}"    />
   			
   				
			Ext.getCmp('btnlogin_Eauser_form_login').on('click',function(){
		        login(loginForm);
			});	
			
			Ext.getCmp('btnEauser_form_save').on('click',function(){
		        saveData("sign");
			});
			
			
			/**
			* 保存数据
			*/
			function saveData(opType){
				if (signForm.getForm().isValid()) {
					signForm.getForm().submit({
								url : 'saveUserInfo_login_login.do?filterType=no',
								waitTitle : '提示',
								method : 'POST',
								waitMsg : '正在保存数据,请稍候.....',
								success : function(form, action) {
			                       Ext.Msg.alert('提示', '注册成功', function() {
								   });
								},
								failure : function(form, action) {
									var errmsg = action.result.msg;
									Ext.Msg.alert('提示', errmsg, function() {
									});
								},
								params : {
									opType : opType
							 	}
					});
				}
			}
   			
		   /**
			 * 提交登陆请求
			 */
			function login(form) {
				
				if (form.isValid()) {
					form.submit({
						url : 'loginCheck.do',
						waitTitle : '提示',
						method : 'POST',
						waitMsg : '正在验证您的身份,请稍候.....',
						success : function(form, action) {
							Ext.Msg.alert('提示', '登录成功', function() {
								window.location.href='loginInit.do';
							});
						},
						failure : function(form, action) {
							var errmsg = action.result.msg;
							var errtype = action.result.errorType;
							Ext.Msg.alert('提示', errmsg, function() {
								window.location.href='sign.do';
							});
						}
					});
				}
			}
			
	 });

    </script>
</@Ctg.chead>
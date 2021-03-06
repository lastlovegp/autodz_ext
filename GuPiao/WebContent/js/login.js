Ext.onReady(function() {
	var loginImage = Ext.create('Ext.Img', {
		src : '/CallSell/images/kefu.jpg'
	});
	
	// 清除按钮上下文菜单
	var mainMenu = new Ext.menu.Menu({
		id : 'mainMenu',
		items : [ {
			text : '清除记忆',
			iconCls : 'status_awayIcon',
			handler : function() {
				clearCookie('myerp.login.account');
				var account = Ext.getCmp('account');
				Ext.getCmp('loginForm').form.reset();
				account.setValue('');
				account.focus();
			}
		} ]
	});

	var tab2 = Ext.widget({
		border : false,
		xtype : 'form',
		id : 'loginForm',
		collapsible : false,
		bodyPadding : 0,
		width : 600,
		fieldDefaults : {
			msgTarget : 'side'
		},
		defaults : {
			anchor : '100%'
		},

		items : [ loginImage, {
			xtype : 'tabpanel',
			plain : true,
			activeTab : 0,
			height : 235,
			defaults : {
				bodyPadding : 0,
				border : false
			},
			items : [ {
				title : '<span style="font-size:12px">身份认证</span>',
				xtype : 'form',
				defaults : {
					width : 350,
					labelWidth : 100,
					labelAlign : 'right'
				},
				border : false,
				defaultType : 'textfield',
				items : [ {
					hideLabel : true,
					xtype : 'displayfield',
		            anchor:'100% 20%'
		        }, {
					fieldLabel : '帐&nbsp;号:',
					name : 'account',
					id : 'account',
					blankText : '帐号不能为空,请输入!',
					maxLength : 30,
					maxLengthText : '账号的最大长度为30个字符',
					allowBlank : false,
					listeners : {
						specialkey : function(field, e) {
							if (e.getKey() == Ext.EventObject.ENTER) {
								Ext.getCmp('password').focus();
							}
						}
					}
				}, {
					fieldLabel : '密&nbsp;码:',
					name : 'password',
					id : 'password',
					inputType : 'password',
					blankText : '密码不能为空,请输入!',
					maxLength : 20,
					maxLengthText : '密码的最大长度为20个字符',
					allowBlank : false,
					listeners : {
						specialkey : function(field, e) {
							if (e.getKey() == Ext.EventObject.ENTER) {
								login(Ext.getCmp('loginForm').getForm());
							}
						}
					}
				} ]
			}, {
				title : '<span style="font-size:12px">信息公告</span>',
				contentEl : 'infoDiv',
				border : false,
				defaults : {
					width : 230
				}
			}, {
				title : '<span style="font-size:12px">关于</span>',
				contentEl : 'aboutDiv',
				border : false,
				defaults : {
					width : 230
				}
			} ]
		} ]
	});

	/**
	 * 提交登陆请求
	 */
	function login(form) {
		
        if (Ext.isIE6 || Ext.isIE7 || Ext.isIE8) {
        	Ext.Msg.show({
        	     title:'浏览器不适配',
        	     msg: '您的IE浏览器太低了，只支持IE9，请升级浏览器或者使用火狐，谷歌浏览器',
        	     buttons: Ext.Msg.YES,
        	     icon: Ext.Msg.WARNING 
        	});
        	return;
        }
		
		if (form.isValid()) {
			form.submit({
				url : 'loginCheck.do',
				waitTitle : '提示',
				method : 'POST',
				waitMsg : '正在验证您的身份,请稍候.....',
				success : function(form, action) {
					var account = Ext.getCmp('account');
					setCookie("myerp.login.account", account.getValue(), 240);
					setCookie("myerp.login.userid", action.result.userid, 240);
					setCookie("myerp.lockflag", '0', 240);
					window.location.href='indexInit.do';
				},
				failure : function(form, action) {
					var errmsg = action.result.msg;
					var errtype = action.result.errorType;
					Ext.Msg.alert('提示', errmsg, function() {
						var account = Ext.getCmp('account');
						var password = Ext.getCmp('password');
						if (errtype == '1') {
							form.reset();
							account.focus();
							account.validate();
						} else if (errtype == '2') {
							password.focus();
							password.setValue('');
						} else if (errtype == '3') {
							account.focus();
						}
					});
				}
			});
		}
	}

	var win = new Ext.Window({
		title : '<span style="font-size:12px">系统登录</span>',
		renderTo : Ext.getBody(),
		layout : 'fit',
		width : 460,
		height : 300,
		closeAction : 'hide',
		plain : true,
		collapsible : false,
		titleCollapse : true,
		maximizable : false,
		draggable : false,
		closable : false,
		resizable : false,
		autoShow : true,
		animateTarget : document.body,
		items : tab2,
		buttons : [ {
			text : '登录',
			iconCls : 'acceptIcon',
			handler : function() {
				login(Ext.getCmp('loginForm').getForm());
			}
		}, {
			text : '选项',
			iconCls : 'tbar_synchronizeIcon',
			menu : mainMenu
		} ]
	});

	win.on('show', function() {
		setTimeout(function() {
			var account = Ext.getCmp('account');
			var password = Ext.getCmp('password');
			var c_account = getCookie('myerp.login.account');
			account.setValue(c_account);
			if (Ext.isEmpty(c_account)) {
				account.focus();
			} else {
				password.focus();
			}
		}, 200);
	}, this);

});
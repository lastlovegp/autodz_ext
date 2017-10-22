Ext.Loader.setConfig({
	enabled : true
});
Ext.Loader.setPath('Ext.ux', '/CallSell/pages/ux/');
Ext.require([ '*' ]);

Ext.define('dicMode', {
	extend : 'Ext.data.Model',
	fields : [ {
		type : 'string',
		name : 'field'
	}, {
		type : 'string',
		name : 'fieldname'
	}, {
		type : 'string',
		name : 'code'
	}, {
		type : 'string',
		name : 'codetype'
	}, {
		type : 'string',
		name : 'codedesc'
	} ]
});

//生成几位随机数
function RndNum(n){
  var rnd="";
  for(var i=0;i<n;i++)
     rnd+=Math.floor(Math.random()*10);
  return rnd;
}

var checkNum =  RndNum(4);

// 必输项
var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';

function SEXCodeTrans(code) {
	switch (code) {
	case '0':
		return '男';
	case '1':
		return '女';
	default:
		return code;
	}
};
function YESORNOCodeTrans(code) {
	switch (code) {
	case 'Y':
		return '是';
	case 'N':
		return '否';
	default:
		return code;
	}
};

Ext.onReady(function() {
	Ext.QuickTips.init();

	Ext.apply(Ext.form.field.VTypes, {
		mobilephone : function(val, field) {
			return /(^0?[1][3-8][0-9]{9}$)/.test(val);
		},
		mobilephoneText : '请输入正确的手机号码',

		phone : function(v) {
			return /^\d{3}-\d{8}|\d{4}-\d{7}$/.test(v);
		},
		phoneText : '请输入正确的电话号码'
	});

	var loginForm = Ext.widget({
		xtype : 'form',
		layout : {
			type : 'anchor'
		},
		id : 'id_loginForm',
		tools : [],
		titleCollapse : true,
		collapsible : false,
		frame : true,
		autoScroll : false,
		border : false,
		collapsed : false,
		bodyPadding : '0 0 0 0',
		renderTo : login_div,
		title : '登录',
		width : 350,
		height : 170,
		fieldDefaults : {
			msgTarget : 'side',
			labelAlign : 'right',
			labelWidth : 85
		},
		items : [ {
			xtype : 'fieldcontainer',
			fieldLabel : '',
			combineErrors : false,
			msgTarget : 'under',
			items : [ {
				xtype : 'textfield',
				fieldLabel : '账号',
				name : 'account',
				id : 'account',
				blankText : '帐号不能为空,请输入!',
				maxLength : 30,
				maxLengthText : '账号的最大长度为30个字符',
				width : 300,
				allowBlank : false,
				afterLabelTextTpl : required,
				listeners : {
					specialkey : function(field, e) {
						if (e.getKey() == Ext.EventObject.ENTER) {
							Ext.getCmp('password').focus();
						}
					}
				}
			} ],
			layout : 'hbox'
		}, {
			xtype : 'fieldcontainer',
			fieldLabel : '',
			combineErrors : false,
			msgTarget : 'under',
			items : [ {
				xtype : 'textfield',
				fieldLabel : '密码',
				name : 'password',
				id:'password',
				width : 300,
				blankText : '密码不能为空,请输入!',
				maxLength : 20,
				maxLengthText : '密码的最大长度为20个字符',
				allowBlank : false,
				inputType : 'password',
				afterLabelTextTpl : required,
				listeners : {
					specialkey : function(field, e) {
						if (e.getKey() == Ext.EventObject.ENTER) {
							Ext.getCmp('randomInput').focus();
						}
					}
				}
			} ],
			layout : 'hbox'
		}, {
			xtype : 'fieldcontainer',
			fieldLabel : '',
			combineErrors : false,
			msgTarget : 'under',
			items : [ {
				xtype : 'hidden',
				name : 'randomHidden',
				id : 'randomHidden',
				value : checkNum
			}, {
				xtype : 'displayfield',
				fieldLabel : '验证码',
				name : 'random',
				id:'random',
				width : 150,
				value : checkNum
			}, {
				xtype : 'textfield',
				fieldLabel : '验证码',
				name : 'randomInput',
				id : 'randomInput',
				blankText : '验证码能为空,请输入!',
				width : 150,
				allowBlank : false,
				hideLabel : true,
				afterLabelTextTpl : required,
				listeners : {
					specialkey : function(field, e) {
						if (e.getKey() == Ext.EventObject.ENTER) {
							login(loginForm.getForm());
						}
					}
				}
			}],
			layout : 'hbox'
		} ],
		buttons : [ {
			text : '登录',
			id : 'btnlogin_Eauser_form_login',
			iconCls : 'acceptIcon',
			iconAlign : 'left'
		} ]
	});

	var signForm = Ext.widget({
		xtype : 'form',
		layout : {
			type : 'table',
			columns : 2
		},
		id : 'id_signForm',
		tools : [],
		titleCollapse : true,
		collapsible : false,
		frame : true,
		autoScroll : false,
		border : false,
		collapsed : false,
		bodyPadding : '0 0 0 0',
		renderTo : sign_div,
		title : '注册',
		width : 520,
		height : 170,
		fieldDefaults : {
			msgTarget : 'side',
			labelAlign : 'right',
			labelWidth : 85
		},
		items : [ {
			xtype : 'fieldcontainer',
			fieldLabel : '',
			combineErrors : false,
			msgTarget : 'under',
			items : [ {
				xtype : 'textfield',
				fieldLabel : '账号',
				name : 'account',
				width : 250,
				allowBlank : false,
				afterLabelTextTpl : required
			} ]
		}, {
			xtype : 'textfield',
			fieldLabel : '姓名',
			name : 'username',
			width : 250,
			allowBlank : false,
			afterLabelTextTpl : required
		}, {
			xtype : 'textfield',
			fieldLabel : '电子邮件',
			name : 'email',
			width : 250,
			allowBlank : false,
			vtype : 'email',
			afterLabelTextTpl : required
		}, {
			xtype : 'textfield',
			fieldLabel : '电话',
			name : 'tel',
			width : 250,
			allowBlank : false,
			vtype : 'mobilephone',
			afterLabelTextTpl : required
		}, {
			xtype : 'textfield',
			fieldLabel : '城市',
			name : 'city',
			width : 250
		}, {
			xtype : 'combo',
			width : 250,
			editable : false,
			multiSelect : false,
			fieldLabel : '性别',
			displayField : 'codedesc',
			valueField : 'code',
			store : Ext.create('Ext.data.Store', {
				model : 'dicMode',
				data : [ {
					code : '0',
					codetype : '',
					codedesc : '男'
				}, {
					code : '1',
					codetype : '',
					codedesc : '女'
				} ]
			}),
			queryMode : 'local',
			typeAhead : false,
			value : '0',
			name : 'sex'
		} ],
		buttons : [ {
			text : '保存',
			id : 'btnEauser_form_save',
			iconCls : 'acceptIcon',
			iconAlign : 'left'
		} ]
	});

	Ext.getCmp('btnlogin_Eauser_form_login').on('click', function() {
		login(loginForm);
	});

	Ext.getCmp('btnEauser_form_save').on('click', function() {
		saveData("sign");
	});

	/**
	 * 保存数据
	 */
	function saveData(opType) {
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
						window.location.href = 'loginInit.do';
					});
				},
				failure : function(form, action) {
					var errmsg = action.result.msg;
					var errtype = action.result.errorType;
					Ext.Msg.alert('提示', errmsg, function() {
						checkNum = RndNum(4);
						Ext.getCmp('randomHidden').setValue(checkNum);
						Ext.getCmp('random').setValue(checkNum);
					});
				}
			});
		}
	}

});
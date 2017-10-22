Ext.require('Ext.ux.TabCloseMenu');
var pwdChgWin;
Ext
		.onReady(function() {
			var mainMenu = new Ext.menu.Menu({
				id : 'mainMenu',
				items : [ {
					text : '密码修改',
					iconCls : 'keyIcon',
					handler : function() {
						updateUserInit();
					}
				}, {
					text : '系统锁定',
					iconCls : 'lockIcon',
					handler : function() {
						lockWindow.show();
						setCookie("erp.lockflag", '1', 240);
					}
				} ]
			});

			var closeButton = new Ext.Button({
				tooltip : '<span style="font-size:12px">切换用户,安全退出系统</span>',
				text : '退    出',
				pressed : true,
				iconCls : 'cancel_48Icon',
				scale : 'large',
				arrowAlign : 'right',
				renderTo : 'closeDiv',
				handler : function() {
					window.location.href = 'loginOut.do';
				}
			});

			var configButton = new Ext.Button({
				scale : 'large',
				text : '首选项',
				iconCls : 'config2Icon',
				iconAlign : 'left',
				tooltip : '<span style="font-size:12px">首选项</span>',
				pressed : true,
				renderTo : 'configDiv',
				menu : mainMenu
			});

			function unlockSystem() {
				// showWaitMsg();
				if (!lockForm.form.isValid())
					return;
				var params = lockForm.getForm().getValues();
				Ext.Ajax.request({
					url : 'unlockSystem_login_base.do',
					success : function(response, opts) {
						var resultArray = Ext.decode(response.responseText);
						if (resultArray.flag == "1") {
							lockWindow.hide();
							setCookie("erp.lockflag", '0', 240);
						} else {
							Ext.Msg.alert('提示', '密码错误,请重新输入', function() {
								lockForm.form.reset();
								Ext.getCmp('password_lock').focus();
							});
						}
					},
					failure : function(response, opts) {
					},
					params : params
				});
			}

			var lockForm = new Ext.form.FormPanel(
					{
						labelWidth : 60,
						defaultType : 'textfield',
						labelAlign : 'right',
						bodyStyle : 'padding:10 5 5 5',
						layout : 'form',
						items : [
								{
									fieldLabel : '帐户密码',
									name : 'password',
									inputType : 'password',
									id : 'password_lock',
									allowBlank : false,
									maxLength : 50,
									listeners : {
										specialkey : function(field, e) {
											if (e.getKey() == Ext.EventObject.ENTER) {
												unlockSystem();
											}
										}
									},
									anchor : '100%'
								},
								{
									xtype : 'panel',
									border : false,
									html : '<div style="font-size:12px;margin-left:10px">(提示:系统已成功锁定,解锁请输入登录帐户密码)</div>'
								} ]
					});

			var lockWindow = new Ext.Window({
				title : '<span class="commoncss">系统锁定</span>',
				iconCls : 'lockIcon',
				layout : 'fit',
				width : 320,
				height : 130,
				closeAction : 'hide',
				collapsible : false,
				closable : false,
				maximizable : false,
				border : false,
				modal : true,
				constrain : true,
				animateTarget : Ext.getBody(),
				items : [ lockForm ],
				listeners : {
					'show' : function(obj) {
						lockForm.form.reset();
						Ext.getCmp('password_lock').focus(true, 50);
					}
				},
				buttons : [ {
					text : '解锁',
					iconCls : 'keyIcon',
					handler : function() {
						unlockSystem();
					}
				}, {
					text : '重新登录',
					iconCls : 'tbar_synchronizeIcon',
					handler : function() {
						window.location.href = 'loginOut.do';
					}
				} ]
			});

			function updateUserInit() {
				if (Ext.isEmpty(pwdChgWin)) {
					pwdChgWin = new Ext.Window({
						title : '密码修改',
						height : 230,
						width : 360,
						closeAction : 'hide',
						layout : 'fit',
						loader : {
							url : 'userPwdChgMng_user_base.do',
							autoLoad : true,
							scripts : true
						// params: 'foo=123&bar=abc'
						}

					});
					pwdChgWin.show();
				} else {
					pwdChgWin.show();
				}
			}
			
			Ext.define('rsgMsgModel', {
				extend : 'Ext.data.Model',
				idProperty : 'rsgMsgModel',
				fields : [  {
					name : 'fromusername',
					type : 'string',
					dateFormat : '',
					mapping : 'fromusername'
				}, {
					name : 'createtime',
					type : 'date',
					dateFormat : 'Y-m-d H:i:s',
					mapping : 'createtime'
				}, {
					name : 'msgid',
					type : 'string',
					dateFormat : '',
					mapping : 'msgid'
				}, {
					name : 'content',
					type : 'string',
					dateFormat : '',
					mapping : 'content'
				}]
			});

			// create the Data Store
			var rsgMsgStore = Ext.create('Ext.data.Store', {
				pageSize : 50,
				autoLoad : false,
				model : 'rsgMsgModel',
				proxy : {
					type : 'ajax',
					url : 'getOnlineMsg_weixin_webcall.do',
					reader : {
						root : 'items',
						totalProperty : 'totalCount'
					}
				}
			});

			var msgView = Ext
					.create(
							'Ext.view.View',
							{
								deferInitialRefresh : false,
								store : rsgMsgStore,
								loadMask:false,
								height:300,
								autoScroll : true,
								tpl : Ext
										.create(
												'Ext.XTemplate',
												'<tpl for=".">',
												'<div class="msg" style="width:200px;height:25px;">{fromusername}<strong>:{content}</strong></div>',
												'</tpl>'),
								itemSelector : 'div.msg',
								id : 'weixin_msg_view'
							});


			Ext.define('remindStaticModel', {
				extend : 'Ext.data.Model',
				idProperty : 'remindStaticModel',
				fields : [ {
					name : 'rmdtype',
					type : 'string',
					dateFormat : '',
					mapping : 'rmdtype'
				}, {
					name : 'rmddesc',
					type : 'string',
					dateFormat : '',
					mapping : 'rmddesc'
				}, {
					name : 'rmdNum',
					type : 'int',
					dateFormat : '',
					mapping : 'rmdNum'
				} ]
			});

			// create the Data Store
			var remindStaticStore = Ext.create('Ext.data.Store', {
				pageSize : 20,
				autoLoad : true,
				model : 'remindStaticModel',
				proxy : {
					type : 'ajax',
					url : 'getRemindStaticData_remind_base.do',
					reader : {
						root : 'items',
						totalProperty : 'totalCount'
					}
				}
			});

			var getTelsStore = Ext.create('Ext.data.Store', {
				fields : [ 'custid', 'tel','tranTel'],
				autoLoad : false,
				proxy : {
					type : 'ajax',
					url : 'getTels_sale_base.do',
					reader : {
						root : 'items',
						totalProperty : 'totalCount'
					}
				}
			})

			function queryRemindStatic() {
				remindStaticStore.load({
					// 回调函数
					callback : function(records, operation, success) {
					},
					params : {}
				});
			}

			var remindStaticGrid = Ext.create('Ext.grid.Panel', {
				tools : [ {
					type : 'refresh',
					tooltip : '刷新',
					handler : function(event, toolEl, panelHeader) {
						queryRemindStatic();
					}
				} ],
				forceFit : true, // 列表宽度自适应
				features : [ {
					id : 'summary',
					ftype : 'summary'
				} ],
				id : 'id_remindStaticGrid',
				title : '<span style="font-size:12px">任务提醒</span>',
				columnLines : false,
				border : false,
				iconCls : 'commentsIcon',
				autoScroll : true,
				sortableColumns : false,
				collapsible : false,
				collapsed : false,
				store : remindStaticStore,
				columns : [ {
					text : '提醒类型',
					hidden : false,
					dataIndex : 'rmddesc'
				}, {
					text : '数量',
					hidden : false,
					dataIndex : 'rmdNum'
				}, {
					text : 'rmdtype',
					hidden : true,
					dataIndex : 'rmdtype'
				} ]
			});

			Ext.define('treemode', {
				extend : 'Ext.data.Model',
				fields : [ {
					name : 'id',
					type : 'string'
				}, {
					name : 'text',
					type : 'string'
				}, {
					name : 'iconCls',
					type : 'string'
				}, {
					name : 'request',
					type : 'string'
				} ]
			});

			Ext.define('customerModel', {
				extend : 'Ext.data.Model',
				idProperty : 'customerModel_id',
				fields : [ {
					name : 'custid',
					type : 'string',
					mapping : 'custid'
				}, {
					name : 'custname',
					type : 'string',
					mapping : 'custname'
				},{
					name : "biztype",
					type : "string",
					mapping : "biztype"
				}, {
					name : 'tel1',
					type : 'string',
					mapping : 'tel1'
				}, {
					name : 'tel2',
					type : 'string',
					mapping : 'tel2'
				}, {
					name : 'tel3',
					type : 'string',
					mapping : 'tel3'
				}, {
					name : 'tel4',
					type : 'string',
					mapping : 'tel4'
				} ]
			});

			// create the Data Store
			var customerStore = Ext.create('Ext.data.Store', {
				pageSize : 30,
				autoLoad : false,
				model : 'customerModel',
				proxy : {
					type : 'ajax',
					url : 'getQuickCustomerData_customer_base.do',
					reader : {
						root : 'items',
						totalProperty : 'totalCount'
					}
				}
			});

			var customerGrid = Ext.create('Ext.grid.Panel', {
				id : 'id_customerGrid',
				title : '<span style="font-size:12px">快速查找</span>',
				columnLines : false,
				border : false,
				sortableColumns : false,
				autoScroll : true,
				iconCls : 'page_findIcon',
				collapsible : false,
				forceFit : true,
				collapsed : false,
				width : 225,
				store : customerStore,
				columns : [ {
					text : '客户姓名',
					sortable : false,
					dataIndex : 'custname'
				}, {
					text : '电话',
					sortable : false,
					dataIndex : 'tel1'
				} ],
				tbar : [ new Ext.form.TextField({
					id : 'queryParam',
					name : 'queryParam',
					emptyText : '电话|名称',
					width : 215,
					enableKeyEvents : true,
					listeners : {
						specialkey : function(field, e) {
							if (e.getKey() == Ext.EventObject.ENTER) {
								getCustData('');
							}
						}
					}
				}) ]
			});
			
			

			var viewport = Ext
					.create(
							'Ext.Viewport',
							{
								id : 'border-example',
								layout : 'border',
								items : [
										Ext.create('Ext.Component', {
											region : 'north',
											height : 70,
											contentEl : 'north'
										}),
										{
											region : 'south',
											title : userTitle,
											contentEl : 'south',
											split : false,
											height : 50,
											minSize : 50,
											maxSize : 100,
											collapsible : true,
											collapsed : true,
											margins : '0 0 0 0'
										},
										{
											xtype : 'panel',
											width : 225,
											minWidth : 225,
											maxWidth : 225,
											title : '<span style="font-size:12px">呼叫中心</span>',
											iconCls : 'group_linkIcon',
											anchor : '100%',
											layout : 'vbox',
											region : 'west',
											split : true,
											collapsible : true,
											animCollapse : true,
											items : [
													{
														xtype : 'tabpanel',
														id:'callcenter_tab',
														dockedItems : [ {
															dock : 'top',
															xtype : 'toolbar',
															items : [ {
																xtype : 'button',
																id : 'btnGetNewCust',
																iconCls : 'user_add24',
																scale : 'medium',
																margin : '0 70',
																text : '获取新客户'
															} ]
														} ],
														height : 200,
														width : 225,
														margins : '0 5 0 0',
														activeTab : 0,
														items : [
																{
																	tooltip : '<span style="font-size:12px">电话</span>',
																	iconCls : 'control_play_blue',
																	items : [
																			{
																				xtype : 'displayfield',
																				id : 'dis_cust_info',
																				width : 220,
																				height : 25
																			},
																			{
																				xtype : "hidden",
																				id : "call_custid"
																			},
																			{
																				xtype : 'combo',
																				labelAlign : 'top',
																				id : 'call_mobile_num',
																				width : 220,
																				emptyText : '手机号码',
																				editable : false,
																				queryCaching : false,
																				displayField : 'tranTel',
																				valueField : 'tel',
																				store : getTelsStore,
																				typeAhead : false
																			},
																			{
																				xtype : 'button',
																				margin : '0 5 0 40',
																				scale : 'medium',
																				iconCls : 'play_24',
																				id : 'btn_call',
																				text : '呼     出'
																			},
																			{
																				xtype : 'button',
																				id : 'btn_block',
																				iconCls : 'close_24',
																				scale : 'medium',
																				text : '挂     断'
																			},
																			{
																				xtype : 'displayfield',
																				labelWidth : 55,
																				id : 'call_info',
																				width : 175
																			} ]
																},
																{
																	tooltip : '<span style="font-size:12px">短信</span>',
																	iconCls : 'message_editIcon',
																	items : [
																			{
																				xtype : 'combo',
																				labelAlign : 'top',
																				id : 'sendmsg_mobile_num',
																				width : 220,
																				emptyText : '手机号码',
																				editable : true,
																				queryCaching : false,
																				displayField : 'tel',
																				valueField : 'tel',
																				store : getTelsStore,
																				typeAhead : false
																			},
																			{
																				xtype : 'textarea',
																				id : 'txt_msg_content',
																				emptyText : '短信内容',
																				height : 50,
																				width : 220
																			},
																			{
																				xtype : 'button',
																				margin : '0 0 0 80',
																				iconCls : 'go_24',
																				scale : 'medium',
																				id : 'btn_sendmsg',
																				text : '发    送'
																			} ]
																},
																{
																	tooltip : '<span style="font-size:12px">微信</span>',
																	iconCls : 'commentsIcon',
																	id:'tab_weixin',
																	autoScroll : false,
																	items : [
										         							msgView,{
																				xtype : 'combo',
																				labelAlign : 'top',
																				id : 'sendWeixinMsg',
																				width : 220,
																				emptyText : '微信号',
																				editable : true,
																				typeAhead : false
																			},
																			{
																				xtype : 'textarea',
																				id : 'txt_weixinMsg_content',
																				emptyText : '内容',
																				height : 100,
																				width : 220
																			},
																			{
																				xtype : 'button',
																				margin : '0 0 0 80',
																				iconCls : 'go_24',
																				scale : 'medium',
																				id : 'btn_sendWeixinMsg',
																				text : '发    送'
																			}]
																},
																{
																	tooltip : '<span style="font-size:12px">邮件</span>',
																	iconCls : 'rss_go',
																	id:'tab_email',
																	autoScroll : false,
																	items : []
																},
																{
																	tooltip : '<span style="font-size:12px">IM</span>',
																	iconCls : 'user_commentIcon',
																	id:'tab_IM',
																	autoScroll : false,
																	items : []
																}]
													},													
													{
														id:'customerGrid_panel',
														height : 160,
														width : 225,
														items : [ customerGrid ]
													},
													{
														id:'remindStaticGrid_panel',
														height : 440,
														width : 225,
														items : [ remindStaticGrid ]
													} ]
										},
										{
											region : 'east',
											stateId : 'navigation-panel',
											id : 'west-panel',
											width : 200,
											minWidth : 175,
											maxWidth : 200,
											split : true,
											collapsible : true,
											animCollapse : true,
											collapsed : true,
											margins : '0 0 0 3',
											layout : 'accordion',
											items : [ {
												title : '系统设置',
												items : [ Ext
														.create(
																'Ext.tree.Panel',
																{
																	store : new Ext.data.TreeStore(
																			{
																				model : 'treemode',
																				proxy : {
																					type : 'ajax',
																					url : 'getRoleMenuTreeData.do'
																				},
																				root : {
																					text : 'Ext JS',
																					id : '0101',
																					expanded : true
																				}
																			}),
																	rootVisible : false,
																	height : 800,
																	width : 250,
																	title : '',
																	id : "manage_menu",
																	useArrows : true,
																	autoHeight : false,
																	autoWidth : false,
																	autoScroll : true,
																	animate : false,
																	border : false,
																	listeners : {
																		'itemclick' : function(
																				view,
																				re) {
																			// 打开主页面
																			openMainTab(
																					re.data.id,
																					re.data.request,
																					re.data.iconCls,
																					'<span style="font-size:12px">'
																							+ re.data.text
																							+ '</span>');
																		}
																	}
																}) ],
												iconCls : 'userIcon'
											} ]
										},
										Ext
												.create(
														'Ext.tab.Panel',
														{
															id : 'mainTabs',
															region : 'center',
															deferredRender : false,
															activeTab : 0, 
															items : [ {
																title : '<span style="font-size:12px">首页</span>',
																layout : 'fit',
																iconCls : 'userIcon',
																contentEl : 'welcome',
																autoScroll : true
															} ]
														}) ]
							});

			customerGrid.on('itemdblclick', function(ev, re, item, index) {
				openMainTab(re.data.custid,
						'custSelMng_customer_base.do?custid=' + re.data.custid,
						'', '<span style="font-size:12px">' + re.data.custname
								+ '</span>');
				loadCustTels(re);
			});

			remindStaticGrid.on('itemdblclick', function(ev, re, item, index) {
				openMainTab('remindQry', 'remindMng_remind_base.do?rmdtype='
						+ re.data.rmdtype, '',
						'<span style="font-size:12px">任务查询</span>', true);
			});

			function getCustData(type) {
				var param = Ext.getCmp('queryParam').getValue();
				if (type != 'next' && Ext.isEmpty(param)) {
					return;
				} else if (type == 'next') {
					customerStore.getProxy().url = 'getNextCustomer_customer_base.do';
				} else {
					customerStore.getProxy().url = 'getQuickCustomerData_customer_base.do';
				}

				customerStore
						.load({
							// 回调函数
							callback : function(records, operation, success) {
								if (type == 'next') {
									var re = records[0];
									if (!Ext.isEmpty(re)) {
										var selUrl = "custSelMng_customer_base.do?custid=";
										if (re.data.biztype == "HOUSE") {
											selUrl = "houseSelMng_house_webcall.do?custid=";
										}
										openMainTab(re.data.custid,
												selUrl+ re.data.custid, "",
												'<span style="font-size:12px">'
														+ re.data.custname + "</span>");

										loadCustTels(re);
									} else {
										alert('暂无客户!');
									}
								}
							},
							params : {
								queryParam : Ext.getCmp('queryParam')
										.getValue()
							}
						});
			}

			Ext.getCmp('btnGetNewCust').on('click', function() {
				getCustData('next');
			});

			Ext.getCmp('btn_call').on('click', function() {
				if ("undefined" == (typeof Cloopen)) {
					alert("未连接通过服务器，请先连接服务器");
					return;
				}
				var telnum = Ext.getCmp('call_mobile_num').getValue();
				if (telnum) {
					Cloopen.invitetel(telnum);
					this.setDisabled(true);
				}
			});
			
			//展开管理菜单
			Ext.getCmp('manage_menu').expandPath('/0101/010105','id','/',function(success, lastNode) {
		    });
			
			//TAB改变事件
			var timer;
			Ext.getCmp('callcenter_tab').on('tabchange',function(tabPanel, newCard, oldCard, eOpts) {
				var id = newCard.getItemId();
				//微信
				if (id == 'tab_weixin') {
					refresh = true;
					Ext.getCmp('customerGrid_panel').hide();
					Ext.getCmp('remindStaticGrid_panel').hide();
					tabPanel.setHeight(800);
					rsgMsgStore.reload();
					
				} else if (id == 'tab_email') {
					refresh = true;
					Ext.getCmp('customerGrid_panel').hide();
					Ext.getCmp('remindStaticGrid_panel').hide();
					tabPanel.setHeight(800);
				} else if (id == 'tab_IM') {
					refresh = true;
					Ext.getCmp('customerGrid_panel').hide();
					Ext.getCmp('remindStaticGrid_panel').hide();
					tabPanel.setHeight(800);
				}  else {
					
					Ext.getCmp('customerGrid_panel').show();
					Ext.getCmp('remindStaticGrid_panel').show();
					tabPanel.setHeight(200);
				}
				
			});

			Ext.getCmp('btn_sendmsg').on(
					'click',
					function() {
						var telnum = Ext.getCmp('sendmsg_mobile_num')
								.getValue();
						if (telnum) {
							Ext.Ajax.request({
								url : 'sendMsg_customer_base.do',
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
									destTel : telnum,
									content : Ext.getCmp('txt_msg_content')
											.getValue()
								}
							});
						}
					});

			Ext.getCmp('btn_block').on('click', function() {
				Cloopen.bye();
				stopCount();
				Ext.getCmp('btn_call').setDisabled(false);
			});
			

		});
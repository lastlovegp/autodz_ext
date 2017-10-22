Ext.onReady(function() {
	var currentItem;
	var viewport = Ext.create('Ext.Viewport', {
		id : 'border-example',
		layout : 'border',
		items : [
				// create instance immediately
				Ext.create('Ext.Component', {
							region : 'north',
							height : 32, // give north and south regions a
							// height
							autoEl : {
								tag : 'div',
								html : '<p>格迅软件</p>'
							}
						}), {
					// lazily created panel (xtype:'panel' is default)
					region : 'south',
					contentEl : 'south',
					split : true,
					height : 100,
					minSize : 100,
					maxSize : 200,
					collapsible : false,
					collapsed : true,
					title : '超级用户',
					margins : '0 0 0 0'
				}, {
					region : 'west',
					stateId : 'navigation-panel',
					id : 'west-panel', // see Ext.getCmp() below
					title : '功能菜单',
					split : true,
					width : 200,
					minWidth : 175,
					maxWidth : 400,
					collapsible : true,
					animCollapse : true,
					margins : '0 0 0 5',
					layout : 'accordion',
					items : [{
								contentEl : 'west',
								title : '菜单导航',
								iconCls : 'nav', // see the HEAD section for
								contentEl : 'div.card.nav'
							}, {
								title : '系统设置',
								html : '<p>Some settings in here.</p>',
								iconCls : 'folder_wrenchIcon'
							}, {
								title : '系统信息',
								html : '<p>Some info in here.</p>',
								iconCls : 'info'
							}]
				}, Ext.create('Ext.tab.Panel', {
					id : 'mainTabs',
					region : 'center', // a center region is ALWAYS
					// required for border layout
					deferredRender : false,
					plugins : Ext.create('Ext.ux.TabCloseMenu', {
						extraItemsTail : ['-', {
									text : 'Closable',
									checked : true,
									hideOnClick : true,
									handler : function(item) {
										currentItem.tab
												.setClosable(item.checked);
									}
								}],
						listeners : {
							aftermenu : function() {
								currentItem = null;
							},
							beforemenu : function(menu, item) {
								var menuitem = menu.child('*[text="Closable"]');
								currentItem = item;
								menuitem.setChecked(item.closable);
							}
						}
					}),
					activeTab : 0, // first tab initially active
					items : [{
								contentEl : 'center2',
								title : '首页信息',
								autoScroll : true
							}]
				})]
	});

	Ext.define('ctreemodel', {
				extend : 'Ext.data.Model',
				fields : [{
							name : 'id',
							type : 'string'
						}, {
							name : 'text',
							type : 'string'
						}, {
							name : 'request',
							type : 'string'
						}]
			});

	var store = new Ext.data.TreeStore({
				model : 'ctreemodel',
				proxy : {
					type : 'ajax',
					url : 'getMenuTreeData.do'
				},
				root : {
					text : 'Ext JS',
					id : '0',
					expanded : true
				},
				sorters : [{
							property : 'leaf',
							direction : 'ASC'
						}, {
							property : 'id',
							direction : 'ASC'
						}]
			});

	var tree = Ext.create('Ext.tree.Panel', {
		store : store,
		rootVisible : false,
		renderTo : 'div.card.nav',
		height : 800,
		width : 250,
		title : '',
		useArrows : true,
		autoHeight : false,
		autoWidth : false,
		autoScroll : false,
		animate : false,
		border : false,
		containerScroll : true,
		listeners : {
			'itemclick' : function(view, re) {
				var menuid = re.data.id;
				var id = "tab_id_" + menuid;
				var url = re.data.request;
				var mainTabs = Ext.getCmp('mainTabs');
				if (url == '#' || url == '') {
					// Ext.Msg.alert('提示', '此菜单还没有指定请求地址,无法为您打开页面.');
					return;
				} else {
					var index = url.indexOf('.do');
					if (index != -1)
						url = url + '?menuid=' + menuid;
					var n = mainTabs.getComponent(id);
					if (!n) {
						n = mainTabs.add({
							id : id,
							title : re.data.text,
							closable : true,
							layout : 'fit',
							html : '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src='
									+ url + '></iframe>'
						});
					}
					mainTabs.setActiveTab(n);
				}
			}
		}
	});

});
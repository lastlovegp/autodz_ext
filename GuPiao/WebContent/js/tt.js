var deptTreeStore = Ext.create('Ext.data.TreeStore', {
			fields : ['id', 'text', 'leaf'],
			proxy : {
				type : 'ajax',
				url : 'getDeptTreeData_dept_base.do'
			},
			root : {
				text : '根菜单',
				id : '0',
				expanded : true
			}
		});
var deptTree = Ext.create('Ext.tree.Panel', {
			store : deptTreeStore,
			viewConfig : {},
			renderTo : Ext.getBody(),
			height : 500,
			border : false,
			width : 200,
			useArrows : true,
			autoScroll : true,
			multiSelect : false,
			rootVisible : true,
			animate : false,
			dockedItems : [{
						xtype : 'toolbar',
						items : []
					}]

		});
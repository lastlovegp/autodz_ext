<#import "/common/include/IndexTagMacro.ftl" as Ctg>
<#import "/common/include/CommonTagMacro.ftl" as ext>
<@Ctg.chead>
	<@Ctg.cbody enSlider = "false">
	  <div id="welcome">
	    欢迎您
    </div>
	
	</@Ctg.cbody>
	
	<script type="text/javascript">
	
	 Ext.onReady(function(){
	    
		var resultsPanel = Ext.create('Ext.panel.Panel', {
			    width: 955,
			    height: 600,
			    renderTo: 'div_main',
			    layout: {
			        type: 'hbox',       
			        padding: 1
			    },
			    items: [{              
			        xtype: 'tree',
			        rootVisible : false,
					lines : false,
					border :false,
		    		height: 500,
					useArrows : true,
			        root : {
						expanded : true,
						children : [{
									text : "<span style='font-size:13px'>股票信息</span>",
									expanded : true,
									children : [{
												id : "transLogQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>交易日志</span>",
												leaf : true
											}, {
												id : "positionQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>仓位查询</span>",
												leaf : true
											}, {
												id : "tranhisQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>交易历史</span>",
												leaf : true
											}, {
												id : "hyMng_gpMonitor_base.do",
												text : "<span style='font-size:13px'>今日行业</span>",
												leaf : true
											},{
												id : "gnMng_gpMonitor_base.do",
												text : "<span style='font-size:13px'>今日概念</span>",
												leaf : true
											},{
												id : "storeQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>绩效查询</span>",
												leaf : true
											}, {
												id : "gpstoreQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>股票池</span>",
												leaf : true
											}, {
												id : "jumpQry_gpMonitor_base.do",
												text : "<span style='font-size:13px'>全局筛选</span>",
												leaf : true
											}, {
												id : "costMng_gpMonitor_base.do",
												text : "<span style='font-size:13px'>价格修改</span>",
												leaf : true
											}, {
												id : "paramMng_gpMonitor_base.do",
												text : "<span style='font-size:13px'>参数维护</span>",
												leaf : true
											}
											
											]
								}]},
					listeners : {
						'itemclick' : function(view, re) {
						    if (re.data.id != 'loginOut.do') {
						        // 打开主页面
								openMainTab(
									    re.data.id,
										re.data.id,
										'',
										'<span style="font-size:12px">'
												+ re.data.text
												+ '</span>',true);
						    } else {
						         window.location.href= 'loginOut.do';
						    }
						}
					},
			        flex: 1                                      
			    }, {
			        xtype: 'splitter'   // A splitter between the two child items
			    }, 			    
			    Ext.create('Ext.tab.Panel',{
							id : 'mainTabs',
							region : 'center',
							flex: 4,
							bodyPadding: 5,	
							height: 600,
							deferredRender : false,
							activeTab : 0,
							items : [ {
										title : '<span style="font-size:12px">首页</span>',
										layout : 'fit',
										iconCls : 'userIcon',
										contentEl : 'welcome',
										autoScroll : true
									} ]
					})
			    ]
			});
		
		   
		
 	 });
 	 
 	 

    </script>
</@Ctg.chead>
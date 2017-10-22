<#import "/common/include/CommonTagMacro.ftl" as CommonMacro>
<@CommonMacro.mobilePage title="工作任务">

<body>

 	<div data-role="header" data-position="fixed">
		<h1>工作任务</h1>
	</div>
	<div data-role="content" id="main1Content" >

		<p>功能九宫格/功能列表/功能块</p>
		<div class="ui-grid-b">
			<div class="ui-block-a"><img src="${contextPath}/images/album-bb.jpg" width="80%" /><p>拜访任务</p></div>
			<div class="ui-block-b"><img src="${contextPath}/images/album-bb.jpg"  width="80%"/></div>
			<div class="ui-block-c"><img src="${contextPath}/images/album-bb.jpg"  width="80%"/></div>
		</div>
		<div class="ui-grid-b">
			<div class="ui-block-a"><img src="${contextPath}/images/album-bb.jpg"  width="80%"/></div>
			<div class="ui-block-b"><img src="${contextPath}/images/album-bb.jpg"  width="80%"/></div>
			<div class="ui-block-c"></div>
		</div>
		<div class="ui-grid-b">
			<div class="ui-block-a"></div>
			<div class="ui-block-b"></div>
			<div class="ui-block-c"></div>
		</div>
	</div>
	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<ul>
				<li><a href="#" data-icon="grid" class="ui-btn-active">工作</a></li>
				<li><a href="contact_jqm_jqm.do" data-icon="info"  rel="external">资讯</a></li>
				<li><a href="config_jqm_jqm.do" data-icon="gear"   rel="external">设置</a></li>
				<li><a href="baiduMap_jqm_jqm.do" data-icon="search"  rel="external"  >地图</a></li>
			</ul>
		</div>
	</div>

</body>

</@CommonMacro.mobilePage>

<#import "/common/include/CommonTagMacro.ftl" as CommonMacro>
<@CommonMacro.mobilePage title="系统设置">

<body>

   <div data-role="header" data-position="fixed">
			<h1>系统设置</h1>
	</div>
	<div data-role="content" id="main3Content" >

		<ul data-role="listview" data-split-icon="gear" data-split-theme="d">
			<li>
				<a href="#">
					<img src="${contextPath}/images/album-bb.jpg" />
					<h3>设置</h3>
					<p>设置系统运行参数</p>
				</a>
				<a href="#" data-rel="dialog" data-transition="slideup">动作</a>
			</li>
			<li>
				<a href="#">
					<img src="${contextPath}/images/album-hc.jpg" />
					<h3>更新</h3>
					<p>更新系统表单</p>
				</a>
				<a href="#" data-rel="dialog" data-transition="slideup">动作</a>
			</li>
			<li>
				<a href="#">
					<img src="${contextPath}/images/album-p.jpg" />
					<h3>帮助</h3>
					<p>查看系统帮助信息</p>
				</a>
				<a href="#" data-rel="dialog" data-transition="slideup">动作</a>
			</li>
			<li>
				<a href="index.ftl"  rel="external">
					<img src="${contextPath}/images/album-p.jpg" />
					<h3>重新登录</h3>
					<p>返回登录界面重新登录</p>
				</a>
				<a href="index_jqm_jqm.do" data-rel="dialog" data-transition="slideup"  rel="external">动作</a>
			</li>
		</ul>
	</div>
	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
				<ul>
					<li><a href="workTask_jqm_jqm.do" data-icon="grid"  rel="external" >工作</a></li>
					<li><a href="contact_jqm_jqm.do" data-icon="info"  rel="external">资讯</a></li>
					<li><a href="#" data-icon="gear" class="ui-btn-active"  >设置</a></li>
					<li><a href="baiduMap_jqm_jqm.do" data-icon="search"  rel="external" >地图</a></li>
				</ul>
		</div>

	</div>

</body>

</@CommonMacro.mobilePage>

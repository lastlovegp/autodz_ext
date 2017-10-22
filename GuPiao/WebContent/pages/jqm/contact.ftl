<#import "/common/include/CommonTagMacro.ftl" as CommonMacro>
<@CommonMacro.mobilePage title="资讯沟通">

<body>

     <div data-role="header" data-position="fixed">
				<h1>资讯沟通</h1>
	</div>
	<div data-role="content" id="main2Content" >

		<ol data-role="listview"  data-filter="true">
			<li><a href="#">资讯1 <span class="ui-li-count">12</span></a></li>
			<li><a href="#">资讯2 <span class="ui-li-count">1</span></a></li>
			<li><a href="#">资讯3 <span class="ui-li-count">312</span></a></li>
			<li><a href="#"><img src="${contextPath}/images/gf.png" alt="France" class="ui-li-icon">资讯4</a></li>
			<li><a href="#"><img src="${contextPath}/images/de.png" alt="France" class="ui-li-icon">资讯5</a></li>
			<li><a href="#"><img src="${contextPath}/images/gb.png" alt="France" class="ui-li-icon">资讯6</a></li>
			<li><a href="#">资讯7</a></li>
			<li><a href="#">资讯8</a></li>
			<li><a href="#">资讯9</a></li>

		</ol>
	</div>
	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
			<ul>
				<li><a href="workTask_jqm_jqm.do" data-icon="grid"  rel="external">工作</a></li>
				<li><a href="#" data-icon="info"  class="ui-btn-active" >资讯</a></li>
				<li><a href="config_jqm_jqm.do" data-icon="gear"  rel="external" >设置</a></li>
				<li><a href="baiduMap_jqm_jqm.do" data-icon="search"  rel="external"  >地图</a></li>
			</ul>
		</div>
	</div>


</body>

</@CommonMacro.mobilePage>

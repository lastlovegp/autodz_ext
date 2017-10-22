<#import "/common/include/CommonTagMacro.ftl" as CommonMacro>
<@CommonMacro.mobilePage title="地图定位">
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>

	<script type="text/javascript">

        function initialize() {
			var mp = new BMap.Map('main4Content');
			//mp.addControl(new BMap.NavigationControl());
			//mp.addControl(new BMap.ScaleControl());
			//mp.addControl(new BMap.OverviewMapControl());
			//mp.addControl(new BMap.MapTypeControl());
			//mp.setCurrentCity("北京"); // 地图定位

			var point = new BMap.Point(116.404, 39.915);
			mp.centerAndZoom(point, 15);

			var marker = new BMap.Marker(point); 
			mp.addOverlay(marker); 
		}

		function loadScript() {
			var script = document.createElement("script");
	 		script.src = "http://api.map.baidu.com/api?v=1.2&callback=initialize";
			document.body.appendChild(script);
		}

		window.onload = loadScript;

    </script>
</head>
<body>

    <div data-role="header" data-position="fixed">
			<h1>地图定位</h1>
	</div>
	<div data-role="content" id="main4Content" style="width:100%;height:420px">

	</div>

	<div data-role="footer" data-position="fixed">
		<div data-role="navbar">
				<ul>
					<li><a href="workTask_jqm_jqm.do" data-icon="grid"  rel="external">工作</a></li>
					<li><a href="contact_jqm_jqm.do" data-icon="info"  rel="external">资讯</a></li>
					<li><a href="config_jqm_jqm.do" data-icon="gear"  rel="external">设置</a></li>
					<li><a href="#" data-icon="search" class="ui-btn-active" >地图</a></li>>
				</ul>
		</div>
	</div>

</body>

</@CommonMacro.mobilePage>

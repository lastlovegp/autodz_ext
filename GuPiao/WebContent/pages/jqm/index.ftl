<#import "/common/include/CommonTagMacro.ftl" as CommonMacro>
<@CommonMacro.mobilePage title="首页">

	<script type="text/javascript">
		//进行登录
        $('#btnLogin').live("tap",function(){
			$.mobile.changePage('#result', { transition: "fade"});
        });

         //为页面添加swip 事件
        $("#home").live("pageinit",function(){
            $('#homeContent').bind("swipeleft",function(){
              alert("success");
            });
            $('#homeContent').bind("swiperight",function(){
              alert("insys");
            });
        });
    </script>
<body>
	<div data-role="page" id="home">
		<div data-role="header" data-position="fixed">
			<h1>个人登录</h1>
			<a href="#setting" data-role="button" data-icon="gear" data-transition="slide">设置</a>
		</div>
		<div data-role="content" id="homeContent" >
			<label for="username">用户名：</label>
			<input type="text" id="username" placeholder="请输入用户名" />
			<label for="userpassword">密码：</label>
			<input type="password" id="userpassword"  placeholder="请输入密码 " />
			<p></p>
			<input type="checkbox"  id="checkbox-0" data-role="none" />
			<label for="checkbox-0">记住密码</label>
			<input type="checkbox"  id="checkbox-2" data-role="none" />
			<label for="checkbox-2">自动登录</label>
		</div>
		<div data-role="footer" data-position="fixed" >
			<div data-role="navbar">
				<ul>
					<li><a href="#result" data-role="button" data-icon="forward" data-transition="slide">登录提示</a></li>
					<li><a href="workTask_jqm_jqm.do" data-role="button" data-icon="arrow-r" data-transition="slide" rel="external">直接登录</a></li>
				</ul>
			</div>
		</div>
		</div>

	</div>

	<div data-role="page" id="result">
        <div data-role="header">
            <h1>登录提示</h1>
        </div>
        <div data-role="Content"  id="resultContent">
            	提示内容
        </div>
        <div data-role="footer" data-position="fixed">
        	<div data-role="navbar">
				<ul>
					<li><a href="#home" data-role="button" data-icon="refresh" data-transition="slide">重新登录</a></li>
				</ul>
			</div>
		</div>
     </div>

     <div data-role="page" id="setting">
        <div data-role="header">
            <h1>登录设置</h1>
        </div>
        <div data-role="Content"  id="resultContent">
            	设置内容
        </div>
        <div data-role="footer" data-position="fixed">
			<div data-role="navbar">
				<ul>
					<li><a href="#home" data-role="button" data-icon="check" data-transition="slide">确认</a></li>
					<li><a href="#home" data-role="button" data-icon="refresh" data-transition="slide">返回</a></li>
				</ul>
			</div>
		</div>
     </div>
</body>

</@CommonMacro.mobilePage>
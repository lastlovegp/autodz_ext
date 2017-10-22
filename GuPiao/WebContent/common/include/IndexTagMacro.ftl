<#--global value-->
<#global contextPath = contextPath>
<#---->
<#macro chead enablExt="true"  title="股票终端" require="'*'" >
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta charset="utf-8" />
	<title>${title}</title>
	<#if enablExt =="true">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/ext_icon.css"/>
		<script type="text/javascript" src="${contextPath}/pages/shared/include-ext.js"></script>
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/css/ext-custom-css.css"/>
		<script type="text/javascript" src="${contextPath}/locale/ext-lang-zh_CN.js"></script>
    </#if>
	<link rel="shortcut icon" type="image/x-icon" href="css/images/favicon.ico" />
	<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="all" />
	<script src="js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
	<script src="js/jquery.flexslider-min.js" type="text/javascript"></script>
	<script src="js/functions.js" type="text/javascript"></script>
</head>

<script language="javascript">

		 <#if enablExt =="true">
	          Ext.Loader.setConfig({enabled: true});
		      Ext.Loader.setPath('Ext.ux', '${contextPath}/pages/ux/');
		      Ext.require([
			  		${require}
			  ]);
			  
			  Ext.define('dicMode', {
		        extend: 'Ext.data.Model',
		        fields: [
		            {type: 'string', name: 'field'},
			        {type: 'string', name: 'fieldname'},
			        {type: 'string', name: 'code'},
			        {type: 'string', name: 'codetype'},
			        {type: 'string', name: 'codedesc'}
		        ]
		      });
		      
			  //必输项
			  var required = '<span style="color:red;font-weight:bold" data-qtip="Required">*</span>';
	
			  <#if uiDto?exists>
			    <#if uiDto.codeTrans?exists>
			       ${uiDto.codeTrans}
			    </#if>
			  </#if>
			  
		      Ext.onReady(function() {
	                 Ext.QuickTips.init();

	                 Ext.apply(Ext.form.field.VTypes,{
				          mobilephone:function(val,field)
						  {
						       return /(^0?[1][3-8][0-9]{9}$)/.test(val);
						  },
						  mobilephoneText:'请输入正确的手机号码',

						  phone: function(v) {
						        return /^\d{3}-\d{8}|\d{4}-\d{7}$/.test(v);
						  },
						  phoneText: '请输入正确的电话号码'
				    });
	          });
         </#if>

    </script>

<#nested>
</html>
</#macro>


<#macro cbody enSlider = "true">
<body>
	<!-- wrapper -->
	<div id="wrapper">
		<!-- shell -->
		<div class="shell">
			<!-- container -->
			<div class="container">
							
				<!-- header -->
				<@Ctg.header />
				<!-- end of header -->
				
				<div class="main" id="div_main">
				     <#if enSlider == "true">
						   <@Ctg.slider title="注册&登录" content="注册即享受超值服务，简单注册即可享用，亲，赶快注册吧!"/>
				     </#if>
				 
					<#nested>
				</div>
				<!-- end of main -->
			</div>
			<!-- end of container -->	
			
			<@Ctg.footer />
			
		</div>
		<!-- end of shell -->
	</div>
	<!-- end of wrappert -->

</body>
</#macro>

<#macro header >
<header class="header">
	<h1 id="logo"><a href="#">捷通网络</a></h1>
	<nav id="navigation">
		<ul>
			<li class="active"><a href="index.html">首页</a></li>
            <li >
				<a href="#">我们的服务<span></span></a>
				<ul>
					<li><a href="../wlyx.html">&nbsp;&nbsp;111111</a></li>
				</ul>
			</li>
			<li>
				<a href="sign.do">登录&注册</a>
			</li>
			<li><a href="../buyflow.html">购买流程</a></li>
			<li>
				<a href="../about.html">关于我们</a>
			</li>
		</ul>
	</nav>
	<div class="cl">&nbsp;</div>
	</header>
</#macro>

<#macro footer >
	<div class="footer">
		<nav class="footer-nav">
			<ul>
				<li><a href="../index.html">首页</a></li>
				<li><a href="../about.html">关于我们</a></li>
			</ul>
		</nav>
		<p class="copy">谢谢 </p>
		<p class="copy">Copyright 2014, JITONG SOFT Technologies CO.Ltd. All rights reserved ICP </p>
	</div>
</#macro>

<#macro slider title="产品介绍" content="详细描述">
	<!-- slider -->
	<div class="flexslider">
		<ul class="slides">
			<li>
				<img src="css/images/slide-img1.jpg" alt="" />
				<div class="slide-cnt">
					<h2>${title} </h2>
					<p>${content}</p>
				</div>
			</li>
		</ul>
	</div>
</#macro>

<#macro box title="经营范围">
	<!-- box -->
	<section class="box">
		<span class="shadow-t"></span>
		<h3>${title}</h3>
		<div class="cl">&nbsp;</div>
		<!-- entries -->
		<#nested>	
	
	</section>
	<!-- end of box -->
</#macro>


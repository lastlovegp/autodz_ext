<#import "/common/include/CommonTagMacro.ftl" as Ctg>
<#assign account= uiDto.userInfo.account?default('')>
<#assign username= uiDto.userInfo.username?default('')>
<#assign deptname= uiDto.userInfo.deptname?default('')>
<@Ctg.page title="电话销售平台" callOpen="true" voipAccount="${uiDto.voipAccount}" voipPassword="${uiDto.voipPassword}">
<style type="text/css">
	.top{position:absolute;z-index:9999;top:0;margin:0 0 100px 50px; }
</style>
<link rel="stylesheet" type="text/css" href="${contextPath}/common/css/animated-dataview.css"/>
<script type="text/javascript">
 	var userTitle = "欢迎你 ${username}!,帐户:${account},所属部门:${deptname}";
</script>
<script type="text/javascript" src="${contextPath}/js/index.js"></script>
<@Ctg.callInit callOpen="true" 
      voipAccount="${uiDto.voipAccount}" voipPassword="${uiDto.voipPassword}" />

<div id="videobg" class="top">
    <div id="idvideophone" style="display:block">
   		<a href="http://www.adobe.com/go/getflashplayer" alt="Get Adobe Flash player">安装Flash控价</a> 
    </div>
</div>      
<body onbeforeunload="checkLeave();">
  
    <div id="north"   >
         <table width="100%" border="0" cellpadding="0" cellspacing="3" >
				    <tr >
				        <td align="left" ><img class="IEPNG" width="800" height="70" src="images/b5.jpg" /></td>
					    <td align="right">
					      <table border="0" cellpadding="0" cellspacing="1">
					        <tr>
					          <td>&nbsp;</td>
					          <td><div id = "configDiv"></td>
					          <td>&nbsp;</td>
					          <td><div id = "closeDiv"></td>
					          <td>&nbsp;</td>
					        </tr>
					      </table>
					    </td>
				    </tr>
		 </table>
    </div>
    <div id="welcome">
    </div>
    <div id="south" >
       <p>${uiDto.copyright}</p>
    </div>
</body>


<script type="text/javascript">
  function checkLeave() {
     window.location.href = 'loginOut.do';
  }
  
  Ext.onReady(function(){
	 	<#-- 菜单 tree 定义 -->
	    <@Ctg.store name="image" url="getUserMenuList_menu_base.do" fieldStr="${uiDto.menuFstr}"/>
	
	    <@Ctg.imageView store="imageStore" name="image" renderTo="welcome" itemname="menuname" 
	    	imageurl="image"/>
	    
	    ivimage.on('itemclick',function(t, r, item, index, e, eOpts){
	        openMainTab(
						r.data.menuid,
						r.data.request,
						r.data.iconcls,
						'<span style="font-size:12px">'
								+ r.data.menuname
								+ "</span>");
		});
		
 });
  
</script>

</@Ctg.page>

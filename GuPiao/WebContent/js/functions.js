/**
		 * 打开主TAB页
		 */
function openMainTab(menuid,url,iconCls,text,reAdd) {
	var id = "tab_id_" + menuid;
	var mainTabs = Ext.getCmp('mainTabs');
	if (Ext.isEmpty(mainTabs)) {
	    mainTabs = parent.Ext.getCmp('mainTabs');
	}
	if (url == '#' || url == '') {
		return;
	} else {
		var index = url.indexOf('.do');
		if (index != -1) {
		   if (url.indexOf('?') == -1) {
		      url = url;
		   } else {
              url = url;
		   }
		}

		var n = mainTabs.getComponent(id);
		if (n) {
		    if (reAdd) {
		       mainTabs.remove(n, true);
		       n = null;
		    }
		}
		if (!n) {
			n = mainTabs.add({
				id : id,
				iconCls: iconCls,
				iconAlign : 'center',
				title : text,
				closable : true,
				layout : 'fit',
				html : '<iframe scrolling="auto" frameborder="0" width="100%" height="100%" src='
						+ url + '></iframe>'
			});
		} 
		mainTabs.setActiveTab(n);
	}
}

$(function() {

	$('#navigation ul li:first-child').addClass('first')
	$('#navigation ul li:last-child').addClass('last')
	$('section:last').addClass('last-section')
});

$(window).load(function() {
	$('.flexslider').flexslider({
		animation: "slide",
		controlsContainer: ".slider-holder",
		slideshowSpeed: 5000,
		directionNav: true,
		controlNav: false,
		animationDuration: 900
	});
});
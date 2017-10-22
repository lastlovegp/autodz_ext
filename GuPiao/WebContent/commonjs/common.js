
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

/**
 * 保持电话拨打记录
 */
function saveCallHis(costtime,custid,tel) {
	var callid = '';
	Ext.Ajax.request({
				url : 'saveCallHistory_company_base.do',
				success : function(response) {
					var resultArray = Ext.JSON.decode(response);
					callid = resultArray.callid;
				},
				failure : function(response) {
				},
				params : {
					costtime:costtime,
					custid:custid,
					tel:tel
				}
			});
	return callid;
}


function getFormValue(form,fname) {
	return form.getForm().findField(fname).getValue();
}

function getFormCmp(form,fname) {
	return form.getForm().findField(fname);
}

function setFormValue(form,fname,value) {
	return form.getForm().findField(fname).setValue(value);
}


/**
 * 公共summary 处理
 *
 * @param value
 * @param summaryData
 * @param dataIndex
 * @returns
 */
function summaryRenderer(value, summaryData, dataIndex) {
	return Ext.util.Format.round(value, 2);
}

/**
 * 行编辑
 *
 * @param {}
 *            m
 * @return {}
 */
function getDirtydata(m) {
	var jsonArray = [];
	// 将record数组对象转换为简单Json数组对象
	Ext.each(m, function(item) {
		jsonArray.push(item.data);
	});
	return Ext.encode(jsonArray);
}

/**
 * 将JS数组转换为JS字符串 表格复选框专用
 */
function jsArray2JsString(arrayChecked, id) {
	var strChecked = "";
	for ( var i = 0; i < arrayChecked.length; i++) {
		strChecked = strChecked + arrayChecked[i].get(id) + ',';
	}
	return strChecked.substring(0, strChecked.length - 1)
}

/**
 * 清除Ext.Form表单元素
 */
function clearForm(pForm) {
	var formItems = pForm.items['items'];
	for (i = 0; i < formItems.length; i++) {
		element = formItems[i];
		element.setValue('');
		element.reset(); // 避免出现红色波浪线
	};
}

/**
 * 帮助窗口
 */
function openHelpWin(helpPath) {
	var initUrl = '/CallSell/help_help_help.do?nodePath='+helpPath;
    var pWidth = 800;
	var pHeight = 600;
	var left = (screen.width - pWidth) / 2;
	var top = (screen.height - pHeight) / 2;
	var str = 'toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no';
	window.open(initUrl, '', str);
}

/**
 * 通过iFrame实现类ajax文件下载
 */
function exportExcel(url) {
	var exportIframe = document.createElement('iframe');
	exportIframe.src = url;
	exportIframe.style.display = "none";
	document.body.appendChild(exportIframe);
}

// 这个可以验证15位和18位的身份证，并且包含生日和校验位的验证。
function isIdCardNo(num) {
	if (Ext.isEmpty(num))
		return false;
	num = num.toUpperCase();
	// 身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。
	if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {
		Ext.MessageBox.alert('提示',
				'输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');
		return false;
	}
	// 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
	// 下面分别分析出生日期和校验位
	var len, re;
	len = num.length;
	if (len == 15) {
		re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/);
		var arrSplit = num.match(re);
		// 检查生日日期是否正确
		var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/'
				+ arrSplit[4]);
		var bGoodDay;
		bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2]))
				&& ((dtmBirth.getMonth() + 1) == Number(arrSplit[3]))
				&& (dtmBirth.getDate() == Number(arrSplit[4]));
		if (!bGoodDay) {
			Ext.MessageBox.alert('提示', '输入的身份证号里出生日期不对！');
			return false;
		} else {
			// 将15位身份证转成18位
			// 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5,
					8, 4, 2);
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4',
					'3', '2');
			var nTemp = 0, i;
			num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);
			for (i = 0; i < 17; i++) {
				nTemp += num.substr(i, 1) * arrInt[i];
			}
			num += arrCh[nTemp % 11];
			return num;
		}
	}
	if (len == 18) {
		re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/);
		var arrSplit = num.match(re);
		// 检查生日日期是否正确
		var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/"
				+ arrSplit[4]);
		var bGoodDay;
		bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2]))
				&& ((dtmBirth.getMonth() + 1) == Number(arrSplit[3]))
				&& (dtmBirth.getDate() == Number(arrSplit[4]));
		if (!bGoodDay) {
			// alert(dtmBirth.getYear());
			// alert(arrSplit[2]);
			Ext.MessageBox.alert('提示', '输入的身份证号里出生日期不对！');
			return false;
		} else {
			// 检验18位身份证的校验码是否正确。
			// 校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。
			var valnum;
			var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5,
					8, 4, 2);
			var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4',
					'3', '2');
			var nTemp = 0, i;
			for (i = 0; i < 17; i++) {
				nTemp += num.substr(i, 1) * arrInt[i];
			}
			valnum = arrCh[nTemp % 11];
			if (valnum != num.substr(17, 1)) {
				Ext.MessageBox.alert('提示', '18位身份证的校验码不正确！应该为:' + valnum);
				return false;
			}
			return num;
		}
	}
	return false;
}

/**
 * 设置Cookie
 *
 * @param {}
 *            name
 * @param {}
 *            value
 */
function setCookie(name, value, minuts) {
	var argv = setCookie.arguments;
	var argc = setCookie.arguments.length;
	var expiration = new Date((new Date()).getTime() + minuts * 60000 * 60);
	document.cookie = name + "=" + escape(value) + "; expires="
			+ expiration.toGMTString();
}

/**
 * 获取Cookie
 *
 * @param {}
 *            Name
 * @return {}
 */
function getCookie(Name) {
	var search = Name + "="
	if (document.cookie.length > 0) {
		offset = document.cookie.indexOf(search)
		if (offset != -1) {
			offset += search.length
			end = document.cookie.indexOf(";", offset)
			if (end == -1)
				end = document.cookie.length
			return unescape(document.cookie.substring(offset, end))
		} else
			return ""
	}
}

/**
 * 从缓存中清除Cookie
 *
 * @param {}
 *            name
 */
function clearCookie(name) {
	var expdate = new Date();
	expdate.setTime(expdate.getTime() - (86400 * 1000 * 1));
	setCookie(name, "", expdate);
}


var custBoxSelWin;
function openCustBoxSelWin(bizType) {
   if (Ext.isEmpty(custBoxSelWin)) {
	   custBoxSelWin= new Ext.Window({
                   title: '客户池号设置',
                   height: 460,
                   autoScroll : false,
                   width: 320,
                   y : 20,
   				   x : document.body.clientWidth / 2 - 420 / 2,
                   id:'custBoxSelWin',
                   closeAction : 'hide',
                   layout: 'fit',
                   loader: {
	                    url: 'custBoxSel_custbox_base.do?bizType='+bizType,
	                    autoLoad: true,
	                    scripts: true
	                }
               });

	   custBoxSelWin.show();
   } else {
	   custBoxSelWin.show();
   }
}


var custTraceWin;
function openCustTraceWin(cmpid) {
   if (Ext.isEmpty(custTraceWin)) {
	   custTraceWin= new Ext.Window({
                   title: '客户跟踪记录',
                   height: 360,
                   autoScroll : false,
                   width: 450,
                   y : 20,
   				   x : document.body.clientWidth / 2 - 420 / 2,
                   id:'custTraceWin',
                   closeAction : 'hide',
                   layout: 'fit',
                   loader: {
	                    url: 'custTraceList_callhistory_base.do?cmpid='+cmpid,
	                    autoLoad: true,
	                    scripts: true
	                }
               });

	   custTraceWin.show();
   } else {
	   custTraceWin.show();
   }
}


var companyQryWin;
function openCompanyQryWin() {
	if (Ext.isEmpty(companyQryWin)) {
		companyQryWin = new Ext.Window({
			title : '单位查询',
			height: 300,
            autoScroll : false,
			width : 400,
			modal : true,
			id : 'companyQryWin',
			closeAction : 'hide',
			layout : 'fit',
			loader : {
				url : 'companyQuery_company_base.do',
				autoLoad : true,
				scripts : true
			}
		});
		companyQryWin.show();
	} else {
		companyQryWin.show();
	}
}


var sendMessageWin;
function openSendMessageWin() {
   if (Ext.isEmpty(sendMessageWin)) {
	   sendMessageWin= new Ext.Window({
                   title: '短信发送',
                   height: 290,
                   autoScroll : false,
                   width: 310,
                   y : 20,
   				   x : document.body.clientWidth / 2 - 420 / 2,
                   id:'sendMessageWin',
                   closeAction : 'hide',
                   layout: 'fit',
                   loader: {
	                    url: 'sendMessage_sale_base.do',
	                    autoLoad: true,
	                    scripts: true
	                }
               });

	   sendMessageWin.show();
   } else {
	   sendMessageWin.show();
   }
}


var sendMailWin;
function openSendMailWin() {
   if (Ext.isEmpty(sendMailWin)) {
	   sendMailWin= new Ext.Window({
                   title: '邮件发送',
                   height: 400,
                   autoScroll : false,
                   width: 550,
                   y : 20,
   				   x : document.body.clientWidth / 2 - 420 / 2,
                   id:'sendMailWin',
                   closeAction : 'hide',
                   layout: 'fit',
                   loader: {
	                    url: 'sendMail_sale_base.do',
	                    autoLoad: true,
	                    scripts: true
	                }
               });

	   sendMailWin.show();
   } else {
	   sendMailWin.show();
   }
}

var prdSelWin;
function openPrdSelWin() {
   if (Ext.isEmpty(prdSelWin)) {
	   prdSelWin= new Ext.Window({
                   title: '产品选择',
                   height: 400,
                   autoScroll : false,
                   width: 720,
                   id:'prdSelWin',
                   closeAction : 'hide',
                   layout: 'fit',
                   loader: {
	                    url: 'prdSellSel_product_base.do',
	                    autoLoad: true,
	                    scripts: true
	                }
               });
	   prdSelWin.show();
   } else {
	   prdSelWin.show();
   }
}




var iconQryWin;
function openIconQryWin() {
     if (Ext.isEmpty(iconQryWin)) {
    	 iconQryWin= new Ext.Window({
                     title: '图标选择',
                     height: 400,
                     autoScroll : false,
                     width: 630,
                     id:'iconQryWin',
                     closeAction : 'hide',
                     layout: 'fit',
                     loader: {
		                    url: 'iconSel_icon_base.do',
		                    autoLoad: true,
		                    scripts: true
		                }

                 });

    	 iconQryWin.show();
     } else {
    	 iconQryWin.show();
     }
}


var imageQryWin;
function openImageQryWin() {
     if (Ext.isEmpty(imageQryWin)) {
    	 imageQryWin= new Ext.Window({
                     title: '图片选择',
                     height: 400,
                     autoScroll : false,
                     width: 630,
                     id:'imageQryWin',
                     closeAction : 'hide',
                     layout: 'fit',
                     loader: {
		                    url: 'imageSel_icon_base.do',
		                    autoLoad: true,
		                    scripts: true
		                }

                 });

    	 imageQryWin.show();
     } else {
    	 imageQryWin.show();
     }
}


var custViewWin;
function openCustViewWinWin() {
     if (Ext.isEmpty(custViewWin)) {
    	 custViewWin= new Ext.Window({
                     title: '客户查询',
                     height: 450,
                     autoScroll : false,
                     width: 880,
                     id:'custViewWin',
                     closeAction : 'hide',
                     layout: 'fit',
                     loader: {
		                    url: 'custView_customer_base.do',
		                    autoLoad: true,
		                    scripts: true
		                }

                 });

    	 custViewWin.show();
     } else {
    	 custViewWin.show();
     }
}

var deptListWin;
/**
 * 科目查询
 */
function openDeptWin() {
     if (Ext.isEmpty(deptListWin)) {
    	 deptListWin= new Ext.Window({
                     title: '部门列表',
                     height: 450,
                     autoScroll : false,
                     modal : true,
                     width: 220,
                     id:'deptListWin',
                     closeAction : 'hide',
                     layout: 'fit',
                     loader: {
		                    url: 'deptList_dept_base.do',
		                    autoLoad: true,
		                    scripts: true
		                }

                 });

    	 deptListWin.show();
     } else {
    	 deptListWin.show();
     }
}



var userListWin;
/**
 * 科目查询
 */
function openUserWin() {
     if (Ext.isEmpty(userListWin)) {
    	 userListWin= new Ext.Window({
                     title: '用户列表',
                     height: 450,
                     modal : true,
                     autoScroll : false,
                     width: 380,
                     id:'userListWin',
                     closeAction : 'hide',
                     layout: 'fit',
                     loader: {
		                    url: 'userList_user_base.do',
		                    autoLoad: true,
		                    scripts: true
		                }

                 });

    	 userListWin.show();
     } else {
    	 userListWin.show();
     }
}




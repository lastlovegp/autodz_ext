package com.base.common;

/**
 * 常量表
 *
 * @author XiongChun
 * @since 2009-07-13ERRMSG_RES
 */
public interface SysConstants {


	public static final String FLAG_ON = "1";
	public static final String FLAG_OFF = "0";
	
	public static final String FLAG_YES = "Y";
	public static final String FLAG_NO = "N";

	public static final String GRID_MODIFYED_REC = "modifyRecs";
	public static final String GRID_DELED_REC = "delRecs";

	// messageResource,errcode
	public static final String MESSAGE_RES = "messageResource";
	public static final String ERRMSG_RES = "errcode";
	
	
	public static final String LOGIN_FLAG = "loginFlag";

	/**
	 * 树节点类型<br>
	 * 1:叶子节点
	 */
	public static final String LEAF_Y = "1";
	public static final String LEAF_N = "0";

	public static final String SESSION_KEY = "SessionContainer";

	public static final String USER_INFO = "userInfo";
	public static final String SYSTEM_PARAM = "systemParam";

	/**
	 * XML文档风格<br>
	 * 0:节点属性值方式
	 */
	public static final String XML_Attribute = "0";

	/**
	 * XML文档风格<br>
	 * 1:节点元素值方式
	 */
	public static final String XML_Node = "1";

	/**
	 * 字符串组成类型<br>
	 * number:数字字符串
	 */
	public static final String S_STYLE_N = "number";

	/**
	 * 单据类型
	 */
	public static final String ORDER_TYPE_BUY_ORDER = "PO"; // 采购订单
	public static final String ORDER_TYPE_BUY_BILL = "CG"; // 采购单据
	public static final String ORDER_TYPE_BUY_BACK_BILL = "CT"; // 采购退回
	public static final String ORDER_TYPE_SELL_ORDER = "SO"; // 销售订单
	public static final String ORDER_TYPE_SELL_BACK_BILL = "XT"; // 销售退货单据
	public static final String ORDER_TYPE_SELL_BILL = "XS"; // 销售单据
	public static final String ORDER_TYPE_OTHER_IN_STORE = "QR"; // 其他入库单
	public static final String ORDER_TYPE_OTHER_OUT_STORE = "QC"; // 其他出库单
	public static final String ORDER_TYPE_PRODUCT_ADDR_CHG = "SC"; // 仓库调拨
	public static final String ORDER_TYPE_PRODUCT_COMP_SPLIT = "GC"; // 货品组合单

	public static final String ORDER_TYPE_OTHER_REC = "QS"; // 其他付款收款单
	public static final String ORDER_TYPE_OTHER_PAY = "QF"; // 其他付款收款单

	public static final String ORDER_TYPE_EXCHANGE_PAY = "FK"; // 付款单
	public static final String ORDER_TYPE_EXCHANGE_REC = "SK"; // 收款单

	public static final String ORDER_TYPE_PDT_INIT = "IT"; // 存货初始化


	//其他单据
	public static final String ORDER_TYPE_LEAVE_APPLY = "QJ"; //请假单
	
	
	/**
	 * 客户状态
	 */
	public static final String CUST_STATUS_CREATE = "0"; 
	public static final String CUST_STATUS_TRACE = "1"; 
	public static final String CUST_STATUS_BOOKING = "3"; 
	public static final String CUST_STATUS_COMPLETE = "4"; 
	public static final String CUST_STATUS_CLOSE = "6"; 
	
	/**
	 * 提醒类型
	 */
	public static final String REMIND_TYPE_IMPORTANCE = "01"; 
	public static final String REMIND_TYPE_TRACE = "02"; 
	public static final String REMIND_TYPE_BOOKING = "03"; 
	
	
	/**
	 * 跟进操作类型 0:继续跟进;1:关闭
	 */
	public static final String SALE_DOTLR_TRACEING = "0"; 
	public static final String SALE_DOTLR_CLOSE = "1"; 
	
	
	/**
	 * 预约状态
	 */
	public static final String BOOKING_TYPE_UNBOOKING = "01"; 
	public static final String BOOKING_TYPE_BOOKED = "02"; 
	public static final String BOOKING_TYPE_REBOOKING = "03"; 
	

	/**
	 * 单据状态
	 */
	public static final String ORDER_STATUS_STORE_NOT_IN = "0"; // 未入库
	public static final String ORDER_STATUS_STORE_PART_IN = "1"; // 部分入库
	public static final String ORDER_STATUS_STORE_IN = "2"; // 已入库
	public static final String ORDER_STATUS_STORE_NOT_EXIT = "3"; // 未出库
	public static final String ORDER_STATUS_STORE_PART_IEXIT = "4"; // 部分出库
	public static final String ORDER_STATUS_STORE_EXIT = "5"; // 已出库
	public static final String ORDER_STATUS_STORE_CHANGE = "6"; // 已调拨
	public static final String ORDER_STATUS_PRODUCT_COMP = "7"; // 已组合
	public static final String ORDER_STATUS_PRODUCT_SPLIT = "8"; // 已拆分
	public static final String ORDER_STATUS_STORE_CLOSE = "A"; // 关闭

	// 订单审核状态
	public static final String APPROVE_STATUS_UN_APPROVE = "0"; // 未审批
	public static final String APPROVE_STATUS_APPROVEED = "1"; // 已审批
	public static final String APPROVE_STATUS_APPROVEING = "2"; // 审批中
	public static final String APPROVE_STATUS_SUBMITED = "3"; // 已上传

	// 单据付款/收款状态
	public static final String ATS_STATUS_UN_PAY = "0"; // 未付款
	public static final String ATS_STATUS_PART_PAY = "1"; // 部分付款
	public static final String ATS_STATUS_PAYED = "2"; // 全部已付款
	public static final String ATS_STATUS_UN_REC = "3"; // 未收款
	public static final String ATS_STATUS_PART_REC = "4"; // 部分收款
	public static final String ATS_STATUS_RECED = "5"; // 全部已收款
	public static final String ATS_STATUS_UNUSE = "A"; // 无效

	/**
	 * 币种
	 */
	public static final String CURCD_RMB = "01"; // 人民币
	public static final String CURCD_USA = "02"; // 美元

	/**
	 * 审批意见
	 */
	public static final String APPROVE_DO_AGREDD = "0"; // 同意
	public static final String APPROVE_DO_REJECT = "1"; // 拒绝

	/**
	 * 字符串组成类型<br>
	 * letter:字母字符串
	 */
	public static final String S_STYLE_L = "letter";

	/**
	 * 字符串组成类型<br>
	 * numberletter:数字字母混合字符串
	 */
	public static final String S_STYLE_NL = "numberletter";

	/**
	 * 格式化(24小时制)<br>
	 * FORMAT_DateTime: 日期时间
	 */
	public static final String FORMAT_DateTime = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 格式化(12小时制)<br>
	 * FORMAT_DateTime: 日期时间
	 */
	public static final String FORMAT_DateTime_12 = "yyyy-MM-dd hh:mm:ss";

	/**
	 * 格式化<br>
	 * FORMAT_DateTime: 日期
	 */
	public static final String FORMAT_Date = "yyyy-MM-dd HH:mm:ss";
	
	public static final String FORMAT_Date2 = "yyyy-MM-dd HH:mm:ss";
	
	public static final String FORMAT_Date3 = "yyyy/MM/dd";
	
	public static final String FORMAT_Date_8 = "yyyy-MM-dd ";

	/**
	 * 格式化(24小时制)<br>
	 * FORMAT_DateTime: 时间
	 */
	public static final String FORMAT_Time = "HH:mm:ss";

	/**
	 * 格式化(12小时制)<br>
	 * FORMAT_DateTime: 时间
	 */
	public static final String FORMAT_Time_12 = "hh:mm:ss";

	/**
	 * 换行符<br>
	 * \n:换行
	 */
	public static final String ENTER = "\n";

	/**
	 * 异常信息统一头信息<br>
	 * 非常遗憾的通知您,程序发生了异常
	 */
	public static final String Exception_Head = "\n非常遗憾的通知您,程序发生了异常.\n"
			+ "异常信息如下:\n";

	/**
	 * Ext表格加载模式<br>
	 * \n:非翻页排序加载模式
	 */
	public static final String EXT_GRID_FIRSTLOAD = "first";

	/**
	 * Excel模板数据类型<br>
	 * number:数字类型
	 */
	public static final String ExcelTPL_DataType_Number = "number";

	/**
	 * Excel模板数据类型<br>
	 * number:文本类型
	 */
	public static final String ExcelTPL_DataType_Label = "label";

	/**
	 * HTTP请求类型<br>
	 * 1:裸请求
	 */
	public static final String PostType_Nude = "1";

	/**
	 * HTTP请求类型<br>
	 * 0:常规请求
	 */
	public static final String PostType_Normal = "0";

	/**
	 * Ajax请求超时错误码<br>
	 * 999:Ajax请求超时错误码
	 */
	public static final int Ajax_Timeout = 999;

	/**
	 * Ajax请求非法错误码<br>
	 * 998:当前会话userid和登录时候的userid不一致(会话被覆盖)
	 */
	public static final int Ajax_Session_Unavaliable = 998;

	/**
	 * 交易状态:成功
	 */
	public static final Boolean TRUE = new Boolean(true);

	/**
	 * 交易状态:失败
	 */
	public static final Boolean FALSE = new Boolean(false);

	public static final String CONFFILENAME = "gd";

	public static final String DATE_PATTERN = "yyyy-MM-dd";

	/**
	 * 交易状态:成功
	 */
	public static final String SUCCESS = "1";

	/**
	 * 交易状态:失败
	 */
	public static final String FAILURE = "0";

	public static final String WEB_SESSION_ID = "jsessionid";

	/**
	 * 分页查询分页参数缺失错误信息
	 */
	public static final String ERR_MSG_QUERYFORPAGE_STRING = "您正在使用分页查询,但是你传递的分页参数缺失!如果不需要分页操作,您可以尝试使用普通查询:queryForList()方法";

	/**
	 * Flash图标色彩数组
	 */
	public static String[] CHART_COLORS = { "AFD8F8", "F6BD0F", "8BBA00",
			"008E8E", "D64646", "8E468E", "588526", "B3AA00", "008ED6",
			"9D080D", "A186BE", "1EBE38" };

	/**
	 * 启用状态<br>
	 * 1:启用
	 */
	public static final String ENABLED_Y = "1";

	/**
	 * 启用状态<br>
	 * 0:停用
	 */
	public static final String ENABLED_N = "0";

	/**
	 * 编辑模式<br>
	 * 1:可编辑
	 */
	public static final String EDITMODE_Y = "1";

	/**
	 * 编辑模式<br>
	 * 0:只读
	 */
	public static final String EDITMODE_N = "0";

	/**
	 * 科目方向
	 */
	public static final String SJT_DIRC_DEBIT = "0";
	public static final String SJT_DIRC_CREDIT = "1";

	/**
	 * 锁定态<br>
	 * 1:锁定
	 */
	public static final String LOCK_Y = "1";

	/**
	 * 锁定状态<br>
	 * 0:解锁
	 */
	public static final String LOCK_N = "0";

	/**
	 * 强制类加载<br>
	 * 1:强制
	 */
	public static final String FORCELOAD_Y = "1";

	/**
	 * 强制类加载<br>
	 * 0:不强制
	 */
	public static final String FORCELOAD_N = "0";

	/**
	 * 角色类型<br>
	 * 1:业务角色
	 */
	public static final String ROLETYPE_BUSINESS = "1";

	/**
	 * 角色类型<br>
	 * 2:管理角色
	 */
	public static final String ROLETYPE_ADMIN = "2";

	/**
	 * 角色类型<br>
	 * 3:系统内置角色
	 */
	public static final String ROLETYPE_EMBED = "3";

	/**
	 * 权限级别<br>
	 * 1:访问权限
	 */
	public static final String AUTHORIZELEVEL_ACCESS = "1";

	/**
	 * 权限级别<br>
	 * 2:管理权限
	 */
	public static final String AUTHORIZELEVEL_ADMIN = "2";

	/**
	 * 用户类型<br>
	 * 1:经办员
	 */
	public static final String USERTYPE_BUSINESS = "1";

	/**
	 * 用户类型<br>
	 * 2:管理员
	 */
	public static final String USERTYPE_ADMIN = "2";

	/**
	 * 用户类型<br>
	 * 3:系统内置用户
	 */
	public static final String USERTYPE_EMBED = "3";

	/**
	 * 根节点ID<br>
	 * 01:菜单树
	 */
	public static final String ROORID_MENU = "01";

	/**
	 * 帐户类型<br>
	 * 1:常规帐户
	 */
	public static final String ACCOUNTTYPE_NORMAL = "1";

	/**
	 * 帐户类型<br>
	 * 2:SUPER帐户
	 */
	public static final String ACCOUNTTYPE_SUPER = "2";

	/**
	 * 帐户类型<br>
	 * 3:DEVELOPER帐户
	 */
	public static final String ACCOUNTTYPE_DEVELOPER = "3";

	/**
	 * 操作员事件跟踪监控开关[1:打开;0:关闭]<br>
	 * 1:打开
	 */
	public static final String EVENTMONITOR_ENABLE_Y = "1";

	/**
	 * 操作员事件跟踪监控开关[1:打开;0:关闭]<br>
	 * 0:关闭
	 */
	public static final String EVENTMONITOR_ENABLE_N = "0";

	/**
	 * 切入点类型[1:BPO切入;2:DAO切入]<br>
	 * 1:BPO切入
	 */
	public static final String POINTCUTTYPE_BPO = "1";

	/**
	 * 切入点类型[1:BPO切入;2:DAO切入]<br>
	 * 2:DAO切入
	 */
	public static final String POINTCUTTYPE_DAO = "2";

	/**
	 * 通知类型[1:方法调用通知;2:异常捕获通知]<br>
	 * 1:方法调用通知
	 */
	public static final String ADVISETYPE_CALL = "1";

	/**
	 * 通知类型[1:方法调用通知;2:异常捕获通知]<br>
	 * 2:异常捕获通知
	 */
	public static final String ADVISETYPE_CATCH = "2";

	/**
	 * 菜单类型<br>
	 * 1:系统菜单
	 */
	public static final String MENUTYPE_SYSTEM = "1";

	public static final String DEFAULT_PASSWORD_KEY = "wsjiabao.gd.Ocean's Fourteen.DWMNTH2CJFLCWL";

	/**
	 * 菜单类型<br>
	 * 0:业务菜单
	 */
	public static final String MENUTYPE_BUSINESS = "0";


	/**
	 * 系统参数
	 */
	public static final String SYSPARAM_SYS_DEFAULT_THEME = "SYS_DEFAULT_THEME";
	public static final String SYSPARAM_WELCOME_PAGE_TITLE = "WELCOME_PAGE_TITLE";
	public static final String SYSPARAM_MULTI_SESSION = "MULTI_SESSION";
	public static final String SYSPARAM_BOTTOM_COPYRIGHT = "BOTTOM_COPYRIGHT";
	public static final String SYSPARAM_WEST_NAVIGATE_TITLE = "WEST_NAVIGATE_TITLE";
	public static final String SYSPARAM_TAOBAO_ENV = "TAOBAO_ENV";

	/**
	 * 凭证类型
	 */
	public static final String WARRANT_TYPE_COMM = "0"; // 普通凭证
	public static final String WARRANT_TYPE_TERM_END_COSTCAL = "1"; // 结转凭证-成本核算
	public static final String WARRANT_TYPE_TERM_END_SUNYI_JIEZ = "2"; // 结转凭证-结转损益
	public static final String WARRANT_TYPE_TERM_END_DEVICE_DEB = "3"; // 固定资产结转

	public static final String FACTORY_DEB_CAL_TYPE_YEAR_AVG = "1"; // 1:平均年限法
	public static final String FACTORY_DEB_CAL_TYPE_NO_DEB = "2"; // 2:不提折旧

	public static final String BLANCE_ITEM_TYPE_ZC = "0101"; // 资产
	public static final String BLANCE_ITEM_TYPE_FZ = "0102"; // 负债
	public static final String BLANCE_ITEM_TYPE_QY = "0103"; // 所有者权益
	public static final String BLANCE_ITEM_TYPE_LR = "0104"; // 利润

}
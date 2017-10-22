/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */

package com.base.common;

/**
 * @author valley
 * @date 2004-11-16
 * @desc define error code
 */
public class ErrorCode {

	/**
	 * 系统错误代码 GD0001~GD0100
	 */
	public static final String ERROR_CODE_UNKNOWN = "GD0001"; // 未知错误
	public static final String ERROR_CODE_DATE_FORMAT_ERR = "GD0002"; // 日期格式错误
	public static final String ERROR_CODE_DATA_FORMAT_ERR = "GD0003"; // 数据格式错误
	public static final String ERROR_CODE_INTERNAL_ERROR = "GD0004"; // 应用系统内部错误
	public static final String ERROR_CODE_FTP = "GD0005"; // FTP错误
	public static final String ERROR_CODE_DOWNLOAD = "GD0006"; // 下载文件失败
	public static final String ERROR_CODE_INVALID_FORMAT = "GD0007"; // 格式错误
	public static final String ERROR_CODE_WS_COMM_ERROR = "SE0008"; // 通讯错误

	/**
	 * 用户登陆,操作员信息修改 错误码 GD0101~GD0400
	 */
	public static final String ERROR_CODE_TLRNO_NO_FUNCTION = "GD0101"; // 操作员无此功能权限
	public static final String ERROR_CODE_TLRNO_SESSION_INVALID = "GD0102"; // 操作员会话无效
	public static final String ERROR_CODE_TLRNO_SESSION_BINDED = "GD0103"; // 此会话已经被其他操作员绑定
	public static final String ERROR_CODE_NO_GLOBALINFO_INSTANCE = "GD0104"; // 系统错误，没有初始化全局信息
	public static final String ERROR_CODE_STORE_NOT_ENOUTH = "GD0105"; // 库存不够
	public static final String ERROR_CODE_TLRNO_ALREADY_LOGIN = "GD0106";// 用户已登录
	public static final String ERROR_CODE_TLRNO_STATUS_INVALID = "GD0107";// 用户状态无效
	public static final String ERROR_CODE_USER_NOT_EXIST = "GD0108";// 用户不存在
	public static final String ERROR_CODE_USER_PWD_INVALID = "GD0109";// 用户密码错误
	public static final String ERROR_CODE_TLRNO_PSWD_ERR_THREE_TIMES = "GD0110";// 操作员连续三次密码错误
	public static final String ERROR_CODE_TLRNO_PSWD_ERR_SIX_TIMES = "GD0111";// 操作员当日累计六次密码错误
	public static final String ERROR_CODE_CHG_PWD_SAME_CHARS = "GD0112";// 密码不能为连续相同字母
	public static final String ERROR_CODE_NEW_OLD_PWD_IS_SAME = "GD0113";// 新旧密码不能相同
	public static final String ERROR_CODE_USER_INFO_INVALID = "GD0114";// 获取用户信息失败
	public static final String ERROR_CODE_NEW_AGAIN_PWD_IS_NOT_SAME = "GD0115";// 新密码和确认密码必须相同
	public static final String ERROR_CODE_PWD_FIELDS_IS_NULL = "GD0116";// 旧密码、新密码或确认密码字段不能为空

	/**
	 * DAO错误代码 GD1001~GD2000
	 */
	public static final String ERROR_CODE_DAO = "GD1001"; // DAO错误
	public static final String ERROR_CODE_TRACEDTL_SELECT = "GD1001"; // DAO错误

	/**
	 * 业务错误
	 */
	public static final String ERROR_CODE_ADVANCE_ERROR = "ER0001"; // 预付款超限
	public static final String ERROR_CODE_SYSTEM_RIGHT_ERROR = "ER9999"; // 系统权限错误

	public static final String ERROR_CODE_ORDER_AMT = "ER1001"; // 单据金额错误
	public static final String ERROR_CODE_TLR_INFO_SELECT = "ER0002"; // 操作员查询错误
	public static final String ERROR_CODE_NO_BRCODE = "ER0003"; // DAO错误
	public static final String ERROR_CODE_BCTL_DAO_ERR = "ER0004"; // 机构表操作错误
	public static final String ERROR_CODE_IN_OUT_ERR = "ER0005"; // 出入库错误
	public static final String ERROR_CODE_STROE_CHG_ERR = "ER0006"; // 库存调拨错误

	public static final String ERROR_CODE_ORDER_MODIFY = "ER1007"; // 单据修改出错
	public static final String ERROR_CODE_ORDER_INFO = "ER1008"; // 单据录入信息有误
	public static final String ERROR_CODE_ORDER_NO_FIND = "ER1009"; // 单据找不到
	public static final String ERROR_CODE_STROE_SPLIT_ERR = "ER0010"; // 库存转换错误
	public static final String ERROR_CODE_SUBJECT_CODE = "ER0011"; // 科目编码错误
	public static final String ERROR_CODE_WARRANT_INPUT_CODE = "ER0012"; // 凭证录入出错
	public static final String ERROR_CODE_WARRANT_END_PROCESS = "ER0013"; // 凭期末结转出错
	public static final String ERROR_CODE_EMPLOYEE_MNG = "ER0014"; // 职员维护出错
	public static final String ERROR_CODE_EMPLOYEE_UN_EFFECT = "ER0015"; // 帐套失效

	public static final String ERROR_CODE_EDIT_ERROR = "ER0016"; // 修改错误

	/**
	 * 记账
	 */
	public static final String ERROR_CODE_ASSET_RTN_EDIT = "ER0030"; // 财务报表维护错


	/**
	 * 报表出错
	 */
	public static final String ERROR_CODE_REORT_ERROR = "ER9901"; // 生产报表出错
	public static final String ERROR_CODE_REORT_PRINT_ERROR = "ER9902"; // 打印报表出错
}

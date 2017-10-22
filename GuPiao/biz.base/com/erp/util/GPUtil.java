package com.erp.util;

import java.math.BigDecimal;
import java.util.Calendar;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 */
public class GPUtil {
	private static Log logger = LogFactory.getLog(GPUtil.class);
	

	/**
	 * 获取股票类型
	 * 
	 * @param code
	 * @return
	 */
	public static boolean isGpTranTime() {
		Calendar now = Calendar.getInstance();

		int hour = now.get(Calendar.HOUR_OF_DAY);
		int minute = now.get((Calendar.MINUTE));
		if (hour < 9 || hour == 12 || hour >= 15) {
			return false;
		} else if (hour == 9 && minute <= 25) {
			return false;
		}else if (hour == 11 && minute > 30) {
			return false;
		}

		return true;

	}
	
	/**
	 * 获得服务器当前时间，以格式为：HH:mm:ss的日期字符串形式返回
	 * 
	 * @author dylan_xu
	 * @date Mar 11, 2012
	 * @return
	 */
	public static String getTime(String time) {
		return time.substring(10);
	}

	/**
	 * 获取股票类型
	 * 
	 * @param code
	 * @return
	 */
	public static String getGpType(String code) {
		if (code.indexOf("sh") != -1) {
			return "0";
		} else if (code.indexOf("zs0") != -1) {
			return "1";
		} else {
			return "2";
		}
	}

	/**
	 * 获取股票类型
	 * 
	 * @param code
	 * @return
	 */
	public static String getGpCode(String code) {
		if (code.indexOf("6") == 0) {
			return "sh" + code;
		} else {
			return "sz" + code;
		}
	}

	public static double tranDouble(double data) {
		double d = new BigDecimal(data).setScale(4, BigDecimal.ROUND_HALF_UP)
				.doubleValue();
		return d;
	}

	public static void main(String[] args) throws Exception {
		Calendar now = Calendar.getInstance();

		int hour = now.get(Calendar.HOUR_OF_DAY);
		int minute = now.get((Calendar.MINUTE));
		System.out.println("isGpTranTime:" + hour+":"+minute);
	}

}

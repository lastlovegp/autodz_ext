/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */

package com.erp.framework.util;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.base.common.ErrorCode;
import com.base.common.SysConstants;
import com.erp.framework.exceptions.CommonException;

/**
 * @author valley
 * @date Nov 29, 2004
 * @description
 */
public class DateUtil {

	public static Date defaultDate = null;

	public static Date date19700101 = null;

	private static Calendar cale = Calendar.getInstance();

	private static Log log = LogFactory.getLog(DateUtil.class);

	static {
		try {
			defaultDate = DataFormat.numberToDate("19000101");
			date19700101 = DataFormat.numberToDate("19700101");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public DateUtil() {
		super();
	}

	public static java.sql.Date getCurrentDate() {
		return new java.sql.Date(System.currentTimeMillis());
	}


	/**
	 * 获得服务器当前日期的月份 150. *
	 * 
	 * @author dylan_xu 151. *
	 * @date Mar 11, 2012
	 */
	public static String getMonth() {
		try {
			java.text.DecimalFormat df = new java.text.DecimalFormat();
			df.applyPattern("00;00");
			return df.format((cale.get(Calendar.MONTH) + 1));
		} catch (Exception e) {
			log.debug("DateUtil.getMonth():" + e.getMessage());
			return "";
		}
	}

	public static int getYear() {
		try {
			return cale.get(Calendar.YEAR);
		} catch (Exception e) {
			log.debug("DateUtil.getHour():" + e.getMessage());
			return 0;
		}
	}

	public static int getHour() {
		try {
			return cale.get(Calendar.HOUR_OF_DAY);
		} catch (Exception e) {
			log.debug("DateUtil.getHour():" + e.getMessage());
			return 0;
		}
	}

	public static int getMinute() {
		try {
			return cale.get(Calendar.MINUTE);
		} catch (Exception e) {
			log.debug("DateUtil.getMinute():" + e.getMessage());
			return 0;
		}
	}

	public static String getTerm(Date inDate) {
		return DateUtil.formatDate6(DateUtil.dateToString(inDate));
	}

	public static String toTime(String timeStr) {
		return timeStr.replaceAll("上午", "").replaceAll("下午", "");
	}

	public static Date getDateByStr(String date, String time)
			throws CommonException {
		if (StringUtils.isBlank(date) || StringUtils.isBlank(time)) {
			return null;
		}
		String tmpTimeString = time.replaceAll("上午", "").replaceAll("下午", "");
		String tmpDate = date + " " + tmpTimeString;
		return DateUtil.stringToDate(tmpDate);
	}

	public static Time getCurrentTime() {
		return new Time(System.currentTimeMillis());
	}

	public static Timestamp getTimestamp() {
		return new Timestamp(System.currentTimeMillis());
	}

	public static String dateToString(Date date) {
		if (date == null)
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				SysConstants.FORMAT_Date);
		return simpleDateFormat.format(date);
	}

	public static String dateToString8(Date date) {
		if (date == null)
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				SysConstants.FORMAT_Date_8);
		return simpleDateFormat.format(date);
	}

	public static Date stringToDate(String string) {
		if (string == null)
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				SysConstants.FORMAT_Date2);
		try {
			return simpleDateFormat.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static Date stringToDateExt1(String string) {
		if (string == null)
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				SysConstants.FORMAT_Date3);
		try {
			return simpleDateFormat.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	public static Date stringToDateExt8(String string) {
		if (string == null)
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				SysConstants.FORMAT_Date_8);
		try {
			return simpleDateFormat.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static Date stringToDateExt(String string) throws CommonException {
		if (DataFormat.isEmpty(string))
			return null;

		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(
				"MM/dd/yy HH:mm");
		try {
			return simpleDateFormat.parse(string);
		} catch (ParseException e) {
			e.printStackTrace();
			ExceptionUtil
					.throwCommonException(ErrorCode.ERROR_CODE_DATE_FORMAT_ERR);
		}
		return null;
	}

	public static void main(String[] args) {
		System.out.print(DateUtil.getHour()+":"+DateUtil.getMinute());
	}

	public static int getDaysBetween(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		if (startDate.after(endDate)) {
			Calendar swap = calendarStartDate;
			calendarStartDate = calendarEndDate;
			calendarEndDate = swap;
		}

		int days = calendarEndDate.get(Calendar.DAY_OF_YEAR)
				- calendarStartDate.get(Calendar.DAY_OF_YEAR);
		int y2 = calendarEndDate.get(Calendar.YEAR);
		while (calendarStartDate.get(Calendar.YEAR) < y2) {
			days += calendarStartDate.getActualMaximum(Calendar.DAY_OF_YEAR);
			calendarStartDate.add(Calendar.YEAR, 1);
		}

		return days;
	}

	public static int getIntervalMinutes(Date startDate, Date endDate) {
		long startdate = startDate.getTime();
		long enddate = endDate.getTime();
		long interval = enddate - startdate;
		int intervalday = (int) (interval / (1000 * 60));
		return intervalday;
	}

	public static int getDaysBetween30(Date startDate, Date endDate) {

		Calendar calendarStartDate = Calendar.getInstance();

		Calendar calendarEndDate = Calendar.getInstance();

		calendarStartDate.setTime(startDate);

		calendarEndDate.setTime(endDate);

		if (startDate.after(endDate)) {

			Calendar swap = calendarStartDate;

			calendarStartDate = calendarEndDate;

			calendarEndDate = swap;

		}

		int months =

		calendarEndDate.get(Calendar.MONTH)

		- calendarStartDate.get(Calendar.MONTH)

		+ (calendarEndDate.get(Calendar.YEAR)

		- calendarStartDate.get(Calendar.YEAR))

		* 12;

		Date newEndDate = getEndDateByMonths(startDate, months);

		if (newEndDate.compareTo(endDate) <= 0

		|| isSameDate(newEndDate, endDate) == true)

			months += 1;

		int days = (months - 1) * 30;

		Date newStartDate = getEndDateByMonths(startDate, months - 1);

		days += getDaysBetween(newStartDate, endDate);

		return days;

	}

	/**
	 * 生日得到年龄
	 * 
	 * @param birthDay
	 * @return
	 * @throws Exception
	 */
	public static int getAge(Date birthDay) throws Exception {
		Calendar cal = Calendar.getInstance();

		if (cal.before(birthDay)) {
			return 0;
		}

		int yearNow = cal.get(Calendar.YEAR);
		int monthNow = cal.get(Calendar.MONTH);
		int dayOfMonthNow = cal.get(Calendar.DAY_OF_MONTH);
		cal.setTime(birthDay);

		int yearBirth = cal.get(Calendar.YEAR);
		int monthBirth = cal.get(Calendar.MONTH);
		int dayOfMonthBirth = cal.get(Calendar.DAY_OF_MONTH);

		int age = yearNow - yearBirth;

		if (monthNow <= monthBirth) {
			if (monthNow == monthBirth) {
				if (dayOfMonthNow < dayOfMonthBirth) {
					age--;
				}
			} else {
				age--;
			}
		}

		return age;
	}

	/**
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static int getYearsBetween(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		return calendarEndDate.get(Calendar.YEAR)
				- calendarStartDate.get(Calendar.YEAR);
	}

	/**
	 * ����}��������������(�������µ���һ����)
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static int getMonthsBetween(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		// ������Ϊ��Ӧ����
		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		if (startDate.after(endDate)) {
			Calendar swap = calendarStartDate;
			calendarStartDate = calendarEndDate;
			calendarEndDate = swap;
		}

		int months = calendarEndDate.get(Calendar.MONTH)
				- calendarStartDate.get(Calendar.MONTH)
				+ (calendarEndDate.get(Calendar.YEAR) - calendarStartDate
						.get(Calendar.YEAR)) * 12;

		if (getEndDateByMonths(startDate, months).compareTo(endDate) < 0)
			months += 1;

		return months;
	}

	/**
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static int getActualMonths(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		// ������Ϊ��Ӧ����
		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		if (startDate.after(endDate)) {
			Calendar swap = calendarStartDate;
			calendarStartDate = calendarEndDate;
			calendarEndDate = swap;
		}

		int months = calendarEndDate.get(Calendar.MONTH)
				- calendarStartDate.get(Calendar.MONTH)
				+ (calendarEndDate.get(Calendar.YEAR) - calendarStartDate
						.get(Calendar.YEAR)) * 12;

		return months;
	}

	/**
	 * @param startDate
	 * @param days
	 * @return
	 */
	public static Date getEndDateByDays(Date startDate, int days) {
		Calendar calendarStartDate = Calendar.getInstance();
		calendarStartDate.setTime(startDate);
		calendarStartDate.add(Calendar.DAY_OF_YEAR, days);

		return calendarStartDate.getTime();
	}

	/**
	 * 
	 * @param startDate
	 * @param months
	 * @return
	 */
	public static Date getEndDateByMonths(Date startDate, int months) {
		Calendar calendarStartDate = Calendar.getInstance();
		calendarStartDate.setTime(startDate);
		calendarStartDate.add(Calendar.MONTH, months);

		return calendarStartDate.getTime();
	}

	/**
	 * 
	 * @param startDate
	 * @param term
	 *            YYMMDD��ʽ�Ĵ������
	 * @return
	 */
	public static Date getEndDateByTerm(Date startDate, String term) {
		int years = Integer.parseInt(term.substring(0, 2));
		int months = Integer.parseInt(term.substring(2, 4));
		int days = Integer.parseInt(term.substring(4, 6));
		return getEndDateByDays(
				getEndDateByMonths(startDate, years * 12 + months), days);
	}

	/**
	 * 
	 * @param startDate
	 * @param endDate
	 * @return YYMMDD��ʽ�Ĵ������
	 */
	public static String getTermBetween(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		if (startDate.after(endDate)) {
			Calendar swap = calendarStartDate;
			calendarStartDate = calendarEndDate;
			calendarEndDate = swap;
		}

		int months = calendarEndDate.get(Calendar.MONTH)
				- calendarStartDate.get(Calendar.MONTH)
				+ (calendarEndDate.get(Calendar.YEAR) - calendarStartDate
						.get(Calendar.YEAR)) * 12;
		int days = 0;
		Date tempEndDate = getEndDateByMonths(startDate, months);

		if (tempEndDate.compareTo(endDate) < 0) {
			days = getDaysBetween(tempEndDate, endDate);
		} else if (tempEndDate.compareTo(endDate) > 0) {
			months -= 1;
			tempEndDate = getEndDateByMonths(startDate, months);
			days = getDaysBetween(tempEndDate, endDate);
		}

		int years = months / 12;
		months = months % 12;

		return DataFormat.termToString(years, months, days);
	}

	/**
	 * 
	 * @param startDate
	 * @param years
	 * @param months
	 * @param days
	 * @return
	 */
	public static Date getEndDateByTerm(Date startDate, int years, int months,
			int days) {
		return getEndDateByDays(
				getEndDateByMonths(startDate, years * 12 + months), days);
	}

	/**
	 * 
	 * @param endDate
	 * @param days
	 * @return
	 */
	public static Date getStartDateByDays(Date endDate, int days) {
		Calendar calendarEndDate = Calendar.getInstance();
		calendarEndDate.setTime(endDate);
		calendarEndDate.add(Calendar.DAY_OF_YEAR, 0 - days);

		return calendarEndDate.getTime();
	}

	/**
	 * 
	 * @param endDate
	 * @param months
	 * @return
	 */
	public static Date getStartDateByMonths(Date endDate, int months) {
		Calendar calendarEndDate = Calendar.getInstance();
		calendarEndDate.setTime(endDate);
		calendarEndDate.add(Calendar.MONTH, 0 - months);

		return calendarEndDate.getTime();
	}

	/**
	 * 
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static boolean isSameDate(Date startDate, Date endDate) {
		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);
		if (startDate.after(endDate)) {
			Calendar swap = calendarStartDate;
			calendarStartDate = calendarEndDate;
			calendarEndDate = swap;
		}

		if (calendarStartDate.get(Calendar.DATE) == calendarEndDate
				.get(Calendar.DATE))
			return true;

		if (calendarStartDate.get(Calendar.DATE) > calendarEndDate
				.get(Calendar.DATE)) {
			if (calendarEndDate.get(Calendar.DATE) == calendarEndDate
					.getActualMaximum(Calendar.DATE))
				return true;
		}

		return false;
	}

	/**
	 * 
	 * @param date
	 * @param dd
	 * @return
	 */
	public static boolean isSameDate(Date date, String dd) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int day = Integer.parseInt(dd);

		if (calendar.get(Calendar.DATE) == day)
			return true;

		if (calendar.get(Calendar.DATE) < day) {
			if (calendar.get(Calendar.DATE) == calendar
					.getActualMaximum(Calendar.DATE))
				return true;
		}

		return false;
	}

	/**
	 * @param startDate
	 * @param endDate
	 * @return
	 */
	public static boolean isSameMonth(Date startDate, Date endDate) {
		if (startDate == null || endDate == null)
			return false;

		Calendar calendarStartDate = Calendar.getInstance();
		Calendar calendarEndDate = Calendar.getInstance();

		// ������Ϊ��Ӧ����
		calendarStartDate.setTime(startDate);
		calendarEndDate.setTime(endDate);

		if (calendarStartDate.get(Calendar.YEAR) == calendarEndDate
				.get(Calendar.YEAR)
				&& calendarStartDate.get(Calendar.MONTH) == calendarEndDate
						.get(Calendar.MONTH))
			return true;

		return false;
	}

	/**
	 * 
	 * @param today
	 * @return
	 */
	public static Date getFirstDate(Date today) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(today);
		calendar.set(Calendar.DATE, 1);

		return calendar.getTime();
	}

	/**
	 * 
	 * @param today
	 * @return
	 */
	public static Date getLastDate(Date today) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(today);
		calendar.set(Calendar.DATE, calendar.getActualMaximum(Calendar.DATE));

		return calendar.getTime();
	}

	public static String formatDate8(String date) {
		if (date.length() == 8) {
			return date;
		}
		String year = date.substring(0, 4);
		String month = date.substring(5, 7);
		String day = date.substring(8);

		StringBuffer rtnDate = new StringBuffer(year).append(month).append(day);
		return rtnDate.toString().trim();
	}

	public static String formatDate6(String date) {
		if (date.length() == 8) {
			return date;
		}
		String year = date.substring(0, 4);
		String month = date.substring(5, 7);
		StringBuffer rtnDate = new StringBuffer(year).append(month);
		return rtnDate.toString().trim();
	}

	/**
	 * 
	 * @return
	 */
	public static Date getDefaultDate() {
		return defaultDate;
	}
}
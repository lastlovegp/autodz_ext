/**
 *
 */
package com.erp.framework.util;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang.StringUtils;

public class DataObjectUtils {
	private static final String DATE_NUMBER_PATTERN = "yyyy-MM-dd";
	public static Date defaultDate = null;
	public static Date date19700101 = null;
	/* synthetic */static Class class$0;
	/* synthetic */static Class class$1;
	/* synthetic */static Class class$2;

	static {
		try {
			defaultDate = numberToDate("1900-01-01");
			date19700101 = numberToDate("1970-01-01");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static Date numberToDate(String string) throws Exception {
		if (string == null)
			return null;
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date;
		try {
			date = simpleDateFormat.parse(string);
		} catch (ParseException e) {
			throw new Exception(e.getMessage());
		}
		return date;
	}

	public static void mapToObject(Object object, Map map) throws Exception {
		Iterator iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
			String fieldName = (String) iterator.next();
			String beanFieldName = fieldName.replaceAll("-inputEl", "")
					.replaceAll("CmbTree", "");
			Object o = getNestedProperty(object, fieldName);
			PropertyDescriptor desc = PropertyUtils.getPropertyDescriptor(o,
					beanFieldName);
			if (desc != null) {
				Class cl = desc.getPropertyType();
				Class var_class = class$0;
				if (var_class == null) {
					Class var_class_0_;
					var_class_0_ = Class.forName("java.util.Date");
					var_class = class$0 = var_class_0_;
				}
				if (var_class.isAssignableFrom(cl)) {
					Long time = convert(map.get(fieldName));
					if (time != null)
						BeanUtils.setProperty(o, beanFieldName,
								new Date(time.longValue()));
				} else {
					Class var_class_1_ = class$1;
					if (var_class_1_ == null) {
						Class var_class_2_;

						var_class_2_ = Class.forName("java.util.Calendar");

						var_class_1_ = class$1 = var_class_2_;
					}
					if (var_class_1_.isAssignableFrom(cl)) {
						Long time = convert(map.get(fieldName));
						Calendar calendar = Calendar.getInstance();
						if (time != null) {
							calendar.setTimeInMillis(time.longValue());
							BeanUtils.setProperty(o, beanFieldName, calendar);
						}
					} else {
						Class var_class_3_ = class$2;
						if (var_class_3_ == null) {
							Class var_class_4_;

							var_class_4_ = Class
									.forName("java.math.BigDecimal");

							var_class_3_ = class$2 = var_class_4_;
						}
						if (var_class_3_.isAssignableFrom(cl)) {
							String v = (String) map.get(fieldName);
							if (!StringUtils.isEmpty(v))
								BeanUtils.setProperty(o, beanFieldName, v);
						} else {
							String v = String.valueOf(map.get(fieldName));
							if (v != null) {
//								v = v.replace('|', ' ');
//								v = v.replaceAll("\\^", "\r\n");
//								v = (v.replaceAll(
//										"\n|\r\n|\r|\u0085|\u2028|\u2029", "^p"));
							}
							BeanUtils.setProperty(o, beanFieldName, v);
						}
					}
				}
			}
		}
	}

	private static String descToDateStr(String dateDesc) {
		return dateDesc.replaceAll("年", "-").replaceAll("月", "-")
				.replaceAll("日", "");
	}

	public static void mapToObject2(Object object, Map map) throws Exception {
		Iterator iterator = map.keySet().iterator();
		while (iterator.hasNext()) {
			String fieldName = (String) iterator.next();
			String beanFieldName = fieldName.replaceAll("-inputEl", "")
					.replaceAll("CmbTree", "");
			Object o = getNestedProperty(object, fieldName);
			PropertyDescriptor desc = PropertyUtils.getPropertyDescriptor(o,
					beanFieldName);
			if (desc != null) {
				Class cl = desc.getPropertyType();
				Class var_class = class$0;
				if (var_class == null) {
					Class var_class_5_;

					var_class_5_ = Class.forName("java.util.Date");

					var_class = class$0 = var_class_5_;
				}
				if (var_class.isAssignableFrom(cl)) {
					Long time = convert(map.get(fieldName));
					if (time != null)
						BeanUtils.setProperty(o, beanFieldName,
								new Date(time.longValue()));
					else
						BeanUtils.setProperty(o, beanFieldName, null);
				} else {
					Class var_class_6_ = class$1;
					if (var_class_6_ == null) {
						Class var_class_7_;

						var_class_7_ = Class.forName("java.util.Calendar");

						var_class_6_ = class$1 = var_class_7_;
					}
					if (var_class_6_.isAssignableFrom(cl)) {
						Long time = convert(map.get(fieldName));
						Calendar calendar = Calendar.getInstance();
						if (time != null) {
							calendar.setTimeInMillis(time.longValue());
							BeanUtils.setProperty(o, beanFieldName, calendar);
						} else
							BeanUtils.setProperty(o, beanFieldName, null);
					} else {
						Class var_class_8_ = class$2;
						if (var_class_8_ == null) {
							Class var_class_9_;

							var_class_9_ = Class
									.forName("java.math.BigDecimal");

							var_class_8_ = class$2 = var_class_9_;
						}
						if (var_class_8_.isAssignableFrom(cl)) {
							String v = (String) map.get(fieldName);
							if (!StringUtils.isEmpty(v))
								BeanUtils.setProperty(o, beanFieldName, v);
						} else {
							String v = (String) map.get(fieldName);
							if (v != null) {
								v = v.replace('|', ' ');
								v = (v.replaceAll(
										"\n|\r\n|\r|\u0085|\u2028|\u2029", "^p"));
							}
							BeanUtils.setProperty(o, beanFieldName, v);
						}
					}
				}
			}
		}
	}

	private static Object getNestedProperty(Object o, String propertyDesc)
			throws NoSuchMethodException, InvocationTargetException,
			IllegalAccessException {
		Object value = o;
		String[] properties = StringUtils.split(propertyDesc, ".");
		for (int i = 0; i < properties.length; i++) {
			if (properties.length == 1)
				break;
			String property = properties[i];
			value = PropertyUtils.getProperty(value, property);
			if (i + 2 == properties.length)
				break;
		}
		return value;
	}

	public static Long convert(Object arg1) {
		String p = "0";
		try {
			p = (String) arg1;
		} catch (Exception e) {
			p = "0";
		}

		if (p == null || p.trim().length() == 0)
			return null;

		p = descToDateStr(p);
		Long var_long;
		try {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			var_long = new Long(df.parse(p.trim()).getTime());
		} catch (Exception e) {
			return null;
		}
		return var_long;
	}
}

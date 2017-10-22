package com.base.common.id.prefix;

import com.base.common.id.CreatePrefixException;
import com.base.common.id.PrefixGenerator;
import com.erp.framework.util.DataFormat;

/**
 * DefaultPrefixGenerator 此代码源于开源项目E3,原作者：黄云辉
 * 
 * @author XiongChun
 * @since 2010-03-17
 * @see PrefixGenerator
 */
public class DefaultPrefixGenerator implements PrefixGenerator {

	/**
	 * 前缀值
	 */
	private String prefix = "";
	private String aftfix = "";

	/**
	 * 是否附带日期
	 */
	private boolean withDate = false;
	/**
	 * 日期格式
	 */
	private String pattern = "yyMMdd";

	public String create() throws CreatePrefixException {
		StringBuffer sb = new StringBuffer();

		if (!DataFormat.isEmpty(prefix)) {
			sb.append(prefix);
		}
		if (this.withDate) {
			sb.append(getFormatedDate());
		}

		if (!DataFormat.isEmpty(aftfix)) {
			sb.append(aftfix);
		}
		return sb.toString();
	}

	private String getFormatedDate() {
		java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat(
				this.pattern);
		java.util.Date now = new java.util.Date();
		return sdf.format(now);
	}

	public String getPrefix() {
		return prefix;
	}

	public void setPrefix(String prefix) {
		this.prefix = prefix;
	}

	public boolean isWithDate() {
		return withDate;
	}

	public void setWithDate(boolean withDate) {
		this.withDate = withDate;
	}

	public String getPattern() {
		return pattern;
	}

	public void setPattern(String pattern) {
		this.pattern = pattern;
	}

	public String getAftfix() {
		return aftfix;
	}

	public void setAftfix(String aftfix) {
		this.aftfix = aftfix;
	}

}

/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */
package com.base.common;

import java.util.List;

/**
 * @author <a href="mailto:liu_wen@huateng.com">Liu Wen</a>
 * @version $Revision: 1.1 $
 * @date 2005-7-14
 *  
 * ��Χ��ѯ���.
 */
public class RangeQueryResult {
	private int totalCount; /*�ܼ�¼��*/
	private List queryResult; /*��ѯ���*/
	/**
	 * @return Returns the queryResult.
	 */
	public List getQueryResult() {
		return queryResult;
	}
	/**
	 * @param queryResult The queryResult to set.
	 */
	public void setQueryResult(List queryResult) {
		this.queryResult = queryResult;
	}
	/**
	 * @return Returns the totalCount.
	 */
	public int getTotalCount() {
		return totalCount;
	}
	/**
	 * @param totalCount The totalCount to set.
	 */
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	
	
}

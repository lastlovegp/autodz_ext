/*
 * ==================================================================
 * The Huateng Software License
 *
 * Copyright (c) 2004-2005 Huateng Software System.  All rights
 * reserved.
 * ==================================================================
 */
package com.base.common;

import com.base.common.bean.Dto;

public class PageQueryCondition {
	private int pageSize;
	private int pageIndex;
	private int startResult;
	private int totalResult;

	public String getCountDef() {
		return countDef;
	}

	public void setCountDef(String countDef) {
		this.countDef = countDef;
	}

	private int totalPageNum;

	private String countDef = "po";

	private String queryString;

	public int getTotalResult() {
		return totalResult;
	}

	public void setTotalResult(int totalResult) {
		this.totalResult = totalResult;
	}

	public int getTotalPageNum() {
		return totalPageNum;
	}

	public void setTotalPageNum(int totalPageNum) {
		this.totalPageNum = totalPageNum;
	}

	/**
	 * @return Returns the pageIndex.
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * @param pageIndex
	 *            The pageIndex to set.
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * @return Returns the pageSize.
	 */
	public int getPageSize() {
		return pageSize == 0 ? 100 : this.pageSize;
	}

	/**
	 * @param pageSize
	 *            The pageSize to set.
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * @return Returns the queryString.
	 */
	public String getQueryString() {
		return queryString;
	}

	/**
	 * @param queryString
	 *            The queryString to set.
	 */
	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}

	public PageQueryCondition() {
		super();
	}

	public int getStartResult() {
		return startResult;
	}

	public void setStartResult(int startResult) {
		this.startResult = startResult;
	}

	public PageQueryCondition(Dto inDto) {
		super();
		if (inDto.containsKey("limit")) {
			this.pageSize = inDto.getAsInteger("limit");
			this.pageIndex = inDto.getAsInteger("page");
			this.startResult = inDto.getAsInteger("start");

		}

	}
}

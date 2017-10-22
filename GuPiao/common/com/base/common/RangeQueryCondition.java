package com.base.common;

import java.io.Serializable;

import javax.persistence.metamodel.Type;

public class RangeQueryCondition implements Serializable{
	private static final long serialVersionUID = 1L;
	private int start;    
	private int count;     
	
	private String queryString;
	private Object[] objArray;   
	private Type[] typeArray;    
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Object[] getObjArray() {
		return objArray;
	}
	public void setObjArray(Object[] objArray) {
		this.objArray = objArray;
	}
	public String getQueryString() {
		return queryString;
	}
	public void setQueryString(String queryString) {
		this.queryString = queryString;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public Type[] getTypeArray() {
		return typeArray;
	}
	public void setTypeArray(Type[] typeArray) {
		this.typeArray = typeArray;
	}
}

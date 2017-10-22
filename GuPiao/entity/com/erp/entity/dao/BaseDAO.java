package com.erp.entity.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import com.base.common.PageQueryCondition;
import com.base.common.PageQueryResult;

public interface BaseDAO {
	public void save(Object entity);

	public <T> T getById(Class<T> clazz, Object id);

	void merge(Object entity);

	void delete(Object entity);

	public List queryByCondition(String whereString);

	public PageQueryResult pageQueryByQLExt(PageQueryCondition queryCondition);

	public Query createNativeUseQuery(String sql);

	public Query createUseQuery(String hql);

	public void flush();

	public EntityManager getEm();

	public void localSave(Object entity);

}

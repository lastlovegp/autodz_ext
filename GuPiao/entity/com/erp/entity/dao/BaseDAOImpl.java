package com.erp.entity.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import com.base.common.PageQueryCondition;
import com.base.common.PageQueryResult;

/**
 * 　@Repository用于将数据访问层 (DAO 层 ) 的类标识为 Spring Bean。
 * 
 * @author Administrator
 * 
 */
@Repository(value = "baseDao")
public class BaseDAOImpl implements BaseDAO {

	@PersistenceContext
	private EntityManager em = null;

	public BaseDAOImpl(EntityManager em) {
		if (em == null) {
			this.em = Persistence.createEntityManagerFactory("SoftCall")
					.createEntityManager();
		} else {
			this.em = em;
		}
	}

	public BaseDAOImpl() {
		super();
		if (em == null) {
			this.em = Persistence.createEntityManagerFactory("SoftCall")
					.createEntityManager();
		}
	}

	public Query createNativeUseQuery(String sql) {
		return em.createNativeQuery(sql);
	}

	@Override
	public EntityManager getEm() {
		return em;
	}

	public void setEm(EntityManager em) {
		this.em = em;
	}

	public Query createUseQuery(String hql) {
		return em.createQuery(hql);
	}

	public void save(Object entity) {
		em.persist(entity);
	}

	@Override
	public void localSave(Object entity) {
		if (this.em == null)
			return;
		EntityTransaction ctx = this.em.getTransaction();
		ctx.begin();
		this.em.persist(entity);
		ctx.commit();
	}

	public <T> T getById(Class<T> clazz, Object id) {
		return em.find(clazz, id);
	}

	public void merge(Object entity) {
		em.merge(entity);

	}

	@Override
	public void flush() {
		em.flush();
	}

	public void delete(Object entity) {
		em.remove(entity);
	}

	public List queryByCondition(String whereString) {
		Query query = em.createQuery(whereString);
		query.setFirstResult(0);
		query.setMaxResults(5000);
		return query.getResultList();
	}

	public PageQueryResult pageQueryByQLExt(PageQueryCondition queryCondition) {
		PageQueryResult result = new PageQueryResult();
		Query query = em.createQuery(queryCondition.getQueryString());

		query.setFirstResult(queryCondition.getStartResult());
		query.setMaxResults(queryCondition.getPageSize() > 5000 ? 5000
				: queryCondition.getPageSize());

		result.setQueryResult(query.getResultList());
		Long cnt = new Long(0);
		if (queryCondition.getPageSize() > 0) {
			StringBuffer countHql = new StringBuffer();

			String hql = queryCondition.getQueryString();

			countHql.append("select count(")
					.append(queryCondition.getCountDef()).append(") ")
					.append(hql.substring(hql.toLowerCase().indexOf("from")));
			// hql = countHql.toString().replaceAll("fetch", "");
			Query queryCount = em.createQuery(countHql.toString());
			List<Long> dataList = queryCount.getResultList();
			if (countHql.indexOf("group") != -1) {
				result.setTotalCount(dataList.size());
			} else {
				for (int i = 0; i < dataList.size(); i++) {
					cnt += dataList.get(i);
				}

				result.setTotalCount(cnt.intValue());
			}

		}

		return result;

	}

}

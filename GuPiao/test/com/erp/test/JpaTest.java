package com.erp.test;

import org.junit.Test;

import com.erp.entity.dao.BaseDAOImpl;
import com.erp.service.impl.GetGPDataFromSinaImpl;
import com.erp.service.impl.GpServiceImpl;

public class JpaTest {

	@Test
	public void testrun() {
		
		GetGPDataFromSinaImpl sina = new GetGPDataFromSinaImpl();
		
		
		GpServiceImpl service = new GpServiceImpl();
		service.setJdbcBaseDao(new BaseDAOImpl());
		service.getJdbcBaseDao().getEm().getTransaction().begin();
		
		try {
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		service.getJdbcBaseDao().getEm().getTransaction().commit();

	}
}

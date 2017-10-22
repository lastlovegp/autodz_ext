package com.erp.dataimport;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;

import org.apache.commons.beanutils.BeanUtils;

import com.erp.bean.GpExport;
import com.erp.framework.poi.excel.ExcelImportUtil;
import com.erp.framework.poi.excel.entity.ImportParams;
import com.erp.framework.util.DateUtil;

public class Custimport {

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		EntityManager em = Persistence.createEntityManagerFactory("SoftCall")
				.createEntityManager();
		EntityTransaction ctx = em.getTransaction();
		ctx.begin();
		File file = new File("d:/custdata.xls");
		// 将传入的File构造为FileInputStream;
		FileInputStream in = new FileInputStream(file);
		ImportParams params = new ImportParams();
		//params.setTitleRows(1);
		//params.setSecondTitleRows(2);
		//params.setNeedSave(true);
//		try {
//			List<CustExport> listCustExport = (List<CustExport>) ExcelImportUtil
//					.importExcelByIs(in, CustExport.class, params);
//			
//			Importbatch batch = new Importbatch();
//			batch.setBatchid(UUID.randomUUID().toString());
//			batch.setBatchdesc("企业客户导入");
//			batch.setUploaddate(DateUtil.getCurrentDate());
//			batch.setStatus("N");
//			em.persist(batch);
//			
//			Company cmp = null;
//			for (CustExport c : listCustExport) {
//				cmp = new Company();
//				cmp.setBatchid(batch.getBatchid());
//				BeanUtils.copyProperties(cmp, c);
//				cmp.setCmpid(UUID.randomUUID().toString());
//				cmp.setCustid(UUID.randomUUID().toString());
//				em.persist(cmp);
//			}
//			ctx.commit();
//		} catch (Exception e) {
//			ctx.rollback();
//			e.printStackTrace();
//		} finally {
//			try {
//				in.close();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
	}

}

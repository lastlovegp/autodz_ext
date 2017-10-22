package com.erp.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.base.common.PageQueryCondition;
import com.base.common.PageQueryResult;
import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.base.common.service.impl.BaseManagerImpl;
import com.base.common.util.ProcessExcel;
import com.erp.bean.GpExport;
import com.erp.entity.dao.BaseDAO;
import com.erp.framework.poi.excel.ExcelImportUtil;
import com.erp.framework.poi.excel.entity.ImportParams;
import com.erp.framework.util.DataFormat;
import com.erp.service.GetGpDataFromSina;
import com.erp.service.GpService;
import com.erp.util.GPUtil;

/**
 * 股票处理类
 * 
 */
@Service(value = "gpService")
public class GpServiceImpl extends BaseManagerImpl implements GpService {

	@Resource(name = "baseDao")
	private BaseDAO baseDao;

	@Override
	public BaseDAO getJdbcBaseDao() {
		return baseDao;
	}

	@Override
	public void setJdbcBaseDao(BaseDAO baseDao) {
		this.baseDao = baseDao;
	}

	@Resource(name = "getGpDataFromSina")
	private GetGpDataFromSina getGpDataFromSina;

	@Override
	public PageQueryResult getGpBaseList(Dto inDto) throws Exception {

		String gn = inDto.getAsString("gn");
		String code = inDto.getAsString("code");
		String name = inDto.getAsString("name");
		String sta = inDto.getAsString("sta");
		String hy = inDto.getAsString("hy");
		
		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuffer hql = new StringBuffer();
		hql.append("select DISTINCT po from Gp po left join fetch po.gns where 2=2 ");

		if (!DataFormat.isEmpty(gn)) {
			hql.append(" and po.gn like '%").append(gn).append("%'");
		}

		if (!DataFormat.isEmpty(code)) {
			hql.append(" and po.gpcode='").append(code).append("'");
		}

		if (!DataFormat.isEmpty(name)) {
			hql.append(" and po.name like '%").append(name).append("%'");
		}

		if (!DataFormat.isEmpty(hy)) {
			hql.append(" and po.hy like '%").append(hy).append("%'");
		}

		if (!DataFormat.isEmpty(sta)) {
			hql.append(" and po.sta='").append(sta).append("'");
		}

		qc.setQueryString(hql.toString());
		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;

	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveGpBase(Dto inDto) throws Exception {
//		List modiryList = inDto.getAsList(SysConstants.GRID_MODIFYED_REC);
//		Dto mDto;
//		Gp tmp = null;
//		for (int i = 0; i < modiryList.size(); i++) {
//			mDto = (BaseDto) modiryList.get(i);
//			if (mDto.isEmpty())
//				continue;
//			tmp = new Gp();
//			mapToObject(tmp, mDto);
//			baseDao.merge(tmp);
//		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public Dto importGpData(Dto inDto) throws Exception {
//		Dto rtnDto = new BaseDto();
//
//		String gnDesc = inDto.getAsString("gnDesc");
//
//		File file = new File(inDto.getAsString("filePath"));
//		if (file == null) {
//			throw new Exception("上传文件不能为空");
//		}
//		ProcessExcel ex = new ProcessExcel(file);
//		Workbook wb = ex.getWb();
//		Sheet s = null;
//		Row row = null;
//
//		Gp gp = null;
//		s = wb.getSheetAt(0);
//
//		// 将传入的File构造为FileInputStream;
//		FileInputStream in = new FileInputStream(file);
//		ImportParams params = new ImportParams();
//		try {
//			List<GpExport> listCustExport = (List<GpExport>) ExcelImportUtil
//					.importExcelByIs(in, GpExport.class, params);
//
//			// 记录数限制
//			if (listCustExport.size() > 1000) {
//				throw new Exception("导入超过1000条，每次最多导入1000条");
//			}
//
//			int i = 0;
//			for (GpExport c : listCustExport) {
//				gp = this.baseDao.getById(Gp.class,
//						GPUtil.getGpCode(c.getCode()));
//				if (gp != null) {
//					this.baseDao.merge(gp);
//				}
//				i++;
//				if (i % 300 == 0) {
//					this.baseDao.getEm().flush();
//				}
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				in.close();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
//
//		return rtnDto;
		return null;
	}

	/**
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception {
		File file = new File(
				"D:\\worksplace\\GuPiao\\WebContent\\upload\\gp.xls");
		// 将传入的File构造为FileInputStream;
		FileInputStream in = new FileInputStream(file);
		ImportParams params = new ImportParams();
		// params.setTitleRows(1);
		// params.setSecondTitleRows(2);
		// params.setNeedSave(true);
		try {
			List<GpExport> listCustExport = (List<GpExport>) ExcelImportUtil
					.importExcelByIs(in, GpExport.class, params);

			for (GpExport c : listCustExport) {
				System.out.println(c.toString());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}

package com.erp.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.base.common.PageQueryCondition;
import com.base.common.PageQueryResult;
import com.base.common.bean.Dto;
import com.base.common.service.impl.BaseManagerImpl;
import com.erp.entity.dao.BaseDAO;
import com.erp.entity.data.mng.Eacode;
import com.erp.entity.data.mng.Gpdtl;
import com.erp.framework.extuihelper.ExtUiHelper;
import com.erp.framework.util.DataFormat;
import com.erp.service.ResourceService;

/**
 * 资源模型业务实现类
 * 
 */
@Service(value = "resourceService")
public class ResourceServiceImpl extends BaseManagerImpl implements
		ResourceService {

	@Resource(name = "baseDao")
	private BaseDAO baseDao;

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.erp.service.impl.ResourceService#getDicList(com.base.common.bean.Dto)
	 */
	@Override
	public List<Eacode> getDicList(Dto inDto) throws Exception {
		List<Eacode> list = new ArrayList<Eacode>();
		String field = inDto != null ? inDto.getAsString("field") : "";
		StringBuffer hql = new StringBuffer();
		hql.append("select po from Eacode po where po.enabled='1'");

		if (!DataFormat.isEmpty(field)) {
			hql.append(" and po.field='").append(field).append("'");
		}

		hql.append(" order by po.codeid");
		list = this.baseDao.queryByCondition(hql.toString());
		return list;
	}

	@Override
	public String codeConvert(String codes, String field) {
		String filters = "";
		String rtnString = "";
		if (!StringUtils.isBlank(codes)) {
			String[] cs = codes.split(",");
			for (int i = 0; i < cs.length; i++) {
				filters += "'" + cs[i] + "',";
			}

			if (!"".equals(filters)) {
				filters = filters.substring(0, filters.lastIndexOf(","));
			}
		}

		if (!"".equals(filters)) {
			StringBuffer hql = new StringBuffer();
			hql.append("select po from Eacode po where po.field='")
					.append(field).append("' and po.code in (").append(filters)
					.append(") order by po.codeid");
			List<Eacode> list = this.baseDao.queryByCondition(hql.toString());
			for (Eacode c : list) {
				rtnString += c.getCodedesc() + ",";
			}

			if (!"".equals(rtnString)) {
				rtnString = rtnString.substring(0, rtnString.lastIndexOf(","));
			}
		}

		return rtnString;

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.erp.service.impl.ResourceService#queryDicList(com.base.common.bean
	 * .Dto)
	 */
	@Override
	public PageQueryResult queryDicList(Dto inDto) throws Exception {
		String field = inDto.getAsString("field");

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select po from Eacode po where 2=2 ");

		if (!DataFormat.isEmpty(field)) {
			hql.append(" and po.field like '%").append(field).append("%'");
		}

		// 自动查询生成器
		ExtUiHelper.getQryResultStr(new Eacode(), "", hql, inDto, null);

		hql.append(" order by po.field,po.code asc");
		qc.setQueryString(hql.toString());
		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.erp.service.impl.ResourceService#saveCode(com.base.common.bean.Dto)
	 */
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class, readOnly = false)
	public void saveCode(Dto inDto) throws Exception {
		Gpdtl dtl = new Gpdtl();
		dtl.setName("dssdf");
		this.baseDao.merge(dtl);

	}

}

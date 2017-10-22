package com.erp.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.Query;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.base.common.PageQueryCondition;
import com.base.common.PageQueryResult;
import com.base.common.SysConstants;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.base.common.service.impl.BaseManagerImpl;
import com.erp.bean.GpChartData;
import com.erp.bean.GpTranChartData;
import com.erp.entity.dao.BaseDAO;
import com.erp.entity.data.mng.Bar;
import com.erp.entity.data.mng.Event;
import com.erp.entity.data.mng.Gn1;
import com.erp.entity.data.mng.Gpparam;
import com.erp.entity.data.mng.Gpsel;
import com.erp.entity.data.mng.Gpyaohhis;
import com.erp.entity.data.mng.Gpzhibiao;
import com.erp.entity.data.mng.Hy;
import com.erp.entity.data.mng.Position;
import com.erp.entity.data.mng.Tranhis;
import com.erp.framework.util.DataFormat;
import com.erp.framework.util.DateUtil;
import com.erp.framework.util.StringUtil;
import com.erp.service.GpMonitoService;

/**
 * 股票处理类
 * 
 */
@Service(value = "gpMonitoService")
public class GpMonitorServiceImpl extends BaseManagerImpl implements
		GpMonitoService {

	private Log log = LogFactory.getLog(GpMonitorServiceImpl.class);

	private static SimpleDateFormat sdf_hour_format = new SimpleDateFormat(
			"HH:mm:ss");

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

	@Override
	public PageQueryResult getJjlogList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Jjlog po order by po.logtime DESC");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);				

		return result;
	}
	
	@Override
	public PageQueryResult getHyList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Hy po order by po.sel desc,po.qz desc");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}
	
	
	@Override
	public PageQueryResult getGnList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Gn1 po order by po.sel desc");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}
	

	@Override
	public Gpparam getGpparams(Dto inDto) throws Exception {
		Gpparam param = this.baseDao.getById(Gpparam.class, "001");
		return param;
	}
	
	@Override
	public Gpzhibiao getZhibiao(Dto inDto) throws Exception {
		String code = inDto.getAsString("code");
		String date = inDto.getAsString("date");
		String type = inDto.getAsString("type");
		Query q =  this.baseDao.
				createUseQuery("select po from Gpzhibiao po where po.code='"
						+code+"' and po.date='"+date+"' and po.type="+type);
		Gpzhibiao zb = null;
		List<Gpzhibiao> zblist = q.getResultList();
		if (!zblist.isEmpty()) {
			zb = (Gpzhibiao)zblist.get(0);
		}
		return zb;
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveGpParam(Dto inDto) throws Exception {
		String opType = inDto.getAsString("opType");
		Gpparam param = new Gpparam();
		if ("save".equals(opType)) {
			param = baseDao.getById(Gpparam.class, "001");
			mapToObject(param, inDto);
			this.baseDao.merge(param);
		}
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void reTestCode(Dto inDto) throws Exception {
		String code = inDto.getAsString("code");
		String bdate = inDto.getAsString("bdate");
		this.baseDao.createNativeUseQuery("UPDATE gpparam  SET testbdate = '"+bdate+"'").executeUpdate();
		this.baseDao.createNativeUseQuery("UPDATE stratey  SET gpcodes = '"+code+"'").executeUpdate();
		
	}


	@Override
	public PageQueryResult getPositionList(Dto inDto) throws Exception {
		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from BuyList po ");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}
	
	
	@Override
	public PageQueryResult getGPStoreList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select po from Gpstore po ");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}
	

	
	@Override
	public PageQueryResult getJumprecList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
	    String qrycon = inDto.getAsString("qrycon");
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Jumprec po where 2=2");
		
		if ("dbxt".equals(qrycon)) {
			hql.append(" and po.rsi6 < 50 and po.rsi12 < 50 ");
		} else if ("zpyx".equals(qrycon)) {
			hql.append(" and po.syl < 50 and po.ltzb < 10 and po.rsi6 < 80 and po.rsi6 > po.rsi12");
		} else if ("pzyx".equals(qrycon)) {
			hql.append(" and po.zf >= 5");
		}
		
		qc.setQueryString(hql.toString());
		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}

	@Override
	public PageQueryResult getTranhisList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Tranhis po order by po.code,po.tran_date");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}


	@Override
	public PageQueryResult getStoreList(Dto inDto) throws Exception {

		PageQueryCondition qc = new PageQueryCondition(inDto);
		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Store po");

		qc.setQueryString(hql.toString());

		PageQueryResult result = this.baseDao.pageQueryByQLExt(qc);

		return result;
	}


	@Override
	public GpChartData getMinuteBarData(Dto inDto) throws Exception {

		String code = inDto.getAsString("code");
		String tdate = inDto.getAsString("tdate");

		StringBuilder hql = new StringBuilder();
		hql.append("select po from Bar po where po.sec_id='").append(code)
				.append("'").append(" and po.tdate='").append(tdate)
				.append("'").append(" order by po.ttime asc");

		List<Bar> hisList = this.baseDao.queryByCondition(hql.toString());
		List<String> times = new ArrayList<String>();
		List<double[]> minvalues = new ArrayList<double[]>();
		double[] value = null;
		for (Bar b : hisList) {
			times.add(b.getTtime());
			value = new double[4];
			value[0] = b.getOpen();
			value[1] = b.getClose();
			value[2] = b.getLow();
			value[3] = b.getHigh();
			minvalues.add(value);
		}

		GpChartData data = new GpChartData();
		data.setMinValues(minvalues);
		data.setMinutes(times);

		// hql.delete(0, hql.length());
		// hql.append("select po from Gptoday po where po.code='")
		// .append(code).append("'");
		// List<Gptoday> gtList = this.baseDao.queryByCondition(hql.toString());
		// Gptoday gt = null;
		// if (gtList.size() > 0) {
		// gt = gtList.get(0);
		// }
		// data.setPre_close(gt.getZrspj());

		String tranCode = code.replaceAll("sz", "").replaceAll("sh", "");
		hql.delete(0, hql.length());
		hql.append("select po from Tranhis po where po.code='")
				.append(tranCode).append("'").append(" and po.tran_date>='")
				.append(tdate).append("' and po.tran_date<='").append(tdate)
				.append(" 16:00:00").append("'");

		List<Tranhis> tranhisList = this.baseDao.queryByCondition(hql
				.toString());

		List<GpTranChartData> tranDataList = new ArrayList<GpTranChartData>();
		GpTranChartData tranChart = null;
		String timesString = "";
		for (Tranhis th : tranhisList) {
			tranChart = new GpTranChartData();

			timesString = sdf_hour_format.format(DateUtil.stringToDate(th
					.getTran_date()));

			tranChart.setName(th.getSide() == 1 ? "买入" : "卖出");
			tranChart.setName(tranChart.getName() + "[" + timesString + "],信号["
					+ th.getInxh() + "]");
			tranChart.setValue(th.getPrice());
			tranChart.setxAxis(timesString.substring(0, 5) + ":00");
			tranChart.setyAxis(th.getPrice());
			tranDataList.add(tranChart);
		}

		data.setTranValues(tranDataList);

		return data;
	}

	@Override
	public GpChartData getDailyBarData(Dto inDto) throws Exception {

		String code = inDto.getAsString("code");
		String bDate = inDto.getAsString("bDate");
		String eDate = inDto.getAsString("eDate");

		StringBuilder hql = new StringBuilder();
		hql.append("select DISTINCT po from Gpyaohhis po where po.code='")
				.append(code).append("'");

		if (!DataFormat.isEmpty(bDate)) {
			hql.append(" and po.date>='").append(bDate).append("'");
		}

		if (!DataFormat.isEmpty(eDate)) {
			hql.append(" and po.date>='").append(eDate).append("'");
		}

		hql.append(" order by po.date asc");

		List<Gpyaohhis> hisList = this.baseDao.queryByCondition(hql.toString());
		List<String> dates = new ArrayList<String>();
		List<double[]> values = new ArrayList<double[]>();
		List<Double> zf = new ArrayList<Double>();
		double[] value = null;
		for (Gpyaohhis h : hisList) {
			if (dates.contains(h.getDate())) {
				continue;
			}
			dates.add(h.getDate());
			zf.add(h.getZf());
			value = new double[4];
			value[0] = h.getOpen();
			value[1] = h.getClose();
			value[2] = h.getLow();
			value[3] = h.getHigh();
			values.add(value);
		}

		GpChartData data = new GpChartData();

		data.setDates(dates);
		data.setValues(values);
		data.setZf(zf);

		String tranCode = code.replaceAll("sz", "").replaceAll("sh", "");
		hql.delete(0, hql.length());
		hql.append("select DISTINCT po from Tranhis po where po.code='")
				.append(tranCode).append("'");

		if (!DataFormat.isEmpty(bDate)) {
			hql.append(" and po.tran_date>='").append(bDate).append("'");
		}

		if (!DataFormat.isEmpty(eDate)) {
			hql.append(" and po.tran_date>='").append(eDate).append("'");
		}

		hql.append(" order by po.tran_date desc");

		List<Tranhis> tranhisList = this.baseDao.queryByCondition(hql
				.toString());

		List<GpTranChartData> tranDataList = new ArrayList<GpTranChartData>();
		GpTranChartData tranChart = null;
		String timesString = "";
		for (Tranhis th : tranhisList) {
			tranChart = new GpTranChartData();
			timesString = sdf_hour_format.format(DateUtil.stringToDate(th
					.getTran_date()));
			tranChart.setName(th.getSide() == 1 ? "买入" : "卖出");
			tranChart.setName(tranChart.getName() + "[" + timesString + "],信号["
					+ th.getInxh() + "]");
			tranChart.setValue(th.getPrice());
			tranChart.setxAxis(th.getTran_date().substring(0, 10));
			tranChart.setyAxis(th.getPrice());
			tranDataList.add(tranChart);
		}

		data.setTranValues(tranDataList);

		// 均线
		// hql.delete(0, hql.length());
		// hql.append(
		// "select DISTINCT po.gpjxhis from Gpyaohhis po "
		// + "inner join fetch po.gpjxhis where po.code='")
		// .append(code).append("' and po.date=po.gpjxhis.upddate ");
		//
		// if (!DataFormat.isEmpty(bDate)) {
		// hql.append(" and po.gpjxhis.upddate>='").append(bDate).append("'");
		// }
		//
		// if (!DataFormat.isEmpty(eDate)) {
		// hql.append(" and po.gpjxhis.upddate>='").append(eDate).append("'");
		// }
		//
		// hql.append(" order by po.gpjxhis.upddate asc");
		//
		// List<Gpjxhis> gpjxhisList = this.baseDao.queryByCondition(hql
		// .toString());
		// List<Double> jx5 = new ArrayList<Double>();
		// List<Double> jx10 = new ArrayList<Double>();
		// List<Double> ddd = new ArrayList<Double>();
		// List<Double> ema10 = new ArrayList<Double>();
		//
		// for (Gpjxhis jx : gpjxhisList) {
		// jx5.add(jx.getJj5());
		// jx10.add(jx.getJj10());
		// ddd.add(jx.getDdd());
		// ema10.add(jx.getEma10());
		// }
		//
		// data.setDdd(ddd);
		// data.setJj5(jx5);
		// data.setJj10(jx10);
		// data.setEma10(ema10);

		return data;
	}

	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveEvent(Dto inDto) throws Exception {
		String opType = inDto.getAsString("opType");
		String id = inDto.getAsString("id");
		Event param = new Event();	
		mapToObject(param, inDto);
		if ("save".equals(opType)) {
			param.setUptime(DateUtil.getCurrentTime().toString());
			this.baseDao.merge(param);
		} else if ("del".equals(opType)) {
			String delSpl = "update Event po set po.statue='1' where po.id="+id;
			this.baseDao.createUseQuery(delSpl).executeUpdate();
		}

	}
	
	@Override
	public List<Event> queryEventList(Dto inDto) throws Exception {
		StringBuilder hql = new StringBuilder();
		hql.append("select po from Event po where po.statue='0' order by po.uptime desc");

		return baseDao.createUseQuery(hql.toString()).getResultList();
	}
		
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveCostData(Dto inDto) throws Exception {
		List modiryList = inDto.getAsList(SysConstants.GRID_MODIFYED_REC);
		List delList = inDto.getAsList(SysConstants.GRID_DELED_REC);
		Dto mDto;
		Position btn = null;
		for (int i = 0; i < modiryList.size(); i++) {
			mDto = (BaseDto) modiryList.get(i);
			if (mDto.isEmpty())
				continue;
			btn = baseDao.getById(Position.class, mDto.get("code"));
			
			boolean isNew = false;
			if (btn == null) {
				btn = new Position();
				isNew = true;
			}			
			mapToObject(btn, mDto);				
			if (StringUtil.isEmpty(btn.getIndate()) || StringUtil.isEmpty(btn.getOutdate())) {
				btn.setIndate(DateUtil.dateToString(DateUtil.getCurrentDate()));
				btn.setOutdate(DateUtil.dateToString(DateUtil.getCurrentDate()));
			}
			
			if (!isNew) {
				baseDao.merge(btn);
			} else {
				baseDao.save(btn);
			}
			
		}

		for (int i = 0; i < delList.size(); i++) {
			mDto = (BaseDto) delList.get(i);

			if (mDto.isEmpty())
				continue;
			btn = new Position();
			mapToObject(btn, mDto);
			baseDao.createUseQuery(
					"delete from Position po where po.code='" + btn.getCode()
							+ "'").executeUpdate();
		}

	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveHyData(Dto inDto) throws Exception {
		List modiryList = inDto.getAsList(SysConstants.GRID_MODIFYED_REC);
		Dto mDto;
		Hy hy = null;
		for (int i = 0; i < modiryList.size(); i++) {
			mDto = (BaseDto) modiryList.get(i);
			if (mDto.isEmpty())
				continue;
			hy = baseDao.getById(Hy.class, mDto.get("hy"));
			
			boolean isNew = false;
			if (hy == null) {
				hy = new Hy();
				isNew = true;
			}			
			mapToObject(hy, mDto);							
			
			if (!isNew) {
				baseDao.merge(hy);
			} else {
				baseDao.save(hy);
			}
			
		}

	}
	
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void updateGPCost(Dto inDto) throws Exception {
		String code = inDto.getAsString("code");
		double price = 0;
		int number = 0;		
		if (!StringUtil.isEmpty(inDto.getAsString("buyprice"))) {
			 price = Double.valueOf(inDto.getAsString("buyprice"));
		};		
		if (!StringUtil.isEmpty(inDto.getAsString("num"))) {
			number =inDto.getAsInteger("num");
		};		
		if (price*number > 0) {
			Position position = this.baseDao.getById(Position.class, code);		
			position.setVwap((position.getVwap()*position.getAvailable() + (price*number))/(position.getAvailable() + number));
			position.setPrice(position.getVwap());
			position.setAvailable(position.getAvailable() + number);
			baseDao.merge(position);
		}		
	}	
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveGnData(Dto inDto) throws Exception {
		List modiryList = inDto.getAsList(SysConstants.GRID_MODIFYED_REC);
		Dto mDto;
		Gn1 hy = null;
		for (int i = 0; i < modiryList.size(); i++) {
			mDto = (BaseDto) modiryList.get(i);
			if (mDto.isEmpty())
				continue;
			hy = baseDao.getById(Gn1.class, mDto.get("code"));
			
			boolean isNew = false;
			if (hy == null) {
				hy = new Gn1();
				isNew = true;
			}			
			mapToObject(hy, mDto);							
			
			if (!isNew) {
				baseDao.merge(hy);
			} else {
				baseDao.save(hy);
			}
			
		}

	}
	
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = Exception.class)
	public void saveGpStore(Dto inDto) throws Exception {
		List modiryList = inDto.getAsList(SysConstants.GRID_MODIFYED_REC);
		List delList = inDto.getAsList(SysConstants.GRID_DELED_REC);
		Dto mDto;
		Gpsel sel = null;
		for (int i = 0; i < modiryList.size(); i++) {
			mDto = (BaseDto) modiryList.get(i);
			if (mDto.isEmpty())
				continue;
			sel = baseDao.getById(Gpsel.class, mDto.get("code"));
			
			boolean isNew = false;
			if (sel == null) {
				sel = new Gpsel();
				isNew = true;
			}			
			mapToObject(sel, mDto);				
			
			if (!isNew) {
				baseDao.merge(sel);
			} else {
				baseDao.save(sel);
			}
			
		}

		for (int i = 0; i < delList.size(); i++) {
			mDto = (BaseDto) delList.get(i);

			if (mDto.isEmpty())
				continue;
			sel = new Gpsel();
			mapToObject(sel, mDto);
			baseDao.createUseQuery(
					"delete from Gpsel po where po.code='" + sel.getCode()
							+ "'").executeUpdate();
		}

	}
	
}

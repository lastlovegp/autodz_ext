package com.erp.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.base.common.PageQueryResult;
import com.base.common.action.BaseAction;
import com.base.common.bean.Dto;
import com.base.common.bean.impl.BaseDto;
import com.erp.bean.GpChartData;
import com.erp.entity.data.mng.Gn1;
import com.erp.entity.data.mng.Gpparam;
import com.erp.entity.data.mng.Gpstore;
import com.erp.entity.data.mng.Gpzhibiao;
import com.erp.entity.data.mng.Hy;
import com.erp.entity.data.mng.Jjlog;
import com.erp.entity.data.mng.Jumpqry;
import com.erp.entity.data.mng.Jumprec;
import com.erp.entity.data.mng.Position;
import com.erp.entity.data.mng.Postqry;
import com.erp.entity.data.mng.Store;
import com.erp.entity.data.mng.Tranhis;
import com.erp.framework.util.JsonHelper;
import com.erp.service.GpMonitoService;
import com.erp.test.GpApi;
import com.erp.util.GPUtil;

@Controller
@Scope("prototype")
public class GpMonitorAction extends BaseAction {

	private static final long serialVersionUID = 1L;
	
	protected Log log = LogFactory.getLog(GpMonitorAction.class);
	
	@Resource
	protected GpMonitoService gpMonitoService;
			
	public String costMng() throws Exception {
		Position btn = new Position();
		cfg.setPackageName("base");
		cfg.setActionName("gpMonitor");
		cfg.setGridBar("delRow,addRow,save,refresh");
		cfg.setCellCanEdit(true);
		cfg.setHiddenItems("scope");

		setGridUi(btn);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String hyMng() throws Exception {
		Hy hy = new Hy();
		cfg.setPackageName("base");
		cfg.setActionName("gpMonitor");
		cfg.setGridBar("save,refresh");
		cfg.setCellCanEdit(true);

		setGridUi(hy);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String gnMng() throws Exception {
		Gn1 gn = new Gn1();
		cfg.setPackageName("base");
		cfg.setActionName("gpMonitor");
		cfg.setGridBar("save,refresh");
		cfg.setCellCanEdit(true);

		setGridUi(gn);

		this.tranCode2Desc();

		return SUCCESS;
	}
		
	public String paramMng() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Gpparam param = new Gpparam();

		// from 定义		
		this.cfg.setFormBar("save,refresh");
		this.setFormUi(param);
		
		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String zhibiao() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");
		
		Dto dto = getRequestDto();
		String code = dto.getAsString("code");	
		String date = dto.getAsString("date");	
		String type = dto.getAsString("type");	
		getUiDto().put("code", code);	
		getUiDto().put("date", date);
		getUiDto().put("type", type);	
		
		Gpzhibiao param = new Gpzhibiao();
		// from 定义		
		this.cfg.setFormBar("save,refresh");	
		cfg.uiType = "si";
		this.setFormUi(param);
		this.tranCode2Desc();

		return SUCCESS;
	}
		
	public String getParam() throws Exception {
		Dto reqDto = getRequestDto();

		Gpparam param = this.gpMonitoService.getGpparams(reqDto);
	
		if (param == null) {
			setErrTipMsg("没有找到记录", getResponse());
		} else {
			String rtnString = JsonHelper.encodeList2FormJson(param, null);
			write(rtnString, this.getResponse());
		}

		return null;
	}
	
	public String getZhibiao() throws Exception {
		Dto reqDto = getRequestDto();

		Gpzhibiao zb = this.gpMonitoService.getZhibiao(reqDto);
	
		if (zb == null) {
			setErrTipMsg("没有找到记录", getResponse());
		} else {
			String rtnString = JsonHelper.encodeList2FormJson(zb, null);
			write(rtnString, this.getResponse());
		}

		return null;
	}
	
	public void saveParamData() throws Exception {
		Dto dto = this.getRequestDto();
		Dto jsonDto = new BaseDto();
		try {
			this.gpMonitoService.saveGpParam(dto);
			setOkTipMsg("操作成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setOkTipMsg("操作失败", getResponse());
		}
		write(jsonDto.toJson(), getResponse());
	}
	
	public String transLogQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Jjlog log = new Jjlog();
		
		cfg.setGridBar("refresh");		
		this.setGridUi(log);

		this.tranCode2Desc();

		return SUCCESS;
	}	
	
	public String dailyBarFx() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");
		
		Dto dto = getRequestDto();
		String code = dto.getAsString("code");	
		String name = dto.getAsString("name");	
		dto.put("code", GPUtil.getGpCode(code));		
		GpChartData chartData = this.gpMonitoService.getDailyBarData(dto);
		List<String> dates =chartData.getDates();
			
		String dateRtnString = JsonHelper.encodeObject2Json(dates);
		
		String rtnTranString = JsonHelper.encodeObject2Json(chartData.getTranValues());
		
		String jj5 = JsonHelper.encodeObject2Json(chartData.getJj5());
		String jj10 = JsonHelper.encodeObject2Json(chartData.getJj10());
		String ddd = JsonHelper.encodeObject2Json(chartData.getDdd());
		String eam10 = JsonHelper.encodeObject2Json(chartData.getEma10());
		String zf = JsonHelper.encodeObject2Json(chartData.getZf());
		
		getUiDto().put("dateStr", dateRtnString);	
		getUiDto().put("code", code);	
		getUiDto().put("name", name);
		getUiDto().put("rtnTranString", rtnTranString);	
//		getUiDto().put("jj5Str", jj5);		
//		getUiDto().put("jj10Str", jj10);	
//		getUiDto().put("dddStr", ddd);	
//		getUiDto().put("emaStr", eam10);	
		
		getUiDto().put("zfStr", zf);			
		getUiDto().put("valuesStr", JsonHelper.encodeObject2Json(chartData.getValues()));	
		this.tranCode2Desc();
				
		return SUCCESS;
	}
		
	public String minBarFx() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");
		
		Dto dto = getRequestDto();
		String code = dto.getAsString("code");		
		dto.put("code", GPUtil.getGpCode(code));		
		GpChartData chartData = this.gpMonitoService.getMinuteBarData(dto);
		List<String> dates =chartData.getMinutes();
			
		String dateRtnString = JsonHelper.encodeObject2Json(dates);		
		String rtnTranString = JsonHelper.encodeObject2Json(chartData.getTranValues());
			
		getUiDto().put("code", code);	
		getUiDto().put("dateStr", dateRtnString);
//		getUiDto().put("zrspj", chartData.getPre_close());
		getUiDto().put("rtnTranString", rtnTranString);					
		getUiDto().put("valuesStr", JsonHelper.encodeObject2Json(chartData.getMinValues()));	
		this.tranCode2Desc();
				
		return SUCCESS;
	}

	public String positionQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Position position = new Position();
		Postqry qry = new Postqry();	
		
		cfg.setGridBar("refresh,fengx,retest,---,buyin,sellout,updcost");		
		cfg.setQryObj(qry);
		this.setGridUi(position);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String tranhisQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Tranhis tranhis = new Tranhis();
		
		cfg.setGridBar("refresh");		
		this.setGridUi(tranhis);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String storeQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Store store = new Store();
		
		cfg.setGridBar("refresh");		
		this.setGridUi(store);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public String jumpQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Jumprec jump = new Jumprec();	
		Jumpqry qry = new Jumpqry();	
	
		cfg.setGridBar("zpyx,pzyx,dbxt,gpbuy");		
					
		this.setGridWithQryUi(jump, qry);

		this.tranCode2Desc();

		return SUCCESS;
	}
	
	public void buyIn() throws Exception {
		Dto dto = this.getRequestDto();
		String code = dto.getAsString("code");
		int num = dto.getAsInteger("num");
		Dto jsonDto = new BaseDto();
		try {							
			GpApi.buyIn(code, 0, num);				
			setOkTipMsg("操作成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setOkTipMsg("操作失败", getResponse());
		}
		write(jsonDto.toJson(), getResponse());
	}
	
	public void updcost() throws Exception {
		Dto dto = this.getRequestDto();
		Dto jsonDto = new BaseDto();
		try {							
			this.gpMonitoService.updateGPCost(dto);				
			setOkTipMsg("操作成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setOkTipMsg("操作失败", getResponse());
		}
		write(jsonDto.toJson(), getResponse());
	}
	
	public void sellOut() throws Exception {
		Dto dto = this.getRequestDto();
		String code = dto.getAsString("code");
		int num = dto.getAsInteger("num");
		
		Dto jsonDto = new BaseDto();
		try {
			//GpApi.sellOut(code, 0, num);
			setOkTipMsg("操作成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setOkTipMsg("操作失败", getResponse());
		}
		write(jsonDto.toJson(), getResponse());
	}
	
	public String gpstoreQry() throws Exception {
		cfg.setActionName("gpMonitor");
		cfg.setPackageName("base");

		Gpstore store = new Gpstore();
		cfg.setGridBar("refresh");	
		cfg.setGridBar("delRow,addRow,save,refresh");
		cfg.setCellCanEdit(true);
					
		this.setGridUi(store);

		this.tranCode2Desc();

		return SUCCESS;
	}

	public String getJjlogData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getJjlogList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
	
	public String getHyData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getHyList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
	
	public String getGnData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getGnList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
	
	public String getPositionData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getPositionList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
	
	public String getJumprecData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getJumprecList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
		
	public String getTranhisData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getTranhisList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
								
	public String getStoreData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getStoreList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
	
	public String getGpstoreData() throws Exception {
		Dto reqDto = getRequestDto();

		PageQueryResult custList = this.gpMonitoService
				.getGPStoreList(reqDto);

		String rtnString = JsonHelper.encodeList2PageJson(
				custList.getQueryResult(), custList.getTotalCount(), null);
		write(rtnString, this.getResponse());

		return null;
	}
			
	public String saveCostData() throws Exception {
		Dto dto = this.getRequestDto();
		try {
			this.gpMonitoService.saveCostData(dto);
			setOkTipMsg("保存成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg("保存失败", getResponse());
		}

		return null;
	}
	
	public String saveHyData() throws Exception {
		Dto dto = this.getRequestDto();
		try {
			this.gpMonitoService.saveHyData(dto);
			setOkTipMsg("保存成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg("保存失败", getResponse());
		}

		return null;
	}
	
	public String saveGnData() throws Exception {
		Dto dto = this.getRequestDto();
		try {
			this.gpMonitoService.saveGnData(dto);
			setOkTipMsg("保存成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg("保存失败", getResponse());
		}

		return null;
	}
	
	public String reTestData() throws Exception {
		Dto dto = this.getRequestDto();
		try {
			this.gpMonitoService.reTestCode(dto);
			setOkTipMsg("保存成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg("保存失败", getResponse());
		}

		return null;
	}
	
	public String saveGpstoreData() throws Exception {
		Dto dto = this.getRequestDto();
		try {
			this.gpMonitoService.saveGpStore(dto);
			setOkTipMsg("保存成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg("保存失败", getResponse());
		}

		return null;
	}

	public Log getLog() {
		return log;
	}

	public void setLog(Log log) {
		this.log = log;
	}

}

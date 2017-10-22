package com.erp.action;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.base.common.action.FileUploadAction;
import com.base.common.bean.Dto;
import com.erp.bean.ItemImport;
import com.erp.service.GpService;

@Controller
@Scope("prototype")
public class ImportAction extends FileUploadAction {

	private static final long serialVersionUID = 1L;

	@Resource
	protected GpService gpService;


	protected Log log = LogFactory.getLog(ImportAction.class);


	public String gpImport() throws Exception {

		cfg.setActionName("import");
		cfg.setPackageName("base");

		// 导入用
		ItemImport itemImport = new ItemImport();
		this.setFormUi(itemImport);

		this.tranCode2Desc();

		return SUCCESS;
	}


	public void importData() throws Exception {
		Dto dto = getUploadDto(this.getRequestDto());
		try {
			String filePath = saveFile();
			dto.put("filePath", filePath);
			this.gpService.importGpData(dto);

			setOkTipMsg("导入成功", getResponse());
		} catch (Exception e) {
			e.printStackTrace();
			setErrTipMsg(e.getMessage(), getResponse());
		}

	}

	public Log getLog() {
		return log;
	}

	public void setLog(Log log) {
		this.log = log;
	}

}

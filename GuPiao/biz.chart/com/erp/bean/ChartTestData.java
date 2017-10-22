package com.erp.bean;

import java.util.List;

import com.erp.framework.extuihelper.Ef;
import com.erp.framework.extuihelper.Et;
@Et(beanName = "chartTestData")
public class ChartTestData {

	@Ef(fseq=1)
	private List<String> dates;
	@Ef(fseq=2)
	private List<double[]> values;

	public List<String> getDates() {
		return dates;
	}

	public void setDates(List<String> dates) {
		this.dates = dates;
	}

	public List<double[]> getValues() {
		return values;
	}

	public void setValues(List<double[]> values) {
		this.values = values;
	}

}

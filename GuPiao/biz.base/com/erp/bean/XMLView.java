package com.erp.bean;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.View;

public class XMLView implements View {
	protected Log log = LogFactory.getLog(XMLView.class);

	public XMLView() {
	}

	public String getContentType() {
		return "text/xml";
	}

	/**
	 * Spring interface to render the XML view
	 * 
	 * @param model
	 *            Map of values with the data to render
	 * @param request
	 *            HTTP request
	 * @param response
	 *            HTTP response
	 * @throws java.lang.Exception
	 */
	public void render(Map model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 从model中取回结果
		Map myModel = (Map) model.get("model");
		String xmlStr = (String) myModel.get("result");
		// 把结果放进response
		response.setContentType("text/xml");
		response.setContentLength(xmlStr.length());
		PrintWriter out = new PrintWriter(response.getOutputStream());
		out.print(xmlStr);
		out.flush();
		out.close();

	}
}

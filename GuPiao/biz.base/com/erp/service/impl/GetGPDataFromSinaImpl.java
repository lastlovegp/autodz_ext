package com.erp.service.impl;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;

import com.erp.entity.data.mng.Store;
import com.erp.entity.data.mng.Gpdtl;
import com.erp.framework.util.DataFormat;
import com.erp.framework.util.DateUtil;
import com.erp.service.GetGpDataFromSina;

@Service(value = "getGpDataFromSina")
public class GetGPDataFromSinaImpl implements GetGpDataFromSina {

	/**
	 * 如果你要同时查询多个股票，那么在URL最后加上一个逗号，再加上股票代码就可以了；比如你要一次查询大秦铁路（601006）和大同煤业（601001）
	 * 的行情， 就这样使用URL：http://hq.sinajs.cn/list=sh601003,sh601001
	 * 查询大盘指数，比如查询上证综合指数（000001）： http://hq.sinajs.cn/list=s_sh000001
	 */
	public static final String SINA_FINANCE_URL = "http://hq.sinajs.cn/list=";

	/**
	 * 个股数据
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Gpdtl> getGGDataFromSina(String code) throws Exception {

		List<String> codeList = Arrays.asList(code.split(","));
		// =======================================
		// 从URL获取数据，并且解析每一行数据
		// =========================================
		URL myURL = null;
		HttpURLConnection con = null;
		InputStreamReader ins = null;
		BufferedReader in = null;
		InputStream is3 = null;
		List<Gpdtl> data = new ArrayList<Gpdtl>();
		StringBuffer subCode = new StringBuffer();

		String[] codes = null;
		String newLine = "";
		int i1 = 0;

		int seq = 0;
		try {
			for (int i = 0; i < codeList.size(); i++) {
				seq++;
				if (seq % 400 == 0) {
					seq = 0;
					myURL = new URL(SINA_FINANCE_URL + subCode.toString());
					con = (HttpURLConnection) myURL.openConnection();
					con.setRequestMethod("GET");
					con.setRequestProperty("Charset", "GBK");
					con.setDoInput(true);
					con.setRequestProperty("Connection", "Keep-Alive");
					con.setConnectTimeout(1000 * 2);
					con.connect();

					is3 = con.getInputStream();
					ins = new InputStreamReader(is3, "GBK");
					in = new BufferedReader(ins);

					codes = subCode.toString().split(",");
					i1 = 0;

					Gpdtl dtl = null;
					while ((newLine = in.readLine()) != null) {
						// System.out.println("getGGDataFromSina:" + newLine);
						dtl = getGgDtl(codes[i1], newLine);
						data.add(dtl);
						i1++;
					}

					subCode.delete(0, subCode.length());
				}

				if (!codeList.get(i).equals(","))
					subCode.append(codeList.get(i)).append(",");
			}

			if (seq % 400 != 0 && subCode.length() > 0 && !subCode.toString().equals(",")) {
				myURL = new URL(SINA_FINANCE_URL + subCode.toString().trim());
				con = (HttpURLConnection) myURL.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("Charset", "GBK");
				con.setDoInput(true);
				con.setRequestProperty("Connection", "Keep-Alive");
				con.setConnectTimeout(1000 * 2);
				con.connect();

				is3 = con.getInputStream();
				ins = new InputStreamReader(is3, "GBK");
				in = new BufferedReader(ins);

				codes = subCode.toString().split(",");
				i1 = 0;

				Gpdtl dtl = null;
				while ((newLine = in.readLine()) != null) {
					// System.out.println("getGGDataFromSina:" + newLine);
					dtl = getGgDtl(codes[i1], newLine);
					data.add(dtl);
					i1++;
				}
			}

			System.out.println("data.size():" + data.size());

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {

			if (in != null)
				in.close();

			if (ins != null)
				ins.close();

			if (is3 != null)
				is3.close();

		}

		return data;
	}

	/**
	 * 大盘数据
	 * 
	 * @param code
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Store> getDpdtlFromSina(String code) throws Exception {

		// =======================================
		// 从URL获取数据，并且解析每一行数据
		// =========================================
		URL MyURL = null;
		HttpURLConnection con = null;
		InputStreamReader ins = null;
		BufferedReader in = null;
		InputStream is3 = null;
		List<Store> data = new ArrayList<Store>();
		try {

			MyURL = new URL(SINA_FINANCE_URL + code);
			con = (HttpURLConnection) MyURL.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("Charset", "GBK");
			con.setDoInput(true);
			con.setDoOutput(true);
			con.setRequestProperty("Connection", "Keep-Alive");
			con.setConnectTimeout(1000 * 2);
			con.connect();

			is3 = con.getInputStream();
			ins = new InputStreamReader(is3, "GBK");
			in = new BufferedReader(ins);

			String newLine = "";
			String[] codes = code.split(",");
			int i = 0;
			

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (in != null)
				in.close();

			if (ins != null)
				ins.close();

			if (is3 != null)
				is3.close();

		}

		return data;
	}

	/**
	 * @param 获取个股数据
	 * @return
	 */
	private Gpdtl getGgDtl(String code, String line) {
		if (DataFormat.isEmpty(line)) {
			return null;
		}
		String dataString = line.substring(line.indexOf("\"") + 1,
				line.lastIndexOf("\""));

		List<String> dataList = Arrays.asList(dataString.split(","));

		if (dataList.size() <= 1)
			return null;

		Gpdtl point = new Gpdtl();
		point.setId(UUID.randomUUID().toString());
		point.setCode(code);
		point.setName(dataList.get(0));
		point.setKpj(Double.parseDouble(dataList.get(1)));
		point.setZrspj(Double.parseDouble(dataList.get(2)));
		point.setDqj(Double.parseDouble(dataList.get(3)));
		point.setJrzgj(Double.parseDouble(dataList.get(4)));
		point.setJrzdj(Double.parseDouble(dataList.get(5)));
		point.setJbj(Double.parseDouble(dataList.get(6)));
		point.setJsj(Double.parseDouble(dataList.get(7)));
		point.setCjgps(Long.parseLong(dataList.get(8)));
		point.setCjje(Double.parseDouble(dataList.get(9)));

		point.setBgps1(Double.parseDouble(dataList.get(10)));
		point.setBgj1(Double.parseDouble(dataList.get(11)));
		point.setBgps2(Double.parseDouble(dataList.get(12)));
		point.setBgj2(Double.parseDouble(dataList.get(13)));
		point.setBgps1(Double.parseDouble(dataList.get(14)));
		point.setBgj3(Double.parseDouble(dataList.get(15)));
		point.setBgps4(Double.parseDouble(dataList.get(16)));
		point.setBgj4(Double.parseDouble(dataList.get(17)));
		point.setBgps5(Double.parseDouble(dataList.get(18)));
		point.setBgj5(Double.parseDouble(dataList.get(19)));

		point.setSgps1(Double.parseDouble(dataList.get(20)));
		point.setSgj1(Double.parseDouble(dataList.get(21)));
		point.setSgps2(Double.parseDouble(dataList.get(22)));
		point.setSgj2(Double.parseDouble(dataList.get(23)));
		point.setSgps1(Double.parseDouble(dataList.get(24)));
		point.setSgj3(Double.parseDouble(dataList.get(25)));
		point.setSgps4(Double.parseDouble(dataList.get(26)));
		point.setSgj4(Double.parseDouble(dataList.get(27)));
		point.setSgps5(Double.parseDouble(dataList.get(28)));
		point.setSgj5(Double.parseDouble(dataList.get(29)));

		point.setDate(dataList.get(30) + " " + dataList.get(31));
		return point;
	}

	

	/**
	 * 如果你要同时查询多个股票，那么在URL最后加上一个逗号，再加上股票代码就可以了；比如你要一次查询大秦铁路（601006）和大同煤业（601001）
	 * 的行情， 就这样使用URL：http://hq.sinajs.cn/list=sh601003,sh601001
	 * 查询大盘指数，比如查询上证综合指数（000001）： http://hq.sinajs.cn/list=s_sh000001
	 */
	public static void main(String args[]) throws Exception {
		
		StringBuffer aBuffer = new StringBuffer();
		aBuffer.append("sdlfjksldf");
		aBuffer.delete(0, aBuffer.length());
		System.out.println("test:" + new BigDecimal(3.2343)
		.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue());
//		GetGPDataFromSinaImpl test = new GetGPDataFromSinaImpl();
//		// 沪市后缀名.ss 例子： 沪深300 000300.ss ,深市后缀名 .sz 例子： 399106.sz
//		List<Dpdtl> sinaData = test.getDpdtlFromSina("s_sh000001");
//		for (Dpdtl data : sinaData) {
//			System.out.println(data.toString());
//		}

		// List<Dpdtl> sinaDpdtl = test.getDpdtlFromSina("s_sh000001");
		// for (Dpdtl data : sinaDpdtl) {
		// System.out.println(data.toString());
		// }

	}
}

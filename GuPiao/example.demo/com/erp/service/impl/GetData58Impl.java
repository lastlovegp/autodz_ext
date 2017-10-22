package com.erp.service.impl;

import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.htmlparser.Node;
import org.htmlparser.NodeFilter;
import org.htmlparser.Parser;
import org.htmlparser.Tag;
import org.htmlparser.filters.AndFilter;
import org.htmlparser.filters.HasAttributeFilter;
import org.htmlparser.filters.TagNameFilter;
import org.htmlparser.util.NodeList;
import org.htmlparser.visitors.NodeVisitor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.erp.bean.CustInfo58;
import com.erp.service.GetHtmlDataService;

@Service(value = "getData58Impl")
@Transactional(readOnly = true)
public class GetData58Impl extends DataTransBaseService implements
		GetHtmlDataService {
	private static String ENCODE = "UTF-8";
	private CustInfo58 item = null;
	protected String telStr = null;

	// 供应商信息
	@Override
	public void clearData() {
		item = null;
	}

	public static void main(String[] args) {
		GetData58Impl impl = new GetData58Impl();
		try {
			impl.getCustData("http://nb.58.com/wangluoyingxiao/19748635645063x.shtml");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	@Override
	public Object getCustData(String url) throws Exception {
		Parser parser = new Parser(
				(HttpURLConnection) (new URL(url)).openConnection());

		Map<String, Node> nodeMap = new HashMap<String, Node>();
		CustInfo58 info = new CustInfo58();
		// 公司详细信息
		NodeFilter filter1 = new TagNameFilter("div");
		NodeFilter filter2 = new HasAttributeFilter("class", "leftbar pad60");
		NodeFilter filter0 = new AndFilter(filter1, filter2);
		NodeList itemList = parser.extractAllNodesThatMatch(filter0);

		info = (CustInfo58) transFromPage(itemList, info);
		// info.setDh(getTelInfo(url, info));
		System.out.println(info);
		parser.reset();

		return info;
	}

	private String getTelInfo(String url, Object obj) throws Exception {

		Parser parser = new Parser(
				(HttpURLConnection) (new URL(url)).openConnection());

		Map<String, Node> nodeMap = new HashMap<String, Node>();
		CustInfo58 info = new CustInfo58();
		// 公司详细信息
		NodeFilter filter1 = new TagNameFilter("span");
		NodeFilter filter2 = new HasAttributeFilter("id", "showphone");
		NodeFilter filter0 = new AndFilter(filter1, filter2);
		NodeList itemList = parser.extractAllNodesThatMatch(filter0);

		Node node = null;
		for (int i = 0; i < itemList.size(); i++) {
			node = itemList.elementAt(i);
			if (node == null)
				continue;
			NodeVisitor visitor = new NodeVisitor(true, true) {
				public void visitTag(Tag tag) {
					if ("IMG".equals(tag.getTagName())) {
						telStr = tag.getAttribute("src").toString();
					}

				}

			};
			node.accept(visitor);
		}

		return telStr;

	}

}

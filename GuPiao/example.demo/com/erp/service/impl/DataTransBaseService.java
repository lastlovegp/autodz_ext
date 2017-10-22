package com.erp.service.impl;

import java.io.IOException;
import java.lang.reflect.Field;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.htmlparser.Node;
import org.htmlparser.Parser;
import org.htmlparser.Tag;
import org.htmlparser.util.NodeList;
import org.htmlparser.util.ParserException;
import org.htmlparser.visitors.NodeVisitor;

import com.erp.bean.trantag.Get;
import com.erp.framework.extuihelper.ReflectionUtils;
import com.erp.framework.util.DataFormat;

public class DataTransBaseService {

	protected List<Field> list = null;
	protected Object input_object = null;
	protected String replaceStr = "\\(,查看地图,地图,\n,\r,：,\t,&nbsp,;,:,>,\"";

	protected String replaceTagValue(String val) {
		String[] rStrs = replaceStr.split(",");
		String rtnStr = val;
		for (String r : rStrs) {
			rtnStr = rtnStr.replaceAll(r, "");
		}

		return rtnStr.replaceAll(" ", "");

	}

	protected Parser getHttpParser(String strUrl) {
		URL url;
		URLConnection conn = null;
		Parser parser = new Parser();
		try {
			// url = new URL(strUrl);
			// conn = url.openConnection();
			// conn.setRequestProperty("Content-Type",
			// "text/plain; charset=ISO-8859-1");
			// conn.setRequestProperty("User-Agent",
			// "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.3 Gecko/20100401");
			url = new URL(strUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			conn.setRequestProperty(
					"User-Agent",
					"Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; Foxy/1; .NET CLR 2.0.50727;MEGAUPLOAD 1.0)");
			parser.setConnection(conn);
		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParserException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return parser;
	}

	protected List<Field> getFieldsByDefine(Object object) {
		List<Field> list = ReflectionUtils.getDeclaredField(object);
		Get al = null;
		List<Field> rtnList = new ArrayList<Field>();
		for (Field f : list) {
			Object a = f.getAnnotations();
			if (f.isAnnotationPresent(Get.class)) {
				rtnList.add(f);
			}
		}
		return rtnList;
	}

	protected Object transFromPage(NodeList itemList, Object object) {
		input_object = object;
		list = getFieldsByDefine(object);
		Node node = null;
		for (int i = 0; i < itemList.size(); i++) {
			node = itemList.elementAt(i);
			if (node == null)
				continue;
			NodeVisitor visitor = new NodeVisitor(true, true) {
				public void visitTag(Tag tag) {
					Get al = null;
					String keyValue = "";
					String key = "";
					String tagType = "";
					boolean hasKey = false;
					String nodeText = "";
					for (Field f : list) {
						keyValue = "";
						hasKey = false;
						al = f.getAnnotation(Get.class);
						key = al.key();
						tagType = al.tagType();
						nodeText = DataFormat.trim(replaceTagValue(tag
								.toPlainTextString()));

						if (key.indexOf("_") != -1) {
							String[] keys = key.split("_");
							for (int i = 0; i < keys.length; i++) {
								if (!DataFormat.isEmpty(keys[i])) {
									if (i == 0) {
										hasKey = nodeText.startsWith(keys[i]);
									} else if (hasKey && i > 0
											&& i < (keys.length - 1)) {
										hasKey = (nodeText.indexOf(keys[i]) != -1);
									} else if (hasKey) {
										hasKey = nodeText.endsWith(keys[i]);
									}
								}
							}
						} else {
							hasKey = key.equals(nodeText);
						}

						if (hasKey) {
							if ("next".equals(al.direct())) {
								keyValue = replaceTagValue(
										getKeyValue(tag, al.key())).trim();
							} else if ("pre".equals(al.direct())) {
								keyValue = replaceTagValue(
										getPreKeyValue(tag, al.key())).trim();
							}

							if (!StringUtils.isBlank(al.end())) {
								keyValue = keyValue.split(al.end().trim())[0];
							}

							// System.out.println(keyValue);
							try {
								ReflectionUtils.setFieldValue(input_object,
										f.getName(), keyValue);
							} catch (Exception e) {
								e.printStackTrace();
							}
						}

					}

				}

			};
			node.accept(visitor);
		}

		list = null;
		return input_object;
	}

	private String getKeyValue(Node iNode, String key) {

		Node node = iNode.getNextSibling();
		String nText = "";
		String rntStr = "";
		for (int i = 0; i < 10; i++) {

			if (node != null) {
				nText = replaceTagValue(node.toPlainTextString().trim());
			}
			if (node != null && !DataFormat.isEmpty(nText)) {
				rntStr = node.toPlainTextString().trim();
			} else if (node != null) {
				node = node.getNextSibling();
			}
		}

		if (DataFormat.isEmpty(rntStr)) {
			NodeList nList = iNode.getChildren();
			Node cnode = null;
			String cNodeTextString = "";
			if (nList != null && nList.size() > 0) {
				for (int i = 0; i < nList.size(); i++) {
					cnode = nList.elementAt(i);
					cNodeTextString = getKeyValue(cnode, key);
					if (!DataFormat.isEmpty(cNodeTextString)) {
						rntStr = cNodeTextString;
						break;
					}
				}
			}
		}

		return rntStr;
	}

	private String getPreKeyValue(Node iNode, String key) {

		Node node = iNode.getPreviousSibling();
		String nText = "";
		String rntStr = "";
		for (int i = 0; i < 10; i++) {
			if (node != null) {
				nText = replaceTagValue(node.toPlainTextString().trim());
			}
			if (node != null && !DataFormat.isEmpty(nText)) {
				rntStr = node.toPlainTextString().trim();
			} else if (node != null) {
				node = node.getPreviousSibling();
			}
		}

		if (DataFormat.isEmpty(rntStr)) {
			NodeList nList = iNode.getChildren();
			Node cnode = null;
			String cNodeTextString = "";
			if (nList != null && nList.size() > 0) {
				for (int i = 0; i < nList.size(); i++) {
					cnode = nList.elementAt(i);
					cNodeTextString = getKeyValue(cnode, key);
					if (!DataFormat.isEmpty(cNodeTextString)) {
						rntStr = cNodeTextString;
						break;
					}
				}
			}
		}

		return rntStr;
	}

}

package com.erp.framework.extuihelper;

import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.beanutils.ConvertUtils;

/**
 * @author mojp
 *
 */
public class RequestDataBinder {
	/**
	 *
	 * 使用方法
	 *
	 * InfoBean bean = RequestDataBinder.bind(request,InfoBean.class);
	 *
	 * @param request HttpServletRequest
	 * @param clazz 需要的javabean的class
	 * @return
	 */
	public static <B> B bind(HttpServletRequest request,Class<B> clazz){
		RequestWrapper requestWrapper =  new RequestWrapper(request);
		Object res = null;
		try {
			res = clazz.newInstance();
			//取得所有field
			Field[] fields = clazz.getDeclaredFields();
			for(int i=0;fields!=null && i<fields.length;i++){
				Field aField = fields[i];
				//如果是staitc或者final类型的变量，不设值
				if(Modifier.isStatic(aField.getModifiers())||Modifier.isFinal(aField.getModifiers())){
					continue;
				}
				//设置字段可访问为true
				aField.setAccessible(true);
				//取得字段类型
				Class fieldType = aField.getType();
				boolean isArrayField = fieldType.isArray();
				//设置值
				if(isArrayField){
					Class comType = fieldType.getComponentType();
					String[] values = requestWrapper.getParameterValues(aField.getName());
					Object objs = Array.newInstance(comType, values.length);
					for(int k=0,count=values.length;k<count;k++){
						Array.set(objs, k,convert(values[k],comType));
					}
					aField.set(res,objs);
				} else {
					aField.set(res,convert(requestWrapper.getParameter(aField.getName()),fieldType));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return clazz.cast(res);
	}

	/**数据类型格式化
	 * @param value
	 * @param type
	 * @return
	 */
	private static Object  convert(String value,Class type){
		try{
		if( type.equals(Date.class)){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				return format.parse(value);
		}else{
			return ConvertUtils.convert(value,type);
		}
		}catch(Exception ex){
			ex.printStackTrace();
			return ex;
		}

	}


	 /**HttpServletRequest 代理类
	 * @author Administrator
	 *
	 */
	private static class RequestWrapper{
		private HttpServletRequest request;
		private RequestWrapper(HttpServletRequest request){
			this.request = request;
		}

		public String getParameter(String para){
			return nvl(request.getParameter(para));
		}
		public String[] getParameterValues(String arg0) {
			String[] tmp = request.getParameterValues(arg0);
			if(tmp == null){
				return new String[0];
			}else{
				for(int i=0,count=tmp.length;i<count;i++){
					tmp[i] = nvl(tmp[i]);
				}
				return tmp;
			}
		}


		/**HttpServletRequest 代理 去null 做trim 操作
		 * @param request
		 * @return
		 */
		public static RequestWrapper proxyHttpServletRequest(HttpServletRequest request){
			return new RequestWrapper(request);
		}
		/**去除null trim
		 * @param obj
		 * @return
		 */
		private String nvl(Object obj){

			if(null == obj){
				return "";
			}else{
				return obj.toString().trim();
			}
		}
	}
}

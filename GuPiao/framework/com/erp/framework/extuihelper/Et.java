package com.erp.framework.extuihelper;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 类声明用
 * 
 * @author Administrator
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface Et {
	String beanName() default ""; // BEAN名称

	String beanId() default ""; //

	boolean isCache() default false; // 是否缓存,提高性能用
	
	boolean transMsg() default true; //字典转化用
}

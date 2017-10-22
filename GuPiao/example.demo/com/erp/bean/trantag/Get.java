package com.erp.bean.trantag;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 字段声明类
 * 
 * @author Administrator
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Get {

	String tagType() default "";
	String key() default ""; // 关键字
	String end() default ""; //最后阶段
	String direct() default "next"; // 关键字
}
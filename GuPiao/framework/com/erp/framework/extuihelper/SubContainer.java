package com.erp.framework.extuihelper;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 容器注解
 * 
 * @author Administrator
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface SubContainer {

	String xtype() default "'container'";

	String layout() default "'anchor'";

	int flex() default 1;

	String title() default "'title'";

	boolean collapsible() default false;

	String defaultType() default "'textfield'";
	

}
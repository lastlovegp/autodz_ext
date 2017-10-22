package com.erp.framework.extuihelper;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 工作流审批用
 * 
 * @author Administrator
 * 
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface Msg {

	boolean isCondition() default false; // 是否条件字段

}
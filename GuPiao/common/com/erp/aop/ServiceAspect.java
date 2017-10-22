package com.erp.aop;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

import com.erp.entity.dao.BaseDAO;
import com.erp.framework.properties.PropertiesFactory;
import com.erp.framework.properties.PropertiesFile;
import com.erp.framework.properties.PropertiesHelper;

@Component
@Aspect
// 指定一个切面
public class ServiceAspect {

	private static Log log = LogFactory.getLog(ServiceAspect.class);

	private static PropertiesHelper pHelper = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.CFG);

	@Resource(name = "baseDao")
	private BaseDAO baseDao;

	// execution最常用,可以通过 & || !进行切入点表达式的连接
	// 可是是表达式，可以通过切入点标识重用表达式
	// 声明一个切入点第一个*号返回类型,test后面..代表包及下面子包【不写就只代表当前包】,*所有方法,(..)方法的参数
	// @Pointcut("execution(public void com.erp.service..*(..))")
	// public void serviceAop() throws Throwable {
	// System.out.println("execution DoService");
	// }

	// @Before("execution(public void com.erp.service.impl.RecordServiceImpl.*(..))")
	// public void beforeDoRecService(JoinPoint jp) throws Throwable {
	//
	//
	// }

	// 前置通知
	// 表示只拦截到满足上面切入点的以及带有一个参数的方法 args里面的参数跟方法带的参数名称一致
	// @Before("serviceAop()&&args(name)")
	// public void beforeSayHello(String name) {
	// System.out.println("before sayHello:::::::" + name);
	// }

	// 拦截到所有方法
	// @Before("helloworld()")
	// public void beforeSayHello() {
	// System.out.println("before sayHello:::::::");
	// }

	// 最终通知
	// @After("execution(public void com.erp.service..*(..))")
	// public void afterDoService() {
	// System.out.println("after DoService");
	// }

	// 例外通知
	// @AfterThrowing("test.AspectS.helloworld()")
	// public void exceptionSayHello() {
	// System.out.println("throw runtime exception");
	// }

	// 获取方法抛出的异常
	// 例外通知
	// @AfterThrowing(pointcut = "serviceAop()", throwing = "ex")
	// public void exceptionDoService(JoinPoint jp, Throwable ex) throws
	// Throwable {
	// String activeTime = SysUtils.getCurrentTime();
	// String clazzString = jp.getTarget().getClass().getName();
	// String methodName = jp.getSignature().getName();
	// String fullPath = clazzString + "." + methodName;
	// System.out
	// .println("开始业务处理[" + methodName + "出错];全路径[" + fullPath + "]");
	// throw ex;
	// }

	// 后置通知
	// @AfterReturning("test.AspectS.helloworld()")
	// public void returnSayHello() {
	// System.out.println("method has returned");
	// }

	// 得到方法的返回结果
	// @AfterReturning(pointcut="helloworld()",returning="result")
	// public void returnSayHello(String result) {
	// System.out.println("method has returned"+result);
	// }

	// 环绕通知
	// @Around("execution(public void com.erp.service..*(..))")
	// public Object aroundDoService(ProceedingJoinPoint jp) throws Throwable {
	// Object obj = null;
	// try {
	// String activeTime = SysUtils.getCurrentTime();
	// String clazzString = jp.getTarget().getClass().getName();
	// String methodName = jp.getSignature().getName();
	// String fullPath = clazzString + "." + methodName;
	// log.info("开始业务处理[" + methodName + "];全路径[" + fullPath + "]");
	// long time = System.currentTimeMillis();
	//
	// obj = jp.proceed();
	//
	// if (pHelper.getValue("beanMonitor", "0").equals("0")) {
	// return obj;
	// }
	//
	// time = System.currentTimeMillis() - time;
	// log.info("结束业务处理[" + methodName + "];耗时:" + time + "毫秒;全路径["
	// + fullPath + "]");
	//
	// Eabeanmonitor moni = new Eabeanmonitor();
	// moni.setActivetime(activeTime);
	// moni.setAdvisetype(SysConstants.ADVISETYPE_CALL);
	// moni.setClazz(clazzString);
	// moni.setCosttime(time);
	// moni.setException(null);
	// moni.setMethodname(methodName);
	// moni.setPointcuttype(SysConstants.POINTCUTTYPE_BPO);
	// moni.setMonitorid(IDHelper.getMonitorID());
	// this.baseDao.save(moni);
	// } catch (Throwable e) {
	// e.printStackTrace();
	// throw e;
	// }
	// return obj;
	// }
}

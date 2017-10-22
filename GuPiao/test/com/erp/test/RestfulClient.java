package com.erp.test;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.client.RestTemplate;


public class RestfulClient {
	private final static String BASE_PATH = "http://localhost:8080/CallSell/rest";
	private RestTemplate restTemplate;
	
	public RestfulClient(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("com/erp/test/act.xml");
		restTemplate = (RestTemplate)ac.getBean("restTemplate");
	}
	
}

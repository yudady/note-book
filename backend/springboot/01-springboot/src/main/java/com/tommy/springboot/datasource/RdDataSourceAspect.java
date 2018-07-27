package com.tommy.springboot.datasource;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Aspect
@Component
//@Order(Ordered.LOWEST_PRECEDENCE - 10) // ★★★ 優先順を指定 ★★★
public class RdDataSourceAspect {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Before("execution(* com.tommy.springboot.service.rd.*.*(..))")
	public void rd(JoinPoint point) {
		logger.info("operatorRdDataSource ");

		DataSourceContextHolder.operatorRdDataSource();

	}

	@After("execution(* com.tommy.springboot.service.rd.*.*(..))")
	public void after(JoinPoint joinPoint) {
		logger.info("rd clean ");
		DataSourceContextHolder.clearDynamicDataSourceType();
	}

}
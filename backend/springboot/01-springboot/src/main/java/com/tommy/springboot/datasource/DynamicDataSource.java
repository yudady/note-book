package com.tommy.springboot.datasource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;

public class DynamicDataSource extends AbstractRoutingDataSource {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	protected Object determineCurrentLookupKey() {
		logger.info("*********DynamicDataSource***************");

		return DataSourceContextHolder.getDynamicDataSourceType();
	}

}
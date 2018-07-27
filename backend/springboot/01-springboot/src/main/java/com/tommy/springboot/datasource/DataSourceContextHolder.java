package com.tommy.springboot.datasource;

public class DataSourceContextHolder {

	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();

	public static final String mypaycenterDataSource = "mypaycenterDataSource";
	public static final String rdDataSource = "rdDataSource";

	public static void operatorRdDataSource() {
		contextHolder.set(rdDataSource);
	}

	public static void operatorMypaycenterDataSource() {
		contextHolder.set(mypaycenterDataSource);
	}

	public static String getDynamicDataSourceType() {
		return contextHolder.get();
	}

	public static void clearDynamicDataSourceType() {
		contextHolder.remove();
	}
}
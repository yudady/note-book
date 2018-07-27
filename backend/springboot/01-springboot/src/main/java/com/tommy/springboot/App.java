package com.tommy.springboot;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;

import com.tommy.springboot.datasource.DataSourceContextHolder;
import com.tommy.springboot.datasource.DynamicDataSource;

@SpringBootApplication
@MapperScan(basePackages = {"com.tommy.mybatis.dao"})
public class App extends SpringBootServletInitializer {

	private static ConfigurableApplicationContext context;

	public static ConfigurableApplicationContext getContext() {
		return context;
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(App.class);
	}

	public static void main(String[] args) {
		context = SpringApplication.run(App.class, args);

	}

	/**
	 * @Primary 该注解表示在同一个接口有多个实现类可以注入的时候，默认选择哪一个，而不是让@autowire注解报错
	 */
	@Primary
	@Bean
	@ConfigurationProperties(prefix = "datasource.mypaycenter")
	public DataSource mypaycenterDataSource() {
		return DataSourceBuilder.create().build();
	}

	@Bean
	@ConfigurationProperties(prefix = "datasource.rd")
	public DataSource rdDataSource() {
		return DataSourceBuilder.create().build();
	}

	/**
	 * @Qualifier 根据名称进行注入，通常是在具有相同的多个类型的实例的一个注入（例如有多个DataSource类型的实例）
	 */
	@Bean
	public DataSource dataSource(
		@Qualifier(DataSourceContextHolder.mypaycenterDataSource) DataSource mypaycenterDataSource,
		@Qualifier(DataSourceContextHolder.rdDataSource) DataSource rdDataSource

	) {
		Map<Object, Object> targetDataSources = new HashMap<Object, Object>();
		targetDataSources.put(DataSourceContextHolder.mypaycenterDataSource, mypaycenterDataSource);
		targetDataSources.put(DataSourceContextHolder.rdDataSource, rdDataSource);

		DynamicDataSource dataSource = new DynamicDataSource();
		dataSource.setTargetDataSources(targetDataSources);// 该方法是AbstractRoutingDataSource的方法
		dataSource.setDefaultTargetDataSource(mypaycenterDataSource);// 默认的datasource设置为myTestDbDataSource

		return dataSource;
	}

	@Bean
	public SqlSessionFactoryBean sqlSessionFactory(@Qualifier("dataSource") DataSource dataSource)
		throws IOException {
		SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();

		// mybatis配置
		Properties prop = new Properties();
		prop.setProperty("mapUnderscoreToCamelCase", "true");

		sqlSessionFactoryBean.setConfigurationProperties(prop);
		sqlSessionFactoryBean.setTypeAliasesPackage("com.tommy.mybatis.model");

		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		Resource[] resources = resolver.getResources("classpath*:com/tommy/**/*.xml");

		sqlSessionFactoryBean.setMapperLocations(resources);
		sqlSessionFactoryBean.setDataSource(dataSource);

		return sqlSessionFactoryBean;
	}

}

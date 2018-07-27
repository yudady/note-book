package com.tommy.springboot.datasource;

import java.util.Objects;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.tommy.mybatis.dao.PyCustMapper;
import com.tommy.mybatis.model.PyCust;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Component
public class CustomerDBNode {

	private ConcurrentHashMap<String, HikariDataSource> nodeMap = new ConcurrentHashMap();

	@Autowired
	private PyCustMapper PyCustMapper;

	public HikariDataSource getHikariDataSource(String customerId) {

		HikariDataSource hikariDataSource = nodeMap.get(customerId);
		if (Objects.isNull(hikariDataSource)) {
			synchronized (this) {
				hikariDataSource = nodeMap.get(customerId);
				if (Objects.isNull(hikariDataSource)) {
					PyCust pyCust = PyCustMapper.selectByPrimaryKey(customerId);
					HikariDataSource hikariDataSource1 = createHikariDataSource(pyCust);
					nodeMap.put(customerId, hikariDataSource1);
					return hikariDataSource1;
				} else {
					return hikariDataSource;
				}
			}
		}
		return hikariDataSource;

	}

	private HikariDataSource createHikariDataSource(PyCust pyCust) {
		HikariConfig config = new HikariConfig();
		config.setDriverClassName("oracle.jdbc.OracleDriver");
		config.setJdbcUrl("jdbc:oracle:thin:@" + pyCust.getDbHost() + ":1521:myPay");
		config.setUsername(pyCust.getDbName());
		config.setPassword(pyCust.getDbPwd());
		config.setMaximumPoolSize(10);
		config.setMinimumIdle(1);
		// 一个连接的生命时长（毫秒），超时而且没被使用则被释放（retired），缺省:30分钟，建议设置比数据库超时时长少30秒，参考MySQL
		config.setMaxLifetime(120_000);
		config.setConnectionTimeout(30_000);
		config.setIdleTimeout(60_000);
		config.addDataSourceProperty("poolName", "mypay" + pyCust.getId());
		config.addDataSourceProperty("cachePrepStmts", "true");
		config.addDataSourceProperty("prepStmtCacheSize", "250");
		config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
		return new HikariDataSource(config);
	}
}

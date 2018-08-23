# oracle rac

[spring rac database setting](https://docs.spring.io/spring-data/jdbc/old-docs/2.0.0.BUILD-SNAPSHOT/reference/html/orcl.failover.html)


```

jdbc.default.driverClassName=oracle.jdbc.driver.OracleDriver
jdbc.default.url=jdbc:oracle:thin:uid/pswd@(DESCRIPTION=(ADDRESS_LIST=(ADDRESS = (PROTOCOL = TCP)(HOST = your.hostname.com)(PORT = 1521))(ADDRESS = (PROTOCOL = TCP)(HOST = your.hostname.com)(PORT = 1521))(LOAD_BALANCE = yes))(CONNECT_DATA = (SERVER = DEDICATED) (SERVICE_NAME = SID)(FAILOVER_MODE = (TYPE = SELECT)(METHOD = BASIC)(RETRIES = 180)(DELAY = 5))))
jdbc.default.username=uid
jdbc.default.password=pswd
hibernate.dialect=org.hibernate.dialect.Oracle10gDialect








<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:orcl="http://www.springframework.org/schema/data/orcl"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.springframework.org/schema/context
       http://www.springframework.org/schema/context/spring-context-3.0.xsd
       http://www.springframework.org/schema/data/orcl
       http://www.springframework.org/schema/data/orcl/spring-data-orcl-1.0.xsd">

    <orcl:pooling-datasource id="racDataSource"
        url="jdbc:oracle:thin:@(description=(address_list=
            (address=(host=rac1)(protocol=tcp)(port=1521))
            (address=(host=rac2)(protocol=tcp)(port=1521)))
            (connect_data=(service_name=racdb1)))"
        properties-location="classpath:orcl.properties"
        fast-connection-failover-enabled="true"
        ONS-configuration="rac1:6200,rac2:6200"/>

    <bean id="transactionManager" 
          class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
        <property name="dataSource" ref="racDataSource"/>
    </bean>

</beans>



<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:orcl="http://www.springframework.org/schema/data/orcl"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop-3.0.xsd
       http://www.springframework.org/schema/tx
       http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
       http://www.springframework.org/schema/data/orcl
       http://www.springframework.org/schema/data/orcl/spring-data-orcl-1.0.xsd">

    <aop:config>
        <aop:advisor pointcut="execution(* *..PetStoreFacade.insertOrder(..))" 
            advice-ref="racFailoverInterceptor" order="1"/>
        <aop:advisor pointcut="execution(* *..PetStoreFacade.*(..))" 2
            advice-ref="txAdvice"/>
    </aop:config>

    <orcl:rac-failover-interceptor id="racFailoverInterceptor"/> 3

    <tx:advice id="txAdvice">
        <tx:attributes>
            <tx:method name="insert*"/>
            <tx:method name="update*"/>
            <tx:method name="*" read-only="true"/>
        </tx:attributes>
    </tx:advice>

</beans>


<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:orcl="http://www.springframework.org/schema/data/orcl"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop-3.0.xsd
       http://www.springframework.org/schema/tx
       http://www.springframework.org/schema/tx/spring-tx-3.0.xsd
       http://www.springframework.org/schema/data/orcl
       http://www.springframework.org/schema/data/orcl/spring-data-orcl-1.0.xsd">

    <aop:config>
        <aop:advisor 
            pointcut="@annotation(org.springframework.transaction.annotation.Transactional)" 
            advice-ref="racFailoverInterceptor" order="1"/>
    </aop:config>

    <orcl:rac-failover-interceptor id="racFailoverInterceptor"/>

    <tx:annotation-driven/> 3

</beans>
```
# zabbix-java-gateway

> 默认情况下，Java gateway监听10052端口。



## 配置Sever使用Java gateway
现在Java gateway已在运行，接下来您要告诉Zabbix server在哪里找到Zabbix Java gateway. 因此你需要在server配置文件中指定JavaGateway及JavaGateway端口（JavaGatewayPort）.如果JMX应用采用Zabbix agent进行监控的话，您需要在proxy 配置文件 中配置对应的连接参数.

JavaGateway=192.168.3.14
JavaGatewayPort=10052
默认情况下，server并不会产生任何与JMX监控进程。但如果您想使用完成JMX监控，您需要指定Java轮询器的预分支实例数（pre-forked instances），您也可过同类的方式指定常见的轮询器和捕获器。

StartJavaPollers=5
一旦您完成了相关配置，不要忘记重启Sever或Proxy

4.5 Debugging Java gateway
当Java gateway出现问题，或者在前端看到的监控项报错信息不充分时，您也可以通过查看Java gateway日志文件获得更多信息

默认情况下，Java gateway将记录日志到/tmp/zabbix_java.log文件中，日志级别为”info”。 若您觉得”info”级别得到的信息并不充分，则需要修改级别为”debug”。你可以通过修改lib/logback.xml将<root>标签更改为”debug”以让日志级别的增加。

<root level="debug">
  <appender-ref ref="FILE" />
</root>
需要注意的是，与Zabbix server或proxy不同，修改完logback.xml并不需要重启Zabbix Java gateway。 修改后的配置将会自动被加载.。当您完成了debug,您可以将日志级别改为”info”.




# filebeat


[Filebeat的架构分析、配置解释与示例](https://blog.csdn.net/Gamer_gyt/article/details/52688636)


[Filebeat安装部署及配置详解](https://cloud.tencent.com/developer/article/1006051)


[使用 Filebeat 收集日志](https://blog.csdn.net/github_39939645/article/details/78896737)

[ELK + Kafka + Filebeat学习](https://blog.csdn.net/Remoa_Dengqinyi/article/details/77902391)

[ELK+Filebeat+Kafka+ZooKeeper 构建海量日志分析平台](http://blog.51cto.com/tchuairen/1861167)


## windows系统安装运行filebeat

下载安装包 下载地址：https://www.elastic.co/downloads/beats/filebeat
解压到指定目录
打开解压后的目录，打开filebeat.yml进行配置。

①：配置 Filebeat prospectors->path 这里的路径是所要收集日志的路径 
②：配置 enabled: true 这个配置很重要，只有配置为true之后配置才可生效，否则不起作用。 
③：配置Outputs ，这里的Outputs有elasticsearch，logstash。按照配置文件下面的示例配置即可。

打开刚才解压目录 按住ctrl+shift 并同时鼠标右键打开cmd窗口执行命令 
.\filebeat -e -c filebeat.yml 就可以启动filebeat






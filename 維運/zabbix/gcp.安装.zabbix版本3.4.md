# GCP 安装 zabbix v3.4

[zabbix](https://www.zabbix.com/manuals)

## GCP创建server

![从快照创建主机](./images/20180706114045.png)
![从快照创建主机](./images/20180706114431.png)


## 检查java版本
![检查java版本](./images/20180706114543.png)

## 检查SELinux
![检查SELinux](./images/20180706152600.png)

## 检查firewalld
![检查firewalld](./images/20180706152915.png)

## 安裝 MySQL Repository
```
rpm -Uvh http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
```
![](./images/20180706121836.png)



## 安裝 MySQL Server, MySQL client 已經包括在 server 套件內
```
# yum install mysql-community-server
```
![](./images/20180706121951.png)


## 開機自動啟動 MySQL
```
# /usr/bin/systemctl enable mysqld
```

## 啟動 MySQL
```
# /usr/bin/systemctl start mysqld
```

![](./images/20180706122203.png)


![](./images/20180706140745.png)


```
systemctl status mysqld.service
```





![yum install](./images/20180706135817.png)

## MySQL 預設為空密碼, 執行以下指令修改
```
# /usr/bin/mysql_secure_installation

# mysql -uroot -p

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root@zonvan';
flush privileges;

```
![授权](./images/20180706113153.png)


---

## 安装zabbix源码库配置部署包
```
RHEL 7:

rpm -ivh http://repo.zabbix.com/zabbix/3.4/rhel/7/x86_64/zabbix-release-3.4-2.el7.noarch.rpm


yum-config-manager --enable rhel-7-server-optional-rpms

```
![](./images/20180706141316.png)





## Server/proxy/frontend installation
```
yum install zabbix-server-mysql
```
![yum install](./images/20180706141646.png)



## Server/proxy/frontend installation
```
yum install zabbix-proxy-mysql
```
![yum install](./images/20180706141817.png)


## install Zabbix frontend
```
yum install zabbix-web-mysql
```
![yum install](./images/20180706142019.png)

## Create the database using the provided instructions for MySQL
```
shell> mysql -uroot -p
mysql> create database zabbix character set utf8 collate utf8_bin;
mysql> grant all privileges on zabbix.* to 'zabbix'@'localhost' identified by 'zabbix';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'zabbix'@'%' IDENTIFIED BY 'zabbix';
mysql> flush privileges;
mysql> quit;
```
![](./images/20180706144059.png)

![](./images/20180706144904.png)

![](./images/20180706145713.png)


## Importing data
```
cd /usr/share/doc/zabbix-server-mysql-3.4.11
```

![](./images/20180706142215.png)

```
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p zabbix
```

![](./images/20180706150823.png)

![](./images/20180706151332.png)


## zabbix server conf
```
vim /etc/zabbix/zabbix_server.conf
```

## 启动zabbix server
```
systemctl status zabbix-server.service
```
![](./images/20180706151926.png)


## 变更php的timezone
![](./images/20180706152326.png)


## 重新启动httpd
```
systemctl restart httpd.service
```
![](./images/20180706153525.png)


## zabbix-agent installation
```
yum install zabbix-agent
```
![](./images/20180706153707.png)

![](./images/20180706153852.png)




## 准备开始

http://35.236.140.178/zabbix/setup.php

![](./images/20180709103433.png)

![](./images/20180709103945.png)

![](./images/20180709104034.png)

![](./images/20180709104131.png)

![](./images/20180709104204.png)

![](./images/20180709104243.png)

![](./images/20180709104338.png)

![](./images/20180709104425.png)


## zabbix_agentd.conf设定
![](./images/20180709111750.png)




## 安裝 zabbix-java-gateway
```
# yum install -y zabbix-java-gateway
```
![](./images/20180712104606.png)

> rpm -ql zabbix-java-gateway

![](./images/20180712104827.png)


systemctl status zabbix-java-gateway.service
systemctl enable zabbix-java-gateway.service
![](./images/20180712105207.png)

## 配置/etc/zabbix/zabbix_server.conf文件
```
# vim /etc/zabbix/zabbix_server.conf
### Option: JavaGateway
#       IP address (or hostname) of Zabbix Java gateway.
#       Only required if Java pollers are started.
#
# Mandatory: no
# Default:
JavaGateway=127.0.0.1

### Option: JavaGatewayPort
#       Port that Zabbix Java gateway listens on.
#
# Mandatory: no
# Range: 1024-32767
# Default:
JavaGatewayPort=10052

### Option: StartJavaPollers
#       Number of pre-forked instances of Java pollers.
#
# Mandatory: no
# Range: 0-1000
# Default:
StartJavaPollers=5	
```

## 配置 /etc/zabbix/zabbix_java_gateway.conf 文件
```
# vim /etc/zabbix/zabbix_java_gateway.conf
# This is a configuration file for Zabbix Java Gateway.
# It is sourced by startup.sh and shutdown.sh scripts.

### Option: zabbix.listenIP
#	IP address to listen on.
#
# Mandatory: no
# Default:
LISTEN_IP="0.0.0.0"

### Option: zabbix.listenPort
#	Port to listen on.
#
# Mandatory: no
# Range: 1024-32767
# Default:
LISTEN_PORT=10052

### Option: zabbix.pidFile
#	Name of PID file.
#	If omitted, Zabbix Java Gateway is started as a console application.
#
# Mandatory: no
# Default:
# PID_FILE=

PID_FILE="/var/run/zabbix/zabbix_java.pid"

### Option: zabbix.startPollers
#	Number of worker threads to start.
#
# Mandatory: no
# Range: 1-1000
# Default:
START_POLLERS=5
```

## 启动 zabbix-java-gateway
```
# systemctl enable zabbix-java-gateway.service
ln -s '/usr/lib/systemd/system/zabbix-java-gateway.service' '/etc/systemd/system/multi-user.target.wants/zabbix-java-gateway.service'

# systemctl start zabbix-java-gateway.service

systemctl restart zabbix-server
```

# 客戶212(暫停使用)  mypay-bab  主机测试


## windows

### 212Admin

![](./images/20180712144130.png)


### 更新zabbix agent conf

![](./images/20180712142757.png)


### 更新tomcat jmx
![](./images/20180712142550.png)



### restart zabbix agent

![](./images/20180712142842.png)


### restart tomcat

## linux

### 212Order

![](./images/20180712150757.png)

### 更新zabbix agent conf
![](./images/20180712142013.png)

```
vim /etc/zabbix/zabbix_agentd.conf
```

![](./images/20180712142229.png)

![](./images/20180712142439.png)


![](./images/20180712143726.png)

![](./images/20180712143943.png)

### 更新tomcat jmx

![](./images/20180712145242.png)

```
vim /etc/systemd/system/tomcat.service
```


![](./images/20180712150107.png)

```
systemctl disable tomcat.service
systemctl enable tomcat.service
systemctl restart tomcat.service
systemctl status tomcat.service
```


## 新增 Media types

```
cd /usr/lib/zabbix/alertscripts
```

![](./images/20180712152302.png)

![](./images/20180712152412.png)


## 新增 Action

![](./images/20180712153813.png)



## orabbix
```
cd /opt
mkdir orabbix
rz orabbix-1.2.3.zip
unzip orabbix-1.2.3.zip
chmod 777 -R /opt/orabbix
cd conf
```

![](./images/20180712155244.png)

### 复制orabbix启动文件到etc目录下
```
cp /opt/orabbix/init.d/orabbix /etc/init.d/orabbix


chkconfig --add orabbix
chkconfig orabbix on
systemctl enable orabbix.service
/etc/init.d/orabbix start
```

![](./images/20180712160603.png)



### orabbix conf
![](./images/20180712163459.png)
```
vim /opt/orabbix/conf/config.props
```


## 中文乱码
下载 simkai.ttf

![](./images/20180712171419.png)

```
vim /usr/share/zabbix/include/defines.inc.php

graphfont 换成 simkai
```
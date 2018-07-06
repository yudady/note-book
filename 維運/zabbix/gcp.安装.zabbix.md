# GCP 安装 zabbix

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
mysql> grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'zabbix'@'%' IDENTIFIED BY 'zabbix';
flush privileges;

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









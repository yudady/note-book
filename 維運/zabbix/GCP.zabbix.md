# zabbix
> markdown-it GCP.zabbix.md -o GCP.zabbix.html

![hosts](./images/20180705142438.png)

## 修改mariaDB连线设定

![MariaDB](./images/20180705121709.png)

```
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root@zonvan';
flush privileges;
```




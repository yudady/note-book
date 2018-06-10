# zabbix-agent










## windows 测试zabbix

> 进入zabbix目录(cd C:\zabbix)

```
// C槽目前剩下多少空间
zabbix_agentd.exe -t vfs.fs.size[C:,pfree]

zabbix_agentd.exe -t net.if.list

```


## 使用 zabbix_get 在SERVER(192.168.0.30)抓取CLIENT端(GCP)数据

### linux zabbix_get
> zabbix_get -s GCP_IP -k "net.if.out[eth0]"
![](./images/20180609200437568.png)

### windows zabbix_get
zabbix_get -s GCP_IP -k "net.if.out[Red Hat VirtIO Ethernet Adapter]"
![](./images/20180609200930864.png)









## zabbix-agent 自定義用戶訊息
> 加載被監控的主機上面，然後到server端測試可不可以拿到值
![/etc/zabbix/zabbox_agented.conf](./images/2018-06-02_112506.png)
格式:UserParameter=[key][value] , key必須在zabbix全局唯一

> 在SERVER端（10.0.0.7）拿取客戶端（10.0.0.8）數據
zabbix_get -s 10.0.0.8 -k login-user


[powershell UnsafeUserParameters](http://my-fish-it.blogspot.com/2017/03/ss-zabbix-32-userparameter-windows.html)

[zabbix Windows-specific item keys](https://www.zabbix.com/documentation/3.4/manual/config/items/itemtypes/zabbix_agent/win_keys)

[zabbix agent所支持的所有KEY](http://blog.51cto.com/skykws8023/1619075)
















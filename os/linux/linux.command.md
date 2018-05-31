# date

```
10天前
date -d '-14 days' '+%Y%m%d'
```

## find
find / -type f -name "*logstash*"


## 手动和时间服务器校准时间：

```
yum -y install ntpdate
首先关闭ntpd服务：service ntpd stop
然后和时间服务器校准： ntpdate asia.pool.ntp.org
同步BIOS时间：hwclock -w
校准后然后开启ntpd服务：service ntpd start

```

## 找出最后一千行的 关键字(locks)
```
tail -n 1000 ./orabbix.log | grep locks
```






free -m
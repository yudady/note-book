# ELK 

## logstash-*
> 像logstash-*这样命名的indices会应用默认的logstash index模板

```
用 curl 查詢 Elasticsearch 的 Indices Name：

curl "http://localhost:9200/_cat/indices?v&h=i"


删除Indices
curl -XDELETE "localhost:9200/zonpay-2018.01*"
curl -XDELETE "localhost:9200/zonpay-2018.02*"


删除30天前资料
curl -XDELETE "localhost:9200/zonpay-`date -d '-30 days' '+%Y%m%d'`*" >> /var/log/elk-deleteLog.log 2>&1

写到cron自动删除
/opt/elkCronJob/deleteLog.sh >> /var/log/elk-deleteLog.log 2>&1


/etc/init.d/cron restart


查看当前线程组状态
curl -XGET 'http://localhost:9200/_nodes/stats?pretty'  
```


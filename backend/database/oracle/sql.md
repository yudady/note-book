# date


## 日期
```
TO_DATE('2012-07-18 13:27:18', 'YYYY-MM-DD HH24:MI:SS')
```


## 查询oracle登入者资讯
```

select to_char(timestamp,'YYYY-MM-DD HH24:MI:SS') as login_time , p.* from DBA_AUDIT_TRAIL p 
where timestamp > TO_DATE('2018-03-29 18:00:27', 'YYYY-MM-DD HH24:MI:SS') 
order by login_time desc;



```





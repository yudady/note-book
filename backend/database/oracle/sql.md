# date


## oracle日期
```
TO_DATE('2012-07-18 13:27:18', 'YYYY-MM-DD HH24:MI:SS')
```


## 查询oracle登入者资讯
```

select to_char(timestamp,'YYYY-MM-DD HH24:MI:SS') as login_time , p.* from DBA_AUDIT_TRAIL p 
where timestamp > TO_DATE('2018-03-29 18:00:27', 'YYYY-MM-DD HH24:MI:SS') 
order by login_time desc;

```


## oracle flashback
```
SELECT * FROM PY_SYSTEM_CONFIG AS OF TIMESTAMP TO_TIMESTAMP('2018-03-31 09:20:00', 'YYYY-MM-DD HH:MI:SS')
```

## oracle db user drop and create
```
drop user myPay024 cascade;

create user myPay024 identified by myPay024;

GRANT ALL privileges TO myPay024;

GRANT sysdba TO myPay024;

GRANT dba TO myPay024;
```


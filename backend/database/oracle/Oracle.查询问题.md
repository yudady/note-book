# Oracle查询慢的原因

## 查询速度慢的原因很多，常见如下几种：
1.没有索引或者没有用到索引（这是查询慢最常见的问题，是程序设计的缺陷）
2.I/O吞吐量小，形成了瓶颈效应。
3.没有创建计算列导致查询不优化。
4.内存不足
5.网络速度慢
6.查询出的数据量过大（可以采用oracle认证更多详细资料 多次查询，其他的方法降低数据量）
7.锁或者死锁（这也是查询慢最常见的问题，是程序设计的缺陷）
8.sp_lock，sp_who，活动的用户查看，原因是读写竞争资源。
9.返回了不必要的行和列
10.查询语句不好，没有优化

### 可以通过如下方法来优化查询 ：



## oracle alert log location

```
select value from v$diag_info where name ='Diag Alert'; 
```




## Oracle 查询耗时 SQL

当你的系统变慢时，如何查询系统中最耗时的 SQL 呢？试一试下面的 SQL 吧。
```
select * from (
	select * from V$SQLSTATS
	
	-- 最耗时的 SQL
	-- ELAPSED_TIME 指的是总耗时（毫秒），平均耗时 = ELAPSED_TIME/EXECUTIONS
	-- order by ELAPSED_TIME DESC
	
	-- 查询执行次数最多的 SQL
	-- order by EXECUTIONS DESC
	
	-- 读硬盘最多的 SQL
	-- order by DISK_READS DESC
	
	-- 最费 CPU 的 SQL
	-- order by BUFFER_GETS DESC
) where rownum <=50;
```


## Identify the blocking session
```
select * from v$lock ;
```



----

### 查詢Oracle誰Locks住Table: 列出当前locks资料（list current locks）


```

SELECT SN.USERNAME || '@' || SN.MACHINE,
       '|SID->' || M.SID,
       '|Serial->' || SN.SERIAL#,
       '|Lock Type->' || M.TYPE,
       DECODE(LMODE,
              1,
              'Null',
              2,
              'Row-S (SS)',
              3,
              'Row-X (SX)',
              4,
              'Share',
              5,
              'S/Row-X (SSX)',
              6,
              'Exclusive') LOCK_TYPE,
       DECODE(REQUEST,
              0,
              'None',
              1,
              'Null',
              2,
              'Row-S (SS)',
              3,
              'Row-X (SX)',
              4,
              'Share',
              5,
              'S/Row-X (SSX)',
              6,
              'Exclusive') LOCK_REQUESTED,
       '|Time (Sec)->' || M.CTIME "Time(sec)",
       '|ID1->' || M.ID1,
       '|ID2->' || M.ID2,
       '|SQL Text->' || T.SQL_TEXT
  FROM V$SESSION SN, V$LOCK M, V$SQLTEXT T
 WHERE T.ADDRESS = SN.SQL_ADDRESS
   AND T.HASH_VALUE = SN.SQL_HASH_VALUE
   AND ((SN.SID = M.SID AND M.REQUEST != 0) OR
       (SN.SID = M.SID AND M.REQUEST = 0 AND LMODE != 4 AND
       (ID1, ID2) IN (SELECT S.ID1, S.ID2
                          FROM V$LOCK S
                         WHERE REQUEST != 0
                              -- and  s.ctime > 5 
                           AND S.ID1 = M.ID1
                           AND S.ID2 = M.ID2)))
 ORDER BY SN.USERNAME, SN.SID, T.PIECE ;








-----------------------------------------


SELECT B.OBJECT_NAME OBJ_NAME,
       A.ORACLE_USERNAME ORA_USER,
       A.OS_USER_NAME OS_USER,
       D.CTIME LOCK_SECOND_TIME,
       C.SID ORACLE_SID,
       C.SERIAL# ORACLE_SERIAL#,
       C.MACHINE MACHINE,
       C.PROGRAM PROGRAM,
       TO_CHAR(D.LMODE) L,
       TO_CHAR(D.REQUEST) R,
       A.OBJECT_ID OBJ_ID,
       A.PROCESS PID,
       A.SESSION_ID S_ID,
       P.SPID
  FROM V$LOCKED_OBJECT A, ALL_OBJECTS B, V$SESSION C, V$LOCK D, V$PROCESS P
 WHERE A.OBJECT_ID = B.OBJECT_ID
   AND C.PADDR = P.ADDR
   AND A.SESSION_ID = C.SID
   AND A.SESSION_ID = D.SID
   AND D.TYPE = 'TX'
 ORDER BY D.CTIME DESC, P.SPID ;




ALTER SYSTEM KILL SESSION 'sid,serial#';
```













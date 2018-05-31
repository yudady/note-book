# Oracle查询慢的原因


## oracle 建议

```
-- -- 檢索SQL調優顧問結果。 如果你喜歡，你只能運行最近的運行，但它只會包含新的建議。 該語法將檢索所有建議，包括那些自此之後被修改的建議
-- 警告：它會產生相當多的輸出，因為它有每個調整建議。

SELECT DBMS_SQLTUNE.REPORT_AUTO_TUNING_TASK((SELECT MIN(EXECUTION_NAME)
                                              FROM DBA_ADVISOR_FINDINGS
                                             WHERE TASK_NAME LIKE
                                                   'SYS_AUTO_SQL%'),
                                            (SELECT MAX(EXECUTION_NAME)
                                               FROM DBA_ADVISOR_FINDINGS
                                              WHERE TASK_NAME LIKE
                                                    'SYS_AUTO_SQL%'))
  FROM DUAL;


-- 記下建議的執行名稱和對象ID
-- 使用此信息查詢dba_advisor_rationale中的提示：

SELECT REC_ID, TO_CHAR(ATTR5)
  FROM DBA_ADVISOR_RATIONALE
 WHERE EXECUTION_NAME = 'EXEC_24365'
   AND OBJECT_ID = 19930
   AND REC_ID > 0
 ORDER BY REC_ID
```




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




## Oracle 查询耗时 SQL

> 当你的系统变慢时，如何查询系统中最耗时的 SQL 呢？试一试下面的 SQL 吧。

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


## oracle alert log location（找出oracle alert log 位置）

```
select value from v$diag_info where name ='Diag Alert'; 
```





## 查詢Oracle誰Locks住Table: 列出当前locks资料（list current locks）


```

-- 找出被lock资讯
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

---

-- 找出被lock资讯
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



--- 把被lock的session杀掉
ALTER SYSTEM KILL SESSION 'sid,serial#';

```



## ORACLE查看SQL的执行次数/频率

### SQL语句执行了多少次
```
SELECT PARSING_SCHEMA_NAME, SQL_ID, SQL_TEXT, FIRST_LOAD_TIME, EXECUTIONS
  FROM V$SQLAREA
 WHERE 1 = 1
   AND PARSING_SCHEMA_NAME IN ('MYPAY', 'MYPAYCENTER')
 ORDER BY EXECUTIONS DESC;

SELECT SQL_TEXT, EXECUTIONS
  FROM (SELECT SQL_TEXT,
               EXECUTIONS,
               RANK() OVER(ORDER BY EXECUTIONS DESC) EXEC_RANK
          FROM V$SQLAREA)
 WHERE EXEC_RANK <= 15;



-- EXECUTIONS表示同一条SQL语句一共执行了多少次，SORTS表示排序的次数，DISK_READS表示物理读的数量。
SELECT *
  FROM (SELECT PARSING_USER_ID,
               EXECUTIONS,
               SORTS,
               COMMAND_TYPE,
               DISK_READS,
               SQL_TEXT
          FROM V$SQLAREA
         ORDER BY DISK_READS DESC)
 WHERE ROWNUM < 10;




```



## Oracle 控制文件和日志文件
[Oracle 控制文件和日志文件](https://blog.csdn.net/deram_boy/article/details/51248456)




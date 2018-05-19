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
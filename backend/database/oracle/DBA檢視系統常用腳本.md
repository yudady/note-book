# DBA檢視系統常用腳本



-- Parameter
SELECT name,value,description,isdefault,isses_modifiable,issys_modifiable FROM v$parameter;         -- 可以在Session級修改的參數(alter session)
SELECT name,value,description,isdefault,isses_modifiable,issys_modifiable FROM v$parameter2;        -- 可以在Session級修改的參數(alter session) - LIST的值分開, 一行變多行數據
SELECT name,value,description,isdefault,isses_modifiable,issys_modifiable FROM v$system_parameter;  -- 實例級的參數(alter system)
SELECT name,value,description,isdefault,isses_modifiable,issys_modifiable FROM v$system_parameter2; -- 實例級的參數(alter system) - LIST的值分開, 一行變多行數據
SELECT name,value FROM v$spparameter;                                                               -- 保存在spfile中的參數值(scope=both或者spfile). 


-- Parameters
SELECT substr(name, 0, 512) name, 
       DECODE(type, 1, 'Boolean', 2, 'String', 3, 'Integer', 4, 'Filename', ' ') type, 
       substr(value, 0, 512) value, 
       ISDEFAULT,
       ISSYS_MODIFIABLE,
       substr(description,0,512) description
  FROM v$parameter
 ORDER BY name;


-- Spfile Parameters
SELECT UNIQUE sp.name, sp.sid, 
       DECODE(p.type, 1, 'Boolean', 2, 'String', 3, 'Integer', 4, 'Filename', ' ') type, 
       sp.value, p.issys_modifiable, p.description 
  FROM v$spparameter sp, v$parameter p 
 WHERE sp.name = p.name ORDER BY sp.name, sp.sid;


-- Spfile file
SELECT name,value FROM v$parameter WHERE name = 'spfile';


SELECT * FROM v$instance;                                    -- 實例資訊
SELECT name,log_mode,open_mode from v$database;              -- 數據庫資訊
SELECT banner FROM v$version WHERE BANNER LIKE '%Oracle%';   -- 版本資訊
SELECT value FROM v$parameter WHERE  name = 'db_block_size'; -- db block size
SELECT * FROM v$archive_dest ORDER BY dest_id;               -- 歸檔日志位置
SELECT service_id, name, network_name FROM v$services;       -- 服務名


-- Lock: 檢視鎖定的會話和鎖定對象(阻塞的會話)
select s.sid,s.serial#,s.lockwait,s.status,s.schemaname,s.machine,s.terminal,s.osuser,s.program,s.module,s.action,s.logon_time,
       l.oracle_username,l.os_user_name,l.locked_mode,o.owner,o.object_name,o.object_type,o.status,
       'alter system kill session '||''''|| s.sid||','||s.serial#||''''||';' kill_session_sql   
  from v$session s,
       v$locked_object l,
       dba_objects o
 where s.sid = l.session_id
   and l.object_id = o.object_id
   and s.sid in (select holding_session from dba_waiters);


-- Option，數據庫組件
SELECT *
  FROM v$option 
 WHERE value='TRUE' 
   and (parameter like 'OLAP' or parameter like 'Oracle Data Mining' 
        or parameter like 'Oracle Label Security' or parameter like 'Partitioning' 
        or parameter like 'Real Application Clusters' or parameter like 'Spatial');


-- SGA & PGA
SELECT name, value FROM v$sga;
SELECT name, value FROM v$pgastat;


-- SGA share pool advice
SELECT name,value FROM v$parameter WHERE name = 'shared_pool_size';  -- SGA自動管理shared_pool_size=0
select name,value from v$parameter where name = 'sga_target';        -- SGA自動管理需設置參數sga_target
SELECT value FROM v$parameter WHERE name = 'statistics_level';
SELECT shared_pool_size_for_estimate, shared_pool_size_factor, estd_lc_time_saved, estd_lc_time_saved_factor
  FROM v$shared_pool_advice 
 ORDER BY shared_pool_size_for_estimate;


-- SGA db cache, 數據緩沖區命中率
SELECT 1 - ((physical.value - direct.value - lobs.value) / logical.value) "Buffer Cache Hit Ratio" 
  FROM v$sysstat physical,
       v$sysstat direct,
       v$sysstat lobs,
       v$sysstat logical
 WHERE physical.name = 'physical reads'
  AND direct.name='physical reads direct'
  AND lobs.name='physical reads direct (lob)'
  AND logical.name='session logical reads';


-- SGA db cache advice
SELECT name, value FROM v$parameter WHERE  name = 'db_block_size';         -- db block size
SELECT name, value FROM v$parameter WHERE name like 'db%cache_size';       -- SGA自動管理db%cache_size=0
select name,value from v$parameter where name = 'sga_target';              -- SGA自動管理需設置參數sga_target
SELECT value FROM v$parameter WHERE name = 'db_block_buffers';
SELECT value FROM v$parameter WHERE name = 'db_cache_advice';              -- advice
SELECT value FROM v$parameter WHERE name = 'statistics_level';
SELECT name, block_size, size_for_estimate, buffers_for_estimate,  estd_physical_read_factor, estd_physical_reads 
  FROM v$db_cache_advice
 WHERE block_size = 8192;


-- SGA advice
select sga_size,sga_size_factor,estd_db_time from v$sga_target_advice;


-- PGA advice
SELECT value FROM v$parameter WHERE name = 'statistics_level';
SELECT round(pga_target_for_estimate/1024/1024) pga_target_for_estimate_mb, estd_pga_cache_hit_percentage, estd_overalloc_count, pga_target_factor 
  FROM v$pga_target_advice ORDER BY 1;


-- Auto memory advice(SGA + PGA)
select memory_size,memory_size_factor,estd_db_time from v$memory_target_advice;


-- MTTR advice (平均恢復時間)
SELECT estimated_mttr FROM v$instance_recovery;
SELECT value FROM v$parameter WHERE name = 'statistics_level';
SELECT mttr_target_for_estimate, dirty_limit, estd_cache_writes, estd_cache_write_factor, 
       estd_total_writes, estd_total_write_factor,  estd_total_ios, estd_total_io_factor 
  FROM v$mttr_target_advice
 ORDER BY mttr_target_for_estimate; 


-- Undo tablespace (撤消表空間)
SELECT tablespace_name FROM dba_tablespaces WHERE contents = 'UNDO' ORDER BY 1;
SELECT * FROM sys.dba_data_files WHERE tablespace_name = 'UNDOTBS1';
SELECT max(maxconcurrency), max(undoblks), avg(undoblks) FROM v$undostat;


-- Session
select case when r.session_id is not NULL and r.status = 'SUSPENDED' then 'Suspended' 
            when max(decode(s.serial#,l.serial#,1,0)) = 1 then 'Long Operations' 
            else 'Regular' 
       end operation, 
       s.sid,s.status, s.username, RTRIM(s.osuser), b.spid, 
       s.machine, s.program, s.resource_consumer_group, r.timeout 
from v$session s, v$session_longops l, v$process b, dba_resumable r 
 where (s.sid = l.sid(+)) 
   and (s.sid = r.session_id(+)) 
   and s.paddr=b.addr 
 group by r.session_id, r.error_number, r.status, s.sid,s.status, s.username, 
          s.osuser, b.spid, s.machine, s.program,s.resource_consumer_group, r.timeout;


-- Resource Group
SELECT DISTINCT consumer_group "Consumer Group", mandatory "Mandatory", comments "Description" FROM 
sys.dba_rsrc_consumer_groups ORDER BY 1   
-- Resource Plan
SELECT plan "Plan", mandatory "Mandatory", comments "Description" FROM sys.dba_rsrc_plans ORDER BY 1


-- Tablespace
SELECT tablespace_name, status, contents, logging, extent_management, block_size,segment_space_management--, bigfile  
FROM sys.dba_tablespaces ORDER BY 1;


-- Tablespace used information
SELECT d.status "Status", 
       d.tablespace_name "Name", 
       d.contents "Type", 
       d.extent_management "Extent Management", 
       NVL(a.bytes / 1024 / 1024, 0) "Size (M)", 
       TO_CHAR(NVL(a.bytes - NVL(f.bytes, 0), 0)/1024/1024,'99999999.999') "Used (M)", 
       ROUND(NVL((a.bytes - NVL(f.bytes, 0)) / a.bytes * 100, 0),2) "Used (%)" 
  FROM sys.dba_tablespaces d, 
       (select tablespace_name, sum(bytes) bytes from dba_data_files group by tablespace_name) a, 
       (select tablespace_name, sum(bytes) bytes from dba_free_space group by tablespace_name) f 
 WHERE d.tablespace_name = a.tablespace_name(+) 
   AND d.tablespace_name = f.tablespace_name(+) 
   AND NOT (d.extent_management like 'LOCAL' AND d.contents like 'TEMPORARY') 
 UNION ALL
SELECT d.status "Status", 
       d.tablespace_name "Name", 
       d.contents "Type", 
       d.extent_management "Extent Management", 
       NVL(a.bytes / 1024 / 1024, 0) "Size (M)", 
       TO_CHAR(NVL(t.bytes,0)/1024/1024,'99999999.999') "Used (M)", 
       ROUND(NVL(t.bytes / a.bytes * 100, 0),2) "Used (%)" 
  FROM sys.dba_tablespaces d, 
       (select tablespace_name, sum(bytes) bytes from dba_temp_files group by tablespace_name) a,
       (select tablespace_name, sum(bytes_cached) bytes from v$temp_extent_pool group by tablespace_name) t 
 WHERE d.tablespace_name = a.tablespace_name(+) 
   AND d.tablespace_name = t.tablespace_name(+) 
   AND d.extent_management like 'LOCAL' 
   AND d.contents like 'TEMPORARY'
 ORDER BY 2;
  
-- Tablespace datafile
SELECT /*+ use_hash(d v) */ d.tablespace_name, d.file_name,  v.status, 
       TO_CHAR((d.bytes / 1024 / 1024), '99999990.000') "Size (M)",
    NVL(TO_CHAR(((d.bytes - s.bytes) / 1024 / 1024), '99999990.000'), 
       TO_CHAR((d.bytes / 1024 / 1024), '99999990.000')) "Used (M)", 
       d.file_id, d.autoextensible, d.increment_by, d.maxblocks 
  FROM sys.dba_data_files d, 
       v$datafile v, 
       (SELECT file_id, SUM(bytes) bytes FROM sys.dba_free_space GROUP BY file_id) s 
 WHERE (s.file_id (+)= d.file_id) 
   AND (d.file_name = v.name)
 ORDER BY d.tablespace_name, d.file_name;


-- Tablespace extents
SELECT tablespace_name,(initial_extent / 1024) initial_extent_kb, (next_extent / 1024) next_extent_kb, min_extents, max_extents, pct_increase, 
    (min_extlen / 1024) min_extlen_kb, extent_management, allocation_type 
  FROM sys.dba_tablespaces
 ORDER BY tablespace_name;


-- Property: Character set, Default_temp_tablepsace, ... 
SELECT * FROM sys.props$;
SELECT name,value$ FROM sys.props$ WHERE name = 'DEFAULT_TEMP_TABLESPACE';


-- Datafile used
SELECT /*+ ordered no_merge(v) */ v.status "Status", d.file_name "Name", d.tablespace_name "Tablespace", 
       TO_CHAR(NVL(d.bytes / 1024 / 1024, 0), '99999990.000') "Size (M)", 
    TO_CHAR(NVL((d.bytes - NVL(s.bytes, 0))/1024/1024, 0),'99999999.999') || '/' || 
    TO_CHAR(NVL(d.bytes/1024/1024, 0),'99999999.999') || '/' || NVL(d.autoextensible, 'NO') "Used", 
    TO_CHAR(NVL((d.bytes - NVL(s.bytes, 0)) / d.bytes * 100, 0), '990.00') "Used %" 
  FROM sys.dba_data_files d, 
       v$datafile v, 
       (SELECT file_id, SUM(bytes) bytes  FROM sys.dba_free_space GROUP BY file_id) s 
 WHERE (s.file_id (+)= d.file_id)
   AND (d.file_name = v.name)
 UNION ALL
SELECT /*+ ordered no_merge(v) */ v.status "Status", d.file_name "Name", d.tablespace_name "Tablespace", 
    TO_CHAR(NVL(d.bytes / 1024 / 1024, 0), '99999990.000') "Size (M)", 
    TO_CHAR(NVL(t.bytes_cached/1024/1024, 0),'99999999.999') || '/' || 
           TO_CHAR(NVL(d.bytes/1024/1024, 0),'99999999.999') || '/' || NVL(d.autoextensible, 'NO') "Used", 
       TO_CHAR(NVL(t.bytes_cached / d.bytes * 100, 0), '990.00') "Used %"
  FROM sys.dba_temp_files d,
       v$temp_extent_pool t,
       v$tempfile v
 WHERE (t.file_id (+)= d.file_id)
   AND (d.file_id = v.file#);


-- Rollback segment (普通表空間9i開始已不建議使用Rollback segment，僅用于SYSTEM)
SELECT r.status "Status", r.segment_name "Name", r.tablespace_name "Tablespace", s.extents "Extents",
    TO_CHAR((s.bytes / 1024 / 1024), '99999990.000') "Size" ,segment_type
  FROM sys.dba_rollback_segs r, sys.dba_segments s 
 WHERE r.segment_name = s.segment_name 
   AND s.segment_type = 'ROLLBACK';


-- Log group
SELECT NLS_INITCAP(status) "Status", group# "Group", members "# of Members", NLS_INITCAP(archived) "Archived", 
       (bytes / 1024) "Size (K)", sequence# "Sequence" , first_change# "First Change#" 
  FROM v$log
 ORDER BY group#;


-- Log file
SELECT group#, status, type, member, is_recovery_dest_file,con_id FROM v$logfile ORDER BY group#;


-- Archived log
SELECT name "Name",sequence# "Sequence", thread# "Thread", backup_count "Backup Count", 
       first_change# "First Change#", first_time "First Time", completion_time "Archival Time", deleted
  FROM v$archived_log 
 WHERE deleted='NO'
 ORDER BY sequence#;


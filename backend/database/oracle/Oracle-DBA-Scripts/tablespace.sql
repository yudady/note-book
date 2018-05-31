-- Tablespaces, ordered by percentage of space used

col bytes_used format 99999999999999 
SELECT A.TABLESPACE_NAME,
       A.BYTES / 1024 / 1024 MBYTES_USED,
       B.BYTES / 1024 / 1024 MBYTES_FREE,
       ROUND(((A.BYTES - B.BYTES) / A.BYTES) * 100, 2) PERCENT_USED
  FROM (SELECT TABLESPACE_NAME, SUM(BYTES) BYTES
          FROM DBA_DATA_FILES
         GROUP BY TABLESPACE_NAME) A
  LEFT OUTER JOIN (SELECT TABLESPACE_NAME,
                          SUM(BYTES) BYTES,
                          MAX(BYTES) LARGEST
                     FROM DBA_FREE_SPACE
                    GROUP BY TABLESPACE_NAME) B
    ON A.TABLESPACE_NAME = B.TABLESPACE_NAME
 WHERE 1 = 1
   AND A.TABLESPACE_NAME LIKE '%'
 ORDER BY ((A.BYTES - B.BYTES) / A.BYTES) DESC

-- List files in a tablespace with current size and max size
SELECT FILE_NAME,
       BYTES / 1024 / 1024 MBYTES,
       AUTOEXTENSIBLE,
       MAXBYTES / 1024 / 1024 M_MAXBYTES
  FROM DBA_DATA_FILES
 WHERE TABLESPACE_NAME = 'ts_myPay';


-- List files in a volume with current size and max size
select file_name,bytes/1024/1024 Mbytes,autoextensible,maxbytes/1024/1024 M_maxbytes from dba_data_files where file_name like '/u04/oradata7/%' order by file_name;

-- Grow a datafile
ALTER DATABASE DATAFILE '/u05/oradata/COGPREPO/perfstat_01.dbf' resize 2048M;

-- add datafile
alter tablespace ALLHOTDB_DATA01 add datafile '/ihotelt3/oradata/ihotelt3/allhotdb_data01_07.dbf' size 10240M autoextend off;

-- Free temp space
SELECT TABLESPACE_NAME,
       TOTAL_BLOCKS,
       USED_BLOCKS,
       FREE_BLOCKS,
       TOTAL_BLOCKS * 16 / 1024 AS TOTAL_MB,
       USED_BLOCKS * 16 / 1024 AS USED_MB,
       FREE_BLOCKS * 16 / 1024 AS FREE_MB
  FROM V$SORT_SEGMENT;
 
-- 
-- So what's using the segments:
-- 
SELECT   b.TABLESPACE,
         b.segfile#,
         b.segblk#,
         b.blocks,
   b.blocks*16/1024 as MB,
         a.SID,
         a.serial#,
         a.status
FROM     v$session a,
         v$sort_usage b
WHERE    a.saddr = b.session_addr
ORDER BY b.TABLESPACE,
         b.segfile#,
         b.segblk#,
         b.blocks;



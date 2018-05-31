
-- Retrieve SQL tuning advisor findings. You can only run the most recent run if you like, but it will only contain new recommendations. This syntax will retrieve all recommendations, including those that have since been modified
-- Warning: it generates quite a bit of output, as it has every tuning recommendation.
-- 檢索SQL調優顧問結果。 如果你喜歡，你只能運行最近的運行，但它只會包含新的建議。 該語法將檢索所有建議，包括那些自此之後被修改的建議
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


--  Note the execution name and object ID for the recommendation
-- Use this information to query out the hints from dba_advisor_rationale:
-- 記下建議的執行名稱和對象ID
-- 使用此信息查詢dba_advisor_rationale中的提示：

SELECT REC_ID, TO_CHAR(ATTR5)
  FROM DBA_ADVISOR_RATIONALE
 WHERE EXECUTION_NAME = 'EXEC_24365'
   AND OBJECT_ID = 19930
   AND REC_ID > 0
 ORDER BY REC_ID

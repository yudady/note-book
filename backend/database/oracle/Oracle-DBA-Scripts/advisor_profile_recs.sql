
-- Retrieve SQL tuning advisor findings. You can only run the most recent run if you like, but it will only contain new recommendations. This syntax will retrieve all recommendations, including those that have since been modified
-- Warning: it generates quite a bit of output, as it has every tuning recommendation.
-- 檢索SQL調優顧問結果。 如果你喜歡，你只能運行最近的運行，但它只會包含新的建議。 該語法將檢索所有建議，包括那些自此之後被修改的建議
-- 警告：它會產生相當多的輸出，因為它有每個調整建議。


select dbms_sqltune.report_auto_tuning_task((select min(execution_name) from dba_advisor_findings where task_name like 'SYS_AUTO_SQL%'),
(select max(execution_name) from dba_advisor_findings where task_name like 'SYS_AUTO_SQL%')) from dual;


--  Note the execution name and object ID for the recommendation
-- Use this information to query out the hints from dba_advisor_rationale:
-- 記下建議的執行名稱和對象ID
-- 使用此信息查詢dba_advisor_rationale中的提示：

select rec_id,to_char(attr5) from dba_advisor_rationale where execution_name = 'EXEC_24365'
and object_id = 19930
and rec_id > 0
order by rec_id

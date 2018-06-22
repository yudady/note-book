# oracle 救援 SQL



ALTER USER user_name IDENTIFIED BY new_password;

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


## oracle flashback（资料库闪回）
```

-- 先找出嘚删除的资料
SELECT * FROM PY_SYSTEM_CONFIG AS OF TIMESTAMP TO_TIMESTAMP('2018-03-31 09:20:00', 'YYYY-MM-DD HH:MI:SS')

-- 把资料放到暂存档（TABLE 需要存在）
INSERT INTO PY_ORDER_BACK 
SELECT * FROM PY_SYSTEM_CONFIG AS OF TIMESTAMP TO_TIMESTAMP('2018-03-31 09:20:00', 'YYYY-MM-DD HH:MI:SS')

-- 把资料放到暂存档
CREATE TABLE new_table
AS
SELECT * FROM PY_SYSTEM_CONFIG AS OF TIMESTAMP TO_TIMESTAMP('2018-03-31 09:20:00', 'YYYY-MM-DD HH:MI:SS')

```

## oracle db user drop and create（删除用户，给全部权限）
```
drop user myPay024 cascade;

create user myPay024 identified by myPay024;

GRANT ALL privileges TO myPay024;

GRANT sysdba TO myPay024;

GRANT dba TO myPay024;
```



## create oracle dblink
CREATE DATABASE LINK mypay009 CONNECT TO myPay IDENTIFIED BY fSDd4860dj
USING
'(DESCRIPTION=(ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = 10.140.0.24)(PORT = 1521)))(CONNECT_DATA = (SERVICE_NAME =myPay)) )'

--SELECT * FROM py_order@mypay009

--DROP DATABASE LINK mypay009;





## 客户端 DB 还原

```

-- 处理用户
startup force

drop user myPay cascade;

create user myPay identified by "eje93nf";

GRANT ALL privileges TO myPay;

GRANT sysdba TO myPay;

GRANT dba TO myPay;


-- 把用户资料倒入
imp myPay/"eje93nf"@myPay file="C:/Users/mypay/Desktop/090/dumpFileMyPay.DMP" log="C:/Users/mypay/Desktop/090/090.log" fromuser=myPay touser=myPay INDEXES=n STATISTICS=none



-- db link
CREATE DATABASE LINK mypaycenter CONNECT TO mypaycenter IDENTIFIED BY u3gfu206kf
USING
'(DESCRIPTION=(ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = 10.140.0.79)(PORT = 1521)))(CONNECT_DATA = (SERVICE_NAME =myPay)) )'



-- 把 py_order -> from mypaycenter to cust DB

SELECT * FROM py_order@mypaycenter where CUST_ID = '090';





INSERT INTO PY_ORDER 
SELECT 
ORDER_NO
,PAGE_ID
,PAGE_NAME
,MERCHANT_ID
,MERCHANT_NAME
,PAYMENT_ORDER_NO
,RECHARGE_AMOUNT
,PAYMENT_DATE
,PAYMENT_NOTIFY_DATE
,'3'   // STATUS(已支付-已添加)
,LOCK_USER_ID
,LOCK_USER_NAME
,LOCK_TIME
,CLIENT_ACCOUNT
,CLIENT_TERMINAL
,CLIENT_IP
,REMARK
,CREATE_DATE
,UPDATE_DATE
,UPDATE_USER_ID
,UPDATE_USER_NAME
,SUBMIT_DATE
,RESPONSE_DATA
,RESPONSE_CODE
,RESPONSE_DESC
,RESPONSE_QRCODE
,PAYMENT_PLATFORM_ID
,PAYMENT_PLATFORM_NAME
,PAYMENT_METHOD_ID
,PAYMENT_METHOD_NAME
,ROBOT_PROCESS_STATUS
,DEPOSIT_OFFER
,RED_ENVELOPES_OFFER
,TOTAL_AMOUNT
,CALLBACK_AMOUNT
,FEE_OFFER
FROM   py_order@mypaycenter where CUST_ID = '090'

```





## oracle 找出栏位长度大于XXX
```
SELECT ORDER_NO,CLIENT_IP FROM PY_ORDER WHERE lengthb(CLIENT_IP) > 40;

```


cat /mnt/nfs/var/rd2/callback.log | grep 201804110090005041
cat /mnt/nfs/var/rd3/callback.log | grep 201804110090005041
cat /mnt/nfs/var/rd3-1/callback.log | grep 201804110090005041
cat /mnt/nfs/var/rd3-2/callback.log | grep 201804110090005041

---








## 书签
[oracle提高查询效率的34条方法](https://www.2cto.com/database/201301/181269.html)














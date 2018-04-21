# nginx 

## windows



## 啟動 關閉

```
unzip 直接使用
cd folder
啟動執行    nginx.exe
nginx -s stop	fast shutdown
nginx -s quit	graceful shutdown
nginx -s reload	changing configuration, starting new worker processes with a new configuration, graceful shutdown of old worker processes
nginx -s reopen	re-opening log files
```










## linux install 

```

yum install -y gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel

1. download nginx src
2. unzio zip
3. configure 加上參數（--prefix）才能生成make file 


```
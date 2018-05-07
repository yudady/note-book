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


















## 我的 nginx.conf 设定
```

#user  nobody;
worker_processes  1;

error_log  logs/error.log;
error_log  logs/error.log  notice;
error_log  logs/error.log  info;

pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;

    gzip  on;

    server {
	
		listen       80;
		server_name       192.168.168.167;

		location ^~ /note-book/ {

			#add_header 				'Content-Type' 'text/html; charset=utf-8';
		
			if ($request_uri ~ \.md$) {
				add_header 				'Content-Type' 'text/plant; charset=utf-8';
			}
		
		
		
			proxy_pass              http://192.168.168.167:18080/note-book/;
			proxy_redirect          off;
			proxy_set_header        Host $host;
			proxy_set_header        X-Real-IP       $remote_addr;
			proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
		}
	
        location / {
            root   html;
            index  index.html index.htm;
        }
		
		
        error_page   500 502 503 504  /50x.html;
        location = /50x.html {
            root   html;
        }


    }



}


```



## 内置的全局变量
```
$args ：这个变量等于请求行中的参数，同$query_string
$content_length ： 请求头中的Content-length字段。
$content_type ： 请求头中的Content-Type字段。
$document_root ： 当前请求在root指令中指定的值。
$host ： 请求主机头字段，否则为服务器名称。
$http_user_agent ： 客户端agent信息
$http_cookie ： 客户端cookie信息
$limit_rate ： 这个变量可以限制连接速率。
$request_method ： 客户端请求的动作，通常为GET或POST。
$remote_addr ： 客户端的IP地址。
$remote_port ： 客户端的端口。
$remote_user ： 已经经过Auth Basic Module验证的用户名。
$request_filename ： 当前请求的文件路径，由root或alias指令与URI请求生成。
$scheme ： HTTP方法（如http，https）。
$server_protocol ： 请求使用的协议，通常是HTTP/1.0或HTTP/1.1。
$server_addr ： 服务器地址，在完成一次系统调用后可以确定这个值。
$server_name ： 服务器名称。
$server_port ： 请求到达服务器的端口号。
$request_uri ： 包含请求参数的原始URI，不包含主机名，如：”/foo/bar.php?arg=baz”。
$uri ： 不带请求参数的当前URI，$uri不包含主机名，如”/foo/bar.html”。
$document_uri ： 与$uri相同。
```


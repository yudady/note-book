# [browser-sync](http://www.browsersync.cn/)

## 安裝Browser-Sync
```
npm install -g browser-sync
```

## 使用Browser-Sync
### 静态网站
```
browser-sync start --server --files="**/*.css, **/*.js, **/*.jsp"
```
這行指令會在該目錄執行Browser-Sync，參數--server 會開啟一個mini-web server以裝載該目錄下的html檔，並用預設的網址-http://localhost:3000 以開啟瀏覽器。如果該目錄有一個index.html檔，則該mini-web server會將其當作首頁，開啟在瀏覽器中。


### 动态网站
如果您已经有其他本地服务器环境PHP或类似的，您需要使用代理模式
```
// 主机名可以是ip或域名
// 可以是公网上面域名
browser-sync start --proxy "主机名" "css/*.css"

cd workspace
browser-sync start --proxy "localhost:8080/myPay/" --files "**/*.css, **/*.js, **/*.jsp"
```


## 管理介面
另外，使用瀏覽器開啟網址http://localhost:3001(可以在command line視窗看到網址提示)，會開啟BrowserSync的管理介面。裡面有些選項可以設定，可以依據自己的需要去進行設定。
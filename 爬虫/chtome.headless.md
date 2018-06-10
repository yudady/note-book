# Chrome headless

1. [cdp4j  Chrome DevTools Protocol for Java](https://github.com/webfolderio/cdp4j)
2. selenium






### 先聊聊數據抓取技術選型
在我看來數據抓取可以分為三種場景：
- 基本穩定的源站格式或者大量的數據抓取、需要蜘蛛集群調度：使用Java比較方便，可以用WebMagic抓取配合Hadoop調度，如果源站經常改動用Java代碼實現頁面分析真的很蛋疼。
- 常規的一般頁面抓取：使用python妥妥的，腳本語言改動靈活，代碼簡單，而且相關類庫很多。
- 比較難抓的，有較強反扒措施的網站，比如網銀和現在比較流行的Vue、React：這些網站有的有瀏覽器插件，有的js和html混寫，很難靜態分析再模擬請求。只能使用真實的瀏覽器引擎動態解析頁面。

本文說的chrome headless就是針對比較難抓取的情況提出的一種新的解決方案。
將Chrome以無界面模式運行，開啟Chrome Remote Debugging，從外部進入Chrome內。之前有類似的PhantomJS、Selenium之類的東西，相比來說直接用原生Chrome兼容性更強，更通用。缺點都是抓取效率較低，動態抓取需要將頁面執行一遍再操作DOM抓取，不如模擬請求快。

### 環境搭建
Chrome從59版開始支持headless模式運行，不考慮Chromium，Chrome有四種版本：

- Stable 穩定版，最新版本：58
- Beta 測試版，最新版本：59
- Dev 開發版，最新版本：60
- Canary 金絲雀，最新版本：60（每天更新，只有Windows版）

如果你在本機開發，推薦使用Canary，它和已有的Chrome不在同一目錄下，可以共存。

我這裏配了一臺ubuntu Server虛擬機，註意Server版即可，不需要桌面環境。然後安裝了Chrome dev版。Ubuntu安裝Chrome參考：https://segmentfault.com/a/1190000007895508  。
如果像我一樣在虛擬機或遠程服務器上，安裝完把9222端口映射出來（起初我直接防火墻放開了9222端口的訪問，但是死活連不上，可能Chrome遠程調試限制了請求的IP只能是本機），我用的ssh訪問的虛擬機，所以直接用ssh把端口轉發出來，不詳述了。

### 關於Chrome Debugging Protocol
Chrome提供了websocket調試接口用於對當前Tab內頁面的DOM、網絡、性能、存儲等等進行調試，我們常用的開發者工具就是基於此接口，這個接口也支持遠程調用，在啟動參數中加上--remote-debugging-port=9222即可。

![Chrome開發者工具](https://static.oschina.net/uploads/img/201705/01144211_lGPX.png "Chrome開發者工具")

遠程調試還提供了一個JSON接口，用於管理瀏覽器的Tab頁面。

### 跑起來

#### 啟動Chrome
如果在遠程服務器上建議在screen裏運行，一個小工具防止網絡突然中斷。
```
$ screen -S chrome
```
然後會打開一個新的shell，可以用 Ctrl + A + D切出來，或者斷開SSH直接切出來。再進去只需要執行：
```
$ screen -r chrome
```
然後在screen裏面的shell執行（本機Windows調試把Google-chrome-unstable換成chrome.exe）：
```
$ google-chrome-unstable --headless --remote-debugging-port=9222 --user-data-dir='/home/luke/chrome-data/baidu' --user-agent='Mozilla/5.0 (X11; linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3080.5 Safari/537.36'

```
解釋下參數：
- --headless：無頭模式，就是無界面模式運行
- --remote-debugging-port：開啟遠程調試，端口9222和我們之前轉發出來的端口一致
- --user-data-dir：設置獨立的文件保存目錄，建議一個網站一個目錄
- --user-agent：偽裝瀏覽器，默認User-Agent裏的瀏覽器叫HeadlessChrome，很容易被發現

#### 連接調試端口
我們說過遠程調試接口是一個WebSocket的接口，Chrome提供的開發者工具是一種客戶端，我們自己寫代碼調用也是一種客戶端。今天我們先用開發者工具測試，下篇我會寫代碼來實現。
在本地瀏覽器打開：http://服務器IP:9222/json ，本機測試的話就是 http://127.0.0.1:9222/json  。我已經用SSH把服務器的9222轉發到本機的9222了，這是效果：

![連接調試端口](https://static.oschina.net/uploads/img/201705/01151344_j3Aa.png "連接調試端口")

這裏列出了當前遠程瀏覽器內打開的Tab，每個頁面一個UUID用以識別。已知接口：
- http://127.0.0.1:9222/json ：查看已經打開的Tab列表
- http://127.0.0.1:9222/json/version : 查看瀏覽器版本信息
- http://127.0.0.1:9222/json/new?http://www.baidu.com : 新開Tab打開指定地址
- http://127.0.0.1:9222/json/close/ac5a6adb-bb53-44f1-a9e6-2354bd724924 : 關閉指定Tab
- http://127.0.0.1:9222/json/activate/69301801-d503-42a3-9335-3e448a780857 : 切換到目標Tab

### 抓取百度

#### 遠程打開
我們新開一個Tab打開百度首頁，然後刷新Tab列表，可以看到百度已經打開了：

![百度Tab](https://static.oschina.net/uploads/img/201705/01152557_oMqc.png "百度Tab")

註意到，有一個devtoolsFrontendUrl，那就是開發者工具的前端地址，就是一個html應用，url裏面傳過去WebSocket調試地址。打開這個地址就可以看到熟悉的開發者工具了！註意：這個窗口調試的是遠程chrome上的頁面。

![百度首頁](https://static.oschina.net/uploads/img/201705/01153019_8Doj.png "百度首頁")

如果你想看看頁面在遠程服務器的Chrome裏渲染的結果，在開發者工具裏切換到Performance，勾選Screenshots，點刷新圖標，重新加載完成就可以看到逐幀加載的截圖。

#### 遠程操作DOM
思路：我們在Elements裏面找到輸入框的ID，使用JQuery操作。百度首頁已經有JQuery了，其他網站我們可以在Console裏執行JS，加載一個。
我們切換到Console裏直接用JS操作DOM，執行：
```
$("input[name='wd']").val('測試');
$("form.fm").submit();
```
相當於在百度輸入框裏輸入了測試並點擊了“百度一下”按鈕。

![JS操作DOM](https://static.oschina.net/uploads/img/201705/01154210_paJc.png "JS操作DOM")

現在再打開http://127.0.0.1:9222/json ，可以看到原來的頁面標題已經變成了“測試_百度搜索”，也就說明成功完成了搜索。

#### 獲取搜索結果
依然是在Elements裏面找到結果列表的ID，然後用JS獲取內容。
獲得結果數量：
```
console.log($("#container").find(".nums").text());
```
獲得所有結果標題：
```
$("#container").find(".c-container").each(function(){console.log($(this).find("h3.t").text())});
```

![獲取搜索結果](https://static.oschina.net/uploads/img/201705/01154750_NZsV.png "獲取搜索結果")

獲取其他內容都一樣，不再演示。

### 總結
這篇文章展示了調用遠程Headless模式的Chrome做頁面抓取，也可以用來做自動化測試，另外對於android版Chrome同樣支持遠程調試！下篇文章將通過代碼直接調用WebSocket接口。

#### 一些提示
- 用JQuery操作遠程頁面DOM可以先在本機打開目標頁面做調試，用元素選取器更方便快速定位DOM。
- Server版Ubuntu一般沒有中文字體，看到的遠程截圖中文都是方塊，但是我們也不需要截圖，有需要請自行安裝Windows上的字體以保持一致性。

#### 參考鏈接
- Chrome Debugging Protocol https://chromedevtools.github.io/debugger-protocol-viewer/1-2/ 
- Chrome Headless模式 https://github.com/yesvods/Blog/issues/10 
- Chrome Debugging Protocol interface for Node.js  https://github.com/cyrus-and/chrome-remote-interface




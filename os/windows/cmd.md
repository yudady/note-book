
# windows cmd path
```
echo 當前盤符：%~d0
echo 當前盤符和路徑：%~dp0
echo 當前批處理全路徑：%~f0
echo 當前盤符和路徑的短文件名格式：%~sdp0
echo 當前CMD默認目錄：%cd%
echo 目錄中有空格也可以加入""避免找不到路徑
echo 當前盤符："%~d0"
echo 當前盤符和路徑："%~dp0"
echo 當前批處理全路徑："%~f0"
echo 當前盤符和路徑的短文件名格式："%~sdp0"
echo 當前CMD默認目錄："%cd%"
```












## 調整在 Windows下的 Congestion window size

先在CMD輸入

1. netsh interface tcp show supplemental

> 如果找不到指令的話，可以安裝這個Patch：Windows Server 2008 R2 Netsh擴充包


TCP 全域預設範本是 internet
 
TCP 補充性參數
----------------------------------------------
最小 RTO (毫秒)                     : 300
初始壅塞窗口 (MSS)                  : 2
延遲認可逾時 (毫秒) 

從這邊可以看到CWND(MSS)是設在2，這個大小有點不太夠用，所以我們要把它改成10

supplemetal設定提供兩種版本，一個是預設的internet，另一個是自訂的custom

先將custom中的CWND設成10


netsh interface tcp set supplemental template=custom icw=10

然後直接套用custom的設定

netsh interface tcp set supplemental template=custom

最後再看看有沒有設定成功

netsh interface tcp show supplemental
```
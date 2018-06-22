# VMWare CentOS 6 Clone 重設網卡MAC

https://dotblogs.com.tw/ghoseliang/2012/10/29/79721

1. 備份或刪除檔案：mv ifcfg-eth* ifcfg-eth*.bak
2. 編輯：vim /etc/udev/rules.d/7*-persistent-net.rules


將衝突的網卡資訊內容刪除或註解，然後重新啟動機器。

系統會偵測網卡，重新產生新的設定資訊。
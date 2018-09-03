# 原來Win10電腦能這樣備份驅動，根本不需要其他工具軟體！

1、首先，按Win+R鍵打開運行框，輸入```cmd``` 回車打開；
![](https://i2.kknews.cc/SIG=2i3rusj/qqp00085pp84n0q3751.jpg)


2、在「命令提示符」里，輸入：```dism /online /export-driver /destination:D:\MyDrivers``` ，等備份完成即可。

![](https://i2.kknews.cc/SIG=24hear1/r51000051599941558r.jpg)


3、如果想恢復驅動，可以在「命令提示符」里輸入 ```Dism /online /Add-Driver /Driver:D:\MyDrivers /Recurse``` 即可。

![](https://i1.kknews.cc/SIG=2t7ajbb/qqr000633n27311o87o.jpg)
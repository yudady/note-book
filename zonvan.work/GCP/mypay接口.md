# 接口

## oracle
ALTER USER myPay IDENTIFIED BY myPay4Zv;

ALTER USER mypaycenter IDENTIFIED BY myPay4Zv;
CREATE USER mypaycenter  IDENTIFIED BY myPay4Zv;
grant all privileges to mypaycenter;

## server
zip -r order.zip order

zip -r myPayCenter.zip myPayCenter

zip -r myPay.zip myPay


myPayCenter zonvan / Zonvan123
myPay   zonpay	/ mypay@zonvan



外网IP  35.234.55.141	
内网IP  10.140.0.195



payment-test

myPay / mypaycenter	/ myPay4Zv

http://35.234.55.141/myPayNotifyCenter/monitor.jsp


## 主机登入

rd
http://35.234.55.141/rd/admin/index.jsp#ajax/orderListMgmt.jsp          
    zonvan / Zonvan123


myPay
http://35.234.55.141/myPay/admin/index.jsp#ajax/merchantMgmt.jsp        
    zonpay	/   mypay@zonvan
    tommy   /   Tommy123


http://35.234.55.141/order/pc/index.jsp  订单


http://35.234.55.141/order/pc/odr.jsp?pageId=545


PY_MYPAY_MERCHANT  =>   IIH001  =>   ORDER_PAGE_ID = 415


415
36cL0Pp8N50SM2v6357g51ww9v3f667QbrNul68SA0q54e0425301B4StT0S



mypayCenter source code in => test folder
CallbackAlwaysSuccessController.class
QueryMyPayOrderController.class




測試送單的網址ip 35.234.55.141 改成用 testapi.mypay2.com



```
<servlet>
    <servlet-name>MypayPlatformController</servlet-name>
    <servlet-class>com.zonpay.platform.servlet.MypayPlatformController</servlet-class>

    <!-- <init-param>
        <param-name>server</param-name>
        <param-value>rd</param-value>
    </init-param> -->
    <init-param>
        <param-name>isFormalENV</param-name>
        <param-value>false</param-value>
    </init-param>
</servlet>
```


myPay接口测试
测试主机
http://testapi.mypay2.com/order
http://testapi.mypay2.com/myPay
http://testapi.mypay2.com/rd
http://testapi.mypay2.com/myPayDemoCallback
http://testapi.mypay2.com/myPayNotifyCenter
-------------------------------
测试送出订单网址
http://mypay.mypay1.com/myPayDemo
资料会送到接口测试主机

rd
http://testapi.mypay2.com/rd/admin/login.jsp  
    zonvan / Zonvan123


myPay
http://testapi.mypay2.com/myPay/admin/login.jsp       
    zonpay	/   mypay@zonvan


http://testapi.mypay2.com/myPayNotifyCenter/monitor.jsp













# Tomcat BIO 、NIO 、AIO(NIO.2) 比較


## Java對BIO、NIO、AIO的支持：

1. Java BIO ： 同步並阻塞，服務器實現模式為一個連接一個線程，即客户端有連接請求時服務器端就需要啟動一個線程進行處理，如果這個連接不做任何事情會造成不必要的線程開銷，當然可以通過線程池機制改善。
2. Java NIO ： 同步非阻塞，服務器實現模式為一個請求一個線程，即客户端發送的連接請求都會註冊到多路複用器上，多路複用器輪詢到連接有I/O請求時才啟動一個線程進行處理。
3. Java AIO(NIO.2) ： 異步非阻塞，服務器實現模式為一個有效請求一個線程，客户端的I/O請求都是由OS先完成了再通知服務器應用去啟動線程進行處理

##BIO、NIO、AIO適用場景分析:

1. BIO方式適用於連接數目比較小且固定的架構，這種方式對服務器資源要求比較高，併發侷限於應用中，JDK1.4以前的唯一選擇，但進程直觀簡單易理解。
2. NIO方式適用於連接數目多且連接比較短（輕操作）的架構，比如聊天服務器，併發侷限於應用中，編程比較複雜，JDK1.4開始支持。
3. AIO方式使用於連接數目多且連接比較長（重操作）的架構，比如相冊服務器，充分調用OS參與併發操作，編程比較複雜，JDK7開始支持。




## tomcat 的 bio、nio、apr 模式

### bio
> bio(blocking I/O)，顧名思義，即阻塞式I/O操作，表示Tomcat使用的是傳統的Java I/O操作(即java.io包及其子包)。Tomcat在默認情況下，就是以bio模式運行的。遺憾的是，就一般而言，bio模式是三種運行模式中性能最低的一種。我們可以通過Tomcat Manager來查看服務器的當前狀態。

### nio
> 是Java SE 1.4及後續版本提供的一種新的I/O操作方式(即java.nio包及其子包)。Java nio是一個基於緩衝區、並能提供非阻塞I/O操作的Java API，因此nio也被看成是non-blocking I/O的縮寫。它擁有比傳統I/O操作(bio)更好的併發運行性能。

### apr
> (Apache Portable Runtime/Apache可移植運行庫)，是Apache HTTP服務器的支持庫。你可以簡單地理解為，Tomcat將以JNI的形式調用Apache HTTP服務器的核心動態鏈接庫來處理文檔讀取或網絡傳輸操作，從而大大地提高Tomcat對靜態文檔的處理性能。 Tomcat apr也是在Tomcat上運行高併發應用的首選模式。


## tomcat管理界面配置起來，以便等下能更方便的觀察我們的bio、nio、apr 模式
```
vim /usr/local/apache-tomcat-7.0.47/conf/tomcat-users.xml
<role rolename="manager-gui"/>       
<user username="tomcat" password="15715746746" roles="manager-gui"/>

bio server.xml 配置 （重啟生效）
    <Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />


nio server.xml 配置 （重啟生效）
    <Connector port="8080" protocol="org.apache.coyote.http11.Http11NioProtocol"
               connectionTimeout="20000"
               redirectPort="8443" />

apr server.xml 配置 （重啟生效）
    <Connector port="8080" protocol="org.apache.coyote.http11.Http11AprProtocol"
               connectionTimeout="20000"
               redirectPort="8443" />

```
> 安裝完後記得在 /etc/profile 的JAVA變量後面多加一條APR的環境變量

### 設置環境變量
```
JAVA_HOME=/usr/local/java
JAVA_BIN=$JAVA_HOME/bin
PATH=$PATH:$JAVA_BIN
CLASSPATH=$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/apr/lib 
```








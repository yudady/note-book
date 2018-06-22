# TCP状态转移要点
> 
    TCP协议规定，对于已经建立的连接，网络双方要进行四次握手才能成功断开连接，如果缺少了其中某个步骤，将会使连接处于假死状态，连接本身占用的资源不会被释放。网络服务器程序要同时管理大量连接，所以很有必要保证无用连接完全断开，否则大量僵死的连接会浪费许多服务器资源。在众多TCP状态中，最值得注意的状态有两个：CLOSE_WAIT和TIME_WAIT。  


1. LISTENING状态
　　FTP服务启动后首先处于侦听（LISTENING）状态。
2. ESTABLISHED状态
　　ESTABLISHED的意思是建立连接。表示两台机器正在通信。
3. CLOSE_WAIT
    对方主动关闭连接或者网络异常导致连接中断，这时我方的状态会变成CLOSE_WAIT 此时我方要调用close()来使得连接正确关闭
4. TIME_WAIT
    我方主动调用close()断开连接，收到对方确认后状态变为TIME_WAIT。TCP协议规定TIME_WAIT状态会一直持续2MSL(即两倍的分段最大生存期)，以此来确保旧的连接状态不会对新连接产生影响。处于TIME_WAIT状态的连接占用的资源不会被内核释放，所以作为服务器，在可能的情况下，尽量不要主动断开连接，以减少TIME_WAIT状态造成的资源浪费。

```
netstat -na | grep 192.168.0.30 | grep LISTENING | wc -l
netstat -na | grep 192.168.0.30 | grep ESTABLISHED | wc -l
netstat -na | grep 192.168.0.30 | grep CLOSE_WAIT | wc -l
netstat -na | grep 192.168.0.30 | grep TIME_WAIT | wc -l

```

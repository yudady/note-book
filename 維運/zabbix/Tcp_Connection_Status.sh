#!/bin/bash
#This script is used to get tcp and udp connection status!
#by Justin Peng
#2016-10-26
Tcp_Status=$1
Tmp_File=/tmp/Tcp_Status.txt
/bin/netstat -an|awk '/^tcp/{++S[$NF]}END{for(a in S) print a,S[a]}' > $Tmp_File
case $Tcp_Status in
     TIME_WAIT)
              num=`awk '/TIME_WAIT/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     CLOSE_WAIT)
              num=`awk '/CLOSE_WAIT/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     SYN_SENT)
              num=`awk '/SYN_SENT/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     ESTABLISHED)
              num=`awk '/ESTABLISHED/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     FIN_WAIT2)
              num=`awk '/FIN_WAIT2/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     LISTEN)
              num=`awk '/LISTEN/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     SYN-RECEIVED)
              num=`awk '/SYN-RECEIVED/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     FIN-WAIT-1)
              num=`awk '/FIN-WAIT-1/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     CLOSING)
              num=`awk '/CLOSING/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     LAST-ACK)
              num=`awk '/LAST-ACK/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     CLOSED)
              num=`awk '/CLOSED/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
     UNKNOWN)
              num=`awk '/UNKNOWN/ {print $NF}' $Tmp_File`
              if [ -z $num ];then
                 echo 0
              else
                 echo $num
              fi
              ;;
           *)
             echo -e "\033[31m Usage:$0 [TIME_WAIT|CLOSE_WAIT|SYN_SENT|ESTABLISHED|FIN_WAIT2|LISTEN|SYN-RECEIVED|FIN-WAIT-1|CLOSING|LAST-ACK|CLOSED|UNKNOWN]\033[0m"
            ;;
esac


/*



LISTEN：侦听来自远方的TCP端口的连接请求

SYN-SENT：再发送连接请求后等待匹配的连接请求（如果有大量这样的状态包，检查是否中招了）

SYN-RECEIVED：再收到和发送一个连接请求后等待对方对连接请求的确认（如有大量此状态，估计被flood***了）

ESTABLISHED：代表一个打开的连接/当前并发连接数

FIN-WAIT-1：等待远程TCP连接中断请求，或先前的连接中断请求的确认

FIN-WAIT-2：从远程TCP等待连接中断请求

CLOSE-WAIT：等待从本地用户发来的连接中断请求

CLOSING：等待远程TCP对连接中断的确认

LAST-ACK：等待原来的发向远程TCP的连接中断请求的确认（不是什么好东西，此项出现，检查是否被***）

TIME-WAIT：等待足够的时间以确保远程TCP接收到连接中断请求的确认

CLOSED：没有任何连接状态。

被监控端：




Zabbix agent 端
[root@localhost etc]# vim ../etc/zabbix_agentd.conf
# Mandatory: no
# Range: 0-1
# Default:
UnsafeUserParameters=1
UserParameter=tcp.status[*],/usr/local/zabbix/etc/Tcp_Connection_Status.sh $1
[root@localhost etc]# service zabbix_agentd restart






Zabbix server 端
命令行测试
[root@Zabbix_Server ~]# /app/zabbix/bin/zabbix_get -s 10.10.55.41 -k tcp.status[TIME_WAIT]
1727
[root@Zabbix_Server ~]# /app/zabbix/bin/zabbix_get -s 10.10.55.41 -k tcp.status[ESTABLISHED]
738
[root@Zabbix_Server ~]# /app/zabbix/bin/zabbix_get -s 10.10.55.41 -k tcp.status[CLOSE_WAIT]
105
[root@Zabbix_Server ~]#

*/
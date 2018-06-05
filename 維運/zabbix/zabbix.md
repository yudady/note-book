# zabbix 




> 安裝 yum install 參考官方文檔


## zabbix-agent 自定義用戶訊息
> 加載被監控的主機上面，然後到server端測試可不可以拿到值
![/etc/zabbix/zabbox_agented.conf](./images/2018-06-02_112506.png)
格式:UserParameter=[key][value] , key必須在zabbix全局唯一

> 在SERVER端（10.0.0.7）拿取客戶端（10.0.0.8）數據
zabbix_get -s 10.0.0.8 -k login-user


[powershell UnsafeUserParameters](http://my-fish-it.blogspot.com/2017/03/ss-zabbix-32-userparameter-windows.html)

[zabbix Windows-specific item keys](https://www.zabbix.com/documentation/3.4/manual/config/items/itemtypes/zabbix_agent/win_keys)

[zabbix agent所支持的所有KEY](http://blog.51cto.com/skykws8023/1619075)

---

# 自動化的3種方法

1. zabbix-agent主動註冊
2. zabbix-server自動發現
3. [zabbix API](https://www.zabbix.com/documentation/3.4/zh/manual/api/reference/host/create)


---


## Macros
[Macros supported by location](https://www.zabbix.com/documentation/3.4/manual/appendix/macros/supported_by_location)

[User macros](https://www.zabbix.com/documentation/3.4/manual/config/macros/usermacros)


# orabbix 监控 (zabbix-trapper)


[客户端自己提交数据给zabbix](http://www.ttlsa.com/zabbix/zabbix-trapper/)

[zabbix trapper方式监控](http://blog.51cto.com/ityunwei2017/1895003)









[zabbix通过orabbix和自定义脚本监控oracle数据库](https://blog.csdn.net/cuiyan1982/article/details/76889576)

[Zabbix利用Orabbix插件监控Oracle数据库(增强版)--里面有orabbix报错的处理方法](https://blog.csdn.net/cuiyan1982/article/details/77051318)

[orabbix 模板部分监控项取不到数据](https://blog.csdn.net/fengyingyuechou/article/details/75195978)

[zabbix学习笔记：zabbix监控oracle](https://blog.csdn.net/linux_player_c/article/details/53005347)















## zabbox-server ( orabbix agent )

systemctl status zabbix-server.service

## zabbix server conf(zabbix设定档)

![zabbix_server.conf](./images/2018-05-29_103000.png)



## zabbix 开启 （orabbix）

![zabbix （orabbix） ubuntu path](./images/2018-05-28_110231.png)

conf
    config.props -- 监测数据的设定档
    query.props -- sql (key)

![oracle自订sql查询.（orabbix）](./images/20180605101950133.png)


-- restart
systemctl restart orabbix.service



## windows 测试zabbix

> 进入zabbix目录(cd C:\zabbix)

```
// C槽目前剩下多少空间
zabbix_agentd.exe -t vfs.fs.size[C:,pfree]

zabbix_agentd.exe -t net.if.list

```

## linux 档案填充0

> for((i=0;i<=40;i++)); do echo `dd if=/dev/zero of=ouftffput${i}.dat  bs=1024M  count=1`; done

---

### ubuntu install zabbix-get command (192.168.0.30)
apt-get install zabbix-get

```
zabbix_get -s 127.0.0.1 -p 10050 -k "system.cpu.load[all,avg1]"
   Options
       -s, --host <host name or IP>
              Specify host name or IP address of a host.

       -p, --port <port number>
              Specify  port  number  of  agent running on the host. Default is
              10050.

       -I, --source-address <IP address>
              Specify source IP address.

       -k, --key <item key>
              Specify key of item to retrieve value for.

       -h, --help
              Display this help and exit.

       -V, --version
              Output version information and exit.

EXAMPLES
       zabbix_get -s 127.0.0.1 -p 10050 -k "system.cpu.load[all,avg1]"
```

zabbix_get -s 127.0.0.1 -p 10050 -k "vfs.fs.size[/,pfree]"


### line notify()
/usr/lib/zabbix/alertscripts/line_notify.sh

```
#!/bin/bash
messages=`echo $3 | tr '\r\n' '\n'`
subject=`echo $2 | tr '\r\n' '\n'`

curl https://notify-api.line.me/api/notify -H "Authorization: Bearer uzufzMO4oOUClwVk6QieufFiRjIwev6etY5GlfuNRXx" -d "message=${subject}-${messages}" >>/tmp/sendline.log 2>&1

```




### mail notify
```
#!/bin/bash
messages=`echo $3 | tr '\r\n' '\n'`
subject=`echo $2 | tr '\r\n' '\n'`
echo "${messages}" | mailx -s "${subject}" $1 >>/tmp/sendmail.log 2>&1
```




### slack notify

```
#!/bin/bash

# Slack incoming web-hook URL and user name
url='https://hooks.slack.com/services/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'		# example: https://hooks.slack.com/services/QW3R7Y/D34DC0D3/BCADFGabcDEF123
username='@zonvanrd'
channel='#客戶主機監控zabbix'

## Values received by this script:
# To = $1 (Slack channel or user to send the message to, specified in the Zabbix web interface; "@username" or "#channel")
# Subject = $2 (usually either PROBLEM or RECOVERY/OK)
# Message = $3 (whatever message the Zabbix action sends, preferably something like "Zabbix server is unreachable for 5 minutes - Zabbix server (127.0.0.1)")

# Get the Slack channel or user ($1) and Zabbix subject ($2 - hopefully either PROBLEM or RECOVERY/OK)
to="$1"
subject="$2"

# Change message emoji depending on the subject - smile (RECOVERY/OK), frowning (PROBLEM), or ghost (for everything else)
recoversub='^RECOVER(Y|ED)?$'
if [[ "$subject" =~ ${recoversub} ]]; then
	emoji=':smile:'
elif [ "$subject" == 'OK' ]; then
	emoji=':smile:'
elif [ "$subject" == 'PROBLEM' ]; then
	emoji=':frowning:'
else
	emoji=':ghost:'
fi

# The message that we want to send to Slack is the "subject" value ($2 / $subject - that we got earlier)
#  followed by the message that Zabbix actually sent us ($3)
message="${subject}: $3"

# Build our JSON payload and send it as a POST request to the Slack incoming web-hook URL
payload="payload={\"$channel\": \"${to//\"/\\\"}\", \"$username\": \"${username//\"/\\\"}\", \"text\": \"${message//\"/\\\"}\", \"$icon_emoji\": \"${emoji}\"}"
curl -m 5 --data-urlencode "${payload}" $url -A 'zabbix-slack-alertscript / https://github.com/ericoc/zabbix-slack-alertscript'

```

















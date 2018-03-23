# zibbox

## windows 测试zabbix

> 进入zabbix目录(cd C:\zabbix)

```
// C槽目前剩下多少空间
zabbix_agentd.exe -t vfs.fs.size[C:,pfree]
```

## linux 

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




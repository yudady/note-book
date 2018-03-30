# SSH免密码

## 先产生RSA  key pair
```
$ ssh-keygen
在user/.ssh/  下面产生了3个档案，

1. id_rsa(私钥)
2. id_rsa.pub(公钥)

$ cd /c/Users/yu_da/.ssh/
// 把pub.key复制到SERVER端
> ssh-copy-id -i id_rsa.pub root@192.168.0.21

// 免密码登入
ssh -l root 192.168.0.21
ssh -l root 192.168.0.23

```

# IDEA 默认会在用户文件夹创建配置目录


## 迁移 {用户目录}/.IntelliJIdea2018.1 文件夹到 D:/Java/JetBrains/.IntelliJIdea2018.1

## 修改 {IDEA目录}/bin/idea.properties 文件的内容如下：

1. idea.config.path=D:/Java/JetBrains/.IntelliJIdea2018.1/config
2. idea.system.path=D:/Java/JetBrains/.IntelliJIdea2018.1/system
3. idea.plugins.path=${idea.config.path}/plugins
4. idea.log.path=${idea.system.path}/log

重启搞定。
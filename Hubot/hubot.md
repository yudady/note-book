

## 安装hubot

```
npm install -g hubot coffee-script yo generator-hubot
```

### 使用 yo 產生機器人
```
mkdir zz
cd zz
yo hubot

slack
```


bin\hubot ping


## hubot-slack
npm install hubot-slack --save
环境变量： 
HUBOT_SLACK_TOKEN


HUBOT_SLACK_TOKEN=YOUR_SLACK_API_TOKEN_HERE ./bin/hubot --adapter slack
HUBOT_SLACK_TOKEN=xoxb-395797895520-395801929776-2cLWVYnqxUOoLKRqk248vrrH ./bin/hubot --adapter slack

## hubot-jenkins 
npm install hubot-jenkins --save

环境变量： 
HUBOT_JENKINS_URL       http://192.168.0.21:18080/jenkins/
HUBOT_JENKINS_AUTH 
（Auth的格式为  jenkins:jenkins@zonvan）

## npm install hubot-script-shellcmd






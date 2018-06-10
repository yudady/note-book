# 告警



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

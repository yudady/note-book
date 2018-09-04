#!/bin/bash
# 检查硬碟空间


ALERT=80	#超过这个值，会寄mail
MY_MAIL="yudady@gmail.com"

df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output;
do
  echo $output
  usep=$(echo $output | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo $output | awk '{ print $2 }' )
  if [ $usep -ge $ALERT ]; then
    echo "Running out of space \"$partition ($usep%)\" on $(hostname) as on $(date)" |
     mail -s "Alert: (192.168.0.22)Almost out of disk space $usep%" $MY_MAIL
  fi
done












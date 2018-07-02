#!/bin/bash
diskUsed=`echo $(df -H | grep sda1 | awk '{print $5}' | grep -o '[0-9]\+')` ;echo $(echo "100.0 - $diskUsed"|bc) ;



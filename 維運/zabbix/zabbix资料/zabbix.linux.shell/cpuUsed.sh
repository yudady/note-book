#!/bin/bash
cpuUsed=`echo $(mpstat -P ALL | grep all | awk '{print $13}')` ;echo $(echo "100.0 - $cpuUsed"|bc) ;

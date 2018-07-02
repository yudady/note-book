#!/bin/bash
netstat -na | grep 192.168.0.30 | grep TIME_WAIT | wc -l

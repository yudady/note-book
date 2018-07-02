#!/bin/bash
netstat -na | grep 192.168.0.30 | grep ESTABLISHED | wc -l

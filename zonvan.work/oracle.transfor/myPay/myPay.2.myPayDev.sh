#/bin/bash

export NLS_LANG="TRADITIONAL CHINESE_TAIWAN.ZHT16MSWIN950"

echo "定义目录"
currentFolder=$(pwd)
targetDay=$(date +"%Y-%m-%d_%H-%M-%S")
backUpFolder="/d/oracle.bak/myPay"
currentBackUpFolder="${backUpFolder}/$targetDay"

mkdir -p $currentBackUpFolder

echo "确认目录"
echo "currentFolder = $currentFolder"
echo "currentBackUpFolder = $currentBackUpFolder"

echo "定义备份文件"
dumpFile="${currentBackUpFolder}/myPay.$targetDay.dmp"
expLogFile="${currentBackUpFolder}/myPay.$targetDay.exp.log"
impLogFile="${currentBackUpFolder}/myPay.$targetDay.imp.log"
echo "dumpFile = $dumpFile"
echo "expLogFile = $expLogFile"
echo "impLogFile = $impLogFile"

echo "开始导出myPay"
exp myPay/myPay4Zv@o11g file=$dumpFile log=$expLogFile owner=myPay INDEXES=n STATISTICS=none
ping 127.0.0.1
echo "导出myPay结束"

echo "把myPayDev使用者删除"
sh "${currentFolder}/drop.myPayDev.table.sh"
ping 127.0.0.1

echo "把myPay倒入myPayDev"
imp myPayDev/myPay4Zv@o11g file=$dumpFile log=$impLogFile fromuser=myPay touser=myPayDev INDEXES=n STATISTICS=none
ping 127.0.0.1


echo "变更myPayDev数据"
sh "${currentFolder}/myPayDev.init.sh"
echo "end"
echo "end"
echo "end"
echo "end"







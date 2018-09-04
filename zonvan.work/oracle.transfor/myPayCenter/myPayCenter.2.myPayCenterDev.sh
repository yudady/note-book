#/bin/bash

export NLS_LANG="TRADITIONAL CHINESE_TAIWAN.ZHT16MSWIN950"

echo "定义目录"
currentFolder=$(pwd)
targetDay=$(date +"%Y-%m-%d_%H-%M-%S")
backUpFolder="/d/oracle.bak/myPayCenter"
currentBackUpFolder="${backUpFolder}/$targetDay"

mkdir -p $currentBackUpFolder

echo "确认目录"
echo "currentFolder = $currentFolder"
echo "currentBackUpFolder = $currentBackUpFolder"

echo "定义备份文件"
dumpFile="${currentBackUpFolder}/myPayCenter.$targetDay.dmp"
expLogFile="${currentBackUpFolder}/myPayCenter.$targetDay.exp.log"
impLogFile="${currentBackUpFolder}/myPayCenter.$targetDay.imp.log"
echo "dumpFile = $dumpFile"
echo "expLogFile = $expLogFile"
echo "impLogFile = $impLogFile"

echo "开始导出myPayCenter"
exp myPayCenter/myPay4Zv@o11g file=$dumpFile log=$expLogFile owner=myPayCenter INDEXES=n STATISTICS=none
ping 127.0.0.1
echo "导出myPayCenter结束"

echo "把myPayCenterDev使用者删除"
sh "${currentFolder}/drop.myPayCenterDev.table.sh"
ping 127.0.0.1

echo "把myPayCenter倒入myPayCenterDev"
imp myPayCenterDev/myPay4Zv@o11g file=$dumpFile log=$impLogFile fromuser=myPayCenter touser=myPayCenterDev INDEXES=n STATISTICS=none
ping 127.0.0.1


echo "变更myPayCenterDev数据"
sh "${currentFolder}/myPayCenterDev.init.sh"
echo "end"
echo "end"
echo "end"
echo "end"







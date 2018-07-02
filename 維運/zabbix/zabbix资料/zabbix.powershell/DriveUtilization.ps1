#################################################################################  
##Disk size on windows server
## Created by Prashant Dev Pandey  
## Date : 21 NOV 2016  
## Version : 1.0  
## Email: pdppandey@hotmail.com    
## This scripts check disk utilization and give the MediaType,Size(GB),Free Space(GB),Free (%)
################################################################################ 

$disk=@()
$disk=Get-WmiObject Win32_logicaldisk -ComputerName LocalHost -Filter "DriveType=3"  `
| Format-Table DeviceID, MediaType, `
@{Name="Size(GB)";Expression={[decimal]("{0:N0}" -f($_.size/1gb))}}, `
@{Name="Free Space(GB)";Expression={[decimal]("{0:N0}" -f($_.freespace/1gb))}}, `
@{Name="Free (%)";Expression={"{0,6:P0}" -f(($_.freespace/1gb) / ($_.size/1gb))}} `
-AutoSize
$disk

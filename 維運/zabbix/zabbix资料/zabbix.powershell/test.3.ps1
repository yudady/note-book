$strComputer = "."
$Disks = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType = 3"`
  -ComputerName $strComputer

foreach ($Disk in $Disks)
{
    $ID = "磁碟機代碼：{0}" -f $Disk.DeviceID
    $Label = "磁碟機名稱：{0}" -f $Disk.VolumeName
    $Size = "磁碟機大小：{0:0.0} GB" -f ($Disk.Size / 1GB)
	$FreeSpace = "剩餘的空間：{0:0.0} GB" -f ($Disk.FreeSpace / 1GB)
	$Used = ([int64]$Disk.size - [int64]$Disk.FreeSpace)
	$SpaceUsed = "已用的空間：{0:0.0} GB" -f ($Used / 1GB)
	$Percent = ($Used * 100.0)/$Disk.Size
	$Percent = "{0:N0}" -f (100 - $Percent) #已用的比例


	"$Percent"
}
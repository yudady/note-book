Get-WmiObject win32_logicaldisk | select-object DeviceID, VolumeName,Size,FreeSpace | findstr "C:" # | %{$_.split()[1]}
# Get-WmiObject win32_logicaldisk | select-object FreeSpace |%{$_.split()[0]}

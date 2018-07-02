$content = Get-Service | Where-Object {$_.Status -eq "Stopped" -and $_.Name -eq "gpsvc"}
if (
    ($content | Select-String -InputObject {$_.Status} -Pattern "Stopped").ToString() -match "Stopped"
) {
    Write-Host "0"
}
else {
    Write-Host "1"
}
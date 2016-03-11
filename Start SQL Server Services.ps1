#http://ss64.com/ps/stop-service.html
#https://4sysops.com/archives/managing-services-the-powershell-way-part-3/

Get-Service "*SQL*" | Sort-Object {$_.Status, $_.Name}
Get-Service "*SQL*" | Where {$_.Status -eq 'Stopped'} | foreach { Start-Service $_.Name -PassThru; Start-Service $_.DependentServices -PassThru}
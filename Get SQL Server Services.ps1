#Set-ExecutionPolicy Unrestricted

Get-Service "*SQL*" | Sort-Object {$_.Status, $_.Name}


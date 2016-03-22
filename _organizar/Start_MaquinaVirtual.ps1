Set-ExecutionPolicy Unrestricted

$env:Path += ";C:\Program Files\Oracle\VirtualBox"

$wmi = Get-WmiObject -Class Win32_NetworkAdapter -filter "Name LIKE '%VirtualBox Host%'"
$wmi.enable()

VBoxManage startvm "Windows XP com IE6"
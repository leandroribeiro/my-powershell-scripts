Set-ExecutionPolicy Unrestricted

$wmi = Get-WmiObject -Class Win32_NetworkAdapter -filter "Name LIKE '%VirtualBox Host%'"
$wmi.disable()
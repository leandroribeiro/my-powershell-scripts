#References: http://stackoverflow.com/questions/3487265/powershell-script-to-return-versions-of-net-framework-on-a-machine

Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
Get-ItemProperty -name Version,Release -EA 0 |
Where { $_.PSChildName -match '^(?!S)\p{L}'} |
Select PSChildName, Version, Release

# Reference: http://stackoverflow.com/questions/3487265/powershell-to-return-versions-of-net-framework-on-a-machine/3495491#3495491

Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
Get-ItemProperty -name Version -EA 0 |
Where { $_.PSChildName -match '^(?!S)\p{L}'} |
Select PSChildName, Version
<#

  STEPS:

  0. Put ;%ProgramFiles(x86)%\Git\cmd OR ;%ProgramFiles%\Git\cmd in YOUR PATH SETTINGS;
  
  FOLLOW THOSE INSTRUCTIONS BELOW:
  1. http://www.hanselman.com/blog/TowardsABetterConsolePSReadLineForPowerShellCommandLineEditing.aspx
  2. http://www.hanselman.com/blog/PromptsAndDirectoriesEvenBetterGitAndMercurialWithPowerShell.aspx
  2. http://markembling.info/2009/09/my-ideal-powershell-prompt-with-git-integration
  3. Put this file in %HOMEPATH%/Documents\WindowsPowerShell/
  
#>


Write-Host "Seja bem-vindo MESTRE, eu sou Jarvis =8]"
Write-Host ""

# Set GIT Path
$env:Path = $env:Path + ";C:\Program Files (x86)\Git\cmd"

Import-Module PsGet
Import-Module PSReadLine
Import-Module posh-git

Set-Alias go-sublime "C:\Program Files\Sublime Text 3\sublime_text.exe"
Set-Alias sublime "C:\Program Files\Sublime Text 3\sublime_text.exe"

Set-Alias go-mu "C:\Program Files (x86)\muCommander\muCommander.exe"

Set-Alias go-kee "c:\Tools\KeePass\KeePass.exe"
Set-Alias keepass "c:\Tools\KeePass\KeePass.exe"

Set-Alias sdelete "c:\Tools\SDelete\sdelete.exe"

function go-projetos
{
	set-location C:\Projetos\ 
}

function go-tools
{
	set-location C:\Tools\ 
}

Function my-get-volumes
{
	GET-WMIOBJECT win32_logicaldisk | FORMAT-TABLE
}

New-Alias Get-Volumes my-get-volumes

#----------------------------------------------------
#TOUCH LIKE UNIX
#Reference http://ss64.com/ps/syntax-touch.html
#New-Alias touch echo $null >>
function Set-FileTime{
  param(
	[string[]]$paths,
	[bool]$only_modification = $false,
	[bool]$only_access = $false
  );

  begin {
	function updateFileSystemInfo([System.IO.FileSystemInfo]$fsInfo) {
	  $datetime = get-date
	  if ( $only_access )
	  {
		 $fsInfo.LastAccessTime = $datetime
	  }
	  elseif ( $only_modification )
	  {
		 $fsInfo.LastWriteTime = $datetime
	  }
	  else
	  {
		 $fsInfo.CreationTime = $datetime
		 $fsInfo.LastWriteTime = $datetime
		 $fsInfo.LastAccessTime = $datetime
	   }
	}
   
	function touchExistingFile($arg) {
	  if ($arg -is [System.IO.FileSystemInfo]) {
		updateFileSystemInfo($arg)
	  }
	  else {
		$resolvedPaths = resolve-path $arg
		foreach ($rpath in $resolvedPaths) {
		  if (test-path -type Container $rpath) {
			$fsInfo = new-object System.IO.DirectoryInfo($rpath)
		  }
		  else {
			$fsInfo = new-object System.IO.FileInfo($rpath)
		  }
		  updateFileSystemInfo($fsInfo)
		}
	  }
	}
   
	function touchNewFile([string]$path) {
	  #$null > $path
	  Set-Content -Path $path -value $null;
	}
  }
 
  process {
	if ($_) {
	  if (test-path $_) {
		touchExistingFile($_)
	  }
	  else {
		touchNewFile($_)
	  }
	}
  }
 
  end {
	if ($paths) {
	  foreach ($path in $paths) {
		if (test-path $path) {
		  touchExistingFile($path)
		}
		else {
		  touchNewFile($path)
		}
	  }
	}
  }
}

New-Alias touch Set-FileTime
#----------------------------------------------------

# (Optional) Call default folder
go-projetos
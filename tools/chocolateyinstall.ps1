$ErrorActionPreference = 'Stop'; 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://download.microsoft.com/download/B/6/3/B63CAC7F-44BB-41FA-92A3-CBF71360F022/1033/x64/sqlncli.msi';
$checksum   = '012aca6cef50ed784f239d1ed5f6923b741d8530b70d14e9abcb3c7299a826cc'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  checksum       = $checksum
  checksumType   = 'sha256' 
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
#
Install-ChocolateyZipPackage @packageArgs 

  # Cygwin $env:TEMP is C:\tools\cygwin\tmp\chocolatey
  # Powershell $env:TEMP is C:\Users\tanner\AppData\Local\Temp
  #
  $installArgs = @{
    packageName    = $env:ChocolateyPackageName
    file           = Join-Path $toolsDir 'sqlncli.msi'
    fileType       = 'msi'
    silentArgs     = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).log`" ACCEPTSQLNCLILICENSETERMS=YES" 
    validExitCodes = @(0, 3010, 1641)
  }
  
  # https://chocolatey.org/docs/helpers-install-chocolatey-package
  #
  Install-ChocolateyInstallPackage @installArgs

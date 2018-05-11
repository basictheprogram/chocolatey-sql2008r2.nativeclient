$ErrorActionPreference = 'Stop'; 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/B/6/3/B63CAC7F-44BB-41FA-92A3-CBF71360F022/1033/x64/sqlncli.msi';
$checksum   = '012aca6cef50ed784f239d1ed5f6923b741d8530b70d14e9abcb3c7299a826cc'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = $url
  silentArgs     = "/qb /norestart /l*v `"$($env:TEMP)\$($packageName).log`" IACCEPTSQLNCLILICENSETERMS=YES" 
  validExitCodes = @(0, 3010, 1641)
  checksum       = $checksum
  checksumType   = 'sha256' 
}

# https://chocolatey.org/docs/helpers-install-chocolatey-package
#
Install-ChocolateyPackage @packageArgs


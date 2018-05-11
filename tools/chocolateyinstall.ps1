$ErrorActionPreference = 'Stop'; 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://go.microsoft.com/fwlink/?LinkID=188400&clcid=0x409'
$checksum   = '35c4b98f7f5f951cae9939c637593333c44aee920efbd4763b7bdca1e23ac335'
$url64bit   = 'https://go.microsoft.com/fwlink/?LinkID=188401&clcid=0x409'
$checksum64 = '012aca6cef50ed784f239d1ed5f6923b741d8530b70d14e9abcb3c7299a826cc'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'msi'
  url            = $url
  checksum       = $checksum
  checksumType   = 'sha256' 
  url64bit       = $url64bit
  checksum64     = $checksum64
  checksumType64 = 'sha256'
  silentArgs     = "/qb /norestart /l*v `"$($env:TEMP)\$($packageName).log`" IACCEPTSQLNCLILICENSETERMS=YES" 
  validExitCodes = @(0, 3010, 1641)
}

# https://chocolatey.org/docs/helpers-install-chocolatey-package
#
Install-ChocolateyPackage @packageArgs


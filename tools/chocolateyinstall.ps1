$ErrorActionPreference = 'Stop'; 

$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://download.microsoft.com/download/2/4/F/24FE862D-7D32-47F2-B91D-22DAFA270BBC/2008%20R2%20ENU-1033/x86/sqlncli.msi'
$checksum   = 'a9c754af47193bc836dc1e2c88b56177812320dccca5c85c204f00bee5780aee'
$url64bit   = 'https://download.microsoft.com/download/2/4/F/24FE862D-7D32-47F2-B91D-22DAFA270BBC/2008%20R2%20ENU-1033/x64/sqlncli.msi'
$checksum64 = '4296bbebd733db708ee53c3753e8c0d1208faf4d5ee8dcd1f2f149c986022994'

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


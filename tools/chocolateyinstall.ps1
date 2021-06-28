$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url = 'https://download.microsoft.com/download/2/4/F/24FE862D-7D32-47F2-B91D-22DAFA270BBC/2008%20R2%20ENU-1033/x86/sqlncli.msi'
$checksum = 'f01c4d4df7caebd0dd164b7a7ed978282535f3951cea523661f0d043c6775ca5'
$url64bit = 'https://download.microsoft.com/download/2/4/F/24FE862D-7D32-47F2-B91D-22DAFA270BBC/2008%20R2%20ENU-1033/x64/sqlncli.msi'
$checksum64 = '8222bebd63c2c79bdf0bfbcb614d43806799891d9348ff8da7df8f458a7f8bc6'

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


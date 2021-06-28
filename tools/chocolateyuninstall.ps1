$ErrorActionPreference = 'Stop';

# HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall
# HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\
#
$msiId = '{4AB6A079-178B-4144-B21F-4D1AE71666A2}'
$msiId64 = '{2180B33F-3225-423E-BBC1-7798CFD3CD1F}'
$packageName = 'SQL2008R2.NativeClient'

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName 'SQL Server 2008 R2 Native Client*'

if ($key.Count -eq 1) {
    $key | ForEach-Object {
        $packageArgs = @{
            packageName    = $packageName
            fileType       = 'MSI'
            silentArgs     = '/qb'
            validExitCodes = @(0)
            file           = "$($_.UninstallString)"
        }

        Uninstall-ChocolateyPackage @packageArgs
    }
}
elseif ($key.Count -eq 0) {
    Write-Warning "$packageName has already been uninstalled by other means."
}
elseif ($key.Count -gt 1) {
    Write-Warning "$($key.Count) matches found!"
    Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
    Write-Warning "Please alert package maintainer the following keys were matched:"
    $key | ForEach-Object { Write-Warning "- $($_.DisplayName)" }
}

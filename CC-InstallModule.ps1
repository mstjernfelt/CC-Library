if (!($env:PSModulePath.ToString().Contains($PSScriptRoot))){
    [environment]::SetEnvironmentVariable('PSModulePath',  $env:PSModulePath + ';' + $PSScriptRoot, 'Machine')
    $env:PSModulePath = $env:PSModulePath + ';' + $PSScriptRoot
}

Write-host "Loading Cosmo.Powershell.NAV..." -ForegroundColor Green
Import-module CC.Powershell.NAV.Utilities -Force 
#Part of Cosmo.Powershell.NAV.Service
function Load-NAV-Modules
{
    [CmdletBinding()]
    param
    (
    )
    process {
        Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | out-null
        Import-Module "$env:ProgramFiles\Microsoft Dynamics NAV\90\Service\NavAdminTool.ps1" -WarningAction SilentlyContinue | Out-Null
        Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1" -WarningAction SilentlyContinue | Out-Null
        Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | Out-Null

        Clear-Host
        Write-Host 'get-Command -Module 'Microsoft.Dynamics.Nav.*'' -ForeGroundColor Yellow
        get-Command -Module 'Microsoft.Dynamics.Nav.*'
        }
}


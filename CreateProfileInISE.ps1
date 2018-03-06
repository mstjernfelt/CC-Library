if (!(test-path $profile.AllUsersCurrentHost)) {
    new-item -type file -path $profile.AllUsersCurrentHost -force
} Else {
    write-warning 'Profile already existed. Code added at the end.'

    Add-Content -Value '' -Path $profile.AllUsersCurrentHost
    Add-Content -Value '' -Path $profile.AllUsersCurrentHost
    Add-Content -Value '### Added Cloud.Ready.Software-part ###' -Path $profile.AllUsersCurrentHost
    Add-Content -Value '' -Path $profile.AllUsersCurrentHost
}


$code = '
function prompt{
    $Currentlocation = (Get-Location).Path
    if ($Currentlocation.Length -le 15) {
        "$($Currentlocation)>>"
    } else {
        #$Currentlocation.Substring(0,3) + ".." + $Currentlocation.Substring($Currentlocation.lastIndexOf(''\''),$Currentlocation.Length - $Currentlocation.lastIndexOf(''\'')) + ">>"        
        "$($Currentlocation)
PS >"
    }   
}

$code =
{
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | out-null
 Import-Module "$env:ProgramFiles\Microsoft Dynamics NAV\110\Service\NavAdminTool.ps1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\110\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | Out-Null

 Clear-Host
 Write-Host ''get-Command -Module ''Microsoft.Dynamics.Nav.*'''' -ForeGroundColor Yellow
 get-Command -Module ''Microsoft.Dynamics.Nav.*''
}
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(''Load NAV 2018 NavAdminTool CmdLets'',$code,$null)

$code =
{
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | out-null
 Import-Module "$env:ProgramFiles\Microsoft Dynamics NAV\100\Service\NavAdminTool.ps1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\100\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | Out-Null

 Clear-Host
 Write-Host ''get-Command -Module ''Microsoft.Dynamics.Nav.*'''' -ForeGroundColor Yellow
 get-Command -Module ''Microsoft.Dynamics.Nav.*''
}
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(''Load NAV 2017 NavAdminTool CmdLets'',$code,$null)

$code =
{
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | out-null
 Import-Module "$env:ProgramFiles\Microsoft Dynamics NAV\90\Service\NavAdminTool.ps1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Apps.Tools.psd1" -WarningAction SilentlyContinue | Out-Null
 Import-Module "${env:ProgramFiles(x86)}\Microsoft Dynamics NAV\90\RoleTailored Client\Microsoft.Dynamics.Nav.Model.Tools.psd1" -WarningAction SilentlyContinue | Out-Null

 Clear-Host
 Write-Host ''get-Command -Module ''Microsoft.Dynamics.Nav.*'''' -ForeGroundColor Yellow
 get-Command -Module ''Microsoft.Dynamics.Nav.*''
}
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(''Load NAV 2016 NavAdminTool CmdLets'',$code,$null)

$code =
{
  Import-module (Join-Path ''' + $PSScriptRoot + ''' ''LoadModules.ps1'')  
}
$psISE.CurrentPowerShellTab.AddOnsMenu.Submenus.Add(''Load CC-Library CmdLets'',$code,$null)

'

Add-Content -Value $code -Path $profile.AllUsersCurrentHost

psEdit $profile.AllUsersCurrentHost
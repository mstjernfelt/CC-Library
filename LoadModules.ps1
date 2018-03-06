write-host 'Loading CC-Library CmdLets...'

Write-Progress -Activity 'Loading CC.Powershell.NAV.Utilities ...' -PercentComplete 12
Import-module (join-path $PSScriptRoot 'CC.Powershell.NAV.Utilities\CC.Powershell.NAV.Utilities.psm1') -DisableNameChecking -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
Import-module Powershell.NAV.Utilities -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue

Write-Progress -Activity 'Loading CC.Powershell.Azure.Utilities ...' -PercentComplete 12
Import-module (join-path $PSScriptRoot 'CC.Powershell.Azure.Utilities\CC.Powershell.Azure.Utilities.psm1') -DisableNameChecking -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue
Import-module Powershell.Azure.Utilities -Force -WarningAction SilentlyContinue -ErrorAction SilentlyContinue

write-host -ForegroundColor Yellow 'Get-Command -Module ''CC.Powershell.NAV*'''
get-command -Module 'CC.Powershell.NAV.*'
write-host -ForegroundColor Yellow 'Get-Command -Module ''CC.Powershell.Azure*'''
get-command -Module 'CC.Powershell.Azure.*'
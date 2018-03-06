Get-Item $PSScriptRoot | Get-ChildItem -Recurse -Include '*.ps1' |  Sort-Object Name | ForEach-Object {
    Write-Verbose "Loading $($_.Name)"  
    . $_.fullname
}

Export-ModuleMember -Function *
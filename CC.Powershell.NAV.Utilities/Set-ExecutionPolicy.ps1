#Part of Cosmo.Powershell.NAV.Service
function Set-ExecutionPolicy
{
    [CmdletBinding()]
    param
    (
    )
    process {
        #Set ExecutionPolicy to Unrestricted
        Set-ExecutionPolicy -ExecutionPolicy Unrestricted
    }
}


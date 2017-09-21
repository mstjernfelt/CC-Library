#Part of Cosmo.Powershell.NAV.Service
function CC-Set-ExecutionPolicy
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


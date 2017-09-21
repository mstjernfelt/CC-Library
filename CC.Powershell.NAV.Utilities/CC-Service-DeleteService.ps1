#Part of Cosmo.Powershell.NAV.Service
function CC-Service-DeleteService
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $NAVServiceName
    )
    process {
        sc.exe delete $NAVServiceName
    }
}


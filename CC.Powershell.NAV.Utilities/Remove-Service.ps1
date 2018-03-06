#Part of Cosmo.Powershell.NAV.Service
function Remove-Service
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


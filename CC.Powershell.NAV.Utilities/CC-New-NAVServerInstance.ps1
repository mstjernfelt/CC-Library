#Part of Cosmo.Powershell.NAV.Utilities
function CC-New-NAVServerInstance
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $ServerInstance,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $DatabaseInstance,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $DatabaseServer,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $DatabaseName,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $ManagementServicesPort = '7045',
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $ClientServicesPort = '7046',
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $SOAPServicesPort = '7047',
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $ODataServicesPort = '7048',
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyname=$true)]
        [System.Boolean]
        $EnablePortSharing = $false
    )
    process {
        # 2017-09-21 07:25:49
        New-NAVServerInstance -ServiceAccount '1' -ServerInstance $ServerInstance -ManagementServicesPort $ManagementServicesPort -ClientServicesPort $ClientServicesPort -SOAPServicesPort $SOAPServicesPort -ODataServicesPort $ODataServicesPort
        
        if ($DatabaseInstance -eq '') 
            {
            Set-NAVServerConfiguration $ServerInstance -KeyName 'DatabaseInstance'
            }
        elseif ($DatabaseInstance -ne $null) 
            {
            Set-NAVServerConfiguration $ServerInstance -KeyName 'DatabaseInstance' -KeyValue $DatabaseInstance
            }

        if ($DatabaseServer) 
            {
            Set-NAVServerAppConfiguration $ServerInstance -KeyName 'DatabaseServer' -KeyValue $DatabaseServer
            }

        if ($DatabaseName) 
            {
            Set-NAVServerConfiguration $ServerInstance -KeyName 'DatabaseName' -KeyValue $DatabaseName
            }

        if ($EnablePortSharing) 
            {
            CC-Serivce-Enable-PortSharing -ServerInstance $ServerInstance
            }
        else 
            {
            Set-NavServerInstance $ServerInstance -start        
            }
    }
}


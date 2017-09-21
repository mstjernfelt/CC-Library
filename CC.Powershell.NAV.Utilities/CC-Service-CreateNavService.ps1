#Part of Cosmo.Powershell.NAV.Service
function CC-Service-CreateNavService
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $NAVRootPath,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $NAVServiceName,
        #[Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        #[System.String]
        #$ServiceUserID,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $DatabaseServer,
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyname=$true)]
        [System.String]
        $DatabaseInstance
    )
    process {
        $NAVNewInstancePath = $NAVRootPath + $NAVServiceName

        $BaseNAVInstancePath = $NAVRootPath + 'Service\'

        if (!(Test-Path -Path $NAVNewInstancePath)) {
            Copy-Item $BaseNAVInstancePath $NAVNewInstancePath -Recurse
        }

        #Install new service
        #$credential = Get-Credential $ServiceUserID
        $FullNAVInstalceName = 'MicrosoftDynamicsNAVServer$' + $NAVServiceName 
        $BinaryPathName = '"' + $NAVNewInstancePath + '\Microsoft.Dynamics.Nav.Server.exe" $' + $NAVServiceName + ' config ' + '"' + $NAVNewInstancePath + '\Microsoft.Dynamics.NAV.Server.exe.config"'
        $DisplayName = 'Microsoft Dynamics NAV Server [' + $NAVServiceName + ']'

        New-Service $FullNAVInstalceName -BinaryPathName $BinaryPathName -DependsOn 'NetTcpPortSharing' -Description 'Service handling requests to Microsoft Dynamics NAV application.' -DisplayName $DisplayName -StartupType Manual #-Credential $credential

        #Update Config File
        Set-NAVServerConfiguration $NAVServiceName -KeyName DatabaseServer -KeyValue $DatabaseServer
        Set-NAVServerConfiguration $NAVServiceName -KeyName DatabaseInstance -KeyValue $DatabaseInstance
        Set-NAVServerConfiguration $NAVServiceName -KeyName DatabaseName -KeyValue $NAVServiceName
    }
}


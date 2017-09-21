function Get-NAVServerConfiguration2
{
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [String]$ServerInstance
    )
    BEGIN
    {
        $ResultObjectArray =  @()          
        
    }
    PROCESS
    {   
        $CurrentServerInstance = Get-NAVServerInstance -ServerInstance $ServerInstance
        $CurrentConfig = $CurrentServerInstance | Get-NAVServerConfiguration -AsXml
        
        foreach ($Setting in $CurrentConfig.configuration.appSettings.add)
        {
            $ResultObject = New-Object System.Object
            $ResultObject | Add-Member -type NoteProperty -name ServiceInstance -value $CurrentServerInstance.ServerInstance
            $ResultObject | Add-Member -type NoteProperty -name Key -value $Setting.Key
            $ResultObject | Add-Member -Type NoteProperty -Name Value -Value $Setting.Value
            $ResultObjectArray += $ResultObject
        }

    }
    END
    {
        $ResultObjectArray
    }
}

function Get-NAVServerInstance3
{
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position=0)]
        [System.String]
        $ServerInstance
    )
    
    process {
        $ServerInstanceObjects = Get-NAVServerInstance -ServerInstance $ServerInstance
        
        foreach ($ServerInstanceObject in $ServerInstanceObjects) {
            $ServerConfigKeys = Get-NAVServerConfiguration2 -ServerInstance $ServerInstanceObject.ServerInstance 
        
            foreach($ServerConfigKey in $ServerConfigKeys) {
                $PropertyAlreadyExists = $ServerInstanceObject | Get-Member | Where Name -ieq $ServerConfigKey.Key
                if (-not ($PropertyAlreadyExists)){
                    $ServerInstanceObject | Add-member -MemberType NoteProperty -Name $ServerConfigKey.Key -Value $ServerConfigKey.Value
                }                        
            }

            $ServerInstanceObject
        }                    
    }      
}

#Part of CC.Powershell.NAV.PSM.Scripts
function Get-NAVServerInstance-PortInfo
{
    [CmdletBinding()]
    param
    (
    )
    process {
        Get-NAVServerInstance3 | Select ServerInstance, State, ManagementServicesPort, ClientServicesPort, SOAPServicesPort, ODataServicesPort, DatabaseName, DatabaseServer, Default
    }
}


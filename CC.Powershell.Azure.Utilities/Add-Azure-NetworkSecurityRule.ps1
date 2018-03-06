#Part of CC.Powershell.Azure.Utilities
function Add-Azure-NetworkSecurityRule
{
    [CmdletBinding()]
    param
    (
        [string]$NetworkSecurityGroupName = "NAVDevPrev-nsg",
        [string]$ResourceGroupName = "resNAV90",
        [string]$Priority = "1000",
        [string]$Name = "default-allow-rdp",
        [string]$Description = "RDP",
        [int]$DestinationPortRange = 3389
    )
    process {
        write-Host -ForegroundColor Green "Adding Network Security Rule for $ResourceGroupName"
        
        $nsg = Get-AzureRmNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NetworkSecurityGroupName
        $httprule = Add-AzureRmNetworkSecurityRuleConfig -Name $Name -Description $Description -Access "Allow" -Protocol "Tcp" -Direction "Inbound" -Priority $Priority -SourceAddressPrefix "Internet" -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange $DestinationPortRange -NetworkSecurityGroup $nsg
        $null = Set-AzureRmNetworkSecurityGroup -NetworkSecurityGroup $nsg

    }
}


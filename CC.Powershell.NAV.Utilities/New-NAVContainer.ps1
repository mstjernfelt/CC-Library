function New-NAVContainer {
    [CmdletBinding()]
    Param(
        [string] [Parameter(Mandatory=$true)] $ContainerName,
        $NAVVersion = (Read-Host -Prompt "NAVVersion [e.g. 2018-cu2-se]"),
        $LicensenFile = (Read-Host -Prompt "LicenseFile [C:\License\SWEDEN NAV2017 Developer License 170721.flf]")
    )

    if ($LicensenFile -eq "")
    {
        $LicensenFile = 'C:\License\SWEDEN NAV2017 Developer License 170721.flf'
    }

    $ImageName = 'microsoft/dynamics-nav:' + $NAVVersion

    New-NavContainer -containerName $ContainerName `
                     -imageName $ImageName `
                     -accept_eula `
                     -licenseFile $LicensenFile `
                     -memoryLimit 4GB `
                     -includeCSide -shortcuts StartMenu `
                     -updateHosts `
                     -doNotExportObjectsToText
}

Export-ModuleMember -Function CC-New-NAVContainer
function Convert-To-AL-CC
{
    [CmdletBinding()]
    Param(
        [string] [Parameter(Mandatory=$true)] $ModifiedContainerName,
        [string] [Parameter(Mandatory=$true)] $OriginalContainerName
    )

    $ModifiedObjPath = "C:\ProgramData\NavContainerHelper\Extensions\" + $ModifiedContainerName + "\my\CAL2AL\MOD"
    $OrigintalObjPath = "C:\ProgramData\NavContainerHelper\Extensions\" + $OriginalContainerName + "\my\CAL2AL\ORG"
    $DeltaObjectPath = "C:\ProgramData\NavContainerHelper\Extensions\" + $ModifiedContainerName + "\my\CAL2AL\DELTA"
    $ALTempOutputPath = "C:\ProgramData\NavContainerHelper\Extensions\" + $OriginalContainerName + "\my\CAL2AL\AL"

    Write-Host "Exporting modified and standard objects..." -ForegroundColor Green
    $null = Export-NavContainerObjects -containerName $ModifiedContainerName -objectsFolder $ModifiedObjPath -exportTo "txt file (new syntax)"
    $null = Export-NavContainerObjects -containerName $OriginalContainerName -objectsFolder $OrigintalObjPath -exportTo "txt file (new syntax)"

    Write-Host "Creating folders..." -ForegroundColor Green
    $null = Create-MyDeltaFolder -containerName $ModifiedContainerName `
                         -modifiedFolder $ModifiedObjPath `
                         -myDeltaFolder $DeltaObjectPath `
                         -myOriginalFolder $OrigintalObjPath

    Write-Host "Converting to AL..." -ForegroundColor Green
    $null = Convert-Txt2Al -containerName $ModifiedContainerName `
                   -myAlFolder $ALTempOutputPath `
                   -myDeltaFolder $DeltaObjectPath

    Write-Host "Converted objects exported to " + $ALTempOutputPath
}
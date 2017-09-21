#Cosmo.Powershell.NAV.Utilities
function CC-Export-NAVApplicationObjectFile
{
    [CmdletBinding()]
    param (
        [String]$WorkingFolder,
        [String]$ExportFile,
        [String]$Database,
        [String]$Server,
        [String]$Filter
          )
 
    $LogFile = "$WorkingFolder\Log_$ExportFile"
    $ExportFile = "$WorkingFolder\$ExportFile"
    if (Test-Path "$WorkingFolder\navcommandresult.txt") {Remove-Item "$WorkingFolder\navcommandresult.txt"}
    if (test-path $ExportFile) {remove-item $ExportFile}
 
    $NAVFolder = 'C:\Program Files (x86)\Microsoft Dynamics NAV\90\RoleTailored Client'
    $exportfinsqlcommand = """$NAVFolder\finsql.exe"" command=exportobjects, file=$ExportFile, servername=$Server, database=$Database, Logfile=$LogFile"
 
    if ($Filter -ne "")
        {$exportfinsqlcommand = "$exportfinsqlcommand,filter=$Filter"} 
 
    $Command = $exportfinsqlcommand
 
    Write-Debug $Command
    cmd /c $Command
 
    $ExportFileExists = Test-Path "$ExportFile"
    If (-not $ExportFileExists) 
    {
            write-error "Error on exporting to $ExportFile.  Look at the information below."
            if (Test-Path "$WorkingFolder\navcommandresult.txt"){Type "$WorkingFolder\navcommandresult.txt"}
            if (Test-Path $LogFile) {type $LogFile}
    }
    else
    {
 
        $NAVObjectFile = Get-ChildItem $ExportFile
        if ($NAVObjectFile.Length -eq 0)
        {
            Remove-Item $NAVObjectFile
        } 
 
        if (Test-Path "$WorkingFolder\navcommandresult.txt")
        {
            Type "$WorkingFolder\navcommandresult.txt"
        }
    }
}
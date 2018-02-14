#Part of CC.Powershell.Azure.Utilities
function CC-Azure-Update-EncryptionKey
{
    [CmdletBinding()]
    param
    (
        [string]$ServiceTierFolder = 'C:\key\',
        [string]$DatabaseUserName = "cosmoadmin",
        [string]$DatabasePassword = "Cosmo2018Cosmo!",
        [string]$EncryptionPassword = "abc123ABC$%&abc123",
        [bool]$TrustSQLServerCertificate = $true,
        [string]$DatabaseServer = "cgss-sql01.database.windows.net",
        [string]$DatabaseName = "cgss-nav-2017-test",
        [string]$ServerInstanceName = "cgss-test",
        [string]$EncryptionKeyName = "DynamicsNAV.key"
    )
    process {
        write-Host -ForegroundColor Green "Updating encryption key for NAV instance $ServerInstanceName"
        
        $DatabaseSecurePassword = ConvertTo-SecureString -String $DatabasePassword -AsPlainText -Force
        $DatabaseCredentials = New-Object PSCredential -ArgumentList $DatabaseUserName, $DatabaseSecurePassword
             
        $EncryptionKeyPath = Join-Path $ServiceTierFolder + $EncryptionKeyName
        $EncryptionSecurePassword = ConvertTo-SecureString -String $EncryptionPassword -AsPlainText -Force
        New-NAVEncryptionKey -KeyPath $EncryptionKeyPath -Password $EncryptionSecurePassword -Force | Out-Null
             
        Write-Host "Import Encryption Key"
        Import-NAVEncryptionKey -ServerInstance $ServerInstanceName `
                                -ApplicationDatabaseServer $DatabaseServer `
                                -ApplicationDatabaseCredentials $DatabaseCredentials `
                                -ApplicationDatabaseName $DatabaseName `
                                -KeyPath $EncryptionKeyPath `
                                -Password $EncryptionSecurePassword `
                                -WarningAction SilentlyContinue `
                                -Force
          
        write-Host -ForegroundColor Green "Updating settings for NAV instance $ServerInstanceName"
        Set-NAVServerConfiguration -ServerInstance $ServerInstanceName -KeyName "EnableSqlConnectionEncryption" -KeyValue "true" -WarningAction SilentlyContinue
        Set-NAVServerConfiguration -ServerInstance $ServerInstanceName -KeyName "TrustSQLServerCertificate" -KeyValue $TrustSQLServerCertificate.Tostring().ToLowerInvariant() -WarningAction SilentlyContinue
        Set-NavServerConfiguration -serverinstance $ServerInstanceName -databaseCredentials $DatabaseCredentials
        Set-NAVServerConfiguration -ServerInstance $ServerInstanceName -KeyName "DatabaseServer" -KeyValue $DatabaseServer
        Set-NAVServerConfiguration -ServerInstance $ServerInstanceName -KeyName "DatabaseName" -KeyValue $DatabaseName        
    }
}


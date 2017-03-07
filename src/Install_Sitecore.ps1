<#

Microsoft PowerShell

Install Sitecore
Created by William Chang

Created: 2016-09-02
Modified: 2017-03-02

PowerShell Examples:
powershell.exe Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
powershell.exe -File .\Install_Sitecore.ps1 -ZipFileBaseName "Sitecore 8.2 rev. 161221" -SiteName "site1.com" -DatabasePrefixName "Site1"
powershell.exe -File C:\Temp\Install_Sitecore.ps1 -ZipFileBaseName "Sitecore 8.2 rev. 161221" -SiteName "site1.com" -DatabasePrefixName "Site1"

#>

param(
    [string]$ZipFileBaseName = $(throw '-ZipFileBaseName is required.'),
    [string]$SiteName = $(throw '-SiteName is required (eg site1.com).'),
    [string]$DatabasePrefixName = $(throw '-DatabasePrefixName is required (eg Site1).'),
    [switch]$Verbose = $False
)

$currentScriptName = 'Install_Sitecore'
$currentDateTime = Get-Date -Format 'yyyyMMddHHmm'
$currentFolderPath = Get-Location

function Invoke-ScriptWithDotNet4 {
    if($PsVersionTable.CLRVersion.Major -lt 4) {
        $env:COMPLUS_version = 'v4.0.30319'
    }
    .\Install_Sitecore_ConfigureFiles.ps1 -WebrootFolderName $SiteName -DataFolderName  ('{0}.data' -f $SiteName) -DatabaseFolderName ('{0}.databases' -f $SiteName) -MediaLibraryFolderName ('{0}.medialibrary' -f $SiteName)
}

function Invoke-Main {
    if($Verbose) {
        $DebugPreference = 'Continue'
    }

    Write-Debug ('')
    Write-Debug ('PowerShell Installation Path : {0}' -f $PsHome)
    Write-Debug ('PowerShell Version : {0}' -f $PsVersionTable.PSVersion)
    Write-Debug ('PowerShell Common Language Runtime Version : {0}' -f $PsVersionTable.CLRVersion)
    Write-Debug ('PowerShell Debug Preference : {0}' -f $DebugPreference)
    Write-Debug ('Current Date And Time : {0}' -f $currentDateTime)
    Write-Debug ('Current Folder Path : {0}' -f $currentFolderPath)
    Write-Debug ('')

    Write-Output ('')
    Write-Output ('Sitecore Zip File Base Name : {0}' -f $ZipFileBaseName)
    Write-Output ('Your Sitecore Site Name : {0}' -f $SiteName)
    Write-Output ('Your Sitecore Database Prefix Name : {0}' -f $DatabasePrefixName)
    Write-Output ('')

    Invoke-ScriptWithDotNet4

    Write-Output ('')
    Write-Output ('Everything installed for CMS')
    Write-Output ('')
}

Invoke-Main

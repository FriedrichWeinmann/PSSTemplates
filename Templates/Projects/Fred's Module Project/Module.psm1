# Run this once to set up your project #
#--------------------------------------#

# Project Name
$ProjectName = "%ProjectName%"

$null = New-Item en-us -ItemType Directory
$null = New-Item bin -ItemType Directory
$null = New-Item functions -ItemType Directory
$null = New-Item internal -ItemType Directory
$null = New-Item internal\configurations -ItemType Directory
$null = New-Item internal\functions -ItemType Directory
$null = New-Item internal\scripts -ItemType Directory
$null = New-Item internal\tepp -ItemType Directory
$null = New-Item tests -ItemType Directory
$null = New-Item xml -ItemType Directory

Move-Item -Path ".\about_Module.help.txt" -Destination "en-us\about_$ProjectName.help.txt"
Move-Item -Path preimport.ps1 -Destination .\internal\scripts\
Move-Item -Path postimport.ps1 -Destination .\internal\scripts\
Move-Item -Path example-configuration.ps1 -Destination .\internal\configurations\
Move-Item -Path pester.ps1 -Destination .\tests

Get-Content -Path ".\modulebase.ps1" -Encoding UTF8 | ForEach-Object { $_ -replace "<ProjectName>", $ProjectName.Replace(" ", "_") } | Set-Content -Path ".\$ProjectName.psm1" -Encoding UTF8
Remove-Item -Path ".\modulebase.ps1"
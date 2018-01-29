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
$null = New-Item tests\functions -ItemType Directory
$null = New-Item tests\general -ItemType Directory
$null = New-Item xml -ItemType Directory

Move-Item -Path ".\about_Module.help.txt" -Destination "en-us\about_$ProjectName.help.txt"
Move-Item -Path preimport.ps1 -Destination .\internal\scripts\
Move-Item -Path postimport.ps1 -Destination .\internal\scripts\
Move-Item -Path license.ps1 -Destination .\internal\scripts\
Move-Item -Path example-configuration.ps1 -Destination .\internal\configurations\
Move-Item -Path pester.ps1 -Destination .\tests\
Move-Item -Path tests-readme.md -Destination .\tests\readme.md
Move-Item -Path tests-functions-readme.md -Destination .\tests\functions\readme.md

# Move tests
Move-Item -Path FileIntegrity.Exceptions.ps1 -Destination .\tests\general\
Move-Item -Path FileIntegrity.Tests.ps1 -Destination .\tests\general\
Move-Item -Path Help.Exceptions.ps1 -Destination .\tests\general\
Move-Item -Path Help.Tests.ps1 -Destination .\tests\general\
Move-Item -Path Manifest.Tests.ps1 -Destination .\tests\general\
Move-Item -Path PSScriptAnalyzer.Tests.ps1 -Destination .\tests\general\

Get-Content -Path ".\modulebase.ps1" -Encoding UTF8 | ForEach-Object { $_ -replace "<ProjectName>", $ProjectName.Replace(" ", "_") } | Set-Content -Path ".\$ProjectName.psm1" -Encoding UTF8
Remove-Item -Path ".\modulebase.ps1"
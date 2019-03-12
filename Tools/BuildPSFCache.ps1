function New-PSSModuleCache
{
<#
	.SYNOPSIS
		Calculates cache data used by PowerShell Studio for the specified module.
	
	.DESCRIPTION
		Calculates cache data used by PowerShell Studio for the specified module.
		This can be used to manually calculate the cache if automatic calculation fails.
	
	.PARAMETER Module
		The module to build the cache for
	
	.EXAMPLE
		PS C:\> Get-Module PSFramework | New-PSSModuleCache
	
		Creates PSS cache data for the PSFramework module
#>
	[CmdletBinding()]
	param (
		[Parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[System.Management.Automation.PSModuleInfo[]]
		$Module
	)
	
	begin
	{
		$common = 'Verbose', 'Debug', 'ErrorAction', 'WarningAction', 'InformationAction', 'ErrorVariable', 'WarningVariable', 'InformationVariable', 'OutVariable', 'OutBuffer', 'PipelineVariable'
	}
	process
	{
		foreach ($moduleItem in $Module)
		{
			$ctext = @()
			$mtext = '{0}|{1}|' -f $moduleItem.Name, $moduleItem.Version.ToString()
			$atext = @()
			
			# Write Header
			$ctext += '[Module]'
			$ctext += '{0}|{1}|{2}' -f $moduleItem.Name, $moduleItem.Version.ToString(), $moduleItem.Description
			
			$commands = $moduleItem.ExportedCommands.Values
			foreach ($command in $commands)
			{
				if ($command.CommandType -like "Alias")
				{
					$atext += '{0} {1}' -f $command.Name, $command.ResolvedCommand.Name
					continue
				}
				$help = Get-Help -Name $command.Name
				$ctext += '[Command]'
				$ctext += '{0}|{1}|C' -f $command.CommandType, $command.Name
				$ctext += ''
				$ctext += $help.Synopsis
				$ctext += '[Syntax]'
				foreach ($set in $command.ParameterSets)
				{
					$ctext += '{0}|{1} {2}' -f $set.Name, $command.Name, $set.ToString()
				}
				$ctext += '[Outputs]'
				foreach ($set in $command.ParameterSets)
				{
					if ($command.OutputType)
					{
						$ctext += '{0}|{1}' -f $set.Name, $command.OutputType[0].Type.ToString()
					}
					else { $ctext += '{0}|System.Management.Automation.PSObject[]' -f $set.Name }
				}
				$ctext += '[Parameters]'
				foreach ($parameter in $command.Parameters.Values)
				{
					if ($parameter.Name -in $common) { continue }
					$ctext += '{0}|{1}|' -f $parameter.Name, $parameter.ParameterType
				}
			}
			
			[pscustomobject]@{
				PSTypeName = 'PSS.Module.Cache'
				Module	   = $mtext
				Aliases    = $atext -join "`n"
				Commands   = $ctext -join "`n"
			}
		}
	}
}

$modules = 'PSFramework', 'PSUtil', 'PSModuleDevelopment', 'PSJukebox', 'Pester', 'MailDaemon'
foreach ($module in $modules)
{
	Import-Module $module
	$cacheData = Get-Module $module | New-PSSModuleCache
	$aliases = Get-Alias | Where-Object Source -eq $module | Select-PSFPropertyValue -Property Name, ResolvedCommand -FormatWith "{0} {1}"
	$moduleObject = Get-Module $module
	$baseName = 'C:\ProgramData\SAPIEN\PresetCache 2.1\ModuleCacheV5\{0}.{1}' -f $moduleObject.Name, $moduleObject.Version
	
	$cacheData.Commands | Set-Content -Path "$baseName.cmdlets"
	$aliases | Set-Content -Path "$baseName.alias"
	
	$baseName = '{0}\SAPIEN\CachedData 2.1\Local Machine\PowerShell64V5' -f $env:AppData
	$cacheData.Commands | Add-Content -Path "$baseName.Cmdlet.Cache"
	$aliases | Add-Content -Path "$baseName.Alias.Cache"
}
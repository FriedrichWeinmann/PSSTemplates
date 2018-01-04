function %FileName% {
	<#
		.SYNOPSIS
			Drops a database, hopefully even the really stuck ones.

		.DESCRIPTION
			Tries a bunch of different ways to remove a database or two or more.

		.PARAMETER SqlInstance
	        SQL Server name or SMO object representing the SQL Server to connect to. This can be a collection and receive pipeline input to allow the function to be executed against multiple SQL Server instances.

	    .PARAMETER SqlCredential
	        Credential object used to connect to the SQL Server Instance as a different user. This can be a Windows or SQL Server account. Windows users are determined by the existence of a backslash, so if you are intending to use an alternative Windows connection instead of a SQL login, ensure it contains a backslash.

		.PARAMETER WhatIf
			If this switch is enabled, no actions are performed but informational messages will be displayed that explain what would happen if the command were to run.

		.PARAMETER Confirm
			If this switch is enabled, you will be prompted for confirmation before executing any operations that change state.

		.PARAMETER EnableException
			By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
			This avoids overwhelming you with "sea of red" exceptions, but is inconvenient because it basically disables advanced scripting.
			Using this switch turns this "nice by default" feature off and enables you to catch exceptions with your own try/catch.

		.NOTES
			Tags: Something, It, Does
			Author: FirstName LastName (@twitterhandle and/or website)

			Website: https://dbatools.io
			Copyright: (C) Chrissy LeMaire, clemaire@gmail.com
			License: GNU GPL v3 https://opensource.org/licenses/GPL-3.0

		.LINK
			https://dbatools.io/%FileName%

		.EXAMPLE
			%FileName% -SqlInstance sql2016 -Database containeddb

			<Insert examples here>
	#>
	[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Low')]
	param (
		[parameter(Mandatory = $true, ValueFromPipeline = $true)]
		[Alias("ServerInstance", "SqlServer")]
		[DbaInstance[]]$SqlInstance,
		[Alias("Credential")]
		[PSCredential]$SqlCredential,
		[Alias('Silent')]
		[switch]$EnableException
	)

	begin {
		<# include any input validations #>
		<# if you need the validation to stop the function further utilize following example #>
		$exists = Test-Path $InputVariable
		if (!$exists) {
			Stop-Function -Message "Input variable passed in is invalid"
			return
		}
	}
	process {
		if (Test-FunctionInterrupt) { return }

		foreach ($instance in $SqlInstance) {
			try {
				Write-Message -Level Verbose -Message "Connecting to $instance"
				$server = Connect-SqlInstance -SqlInstance $instance -SqlCredential $SqlCredential
			}
			catch {
				Stop-Function -Message "Failure" -Category ConnectionError -ErrorRecord $_ -Target $instance -Continue
			}
			
			# Insert code here
		}
	}
}
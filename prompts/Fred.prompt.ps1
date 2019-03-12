function prompt
{
	try {
		$history = Get-History -ErrorAction Ignore
		if ($history)
		{
			Write-PSFHostColor -String "[<c='sub'>$([Sqlcollaborative.Dbatools.Utility.DbaTimeSpanPretty]($history[-1].EndExecutionTime - $history[-1].StartExecutionTime))</c>] " -NoNewLine -DefaultColor DarkGreen
		}
	}
	catch { }
	$segments = $executionContext.SessionState.Path.CurrentLocation.Path -split "\\"
	if ($segments.Count -lt 4) { Write-Host "$($executionContext.SessionState.Path.CurrentLocation.Path)" -NoNewline }
	else { Write-Host "($($segments.Count - 2)) ..\$($segments[-2])\$($segments[-1])" -NoNewline }
	
	"> "
}
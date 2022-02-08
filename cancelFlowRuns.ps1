$flowEnvironment=$args[0]
$flowGUID=$args[1]
$flowRuns = m365 flow run list --environment $flowEnvironment --flow $flowGUID --output json | ConvertFrom-Json
foreach ($run in $flowRuns) 
{
    if($run.status -eq "Running")
	{
		Write-Output "Run details: " $run
		# Cancel all the running flow runs
		m365 flow run cancel --environment $flowEnvironment --flow $flowGUID --name $run.name --confirm
		Write-Output "Run Cancelled successfully"			
	}
}
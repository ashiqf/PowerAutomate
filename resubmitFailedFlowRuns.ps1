$flowEnvironment=$args[0]
$flowGUID=$args[1]
$flowRuns = m365 flow run list --environment $flowEnvironment --flow $flowGUID --output json | ConvertFrom-Json
foreach ($run in $flowRuns) 
{
    if($run.status -eq "Failed")
	{
		Write-Output "Run details: " $run
		#Resubmit all the failed flows
		m365 flow run resubmit --environment $flowEnvironment --flow $flowGUID --name $run.name --confirm
		Write-Output "Run resubmitted successfully"			
	}
}
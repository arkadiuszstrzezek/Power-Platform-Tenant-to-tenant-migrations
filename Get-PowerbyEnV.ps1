clear-host
Import-Module -Name Microsoft.PowerApps.Administration.PowerShell
Add-PowerAppsAccount
$environments = Get-AdminPowerAppEnvironment
ForEach($environment in $environments){
write-host -ForegroundColor Yellow "Apps In" $environment.DisplayName
write-host -ForegroundColor White (Get-AdminPowerApp -EnvironmentName $environment.EnvironmentName |Select DisplayName | write-host -ForegroundColor White )
write-host -ForegroundColor Yellow "Flows In" $environment.DisplayName
write-host -ForegroundColor White (Get-AdminFlow -EnvironmentName $environment.EnvironmentName |Select DisplayName | write-host -ForegroundColor White)
} 
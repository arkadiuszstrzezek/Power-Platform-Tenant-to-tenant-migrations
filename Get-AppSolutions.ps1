$crmUrl = "https://YOUR_ORG.crm.dynamics.com"
Connect-CrmOnline -ServerUrl $crmUrl -InteractiveMode

$solutions = Get-CrmRecords -EntityLogicalName "solution" -Fields "friendlyname", "solutionid"
$solutions.Values | Select-Object friendlyname, solutionid
#Pobranie aplikacji przypisanych do solucji 
$solutionApps = @()
foreach ($solution in $solutions.Values) {
    $solutionName = $solution.friendlyname
    $solutionId = $solution.solutionid
    
    $apps = Get-CrmRecords -EntityLogicalName "appmodule" -FilterAttribute "solutionid" -FilterOperator "eq" -FilterValue $solutionId
    foreach ($app in $apps.Values) {
        $solutionApps += [PSCustomObject]@{
            DisplayName   = $app.friendlyname
            AppId         = $app.appmoduleid
            Type          = "Solution"
            SolutionName  = $solutionName
        }
    }
}

# Wyświetlenie wyników
$solutionApps | Format-Table -AutoSize

# Pobranie aplikacji niezwiązanych z żadną solucją
$nonSolutionApps = Get-CrmRecords -EntityLogicalName "appmodule" | Where-Object { $_.solutionid -eq $null }

$nonSolutionAppsFormatted = @()
foreach ($app in $nonSolutionApps.Values) {
    $nonSolutionAppsFormatted += [PSCustomObject]@{
        DisplayName   = $app.friendlyname
        AppId         = $app.appmoduleid
        Type          = "Non-Solution"
        SolutionName  = "None"
    }
}

# Wyświetlenie wyników
$nonSolutionAppsFormatted | Format-Table -AutoSize
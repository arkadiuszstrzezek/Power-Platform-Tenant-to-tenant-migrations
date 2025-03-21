# Ustawienie środowiska Power Platform
$EnvironmentName = "default"

# Pobranie wszystkich aplikacji w środowisku
$apps = Get-AdminPowerApp -EnvironmentName $EnvironmentName

# Pobranie wszystkich przepływów Power Automate w środowisku
$flows = Get-AdminFlow -EnvironmentName $EnvironmentName

# Pobranie solucji dostępnych w środowisku
$solutions = Get-AdminPowerAppSolution -EnvironmentName $EnvironmentName

# Tworzenie raportu
$report = @()

# Przetwarzanie aplikacji Power Apps
foreach ($app in $apps) {
    $solution = $solutions | Where-Object { $_.ComponentId -eq $app.AppId } | Select-Object -First 1
    
    $report += [PSCustomObject]@{
        Type       = "PowerApp"
        Name       = $app.DisplayName
        Author     = $app.Owner
        Solution   = if ($solution) { $solution.DisplayName } else { "Not Assigned" }
    }
}

# Przetwarzanie przepływów Power Automate
foreach ($flow in $flows) {
    $solution = $solutions | Where-Object { $_.ComponentId -eq $flow.FlowId } | Select-Object -First 1
    
    $report += [PSCustomObject]@{
        Type       = "Flow"
        Name       = $flow.DisplayName
        Author     = $flow.Owner
        Solution   = if ($solution) { $solution.DisplayName } else { "Not Assigned" }
    }
}

# Wyświetlenie raportu na konsoli
$report | Format-Table -AutoSize

# Zapisanie raportu do pliku CSV
$report | Export-Csv -Path "myapp.csv" -NoTypeInformation -Encoding UTF8
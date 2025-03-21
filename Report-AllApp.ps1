# Zalogowanie do Power Platform
Add-PowerAppsAccount

# Pobranie wszystkich środowisk
$Environment = Get-AdminPowerAppEnvironment | Select-Object -First 1
if (-not $Environment) {
    Write-Host "Brak dostępnych środowisk lub brak uprawnień. Sprawdź swoje połączenie i uprawnienia."
    exit
}

$EnvironmentId = $Environment.EnvironmentId
Write-Host "Używane środowisko: $EnvironmentId"

# Pobranie wszystkich aplikacji w środowisku
$apps = Get-AdminPowerApp -EnvironmentName $EnvironmentId
if (-not $apps) {
    Write-Host "Brak aplikacji w środowisku $EnvironmentId"
}

# Pobranie wszystkich przepływów Power Automate w środowisku
$flows = Get-AdminFlow -EnvironmentName $EnvironmentId
if (-not $flows) {
    Write-Host "Brak przepływów w środowisku $EnvironmentId"
}

# Pobranie wszystkich solucji w środowisku
$solutions = Get-AdminPowerAppSolution -EnvironmentName $EnvironmentId

# Tworzenie raportu
$report = @()

# Przetwarzanie aplikacji Power Apps
foreach ($app in $apps) {
    $solution = $solutions | Where-Object { $_.SolutionId -eq $app.SolutionId } | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue
    if (-not $solution) { $solution = "Brak solucji" }
    
    $report += [PSCustomObject]@{
        Type       = "PowerApp"
        Name       = $app.DisplayName
        Author     = $app.Owner
        Solution   = $solution
    }
}

# Przetwarzanie przepływów Power Automate
foreach ($flow in $flows) {
    $solution = $solutions | Where-Object { $_.SolutionId -eq $flow.SolutionId } | Select-Object -ExpandProperty DisplayName -ErrorAction SilentlyContinue
    if (-not $solution) { $solution = "Brak solucji" }
    
    $report += [PSCustomObject]@{
        Type       = "Flow"
        Name       = $flow.DisplayName
        Author     = $flow.Owner
        Solution   = $solution
    }
}

# Sprawdzenie, czy są wyniki
if ($report.Count -eq 0) {
    Write-Host "Brak aplikacji i przepływów do wyświetlenia."
} else {
    # Wyświetlenie raportu na konsoli
    $report | Format-Table -AutoSize

    # Zapisanie raportu do pliku CSV
    $report | Export-Csv -Path "C:\myapp.csv" -NoTypeInformation -Encoding UTF8
    Write-Host "Raport zapisano w pliku myapp.csv"
}

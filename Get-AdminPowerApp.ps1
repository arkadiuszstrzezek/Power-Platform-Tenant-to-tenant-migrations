# Wymagane moduły
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell -Force -AllowClobber
Install-Module -Name Microsoft.PowerApps.PowerShell -Force -AllowClobber

# Importowanie modułów
Import-Module Microsoft.PowerApps.Administration.PowerShell
Import-Module Microsoft.PowerApps.PowerShell

# Logowanie do Power Platform (jeśli wymagane)
Add-PowerAppsAccount

# Pobranie listy aplikacji
$apps = Get-AdminPowerApp

# Ścieżka do pliku CSV
$outputFile = "C:\Temp\PowerAppsList.csv"

# Zapisanie wyniku do pliku CSV
$apps | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Lista aplikacji Power Apps została zapisana w: $outputFile"
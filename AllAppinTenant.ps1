# Logowanie do Power Platform
Add-PowerAppsAccount

# Pobranie aplikacji, posortowanie alfabetycznie i eksport do pliku CSV
Get-AdminPowerApp | 
    Select-Object DisplayName, CreatedBy, Owner | 
    Sort-Object DisplayName | 
    Export-Csv -Path "C:\PowerApps_List.csv" -NoTypeInformation -Encoding UTF8

# Logowanie do Power Platform
Add-PowerAppsAccount

# Pobranie przepływów, posortowanie alfabetycznie i eksport do pliku CSV
Get-AdminFlow | 
    Select-Object DisplayName, CreatedBy, EnvironmentName | 
    Sort-Object DisplayName | 
    Export-Csv -Path "C:\PowerAutomate_Flows_List.csv" -NoTypeInformation -Encoding UTF8
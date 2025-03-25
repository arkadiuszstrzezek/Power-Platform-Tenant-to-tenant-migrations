# Power-Platform-Tenant-to-tenant-migrations
## Before you get started
Be aware of the following before starting a tenant-to-tenant migration.

>Tenant-to-tenant migrations will be supported on Managed Environments in the future.

- Supported environment types: Production and sandbox only.
- Not supported environment types: Default, developer, trial, and Teams environment types aren't supported. Government Community Cloud (GCC) to public clouds and vice versa aren't supported.
- Components not supported include Dynamics 365 Customer Voice, Omnichannel for Customer Service, component library, Dynamics 365 Customer Insights - Journeys, and Dynamics 365 Customer Insights - Data.
- Specific steps required for Power Apps, Power Automate, Power Pages, and Microsoft Copilot Studio are called out in the premigration and post-migration steps.
- A Dataverse organization linked to a finance and operations organization can't be migrated to a different tenant.
You might need to reconfigure some applications and settings after tenant-to-tenant migration, such as Dynamics 365 for Outlook, server-side sync, SharePoint, and others.
- Once users are created and configured, you must create a user mapping file, which is described later in this article.
- If the mapped user has a mailbox in the destination tenant, then the mailbox is automatically configured during the migration. For all other users, you need to reconfigure the mailbox.
    - If the same mailbox is used in the target tenant, , then the mailbox is used by default. Before the tenant-to-tenant migration, customers need to migrate and configure their mailboxes on the target tenant.test@microsoft.com
    - If you're using the default onmicrosoft domain, , the post-migration domain name is changed to . Customers need to reconfigure the mailbox. Learn more about configuring the mailbox in Connect to Exchange Online.test@sourcecompanyname.onmicrosoft.comtest@targetcompanyname.onmicrosoft.com

## Prerequisites
Be sure to complete the following prerequisites before you start the migration process:

- Create users in the target tenant, including:
- Create users in Microsoft 365 and Microsoft Entra ID.
- Assign licenses.
- You must have admin privileges with Power Platform or Dynamics 365 to perform the migration.
- The PowerShell for Power Platform Administrators module is the recommended PowerShell module for interacting with admin capabilities. Learn more in Get started with PowerShell for Power Platform Administrators.

## How to use other script to report
### Install Tools
```powershell
# Install PowerShell for Power Platform Administrators (both source and target admins)

Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
Update-Module -Name Microsoft.PowerApps.Administration.PowerShell 
```
### Login to Power Apps
```powershell
# Sign in to Microsoft Power Platform (both source and target admins)
Add-PowerAppsAccount
```
### Method 1
Super fast way to get a complete list of all of the flows and canvas apps in your organisations tenant
```powershell
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
```
### Method 2
List and Export to csv DisplayName, CreatedBy, Owner
```powershell
# Logowanie do Power Platform
Add-PowerAppsAccount

# Pobranie aplikacji, posortowanie alfabetycznie i eksport do pliku CSV
Get-AdminPowerApp | 
    Select-Object DisplayName, CreatedBy, Owner, EnvironmentName | 
    Sort-Object DisplayName | 
    Export-Csv -Path "C:\PowerApps_List.csv" -NoTypeInformation -Encoding UTF8

# Logowanie do Power Platform
Add-PowerAppsAccount

# Pobranie przepływów, posortowanie alfabetycznie i eksport do pliku CSV
Get-AdminFlow | 
    Select-Object DisplayName, CreatedBy, EnvironmentName | 
    Sort-Object DisplayName | 
    Export-Csv -Path "C:\PowerAutomate_Flows_List.csv" -NoTypeInformation -Encoding UTF8 
```
## Other Simple cmdlet 
### Get-AdminPowerAppConnector
The Get-AdminPowerAppConnector cmdlet looks up information about one or more custom connectors depending on parameters. Use Get-Help Get-AdminPowerAppConnector -Examples for more detail.

Returns all custom connector from all environments where the calling user is an Environment Admin. For Global admins, this will search across all environments in the tenant.

```powershell
Get-AdminPowerAppConnector
```


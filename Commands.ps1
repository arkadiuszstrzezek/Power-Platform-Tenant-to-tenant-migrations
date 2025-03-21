# Install PowerShell for Power Platform Administrators (both source and target admins)

Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
Update-Module -Name Microsoft.PowerApps.Administration.PowerShell

# Install Azure PowerShell on Windows (both source and target admins)

Install-Module -Name Az -Repository PSGallery -Force

# Sign in to Microsoft Power Platform (both source and target admins)
Add-PowerAppsAccount

# Submit migration request (source admin)
TenantToTenant-SubmitMigrationRequest –EnvironmentName {EnvironmentId} -TargetTenantID {TenantID}

# You can view the status and MigrationID using the following command:
TenantToTenant-ViewMigrationRequest

# View and approve migration request (target admin)
Add-PowerAppsAccount

TenantToTenant-ViewApprovalRequest

TenantToTenant-ManageMigrationRequest -MigrationId {MigrationId from above command to approve or deny}

#Generate a shared access signature (SAS) URL (source admin)
GenerateResourceStorage-PowerAppEnvironment –EnvironmentName {EnvironmentId}

<#
Upload the user mapping file (source admin)
The next step involves transferring the user mapping file to the previously established SAS URL. 
To accomplish this, run the following commands in Windows PowerShell ISE, ensuring that the parameters SASUri
and FileToUpload contain the appropriate information about your environment. 
This step is crucial for accurately uploading mapping of the users in the system.
 #>

# Prepare the environment migration (source admin)

TenantToTenant-PrepareMigration 
-MigrationId {MigrationId} 
-TargetTenantId {TargetTenantId} 
-ReadOnlyUserMappingFileContainerUri {SasUri}

# Check status (source admin)
TenantToTenant-GetMigrationStatus -MigrationId {MigrationId}
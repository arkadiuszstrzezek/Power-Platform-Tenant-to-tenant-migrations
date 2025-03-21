# Power-Platform-Tenant-to-tenant-migrations
## Before you get started
Be aware of the following before starting a tenant-to-tenant migration.

>`Note

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
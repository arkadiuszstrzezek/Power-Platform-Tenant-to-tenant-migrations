$SASUri ="SASurlHere" # Replace with your actual SAS URL
$Uri = [System.Uri] $SASUri
 
$storageAccountName = $uri.DnsSafeHost.Split(".")[0]
$container = $uri.LocalPath.Substring(1)
$sasToken = $uri.Query
 
# File to upload
# Note that the file name should be usermapping.csv (case sensitive) with comma separated values.
$fileToUpload = 'C:\Users\arek\OneDrive - Arek CSP Promise SPO\Pulpit\usermapping.csv'
 
# Create a storage context
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -SasToken $sasToken
 
# Upload the file to Azure Blob Storage
Set-AzStorageBlobContent -File $fileToUpload -Container $container -Context $storageContext -Force
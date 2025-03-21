Import-Module Az.Storage 
# Define the SAS URI of the blob
$sasUri = "https://bapfeblobproddb.blob.core.windows.net/20250320t000000zcce44cce7c80431e84f0c8105f883c2a?sv=2018-03-28&sr=c&si=SASpolicy&sig=8VPvRDsAU%2FSDVrN31wY5ZiVKz111J9f9GOQpcTR3Zj0%3D"
# Define the path where the blob will be downloaded
$destinationPath = "C:\Downloads\Failed\"
# Split the SAS URI on the '?' character to separate the URL and the SAS token
$url, $sasToken = $sasUri -split '\?', 2
$containerName = $url.Split('/')[3]
$storageAccountName = $url.Split('/')[2].Split('.')[0]
$storageContext = New-AzStorageContext -StorageAccountName $storageAccountName -SasToken $sasToken
Get-AzStorageBlobContent -Blob "usermapping.csv" -Container $containerName -Destination $destinationPath -Context $storageContext
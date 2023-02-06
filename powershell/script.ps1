# Parameters
$resourceGroup = "ALZ-Terraform-rg"
$location = "WestEurope"
$accountName = "alzterraformsalrs0x"
$storageSku = LRS
$storageKind = StorageV2
$ctx = $storageAccount.Context
$containerName = "tfstate"
$vaultName = "alzdevopskv"

# create resource group
New-AzResourceGroup -Name $resourceGroup -Location $location

# create storage account
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
    -Name $accountName `
    -Location $location `
    -SkuName $storageSku `
    -Kind $storageKind

# create container
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob

# create keyvault
New-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroup -Location $location

# Environment variable for terraform backend
$ACCOUNT_KEY=(Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $accountName)[0].value
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY

## remove resource group
# Remove-AzResourceGroup -Name $resourceGroup

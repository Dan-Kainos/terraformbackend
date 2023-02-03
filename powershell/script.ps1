# Parameters
$resourceGroup = "ALZ-Terraform-rg"
$location = "WestEurope"
$accountName = "alzterraformsalrs0x"
$storageSku = LRS
$storageKind = StorageV2
$ctx = $storageAccount.Context
$containerName = "tfstate"
$vaultName = "alzdevopskv"

# Resource group creation
New-AzResourceGroup -Name $resourceGroup -Location $location
# Storage account creation
$storageAccount = New-AzStorageAccount -ResourceGroupName $resourceGroup `
    -Name $accountName `
    -Location $location `
    -SkuName $storageSku `
    -Kind $storageKind
# Storage container creation
New-AzStorageContainer -Name $containerName -Context $ctx -Permission blob
# Key vault creation
New-AzKeyVault -VaultName $vaultName -ResourceGroupName $resourceGroup -Location $location

# Environment variable for terraform backend
# To configure backend state you need the following information
# storage account name
# container name
# key - name of state file
# access_key - storage access key
# The following command stores access key as env variable
$ACCOUNT_KEY=(Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $accountName)[0].value
$env:ARM_ACCESS_KEY=$ACCOUNT_KEY

##### REMOVE RESOURCE GROUP #############
# Remove-AzResourceGroup -Name $resourceGroup
#-----------------------------------------
# Get Az Subscription
# Get Az RG
# Create Storage account and Container
# Storage for Terraform remote state
# Create KV for secrets
RESOURCE_GROUP_NAME="alz-terraform-rg"
LOCATION="westeurope"
STORAGE_ACCOUNT_NAME="alzterraformsalrs0x"
CONTAINER_NAME="tfstate"
KEY_VAULT_NAME="alzkeyvault"

# create resource group
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query [0].value -o tsv)

# create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY

# create key vault
az keyvault create --location $LOCATION --name $KEY_VAULT_NAME --resource-group $RESOURCE_GROUP_NAME

echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"
echo "access_key: $ACCOUNT_KEY"
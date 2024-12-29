#!/bin/bash

RESOURCE_GROUP_NAME="1-0c081f8e-playground-sandbox"
STORAGE_ACCOUNT_NAME="tfstate1899c343"
CONTAINER_NAME="terraform-state"

# Create a resource group
#az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create a storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob --location westus

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

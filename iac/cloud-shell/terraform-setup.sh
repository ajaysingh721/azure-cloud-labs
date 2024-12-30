#!/bin/bash

RESOURCE_GROUP_NAME="1-79b9cb16-playground-sandbox"
STORAGE_ACCOUNT_NAME="terraformstate1231sa"
CONTAINER_NAME="terraform-state"

# Create a resource group
#az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create a storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob --location westus

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

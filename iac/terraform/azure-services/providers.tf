terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.14.0"
    }
  }

  required_version = ">= 1.10.3"

  backend "azurerm" {
    storage_account_name = "terraformstate1231sa"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate.services"
  }

}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

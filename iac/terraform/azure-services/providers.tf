terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "azurerm" {
    storage_account_name = "terraformstate1231sa"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

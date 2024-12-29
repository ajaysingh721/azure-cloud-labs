terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "1.13.0"
    }
  }

  required_version = ">= 0.14.0"

  backend "azurerm" {
    resource_group_name  = "1-0838e53c-playground-sandbox"
    storage_account_name = "tfstate1899c343"
    container_name       = "terraform-state"
    key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
}

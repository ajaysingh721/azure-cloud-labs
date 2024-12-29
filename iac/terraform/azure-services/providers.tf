terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }

  backend "azurerm" {
    key = "terraform.tfstate"
  }

}

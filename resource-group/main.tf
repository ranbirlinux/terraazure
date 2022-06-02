# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.9"
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "hub_rg" {
  name     = "az_rg_hub"
  location = "westus"
}

resource "azurerm_resource_group" "mgt_rg" {
  name     = "az_rg_mgt"
  location = "westus"
}

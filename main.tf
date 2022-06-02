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

# defining modules

provider "azurerm" {
  features {}
}

module "resource-group" {
  source = "./resource-group"
}

module "network" {
  source = "./network"
}

module "nsg" {
  source = "./nsg"
}
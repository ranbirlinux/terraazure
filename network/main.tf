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

module "nsg" {
  source = "../nsg"
}

resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.vnet_name[0]
  address_space       = [var.vnets[0]]
  location            = var.location.location1
  resource_group_name = var.hub_resource_group
  depends_on = [
    azurerm_resource_group.hub_rg
  ]

}

resource "azurerm_virtual_network" "mgt_vnet" {
  name                = var.vnet_name[1]
  address_space       = [var.vnets[1]]
  location            = var.location.location1
  resource_group_name = var.mgt_resource_group
  depends_on = [
    azurerm_resource_group.mgt_rg
  ]
}

resource "azurerm_subnet" "hub_subnets" {
  name                 = var.hub_subnet_name[count.index]
  resource_group_name  = var.hub_resource_group
  virtual_network_name = var.vnet_name[0]
  address_prefixes     = [var.hub_subnet_prefix[count.index]]
  count                = length(var.hub_subnet_name)
  depends_on = [
    azurerm_virtual_network.hub_vnet
  ]
}
  resource "azurerm_subnet" "mgt_subnets" {
  name                 = var.mgt_subnet_name[count.index]
  resource_group_name  = var.mgt_resource_group
  virtual_network_name = var.vnet_name[1]
  address_prefixes     = [var.mgt_subnet_prefix[count.index]]
  count                = length(var.mgt_subnet_name)
  depends_on = [
    azurerm_virtual_network.mgt_vnet
  ]

}


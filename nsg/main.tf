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

module "resource-group" {
  source = "../resource-group"
}

resource "azurerm_network_security_group" "az_sql_nsg" {
  name = var.nsg.name1
  location = var.location.location1
  resource_group_name = var.mgt_resource_group
  depends_on = [module.resource-group]
}


resource "azurerm_network_security_rule" "az_sql_nsg" {
  for_each                    = local.nsgrules 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = var.mgt_resource_group
  network_security_group_name = azurerm_network_security_group.az_sql_nsg.name
  depends_on = [
    azurerm_network_security_group.az_sql_nsg,module.resource-group
  ]
}




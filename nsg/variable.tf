variable "hub_resource_group" {
  default = "az_rg_hub"
}

variable "mgt_resource_group" {
  default = "az_rg_mgt"
}

variable "location" {
  type = map(string)
  default = {
    location1 = "westus"
    location2 = "eastus"
  }
}


variable "nsg" {
  type = map(string)
  default = {
    name1 = "az_sql_nsg"
    name2 = "az_app_nsg"
  }
}

variable "vnet_name" {
  type    = list(string)
  default = ["az_vnet_hub", "az_vnet_mgt"]
}

variable "vnets" {
  type    = list(string)
  default = ["10.16.0.0/20", "10.16.16.0/20"]
}

variable "hub_subnet_name" {
  default = ["az_sn_01", "az_sn_02", "az_sn_03","az_sn_04"]
}

variable "hub_subnet_prefix" {
  default = ["10.16.0.0/27", "10.16.0.32/27", "10.16.0.64/27","10.16.0.96/27"]
}

variable "mgt_subnet_name" {
  default = ["az_sn_01", "az_sn_02", "az_sn_03","az_sn_04"]
}

variable "mgt_subnet_prefix" {
  default = ["10.16.16.0/27", "10.16.16.32/27", "10.16.16.64/27","10.16.16.96/27"]
}

resource "azurerm_resource_group" "rg_01" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_virtual_network" "vnet_01" {
  name                = var.virtual_network
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group
}

resource "azurerm_subnet" "subnet_01" {
  
  name                 = var.subnet_name
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network
  address_prefixes     = var.address_prefixes
}

resource "azurerm_virtual_machine" "vm_01" {
  name                  = var.virtual_machine
  location              = var.location
  resource_group_name   = var.resource_group
  vm_size               = var.vm_size
}
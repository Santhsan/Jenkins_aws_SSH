terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.1.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "677bcc02-a3a7-468e-b9ce-5f51cdc6a6c7"
  client_id       = "1fb1c7ba-40bf-4cbe-bbbf-c69071e11554"
  client_secret   = "bWP8Q~i0keJC8KTUyEfgRPZNZgQ6MiBuEaNh3bMu"
  tenant_id       = "b36ac463-b379-4752-9185-dcb045b3bea2"
  features {}
}

data "azurerm_subnet" "subnetA" {
  name = "subnetA"
  virtual_network_name = "demo-network"
  resource_group_name = "RG01"
}

resource "azurerm_resource_group" "appdemo" {
    name = "RG01"
    location = "East US"
}    

resource "azurerm_virtual_network" "demo-network" {
  name                = "demo-network"
  location            = "East US"
  resource_group_name = "RG01"
  address_space       = ["10.0.0.0/16"]

  subnet {
    name           = "subnetA"
    address_prefix = "10.0.1.0/24"
  }

}  


resource "azurerm_network_interface" "demo_nic" {
  name                = "demo-nic"
  location            = "East US"
  resource_group_name = "RG01"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "demo_vm" {
  name                = "Demo-VM"
  resource_group_name = "RG01"
  location            = "East US"
  size                = "Standard_B2ms"
  admin_username      = "Santh"
  admin_password      = "Demo@123"
  network_interface_ids = [
    azurerm_network_interface.demo_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}
 

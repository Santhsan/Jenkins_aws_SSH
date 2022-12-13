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

resource "azurerm_resource_group" "RG_network" {
    name = "RG_network"
    location = "East US"
}

resource "azurerm_virtual_network" "example" {
  name                = "demo-network"
  location            = "East US"
  resource_group_name = "RG_network"
  address_space       = ["10.0.0.0/16"]

}  
 
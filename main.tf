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

resource "azurerm_resource_group" "appdemo" {
    name = "RG01"
    location = "East US"
}    

resource "azurerm_storage_account" "storage_account" {
  name                     = "terraform1897"
  resource_group_name      = "RG01"
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = true
  depends_on = [
    azurerm_resource_group.appdemo
  ]

}  

resource "azurerm_storage_container" "Container" {
  name                  = "demo"
  storage_account_name  = "terraform1897"
  container_access_type = "private"
  depends_on = [
    azurerm_storage_account.storage_account
  ]

}

resource "azurerm_storage_blob" "Samp" {
  name                   = "sample.txt"
  storage_account_name   = "terraform1897"
  storage_container_name = "demo"
  type                   = "Block"
  source                 = "sample.txt"
  depends_on = [
    azurerm_storage_container.Container
  ] 
}

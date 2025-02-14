terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.13"
    }
    azurecaf = {
      source  = "claranet/azurecaf"
      version = "~> 1.2.29"
    }
  }
}

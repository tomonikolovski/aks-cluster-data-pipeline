terraform {
  required_version = ">=1.8"

  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.107"
    }

    azapi = {
      source  = "azure/azapi"
      version = "~>1.13"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.6"
    }
    
    time = {
      source  = "hashicorp/time"
      version = "0.11"
    }
  }
}

provider "azurerm" {
  features {}
}
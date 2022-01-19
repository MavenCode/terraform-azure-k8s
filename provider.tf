terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.92.0"
        }
    }
}

provider "azurerm" {
    features {}

    use_msi = true

    backend "azurerm" {
        storage_account_name = var.storage_account_name
        container_name       = var.container_name
        key                  = var.key
        subscription_id      = var.subscription_id
        tenant_id            = var.tenant_id
    }
}
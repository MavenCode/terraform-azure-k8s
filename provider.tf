terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "=2.92.0"
        }
    }
}

provider "azurerm" {
    storage_account_name = var.storage_account_name
    subscription_id      = var.subscription_id
    tenant_id            = var.tenant_id

    use_msi = true

    features {}
}
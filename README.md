# Terraform Azure Kubernetes

######

Using this Terraform template we can provision Azure Storage functions. Following the guidelines, you can provide function details and the template handles the rest.

To make use of this module, you need to take note of the following:
1. Define a terraform azurem resource group block
    ```
        resource "azurerm_resource_group" "rg" {
            name     = var.resource_group_location
            location = var.resource_group_location
            }
    ```

2. Define the secret values of the provider, they are needed to authenticate to Azure.
    ```
    subscription_id = var.subscription_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    tenant_id       = var.tenant_id
    ```
    This can be done from the `vars.tfvars` file.
3. The values of the resource group block are passed as input to following variables of the module
    ```
    - resource_group_name      = azurerm_resource_group.rg.name
    - resource_group_location  = azurerm_resource_group.rg.location
    ```
4. Define the module block 
```
    module "k8s_setup" {
    source = "module-link"

    cluster_name            = var.cluster_name
    resource_group_name     = azurerm_resource_group.rg.name
    resource_group_location = azurerm_resource_group.rg.location
    kubernetes_version      = var.kubernetes_version
    node_pool_name          = var.node_pool_name
    node_pool_count         = var.node_pool_count
    node_pool_vm_size       = var.node_pool_vm_size
    node_pool_osdisk_size   = var.node_pool_osdisk_size
    node_pool_max_count     = var.node_pool_max_count
    node_pool_min_count     = var.node_pool_min_count
    env                     = var.env
    client_id               = var.client_id
    client_secret           = var.client_secret

    }
```

Note: You can insert your values in the module block as shown above. or use a vars.tfvars file. You can reference the vars.tfvars.template to get an idea.

Variables can be defined in the vars.tfvars file. A template can be seen on the repository.
General variables can be seen below.

5. Providers should be setup in the `provider.tf` file.
```
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.92.0"
    }
  }
}


provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}
```
An example can be seen in the example folder.

## Run the setup
Once you have all you configuration files setup, you can spin up your infrastructure by

1. Initialising terraform
` terraform init `

2. Validate your configuration: `terraform validate`

3. Plan your infrastructure: `terraform plan`

4. Apply your infrastructure: `terraform apply`


### Variables

#### Kubernetes variables are as follows:
| Input variables | Description |
| ------------- | ------------- |
| cluster_name | Name of the azure kubernetes service cluster |
| kubernetes_version | Kubernetes version
| node_pool_name | The name which should be used for the default Kubernetes Node Pool. |
| node_pool_count | The initial number of nodes which should exist in this Node Pool |
| node_pool_vm_size | The size of the Virtual Machine, such as Standard_DS2_v2 |
| node_pool_osdisk_size | The size of the OS Disk which should be used for each agent in the Node Pool |
| node_pool_max_count | The maximum number of nodes which should exist in this Node Pool. |
| node_pool_min_count | The minimum number of nodes which should exist in this Node Pool. |
| env | environment name e.g dev, prod etc. |


#### Resource Group Variables

| Input variables | Description |
| ------------- | ------------- |
| resource_group_name | The name of the resource group in which to create the storage account |
| resource_group_location | Specifies the supported Azure location where the resource exists.


#### Provider Variables are as follows:
| Input variables | Description |
| ------------- | ------------- |
| subscription_id | ARM subscription id |
| client_id | ARM client id. |
| client_secret | ARM client secret |
| tenant_id | ARM tenant id 



Below, the provider requirement for module implementation and the infrastructure provider
| Requirements | |
|:---- | ----:|
|Name | Version |
|terraform | ~> 1.0, latest preferred |
| azurerm | ~> 2.29.0, latest preferred |
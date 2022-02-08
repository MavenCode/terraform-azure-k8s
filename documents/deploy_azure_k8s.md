This documentation provides a guide for deploying the Kubernetes resources in this module to the Azure cloud platform.  

STEPS:
1. ## Login to your Azure account and generate the client_id, client_secret and tenant_id.  

You derive these parameters by running the following command in the Azure bash command-line.  

```  
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID"  
```  

Update the `SUBSCRIPTION_ID` in the command above.  

The output of the code above is similar to the one given below.  

```{
  "appId": "XXXX36ca-659a-4c30-aa96-f3437bdeXXXX",
  "displayName": "azure-cli-2022-02-07-17-XXXX",
  "password": "XXXXbsy~Cx3gpmGityjxcM_4nacVh4XXXX",
  "tenant": "XXXX80b7-89b2-4ee9-8726-5255817aXXXX"
}  
```  

These values will be needed in the Terraform configuration.
`appId` is mapped with `client_id`.
`password` is mapped with `client_secret`.
`tenant` is mapped with `tenant_id`.  

2. ## Create a repository and define the state of the Kubernetes cluster in Terraform files.  

- Create a terraform file and name it `main.tf`. Add the following configurations into the file.  

```  
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
}


data "azurerm_kubernetes_service_versions" "current" {
  location = azurerm_resource_group.rg.location
}


resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.cluster_name}-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "k8scluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version

  default_node_pool {
    availability_zones   = [1]
    name                 = var.node_pool_name
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    node_count           = var.node_pool_count
    vm_size              = var.node_pool_vm_size
    type                 = "VirtualMachineScaleSets"
    os_disk_size_gb      = var.node_pool_osdisk_size
    enable_auto_scaling  = true
    max_count            = var.node_pool_max_count
    min_count            = var.node_pool_min_count
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      default_node_pool[1],
    ]
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

#  identity {
#    type = "SystemAssigned"
#  }

  tags = {
    Environment = var.env
  }
}  
```    

- Create a terraform file and name it `providers.tf`. Add the following configurations to the file.  

```  
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.65"
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

- Create a terraform file and name it `outputs.tf`. Add the following configurations to the file.  

```  
output "client_key" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_key
}

output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate
}

output "cluster_ca_certificate" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate
}

output "cluster_username" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.username
}

output "cluster_password" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.password
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.k8s.kube_config_raw
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.k8s.kube_config.0.host
}  
```  

- Create a terraform file and name it `variables.tf`. Add the following configurations to the file.  

```  
variable "resource_group_name" {}
variable "resource_group_location" {}
variable "cluster_name" {}

# node pool
variable "node_pool_name" {}
variable "node_pool_count" {}
variable "node_pool_vm_size" {}
variable "node_pool_osdisk_size" {}
variable "node_pool_max_count" {}
variable "node_pool_min_count" {}


variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}

variable "env" {}  
```  

- Create a terraform file and name it `vars.tfvars`. Add the following configurations to the file.  

```  
cluster_name          = "XXX"
node_pool_name        = "system"
node_pool_count       = 2
node_pool_vm_size     = "Standard_E4s_v3"
node_pool_osdisk_size = 1024
node_pool_max_count   = 5
node_pool_min_count   = 1
env = "dev"

subscription_id = "XXXXe67a-c798-4b94-b332-ff259f9eXXXX"
client_id       = "XXXX36ca-659a-4c30-aa96-f3437bdeXXXX"
client_secret   = "XXXXbsy~Cx3gpmGityjxcM_4nacVh4XXXX"
tenant_id       = "XXXX80b7-89b2-4ee9-8726-5255817aXXXX"

resource_group_name      = "k8s_test"
resource_group_location  = "eastus"  
```

Replace the subscription_id, client_id, client_secret and tenant_id with the values derived from the Azure cloud platform (from step 1).  

You can add the path to the `vars.tfvars` file to `gitignore` for security reasons. 

You also update the values to the variables to the standard and recommended values.  

3. ## Clone the repository to your computer  

```  
git clone <your-repo-link>  
```  

4. ## Install the latest version of Terraform, if you have not done that already.  

Follow the instructions in the [Terraform installation documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli, "install terraform") to install the latest version of Terraform to your system.  

Move the unzipped terraform installation file to your system's PATH after downloading the file.  

5. ## Initialize Terraform  
Run the following command to initialize terraform in the root directory of the cloned repository.  

```  
terraform init  
```  

6. ## Validate the terraform configurations  

```  
terraform validate  
```  

7. ## Plan the execution of the deployments  

```  
terraform plan -var-file="vars.tfvars"  
```  

8. ## Execute the deployments  

```  
terraform apply -var-file="vars.tfvars"  
```  

9. ## Destroy the deployed resources  

If need be to destroy the resources, run the following command.  

``` 
terraform destroy -var-file="vars.tfvars"  
```
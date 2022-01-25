# Terraform Azure Kubernetes

Terraform can be used to provision Azure Kubernetes resources.  

This documentation serves as a guide to provision the terraform resources in this repository.  

The terraform configuration files are defined in the `main.tf`, `provider.tf`, `outputs.tf` and `variables.tf` files.  

The `main.tf` file contains the Azure Kubernetes cluster configurations. This defines the state of the Kubernetes cluster to be installed in the Azure platform.  

The `provider.tf` file specifies the cloud provider.  

The `variable.tf` file declares all the variables used in the other terraform files. Variables are used to ensure the privacy of some critical configuration secrets.  

The `output.tf` file is used to define the output parameters.  

## Steps to provision the resources in this repo  
- Open cloud shell and configure the Azure cloud environment  
- Install Terraform in Azure Cloud Shell  
- Create the terraform configuration files  
- Initialize terraform  
- Validate the terraform configurations  
- Plan your infrastructure  
- Apply your infrastructure  

## Open cloud shell and configure the Azure cloud environment  
You can start an Azure Cloud Shell directly using [shell.azure.com](https://shell.azure.com "Azure Cloud Shell").  

Select `bash` environment for running your commands.  

On first launch, you will need to create a storage account.  

## Install Terraform in Azure Cloud Shell  
You will need to install the latest version of Terraform in Azure Cloud Shell.  

Run the following command in the terminal to execute that.  

```  
curl -O https://releases.hashicorp.com/terraform/1.1.4/terraform_1.1.4_linux_amd64.zip  
``` 

The installation file is in `zip` format, and will need to be unzipped.  

```  
unzip terraform_1.1.4_linux_amd64.zip  
```  

## Configure Azure credentials  
To fetch the credentials for authenticating with Azure, run the following command in the terminal. The command is run on Azure CLI.  

```  
az ad sp create-for-rbac --name <service_principal_name> --role Contributor  
```  

The output of the command is a JSON object.  

Add the object a secret in your github repository.  

## Specify service principal credentials in environment variables  

```
export ARM_SUBSCRIPTION_ID="<azure_subscription_id>"
export ARM_TENANT_ID="<azure_subscription_tenant_id>"
export ARM_CLIENT_ID="<service_principal_appid>"
export ARM_CLIENT_SECRET="<service_principal_password>"  
```  

## Create Terraform configuration files  
Create a file named `provider.tf` and insert the following code:  

```  
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.65"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id   = var.subscription_id
  tenant_id         = var.tenant_id
  client_id         = var.client_id
  client_secret     = var.client_secret
}  
```  

Create a file named `main.tf` and insert the following code:  

```  
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                 = var.cluster_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = var.dns_prefix
  kubernetes_version   = var.kubernetes_version

  default_node_pool {
    name            = "main"
    min_count       = var.node_min_count
    max_count       = var.node_max_count
    vm_size         = var.vm_size
    os_disk_size_gb = var.disk_size
    type            = "VirtualMachineScaleSets"
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }
  
}  
```  

Create a file named `variables.tf` to declare all the variables defined in the above files, and insert the following codes:  

```  
variable "resource_group_name" { 
}

variable "location" {
    default = "eastus2"
    description = "Location of resource group"
}

variable "cluster_name" {
}

variable "dns_prefix" {
  description = "Prefix of the resource group."
}

variable "kubernetes_version" { 
    default = "1.22.5"
    description = "Kubernetes version"
}

variable "node_min_count" {
  description = "Minimum number of nodes"
}

variable "node_max_count" {
  description = "Maximum number of nodes"
}

variable "vm_size" {
  description = "Size of the Virtual Machine"
  default     = "Standard_DS2_v2"
}

variable "disk_size" {
    default     = 250
    description = "Operating system disk size in gigabytes"
}

variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "rbac_enabled" {
  description = "Is Role Based Access Control Enabled?"
  default     = false
}

variable "subscription_id" {
}

variable "client_id" {
}

variable "client_secret" {
}

variable "tenant_id" {
}
```  

## Initialize Terraform  
This downloads the Azure modules required to create an Azure resource group.  

Terraform is initialized by running the following code:

```  
terraform init  
```  

## Validate Terraform configurations  
This validates the configurations defined in the terraform files for the infrastructure's desired state.  

Terraform configurations are validated by running the following code:  

```  
terraform validate  
```  

## Create a Terraform execution plan  
This determines what actions are necessary to create the configuration defined in your terraform files.  

Terraform plan is created by running the following code:  

```  
terraform plan  
```  

## Apply a Terraform execution plan  
This creates the infrastruture defined in your configuration files.  

You achieve this by running the following code:  

```  
terraform apply  
```  
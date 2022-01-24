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
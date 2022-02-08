## Setting up Credentials for Terraform on Azure
### Creating a Service Principal using the Azure CLI

Firstly, login to the Azure CLI using:
` az login `
Once logged in - it's possible to list the Subscriptions associated with the account via:
` az account list`

The output (similar to below) will display one or more Subscriptions - with the id field being the subscription_id field referenced above.

```
[
  {
    "cloudName": "AzureCloud",
    "id": "00000000-0000-0000-0000-000000000000",
    "isDefault": true,
    "name": "PAYG Subscription",
    "state": "Enabled",
    "tenantId": "00000000-0000-0000-0000-000000000000",
    "user": {
      "name": "user@example.com",
      "type": "user"
    }
  }
]
```

If you have more than one Subscription, you can specify the Subscription to use via the following command:
` az account set --subscription="SUBSCRIPTION_ID" `
We can now create the Service Principal which will have permissions to manage resources in the specified Subscription using the following command:

` az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/SUBSCRIPTION_ID" `
This command will output 5 values:
```
{
  "appId": "00000000-0000-0000-0000-000000000000",
  "displayName": "azure-cli-2017-06-05-10-41-15",
  "name": "http://azure-cli-2017-06-05-10-41-15",
  "password": "0000-0000-0000-0000-000000000000",
  "tenant": "00000000-0000-0000-0000-000000000000"
}
```
These values map to the Terraform variables like so:

`appId` is the `client_id` defined above.

`password` is the `client_secret` defined above.

`tenant` is the `tenant_id` defined above.

## Quick Guide to running the terraform module

#### Steps
1. Configure terraform provider
2. Initialize the terraform module
3. Plan the configuration
4. Apply the configuration

#### Breakdown
1. Configure the terraform provider
    - In the example directory, copy the `vars.tfvars.template` file into `vars.tfvars`

    - Replace the client_id, client_secret, tenant_id and subscription_id with your own configuration

    - Edit the other variables to your needs

2. Initialize the terraform modules
    Once the variables are set, initialize the deployment with `terraform init`

3. Plan the configuration
    After initialization, you need to see the plan of your configuration, you can do that by running
    `terraform plan`

4. Apply the configuration
    After you have gone through the plan and seen that everything is configured correctly, you can apply the deployment, do this with `terraform apply`

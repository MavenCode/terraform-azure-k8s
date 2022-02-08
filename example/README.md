## Quick Guide to running the terraform module

1. Configure terraform provider
2. Initialize the terraform module
3. Plan the configuration
4. Apply the configuration

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
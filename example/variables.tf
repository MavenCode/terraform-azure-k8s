variable "resource_group_name" {}
variable "resource_group_location" {}
variable "cluster_name" {}
variable "create_aks" {}
variable "k8s_version" {}

# node pool
variable "node_pool_name" {}
variable "node_pool_count" {}
variable "node_pool_vm_size" {}
variable "node_pool_osdisk_size" {}
variable "node_pool_max_count" {}
variable "node_pool_min_count" {}
variable "network_plugin" {}
variable "load_balancer_sku" {}
variable "dns_prefix" {}


variable "env" {}


variable "client_id" {}
variable "subscription_id" {}
variable "client_secret" {}
variable "tenant_id" {}


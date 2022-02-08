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

variable "network_plugin" {}
variable "load_balancer_sku" {}

variable "client_id" {}
variable "client_secret" {}


variable "env" {}

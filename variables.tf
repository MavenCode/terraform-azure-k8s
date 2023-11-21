variable "resource_group_name" {}
variable "resource_group_location" {}
variable "cluster_name" {}
variable "k8s_version" {}
variable "enable_auto_scaling" {}

# node pool
variable "node_pool_name" {}
variable "node_pool_vm_size" {}
variable "node_pool_osdisk_size" {}
variable "node_pool_max_count" {}
variable "node_pool_min_count" {}
variable "network_plugin" {}
variable "load_balancer_sku" {}
variable "dns_prefix" {}

variable "client_id" {}
variable "client_secret" {}

variable "env" {}

# virtual network and subnet
variable "vnet_name" {}
variable "subnet_name" {}

variable "vnet_address_range" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_address_range" {
  description = "The address prefixes for the subnet"
  type        = list(string)
}

variable "vnet_exists" {}

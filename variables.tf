variable "resource_group_name" {}

variable "resource_group_location" {
    default = "eastus2"
    description = "Location of resource group"
}
variable "cluster_name" {}

variable "kubernetes_version" {
    default = "1.22.5"
    description = "Kubernetes version"
}

variable "dns_prefix" {
    description = "Prefix of the resource group."
}

# node pool
variable "vm_size" {
    description = "Size of the Virtual Machine"
  default     = "Standard_DS2_v2"
}

variable "disk_size" {
    default     = 250
    description = "Operating system disk size in gigabytes"
}

variable "node_max_count" {
    description = "Maximum number of nodes"
}

variable "node_min_count" {
    description = "Minimum number of nodes"
}

variable "serviceprinciple_id" {}

variable "serviceprinciple_key" {}

variable "rbac_enabled" {
    description = "Is Role Based Access Control Enabled?"
  default     = false
}

variable "env" {}

variable "client_id" {}

variable "client_secret" {}

variable "subscription_id" {}

variable "tenant_id" {}
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
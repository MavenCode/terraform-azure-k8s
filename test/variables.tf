variable "resource_group_name" { 
}

variable "location" {
    default = "eastus2"
    type    = string
    description = "zone for aks cluster"
}

variable "cluster_name" {
}

variable "dns_prefix" {
  description = "(Required) Base name used by resources (cluster name, main service and others)."
  type        = string
}

variable "kubernetes_version" { 
    default = "1.22.5"
    type    = string   
    description = "kubernetes version"
}

variable "node_min_count" {
  description = "(Required) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
  type        = number
}

variable "node_max_count" {
  description = "(Required) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
  type        = number
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "disk_size" {
    default     = 250
    type        = number
    description = "os disk size in gigabytes"
}

variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "rbac_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  type        = bool
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
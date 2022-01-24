variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "resource_group_name" { 
}

variable "prefix" {
  description = "(Required) Base name used by resources (cluster name, main service and others)."
  type        = string
}

variable "location" {
    default = "eastus2"
    type    = string
    description = "zone for aks cluster"
}

variable "node_count" {
  description = "(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100 and between min_count and max_count."
  type        = string
}

variable "node_min_count" {
  description = "(Required) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
  type        = number
}

variable "node_max_count" {
  description = "(Required) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
  type        = number
}

variable "rbac_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "vm_size" {
  description = "(Required) The size of the Virtual Machine, such as Standard_DS2_v2."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 110
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "cluster_name" {
}

variable "env" {    
}

variable "kubernetes_version" { 
    default = "1.22.5"
    type    = string   
    description = "kubernetes version"
}

variable "disk_size" {
    default     = 250
    type        = number
    description = "os disk size in gigabytes"
}
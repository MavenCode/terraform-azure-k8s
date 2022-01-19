variable "serviceprinciple_id" {
}

variable "serviceprinciple_key" {
}

variable "storage_account_name" {
}

variable "container_name" {
}

variable "key" {
}

variable "subscription_id" {
}

variable "tenant_id" {
}

variable "resource_group_name" { 
}

variable "location" {
    default = "eastus2"
    type    = string
    description = "zone for aks cluster"

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

variable "disk-size" {
    default     = 250
    type        = number
    description = "os disk size in gigabytes"
}
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
variable "dns_prefix" {}
variable "load_balancer_sku" {}

variable "client_id" {}
variable "client_secret" {}

variable "api_server_authorized_ip_ranges" {
  description = "Ip ranges allowed to interact with Kubernetes API. Default no restrictions"
  type        = list(string)
  default     = []
}

variable "private_cluster_enabled" {
  description = "Configure AKS as a Private Cluster: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_cluster_enabled"
  type        = bool
  default     = true
}

variable "env" {}

variable "subnet_id" {}

variable "umid_name" {}
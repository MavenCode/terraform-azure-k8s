resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                 = var.cluster_name
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = var.dns_prefix
  kubernetes_version   = var.kubernetes_version

  default_node_pool {
    name            = "main"
    min_count       = var.node_min_count
    max_count       = var.node_max_count
    vm_size         = var.vm_size
    os_disk_size_gb = var.disk_size
    type            = "VirtualMachineScaleSets"
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }
  
}
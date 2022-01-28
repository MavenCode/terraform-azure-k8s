resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = var.cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "main"
    vm_size             = var.vm_size
    type                = "VirtualMachineScaleSets"
    os_disk_size_gb     = var.disk_size
    enable_auto_scaling = true
    max_count           = var.node_max_count
    min_count           = var.node_min_count
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  tags = {
    Environment = var.env
  }
}
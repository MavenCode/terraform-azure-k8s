resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-aks"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                 = "${var.cluster_name}-cluster"
  location             = azurerm_resource_group.rg.location
  resource_group_name  = azurerm_resource_group.rg.name
  dns_prefix           = "${local.prefix}-dns"
  kubernetes_version   = var.kubernetes_version

  default_node_pool {
    name            = "main"
    vnet_subnet_id  = var.subnet_id
    node_count      = var.node_count
    min_count       = var.node_min_count
    max_count       = var.node_max_count
    max_pods        = var.max_pods
    vm_size         = var.vm_size
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = var.disk_size
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  role_based_access_control {
    enabled = var.rbac_enabled
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  identity {
    type  = "SystemAssigned"
  }

  tags = var.tags
  
}

resource "azurerm_virtual_network" "azure-vnet" {
  name                = "${var.vnet_name}-vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}
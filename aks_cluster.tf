data "azurerm_virtual_network" "existing_aks_vnet" {
  count                 = var.vnet_exists ? 1 : 0
  name                  = var.vnet_name
  resource_group_name   = var.resource_group_name
}

data "azurerm_subnet" "existing_aks_subnet" {
  count                 = var.vnet_exists ? 1 : 0
  name                  = var.subnet_name
  virtual_network_name  = var.vnet_name
  resource_group_name   = var.resource_group_name
}

locals {
  vnet_exists = length(data.azurerm_virtual_network.existing_aks_vnet) > 0
}

resource "azurerm_virtual_network" "aks_vnet" {
  count               = local.vnet_exists ? 0 : 1
  name                = var.vnet_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_range
}

resource "azurerm_subnet" "aks_subnet" {
  count                = local.vnet_exists ? 0 : 1
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.subnet_address_range

  depends_on = [
    azurerm_virtual_network.aks_vnet
  ]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "${var.cluster_name}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.k8s_version

  default_node_pool {
    name                 = var.node_pool_name
    orchestrator_version = var.k8s_version
    vm_size              = var.node_pool_vm_size
    type                 = "VirtualMachineScaleSets"
    os_disk_size_gb      = var.node_pool_osdisk_size
    enable_auto_scaling  = var.enable_auto_scaling ? true : false
    max_count            = var.enable_auto_scaling ? var.node_pool_max_count : null
    min_count            = var.enable_auto_scaling ? var.node_pool_min_count : null
    vnet_subnet_id       = length(data.azurerm_subnet.existing_aks_subnet) > 0 ? data.azurerm_subnet.existing_aks_subnet[0].id : azurerm_subnet.aks_subnet[0].id
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[1],
    ]
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.is_internal_lb ? "Basic" : "Standard"
  }

  tags = {
    Environment = var.env
  }

  depends_on = [
    azurerm_subnet.aks_subnet
  ]
}

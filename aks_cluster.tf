data "azurerm_virtual_network" "existing_aks_vnet" {
  name                = var.aks_vnet_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

resource "azurerm_virtual_network" "aks_vnet" {
  count               = data.azurerm_virtual_network.existing_aks_vnet ? 0 : 1
  name                = var.aks_vnet_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_range
}

data "azurerm_subnet" "aks_subnet" {
   count                = var.aks_subnet_name != "" && var.subnet_address_range == "" ? 1 : 0
   name                 = var.aks_subnet_name
   virtual_network_name = var.aks_vnet_name
   resource_group_name  = var.resource_group_name
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
    vnet_subnet_id       = data.azurerm_subnet.aks_subnet.id
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
    load_balancer_sku = var.load_balancer_sku
  }

  tags = {
    Environment = var.env
  }
}

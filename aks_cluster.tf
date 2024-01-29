resource "azurerm_kubernetes_cluster" "k8s" {
  name                             = "${var.cluster_name}"
  location                         = var.resource_group_location
  resource_group_name              = var.resource_group_name
  dns_prefix                       = var.dns_prefix
  kubernetes_version               = var.k8s_version
  api_server_authorized_ip_ranges  = var.private_cluster_enabled ? null : var.api_server_authorized_ip_ranges
  private_cluster_enabled          = var.private_cluster_enabled

  default_node_pool {
    name                 = var.node_pool_name
    orchestrator_version = var.k8s_version
    vm_size              = var.node_pool_vm_size
    type                 = "VirtualMachineScaleSets"
    os_disk_size_gb      = var.node_pool_osdisk_size
    enable_auto_scaling  = var.enable_auto_scaling ? true : false
    max_count            = var.enable_auto_scaling ? var.node_pool_max_count : null
    min_count            = var.enable_auto_scaling ? var.node_pool_min_count : null
    vnet_subnet_id       = length(var.existing_subnet) > 0 ? var.existing_subnet_id : var.new_subnet_id
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

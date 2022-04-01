resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

module "k8s_setup" {
  source = "../"
  create_aks              = var.create_aks
  cluster_name            = var.cluster_name
  k8s_version             = var.k8s_version
  resource_group_name     = azurerm_resource_group.rg.name
  resource_group_location = azurerm_resource_group.rg.location
  dns_prefix              = var.dns_prefix
  node_pool_name          = var.node_pool_name
  node_pool_count         = var.node_pool_count
  node_pool_vm_size       = var.node_pool_vm_size
  node_pool_osdisk_size   = var.node_pool_osdisk_size
  node_pool_max_count     = var.node_pool_max_count
  node_pool_min_count     = var.node_pool_min_count
  network_plugin          = var.network_plugin
  load_balancer_sku       = var.load_balancer_sku
  env                     = var.env
  client_id               = var.client_id
  client_secret           = var.client_secret

}

resource "azurerm_resource_group" "resource-group" {
  name     = "${var.resource_group_name}-aks"
  location = var.location
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                 = "${var.cluster_name}-cluster"
  location             = azurerm_resource_group.resource-group.location
  resource_group_name  = azurerm_resource_group.resource-group.name
  dns_prefix           = "mavenk8scluster"
  kubernetes_version   = var.kubernetes_version

  default_node_pool {
    name            = "default"
    node_count      = "2"
    vm_size         = "Standard_E4s_v3"
    type            = "VirtualMachineScaleSets"
    os_disk_size_gb = var.disk_size
  }

  service_principal {
    client_id     = var.serviceprinciple_id
    client_secret = var.serviceprinciple_key
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "Standard"
  }

  identity {
    type  = "SystemAssigned"
  }

  tags = {
    Environment = var.env
  }
}

resource "azurerm_virtual_network" "azure-vnet" {
  name                = "maven-vnet"
  resource_group_name = azurerm_resource_group.resource-group.name
  location            = azurerm_resource_group.resource-group.location
  address_space       = ["10.30.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "terraform-aks-subnet"
  resource_group_name  = azurerm_resource_group.resource-group.name
  virtual_network_name = azurerm_virtual_network.azure-vnet.name
  address_prefix       = "10.30.1.0/24"
}
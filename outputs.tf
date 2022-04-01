output "client_key" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].client_key : null
}

output "client_certificate" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].client_certificate : null
}

output "cluster_ca_certificate" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].cluster_ca_certificate : null
}

output "cluster_username" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].username : null
}

output "cluster_password" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].password : null
}

output "kube_config" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config_raw : null
  sensitive = true
}

output "host" {
  value = var.create_aks ? azurerm_kubernetes_cluster.k8s[0].kube_config[0].host : null
}
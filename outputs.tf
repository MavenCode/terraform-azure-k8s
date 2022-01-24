output "service_principal_id" {
    description = "Service Principal ID"
    value       = azurerm_kubernetes_cluster.k8s.service_principal[0].client_id
}
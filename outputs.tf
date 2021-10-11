output "kubernetes_cluster_id" {
  value = azurerm_kubernetes_cluster.my.id
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.my.name
}

output "monitor_action_group_id" {
  value = azurerm_monitor_action_group.my.id
}

output "monitor_scheduled_query_rules_alert_id" {
  value = azurerm_monitor_scheduled_query_rules_alert.my.id
}
data "azurerm_resource_group" "my" {
  name = var.resource_group_name
}

data "azurerm_log_analytics_workspace" "my" {
  name = var.log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.my.name
}

data "azuread_group" "admin" {
  object_id = var.group_admin_id
}

data "azurerm_kubernetes_service_versions" "current" {
  location        = data.azurerm_resource_group.my.location
  include_preview = false
}

locals {
  aks_cluster_name = "${var.base_name}-${var.environment}"
  query_rules_alert    = "${var.base_name}-${var.environment}-query-rules-alert"

  tags = {
    app         = var.base_name
    environment = var.environment
    creator     = "terraform"
    created_on  = formatdate("YYYY MMM DD hh:mm ZZZ", timestamp())
  }
}

// Create cluster

resource "azurerm_kubernetes_cluster" "my" {
  name                            = local.aks_cluster_name
  location                        = data.azurerm_resource_group.my.location
  resource_group_name             = data.azurerm_resource_group.my.name
  dns_prefix                      = local.aks_cluster_name
  kubernetes_version              = var.kubernetes_version != null ? var.kubernetes_version : data.azurerm_kubernetes_service_versions.current.latest_version
  private_cluster_enabled         = var.private_cluster_enabled
  api_server_authorized_ip_ranges = var.api_authorized_ips

  default_node_pool {
    name                = "default"
    vm_size             = var.vm_size
    enable_auto_scaling = true
    node_count          = var.node_count
    max_count           = var.max_count
    min_count           = var.min_count
    #vnet_subnet_id      = var.private_cluster_enabled ? azurerm_subnet.my[0].id : null
    max_pods            = var.max_pods
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.my.id
    }
    // Expand on if time
    // azure_policy {
    //   enabled = true
    // }
  }

  identity {
    type = "SystemAssigned"
  }

  // Expand on if time
  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed                = true
      admin_group_object_ids = [data.azuread_group.admin.id]
    }
  }

  // linux_profile {
  //   admin_username = var.admin_ssh_key.username

  //   ssh_key {
  //     key_data = var.admin_ssh_key.public_key
  //   }
  // }

  // network_profile {
  //   network_plugin    = "kubnet"
  // }

  tags = local.tags

  lifecycle {
    ignore_changes = [tags, default_node_pool[0].node_count]
  }

}

// Action group

resource "azurerm_monitor_action_group" "my" {
  name                = "CriticalAlertsAction"
  resource_group_name = data.azurerm_resource_group.my.name
  short_name          = "k8s-grp-one"

  email_receiver {
    name          = "Admin"
    email_address = var.email
  }
}

// Alert Rule

resource "azurerm_monitor_scheduled_query_rules_alert" "my" {
  name                = local.query_rules_alert
  location            = data.azurerm_resource_group.my.location
  resource_group_name = data.azurerm_resource_group.my.name

  action {
    action_group           = [azurerm_monitor_action_group.my.id]
    email_subject          = "CPU: ${var.base_name}"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_log_analytics_workspace.my.id
  description    = "K8S Container Counter Average CPU Usage Nano Cores"
  enabled        = true
  query          = <<-QUERY
  Perf
    | where ObjectName == K8SContainer and CounterName == cpuUsageNanoCores
    | summarize AvgCPUUsageNanoCores = avg(CounterValue) by bin(TimeGenerated, 30m), InstanceName, _ResourceId
QUERY
  severity       = 1
  frequency      = 5
  time_window    = 30
  trigger {
    operator  = "GreaterThan"
    threshold = 12
    metric_trigger {
      operator            = "GreaterThan"
      threshold           = 12
      metric_trigger_type = "Total"
      metric_column       = "operation_Name"
    }
  }
}

# tf-template

<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | 2.6.0 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.my](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_monitor_action_group.my](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_action_group) | resource |
| [azurerm_monitor_scheduled_query_rules_alert.my](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_scheduled_query_rules_alert) | resource |
| [azuread_group.admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azurerm_kubernetes_service_versions.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/kubernetes_service_versions) | data source |
| [azurerm_log_analytics_workspace.my](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |
| [azurerm_resource_group.my](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_authorized_ips"></a> [api\_authorized\_ips](#input\_api\_authorized\_ips) | Restricts access to specified IP address ranges to access Kubernetes servers | `list(any)` | `[]` | no |
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | Base for resource naming | `string` | `"aks-mod"` | no |
| <a name="input_email"></a> [email](#input\_email) | Email address for alerts | `string` | `"root@localhost"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Base for resource naming | `string` | `"test"` | no |
| <a name="input_group_admin_id"></a> [group\_admin\_id](#input\_group\_admin\_id) | The ID of the admin group | `string` | `""` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | n/a | `string` | `null` | no |
| <a name="input_load_balancer_sku"></a> [load\_balancer\_sku](#input\_load\_balancer\_sku) | Specifies the SKU of the Load Balancer used for this Kubernetes Cluster | `string` | `"Standard"` | no |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | The name of the analytics workspace | `string` | `""` | no |
| <a name="input_max_count"></a> [max\_count](#input\_max\_count) | The maximum number of kubernetes nodes | `number` | `5` | no |
| <a name="input_max_pods"></a> [max\_pods](#input\_max\_pods) | The highest number of pods that can run on a node | `number` | `100` | no |
| <a name="input_min_count"></a> [min\_count](#input\_min\_count) | The minimum number of kubernetes nodes | `number` | `2` | no |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | Starting number of kubernetes nodes | `number` | `2` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Specifies whether a private cluster should be created | `bool` | `false` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group | `string` | `""` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | Size of nodes in the cluster | `string` | `"Standard_D2s_v3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_cluster_id"></a> [kubernetes\_cluster\_id](#output\_kubernetes\_cluster\_id) | n/a |
| <a name="output_kubernetes_cluster_name"></a> [kubernetes\_cluster\_name](#output\_kubernetes\_cluster\_name) | n/a |
| <a name="output_monitor_action_group_id"></a> [monitor\_action\_group\_id](#output\_monitor\_action\_group\_id) | n/a |
| <a name="output_monitor_scheduled_query_rules_alert_id"></a> [monitor\_scheduled\_query\_rules\_alert\_id](#output\_monitor\_scheduled\_query\_rules\_alert\_id) | n/a |

<!--- END_TF_DOCS --->

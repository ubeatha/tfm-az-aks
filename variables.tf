variable "api_authorized_ips" {
  description = "Restricts access to specified IP address ranges to access Kubernetes servers"
  type        = list(any)
  default     = []
}

variable "email" {
  description = "Email address for alerts"
  type        = string
  default     = "root@localhost"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = ""
}

variable "log_analytics_workspace_name" {
  description = "The name of the analytics workspace"
  default     = ""
}

variable "group_admin_id" {
  description = "The ID of the admin group"
  default     = ""
}

variable "base_name" {
  description = "Base for resource naming"
  type        = string
  default     = "aks-mod"
}

variable "environment" {
  description = "Base for resource naming"
  type        = string
  default     = "test"
}

variable "private_cluster_enabled" {
  description = "Specifies whether a private cluster should be created"
  type        = bool
  default     = false
}

variable "vm_size" {
  description = "Size of nodes in the cluster"
  default     = "Standard_D2s_v3"
}

variable "node_count" {
  description = "Starting number of kubernetes nodes"
  type        = number
  default     = 2
}

variable "max_count" {
  description = "The maximum number of kubernetes nodes"
  type        = number
  default     = 5
}

variable "min_count" {
  description = "The minimum number of kubernetes nodes"
  type        = number
  default     = 2
}

variable "max_pods" {
  description = "The highest number of pods that can run on a node"
  type        = number
  default     = 100
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster"
  type        = string
  default     = "Standard"
}
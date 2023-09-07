variable "workspace_name" {
  description = "Name of the Log Analytics workspace"
}

variable "location" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "workspace_sku" {
  description = "SKU for the Log Analytics workspace"
  default     = "PerGB2018"
}

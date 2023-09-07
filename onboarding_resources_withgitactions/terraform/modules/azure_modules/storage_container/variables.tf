variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region"
}

variable "storage_account_tier" {
  description = "Storage account tier"
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage account replication type"
  default     = "LRS"
}

variable "container_name" {
  description = "Name of the Blob Storage container"
}

variable "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace to send diagnostic logs"
}

variable "keyvault_name" {
  description = "Name of the Azure Key Vault"
}

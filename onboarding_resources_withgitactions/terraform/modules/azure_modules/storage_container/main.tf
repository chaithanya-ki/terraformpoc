resource "azurerm_resource_group" "storage" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.storage.name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = var.container_access_type
}

resource "azurerm_monitor_diagnostic_setting" "diagnostic_settings" {
  name                       = "example"
  target_resource_id         = azurerm_storage_account.storage_account.id
  storage_account_id         = azurerm_storage_account.storage_account.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  log {
    category = "StorageRead"
    enabled  = true
  }

  log {
    category = "StorageWrite"
    enabled  = true
  }
}

resource "azurerm_key_vault" "key_vault" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.storage.name
  resource_group_name         = azurerm_resource_group.storage.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  enabled_for_deployment      = true
  enabled_for_template_deployment = true
  soft_delete_enabled         = true
  purge_protection_enabled    = true
}

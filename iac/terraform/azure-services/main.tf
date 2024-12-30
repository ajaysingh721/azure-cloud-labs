resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "${var.prefix}sa1231"
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "sc" {
  name                  = "${var.prefix}sc"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

resource "azurerm_key_vault" "kv" {
  name                            = "${var.prefix}kv"
  resource_group_name             = var.rg
  location                        = var.location
  sku_name                        = "Standard"
  tenant_id                       = var.tenant_id
  soft_delete_retention_days      = 7
  purge_protection_enabled        = false
  enabled_for_disk_encryption     = true
  enabled_for_deployment          = true
  enabled_for_template_deployment = true
}

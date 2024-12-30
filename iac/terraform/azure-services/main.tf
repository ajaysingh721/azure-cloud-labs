resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}

resource "azurerm_app_service_plan" "asp" {
  name                = "${var.prefix}asp"
  location            = var.location
  resource_group_name = var.rg
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.prefix}app"
  location            = var.location
  resource_group_name = var.rg
  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "DOCKER|nginx"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}

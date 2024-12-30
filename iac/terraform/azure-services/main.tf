resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}


resource "azurerm_app_service_plan" "asp" {
  name                = "${var.prefix}asp"
  resource_group_name = var.rg
  location            = var.location
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_linux_web_app" "lwa" {

  name                = "${var.prefix}lwa"
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = azurerm_app_service_plan.asp.id
  https_only          = true
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    linux_fx_version = "DOCKER|${azurerm_container_registry.acr.login_server}/app:latest"
  }
}

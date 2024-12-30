resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}


resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix}asp"
  resource_group_name = var.rg
  location            = var.location
  sku_name            = "B1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "lwa" {

  name                = "${var.prefix}lwa"
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {

  }
}

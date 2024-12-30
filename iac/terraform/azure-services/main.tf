data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "rg" {
  name = var.rg
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = true
}


resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix}-asp-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "B1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "lwa" {
  name                = "${var.prefix}-lwa-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  service_plan_id     = azurerm_service_plan.asp.id
  https_only          = true
  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  site_config {
    minimum_tls_version = "1.2"

  }

  depends_on = [azurerm_service_plan.asp]
}


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
  admin_enabled       = false

  tags = {
    environment = "dev"
  }
}

// System assigned managed identity
resource "azurerm_user_assigned_identity" "uai" {
  name                = "${var.prefix}-uai-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
}

resource "azurerm_role_assignment" "acr_role_assignment" {
  principal_id         = azurerm_user_assigned_identity.uai.principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id

  depends_on = [azurerm_container_registry.acr, azurerm_user_assigned_identity.uai]
}


resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix}-asp-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_name            = "B1"
  os_type             = "Linux"
}

resource "azurerm_linux_web_app" "lwa" {
  name                = var.web_app_name
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

// Log analytics workspace
resource "azurerm_log_analytics_workspace" "law" {
  name                = "${var.prefix}-law-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "PerGB2018"
}

resource "azurerm_application_insights" "app_insights" {
  name                = "${var.prefix}-ai-${random_integer.ri.result}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  application_type    = "web"

  tags = {
    environment = "dev"
  }
}


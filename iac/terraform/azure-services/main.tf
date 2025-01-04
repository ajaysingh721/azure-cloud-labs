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

  tags = {
    environment = "dev"
  }
}

resource "azurerm_container_group" "container_group" {
  name                = var.aci_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  os_type             = "Linux"

  container {
    name   = "acl-app-dev"
    image  = "nginix:latest"
    cpu    = "1"
    memory = "2"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  container {
    name   = "acl-app-test"
    image  = "nginix:latest"
    cpu    = "1"
    memory = "2"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}

// ontainer app environment
resource "azurerm_container_app_environment" "aca_env" {
  name                = "acl-app-prod"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id

  depends_on = [azurerm_log_analytics_workspace.law]
}

// Azure container app service
resource "azurerm_container_app" "app_service" {
  name                = "acl-prod-app"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  container_app_environment_id = azurerm_container_app_environment.aca_env.id
  revision_mode = "Single"

  template {
    container {
      name   = "examplecontainerapp"
      image  = "mcr.microsoft.com/k8se/quickstart:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  depends_on = [azurerm_container_app_environment.aca_env]
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


provider "azurerm" {
  version = ">= 1.39.0"
}

locals {
  location = "australiasoutheast"
  name     = "testing-aa"
}

# Get a random integer to provide a unique name for resources
resource "random_integer" "id" {
  min = 10000
  max = 50000
}

# Create a resource group to deploy the log analytics workspace to
module "resource-group" {
  source  = "rink72/resource-group/azurerm"
  version = "1.0.0"

  name     = "${local.name}-${random_integer.id.result}"
  location = local.location
}

# Create the log analytics workspace. Use the outputs from the resource-group module to create an implicit dependancy
module "la_workspace" {
  source  = "rink72/log-analytics-workspace/azurerm"
  version = "1.0.2"

  name                = "${local.name}-${random_integer.id.result}"
  resource_group_name = module.resource-group.name
  location            = local.location

  la_depends_on = [
    module.resource-group
  ]
}

# Create the automation account in the created resource group.
module "automation-account" {
  source = "rink72/automation-account/azurerm"
  version = "1.0.0"

  name                = "${local.name}-${random_integer.id.result}"
  resource_group_name = module.resource-group.name
  location            = local.location

  enable_diagnostics         = true
  log_analytics_workspace_id = module.la_workspace.id

  aa_depends_on = [
    module.resource-group,
    module.la_workspace
  ]
}

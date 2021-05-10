module "aks" {
  source              = "../modules/aks"
  name                = local.prefix
  environment         = var.environment
  kubernetes_version  = var.kubernetes_version
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  private_subnet      = module.vnet.private_subnets
  
  tags = merge(local.tags, { "resource_group" = azurerm_resource_group.example.name })
}

module "vnet" {
  source                    = "../modules/vnet"
  name                      = local.prefix
  resource_group_name       = azurerm_resource_group.example.name
  location                  = azurerm_resource_group.example.location
  public_subnet_prefixes    = var.public_subnet_prefixes
  private_subnet_prefixes   = var.private_subnet_prefixes
  private_service_endpoints = var.private_service_endpoints

  tags = merge(local.tags, { "resource_group" = azurerm_resource_group.example.name })
}

resource "azurerm_resource_group" "example" {
  name     = format("%s-resource-group", var.name)
  location = var.region
}

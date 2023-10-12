# Azure vWAN

resource "azurerm_resource_group" "az-cloud-network-platform-vWAN" {
  name     = "az-cloud-network-platform-dev"
  location = "West Europe"
}

resource "azurerm_virtual_wan" "az-vWAN-dev" {
  name                = "az-vWAN-dev"
  resource_group_name = azurerm_resource_group.az-cloud-network-platform-vWAN.name
  location            = azurerm_resource_group.az-cloud-network-platform-vWAN.location
}

# Virtual WAN Hubs

resource "azurerm_virtual_hub" "west-europe-hub1" {
  name                = "${var.region1}-vWAN-hub-01"
  resource_group_name = azurerm_resource_group.region1-rg1.name
  location            = var.region1
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region1-hub1-prefix1
  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_virtual_hub" "region2-vhub1" {
  name                = "${var.region2}-vWAN-hub-02"
  resource_group_name = azurerm_resource_group.region2-rg1.name
  location            = var.region2
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region2-hub1-prefix1
  tags = {
    Environment = var.environment_tag
  }
}
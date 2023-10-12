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

resource "azurerm_virtual_hub" "vWAN_hub1_region1" {
  name                = "${var.region1}-vWAN-hub1"
  resource_group_name = azurerm_resource_group.region1.name
  location            = var.region1
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region1-hub1-prefix1
  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_virtual_hub" "vWAN_hub2_region1" {
  name                = "${var.region1}-vWAN-hub2"
  resource_group_name = azurerm_resource_group.region1.name
  location            = var.region1
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region1-hub2-prefix1
  tags = {
    Environment = var.environment_tag
  }
}
resource "azurerm_virtual_hub" "vWAN_hub1_region2" {
  name                = "${var.region2}-vWAN-hub1"
  resource_group_name = azurerm_resource_group.region2.name
  location            = var.region2
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vwan-region2-hub1-prefix1
  tags = {
    Environment = var.environment_tag
  }
}

# Virtual WAN Connections

resource "azurerm_virtual_hub_connection" "region1-SpokeA" {
  name                      = "${var.region1}-conn-vnet1-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.region1-vhub1.id
  remote_virtual_network_id = azurerm_virtual_network.region1-vnet1.id
}
resource "azurerm_virtual_hub_connection" "region2-SpokeB" {
  name                      = "${var.region2}-conn-vnet1-to-vwan-hub"
  virtual_hub_id            = azurerm_virtual_hub.region2-vhub1.id
  remote_virtual_network_id = azurerm_virtual_network.region2-vnet1.id
}
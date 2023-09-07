# Create VNet, Subnets, and Route Table

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "private" {
  count               = var.create_private_subnet ? 1 : 0
  name                = "PrivateSubnet1"
  resource_group_name = azurerm_virtual_network.example.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = [var.private_subnet_prefix]
}

resource "azurerm_subnet" "public" {
  count               = var.create_public_subnet ? 1 : 0
  name                = "PublicSubnet1"
  resource_group_name = azurerm_virtual_network.example.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes    = [var.public_subnet_prefix]
}

resource "azurerm_route_table" "example" {
  name                = "example"
  resource_group_name = azurerm_virtual_network.example.resource_group_name
  location            = azurerm_virtual_network.example.location
}

resource "azurerm_subnet_route_table_association" "example" {
  count             = var.create_public_subnet ? 1 : 0
  subnet_id         = azurerm_subnet.public[0].id
  route_table_id    = azurerm_route_table.example.id
}

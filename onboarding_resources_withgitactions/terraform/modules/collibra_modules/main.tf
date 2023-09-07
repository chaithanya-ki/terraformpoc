# Resource Group
resource "azurerm_resource_group" "collibra_rg" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "collibra_vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.collibra_rg.location
  resource_group_name = azurerm_resource_group.collibra_rg.name
}

# Subnet
resource "azurerm_subnet" "collibra_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.collibra_rg.name
  virtual_network_name = azurerm_virtual_network.collibra_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

# Public IP Address (if needed)
resource "azurerm_public_ip" "collibra_public_ip" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.collibra_rg.location
  resource_group_name = azurerm_resource_group.collibra_rg.name
  allocation_method   = "Static" # or "Dynamic" as needed
}

# Network Security Group (NSG) for Collibra VM(s)
resource "azurerm_network_security_group" "collibra_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.collibra_rg.location
  resource_group_name = azurerm_resource_group.collibra_rg.name

  security_rule {
    name                       = "allow_https"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Add more security rules as needed
}

# Virtual Machine
resource "azurerm_windows_virtual_machine" "collibra_vm" {
  name                  = var.vm_name
  location              = azurerm_resource_group.collibra_rg.location
  resource_group_name   = azurerm_resource_group.collibra_rg.name
  network_interface_ids = [azurerm_network_interface.collibra_nic.id]
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}

# Network Interface for VM
resource "azurerm_network_interface" "collibra_nic" {
  name                = var.nic_name
  location            = azurerm_resource_group.collibra_rg.location
  resource_group_name = azurerm_resource_group.collibra_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.collibra_subnet.id
    private_ip_address_allocation = "Dynamic" # or "Static" as needed
    public_ip_address_id           = azurerm_public_ip.collibra_public_ip.id # Optional, use if needed
  }
}

# Example: Storage Account for Collibra Data
resource "azurerm_storage_account" "collibra_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.collibra_rg.name
  location                 = azurerm_resource_group.collibra_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Define other resources for Collibra as needed (e.g., databases, additional VMs,

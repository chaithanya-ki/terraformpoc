variable "resource_group_name" {
  description = "Name of the Azure resource group"
}

variable "location" {
  description = "Azure region"
}

variable "virtual_network_name" {
  description = "Name of the Azure virtual network"
}

variable "virtual_network_address_space" {
  description = "Address space for the Azure virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Azure subnet"
}

variable "subnet_address_prefix" {
  description = "CIDR block for the Azure subnet"
}

variable "public_ip_name" {
  description = "Name of the Azure public IP address (if used)"
}

variable "nsg_name" {
  description = "Name of the Azure Network Security Group"
}

variable "vm_name" {
  description = "Name of the Collibra virtual machine"
}

variable "vm_size" {
  description = "Size of the Collibra virtual machine"
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
}

variable "admin_password"

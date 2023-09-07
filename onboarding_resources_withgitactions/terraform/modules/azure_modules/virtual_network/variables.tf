variable "vnet_name" {
  description = "Name of the virtual network"
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "location" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "create_private_subnet" {
  description = "Create the private subnet?"
  type        = bool
  default     = true
}

variable "private_subnet_prefix" {
  description = "CIDR block for the private subnet"
  default     = "10.0.1.0/24"
}

variable "create_public_subnet" {
  description = "Create the public subnet?"
  type        = bool
  default     = true
}

variable "public_subnet_prefix" {
  description = "CIDR block for the public subnet"
  default     = "10.0.2.0/24"
}

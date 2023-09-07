output "private_subnet_id" {
  value = var.create_private_subnet ? azurerm_subnet.private[0].id : null
}

output "public_subnet_id" {
  value = var.create_public_subnet ? azurerm_subnet.public[0].id : null
}

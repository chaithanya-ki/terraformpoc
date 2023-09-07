# Create an Azure AD Group
resource "azuread_group" "example" {
  name = var.group_name
}

# Assign users to the group if needed
# resource "azuread_group_member" "example" {
#   group_id   = azuread_group.example.id
#   member_ids = var.user_ids
# }

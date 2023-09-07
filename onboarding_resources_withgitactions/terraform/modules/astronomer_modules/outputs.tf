output "workspace_id" {
  description = "ID of the created Astronomer workspace"
  value       = null_resource.create_astronomer_resources.triggers["workspace_id"]
}

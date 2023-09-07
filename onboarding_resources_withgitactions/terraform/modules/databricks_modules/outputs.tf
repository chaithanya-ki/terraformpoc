output "workspace_id" {
  description = "ID of the Databricks workspace"
  value       = databricks_workspace.workspace.id
}

output "cluster_id" {
  description = "ID of the Databricks cluster"
  value       = databricks_cluster.example_cluster.id
}

output "cluster_private_ip" {
  description = "Private IP address of the Databricks cluster"
  value       = databricks_cluster.example_cluster.private_ip
}

output "metastore_id" {
  description = "ID of the Databricks Metastore"
  value       = databricks_metastore.example_metastore.id
}

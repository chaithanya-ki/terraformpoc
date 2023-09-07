provider "null" {}

resource "null_resource" "create_astronomer_resources" {
  triggers = {
    # Trigger whenever API token or organization ID changes
    api_token         = var.api_token
    organization_id   = var.organization_id
    workspace_name    = var.workspace_name
    workspace_id      = var.workspace_id
  }

  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash

      # Function to create a workspace
      create_workspace() {
        local api_token="$1"
        local organization_id="$2"
        local workspace_name="$3"

        local workspace_payload='{
          "name": "'"$workspace_name"'",
          "organization_id": "'"$organization_id"'"
          # Add other workspace settings here
        }'

        local workspace_response=$(curl -X POST -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" -d "$workspace_payload" https://api.astronomer.io/api/v0/workspace)

        if [ "$(echo "$workspace_response" | jq -r '.status')" == "success" ]; then
          echo "Workspace created successfully!"
          echo "$workspace_response"
          echo
          echo "Workspace ID: $(echo "$workspace_response" | jq -r '.data.id')"
        else
          echo "Failed to create workspace."
          echo "$workspace_response"
          exit 1
        fi
      }

      # Function to create entitlements
      create_entitlements() {
        local api_token="$1"
        local workspace_id="$2"

        local entitlements_payload='{
          "workspace_id": "'"$workspace_id"'",
          "entitlements": [
            {
              "user_id": "user-id-1",
              "role": "viewer"
            },
            {
              "user_id": "user-id-2",
              "role": "editor"
            }
            # Add more entitlements as needed
          ]
        }

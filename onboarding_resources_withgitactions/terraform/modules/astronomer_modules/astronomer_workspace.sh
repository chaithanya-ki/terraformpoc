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
  }'

  local entitlements_response=$(curl -X POST -H "Authorization: Bearer $api_token" -H "Content-Type: application/json" -d "$entitlements_payload" https://api.astronomer.io/api/v0/entitlements)

  if [ "$(echo "$entitlements_response" | jq -r '.status')" == "success" ]; then
    echo "Entitlements created successfully!"
    echo "$entitlements_response"
  else
    echo "Failed to create entitlements."
    echo "$entitlements_response"
    exit 1
  fi
}

# Set  API token and organization ID
API_TOKEN="API_TOKEN"
ORGANIZATION_ID="organization-id"

# Create the Astronomer workspace
WORKSPACE_NAME="MyWorkspace"
create_workspace "$API_TOKEN" "$ORGANIZATION_ID" "$WORKSPACE_NAME"

# Create the entitlements
#  have the workspace ID from the previous step
WORKSPACE_ID="workspace-id-from-previous-step"
create_entitlements "$API_TOKEN" "$WORKSPACE_ID"

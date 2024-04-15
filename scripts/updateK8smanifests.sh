#!/bin/bash

set -x

# Set the repository URL
REPO_URL="https://$1@dev.azure.com/atharvarthakur/voting-app/_git/voting-app"

# Clean up previous temporary directory if it exists
rm -rf /tmp/temp_repo

# Clone the git repository into the /tmp directory
git clone "$REPO_URL" /tmp/temp_repo

# Navigate into the cloned repository directory
cd /tmp/temp_repo

# Make changes to the Kubernetes manifest file(s)
# For example, let's say you want to change the image tag in a deployment.yaml file
sed -i "s|image:.*|image: votingappcontainerregistry.azurecr.io/$3:$4|g" k8s-specifications/$2-deployment.yaml

# Add the modified files
git add .

# Commit the changes
git commit -m "Update Kubernetes manifest"

# Push the changes back to the repository
git push origin main

# Cleanup: remove the temporary directory
rm -rf /tmp/temp_repo


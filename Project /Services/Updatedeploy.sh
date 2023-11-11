#!/bin/bash

# GitHub repository information
GIT_REPO_NAME="Docker-Zero-to-Hero"
GIT_USER_NAME="shishirv133"
GITHUB_TOKEN="your-github-token"

# Jenkins build number
BUILD_NUMBER=${BUILD_NUMBER}  # Replace with your actual Jenkins build number

# List of deployment YAML files
DEPLOYMENT_FILES=("customer service.yml" "orderservice & productservice.yml" )

# Base branch (usually 'main' or 'master')
BASE_BRANCH="main"

# GitHub API URL
GITHUB_API="https://api.github.com/repos/${GIT_USER_NAME}/${GIT_REPO_NAME}"

# Loop through each deployment file
for FILE in "${DEPLOYMENT_FILES[@]}"
do
    # Replace the placeholder with the Jenkins build number
    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" "$FILE"

    # Commit the changes
    git add "$FILE"
    git commit -m "Update deployment image to version ${BUILD_NUMBER}" "$FILE"
done

# Push the changes to the base branch
git push origin "${BASE_BRANCH}"

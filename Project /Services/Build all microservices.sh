#!/bin/bash

# GitHub repositories for the microservices
ORDER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/OrderService.git"
PRODUCT_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/ProductService.git"
CUSTOMER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/CustomerService.git"

# Function to clone and build a microservice
clone_and_build() {
    local repo_url="$1"
    local service_name="$2"

    # Clone the repository
    echo "Cloning $service_name..."
    git clone $repo_url || { echo "Error cloning $service_name repository"; exit 1; }

    # Build the microservice
    echo "Building $service_name..."
    cd $service_name
    mvn clean package || { echo "Error building $service_name"; exit 1; }
    cd ..

    echo "Build process completed for $service_name."
}

# Clone and build OrderService
clone_and_build "$ORDER_SERVICE_REPO" "OrderService"

# Clone and build ProductService
clone_and_build "$PRODUCT_SERVICE_REPO" "ProductService"

# Clone and build CustomerService
clone_and_build "$CUSTOMER_SERVICE_REPO" "CustomerService"

# Cleanup: Remove the cloned repositories
echo "Cleaning up..."
rm -rf OrderService ProductService CustomerService

echo "Build process completed for all microservices."

#!/bin/bash

# Dockerfile location  for the microservices
ORDER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/OrderService.git"
PRODUCT_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/ProductService.git"
CUSTOMER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME}/CustomerService.git

# Function to build a microservice
build_microservice() {
    local dockerfile_url="$1"
    local service_name="$2"

    # Download the Dockerfile
    echo "Downloading Dockerfile for $service_name..."
    curl -sSLJO $dockerfile_url || { echo "Error downloading Dockerfile for $service_name"; exit 1; }

    # Build the microservice
    echo "Building $service_name..."
    docker build -t ${DOCKER_USERNAME}/${service_name}:${BUILD_NUMBER} -f Dockerfile . || { echo "Error building $service_name"; exit 1; }
    docker push ${DOCKER_USERNAME}/${service_name}:${BUILD_NUMBER} || { echo "Error pushing Docker image for $service_name"; exit 1; }
    rm Dockerfile

    echo "Build process completed for $service_name."
}

# Build OrderService
build_microservice "$ORDER_SERVICE_REPO" "OrderService"

# Build ProductService
build_microservice "$PRODUCT_SERVICE_REPO" "ProductService"

# Build CustomerService
build_microservice "$CUSTOMER_SERVICE_REPO" "CustomerService"

echo "Build process completed for all microservices."

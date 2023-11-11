#!/bin/bash

# GitHub repositories for the microservices
ORDER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}//${GIT_REPO_NAME}/OrderService.git"
PRODUCT_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}//${GIT_REPO_NAME}/ProductService.git"
CUSTOMER_SERVICE_REPO="https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}//${GIT_REPO_NAME}/CustomerService.git"

# Clone and build OrderService
echo "Building OrderService..."
git clone $ORDER_SERVICE_REPO
cd OrderService
mvn clean package
cd ..

# Clone and build ProductService
echo "Building ProductService..."
git clone $PRODUCT_SERVICE_REPO
cd ProductService
mvn clean package
cd ..

# Clone and build CustomerService
echo "Building CustomerService..."
git clone $CUSTOMER_SERVICE_REPO
cd CustomerService
mvn clean package
cd ..

# Cleanup: Remove the cloned repositories
echo "Cleaning up..."
rm -rf OrderService ProductService CustomerService


echo "Build process completed for all microservices."

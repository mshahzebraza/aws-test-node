#!/bin/bash

# Set variables
REPO_NAME="test-express-app-ecr"
REGION="us-east-1"  # Change this to your desired AWS region

# Create ECR repository
echo "Creating ECR repository: $REPO_NAME in region: $REGION"
aws ecr create-repository --repository-name $REPO_NAME --region $REGION

# Output repository URI
REPO_URI=$(aws ecr describe-repositories --repository-names $REPO_NAME --region $REGION --query 'repositories[0].repositoryUri' --output text)
echo "ECR repository created: $REPO_URI"

echo "Remember to update your GitHub secrets with the new ECR_REPOSITORY_URI." 
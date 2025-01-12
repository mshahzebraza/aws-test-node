#!/bin/bash

# Variables
AWS_REGION="us-east-1"  # Change to your desired region
ECR_REPOSITORY_NAME="test-express-app-ecr"

IMAGE_TAG="latest"  # You can use a different tag, like a version number
# Get the AWS account ID currently logged in
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Build the Docker image
echo "Building Docker image..."
docker build -t $ECR_REPOSITORY_NAME .

# Tag the Docker image 
echo "Tagging Docker image..."
docker tag $ECR_REPOSITORY_NAME:latest $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$IMAGE_TAG

# Authenticate Docker to ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

# Push the Docker image to ECR
echo "Pushing Docker image to ECR..."
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$IMAGE_TAG

# Output the image URL
echo "Image URL: $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME:$IMAGE_TAG"

echo "Docker image pushed to ECR successfully!"

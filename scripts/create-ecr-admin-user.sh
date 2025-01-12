#!/bin/bash

# Set variables
IAM_USER_NAME="ecr-admin-test-express-app"
POLICY_NAME="ECRFullAccessTestExpressApp"

# Create IAM user
echo "Creating IAM user: $IAM_USER_NAME"
aws iam create-user --user-name $IAM_USER_NAME

# Attach AWS managed policy for ECR full access
echo "Attaching ECR full access policy"
aws iam attach-user-policy \
    --user-name $IAM_USER_NAME \
    --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess

# Create access key
echo "Creating access key for $IAM_USER_NAME"
aws iam create-access-key --user-name $IAM_USER_NAME

echo "Setup complete! Please save the access key information displayed above."
echo "Remember to store these credentials securely and add them to your GitHub repository secrets." 
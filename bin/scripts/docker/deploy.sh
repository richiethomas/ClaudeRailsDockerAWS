#!/bin/bash
set -e

IMAGE_NAME="982534370940.dkr.ecr.us-east-1.amazonaws.com/blog-app:latest"

echo "Fetching parameters from Parameter Store..."

# Fetch parameters
SECRET_KEY_BASE=$(aws ssm get-parameter --name /blog-app/production/SECRET_KEY_BASE --with-decryption --query 'Parameter.Value' --output text)
DATABASE_URL=$(aws ssm get-parameter --name /blog-app/production/DATABASE_URL --with-decryption --query 'Parameter.Value' --output text)
DD_ENV=$(aws ssm get-parameter --name /blog-app/production/DD_ENV --query 'Parameter.Value' --output text)
DD_SERVICE=$(aws ssm get-parameter --name /blog-app/production/DD_SERVICE --query 'Parameter.Value' --output text)
DD_AGENT_HOST=$(aws ssm get-parameter --name /blog-app/production/DD_AGENT_HOST --query 'Parameter.Value' --output text)

echo "Stopping old container..."
docker stop blog-app || true
docker rm blog-app || true

echo "Authenticating with ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 982534370940.dkr.ecr.us-east-1.amazonaws.com

echo "Pulling latest image..."
docker pull $IMAGE_NAME 

echo "Extracting version from image..."
VERSION=$(docker inspect $IMAGE_NAME --format='{{index .Config.Labels "git.sha"}}')
echo "Deploying version: $VERSION"

echo "Starting new container..."
docker run -d \
  --name blog-app \
  --network host \
  -e RAILS_ENV=production \
  -e SECRET_KEY_BASE="$SECRET_KEY_BASE" \
  -e DATABASE_URL="$DATABASE_URL" \
  -e DD_AGENT_HOST="$DD_AGENT_HOST" \
  -e DD_ENV="$DD_ENV" \
  -e DD_VERSION="$VERSION" \
  -e DD_SERVICE="$DD_SERVICE" \
  $IMAGE_NAME

echo "Deployment complete! Version $VERSION is now running."
docker ps
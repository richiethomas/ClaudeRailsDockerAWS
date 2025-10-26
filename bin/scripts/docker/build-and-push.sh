#!/bin/bash
set -e

# Get git commit SHA (short version)
GIT_SHA=$(git rev-parse --short HEAD)
IMAGE_NAME="982534370940.dkr.ecr.us-east-1.amazonaws.com/blog-app"

echo "Building Docker image for version: $GIT_SHA"

# Build with git SHA label
docker build \
  --build-arg GIT_SHA=$GIT_SHA \
  -t $IMAGE_NAME:$GIT_SHA \
  -t $IMAGE_NAME:latest \
  .

echo "✓ Build complete!"
echo "  Tagged as: $IMAGE_NAME:$GIT_SHA"
echo "  Tagged as: $IMAGE_NAME:latest"

# Ask if user wants to push
read -p "Push to ECR? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Logging into ECR..."
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 982534370940.dkr.ecr.us-east-1.amazonaws.com

    echo "Pushing $IMAGE_NAME:$GIT_SHA..."
    docker push $IMAGE_NAME:$GIT_SHA

    echo "Pushing $IMAGE_NAME:latest..."
    docker push $IMAGE_NAME:latest

    echo "✓ Push complete!"
    echo ""
    echo "To deploy this version on EC2, run:"
    echo "  ./deploy-blog-app.sh"
else
    echo "Skipped push. To push later, run:"
    echo "  docker push $IMAGE_NAME:$GIT_SHA"
    echo "  docker push $IMAGE_NAME:latest"
fi

echo ""
echo "Version $GIT_SHA is ready to deploy!"

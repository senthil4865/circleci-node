#!/bin/sh

echo "logging in"
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin 764941139426.dkr.ecr.ap-south-1.amazonaws.com
echo "Pulling a image"
docker pull 764941139426.dkr.ecr.ap-south-1.amazonaws.com/sales-node:latest
echo "Pull complete"

CONTAINER_NAME='sales-backend'
CID=$(docker ps -q -f status=running -f name=^/${CONTAINER_NAME}$)
if [ "${CID}" ]; then
  echo "Container exists"
  docker stop sales-backend
  docker rm sales-backend
fi

# docker stop $AWS_ECR_ACCOUNT_URL/sales-node
# docker rm $AWS_ECR_ACCOUNT_URL/sales-node
docker run --name sales-backend -p 5000:5000 -d 764941139426.dkr.ecr.ap-south-1.amazonaws.com/sales-node:latest
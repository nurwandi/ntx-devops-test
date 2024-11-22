#!/bin/bash
pwd

TIMESTAMP=$(date +"%m.%d.%Y")

echo "Checking the docker version..."
docker --version

echo "Running Docker container..."
docker run -d -p 3000:3000 nurwandi7/ntx-devops-test:$TIMESTAMP

docker ps

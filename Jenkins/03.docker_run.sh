#!/bin/bash

. /00.clone_repository.sh

pwd

cd "$NODE_APP_DIRECTORY" || exit
echo "Now inside the directory: $NODE_APP_DIRECTORY"

TIMESTAMP=$(date +"%m.%d.%Y")

echo "Checking the docker version..."
docker --version

echo "Running Docker container..."
docker run -d -p 3000:3000 nurwandi7/ntx-devops-test:$TIMESTAMP

docker ps

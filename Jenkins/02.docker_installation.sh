#!/bin/bash

. /00.clone_repository.sh

pwd

cd "$NODE_APP_DIRECTORY" || exit
echo "Now inside the directory: $NODE_APP_DIRECTORY"

TIMESTAMP=$(date +"%m.%d.%Y")

docker build -t nurwandi7/ntx-devops-test:$TIMESTAMP .

sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker 

sudo systemctl status docker
sudo service docker start

sudo usermod -aG docker root

exit

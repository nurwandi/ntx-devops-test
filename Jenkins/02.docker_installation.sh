#!/bin/bash
pwd

TIMESTAMP=$(date +"%m.%d.%Y")

docker build -t nurwandi7/ntx-devops-test:$TIMESTAMP .

sudo yum install -y docker
sudo systemctl status docker
sudo service docker start

sudo usermod -aG docker ec2-user

exit

#!/bin/bash

pwd

sudo yum update -y
sudo yum install -y curl

echo "Install Node.js"
if command -v node &> /dev/null; then
  echo "Node.js is installed. Skip installation."
else
  echo "Node.js is not found. Continue the installation..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
  source ~/.bashrc
  nvm install node
  nvm install 16
  node -v 
  npm -v
fi

echo "Testing the local app..."

npm start &
sleep 5

if netstat -tuln | grep ':3000' &> /dev/null; then
  echo "Server is running on port 3000."

  echo "Stopping the server..."
  kill $(lsof -t -i:3000)
else
  echo "Server is not running on port 3000."
fi
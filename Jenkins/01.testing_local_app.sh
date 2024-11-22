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
cd ..

npm test
npm start
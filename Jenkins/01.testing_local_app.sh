sudo yum update -y
sudo yum install -y curl

echo "Install Node.js"

curl -fsSL https://fnm.vercel.app/install | bash
source ~/.bashrc

fnm use --install-if-missing 22
node -v
npm -v

echo "Testing the local app..."

npm test
npm start
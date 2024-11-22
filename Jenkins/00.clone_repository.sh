# https://github.com/nurwandi/ntx-devops-test.git

#!/bin/bash
pwd

REPO_URL="https://github.com/nurwandi/ntx-devops-test.git"
FOLDER_NAME="ntx-devops-test"

echo "Cloning repository $REPO_URL into folder $FOLDER_NAME..."
git clone "$REPO_URL" "$FOLDER_NAME"

if [ $? -eq 0 ]; then
    echo "Cloning is successful."
    
    cd "$FOLDER_NAME" || exit
    echo "Moving into $FOLDER_NAME."
else
    echo "Failed to clone repository."
    exit 1
fi

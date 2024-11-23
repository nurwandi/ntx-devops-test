# https://github.com/nurwandi/ntx-devops-test.git

#!/bin/bash
repo-clone() {
    BRANCH_NAME=$1
    REPO_URL=$2
    NODE_APP_DIRECTORY=$3

    echo "Executing repository branch: $BRANCH_NAME"

    if [ -d "$NODE_APP_DIRECTORY" ]; then
        echo "Directory $NODE_APP_DIRECTORY exists, pulling latest changes..."
        cd "$NODE_APP_DIRECTORY" || exit
        git checkout "$BRANCH_NAME" || exit
        git pull origin "$BRANCH_NAME" || exit
        echo "Pulling changes for branch $BRANCH_NAME in $NODE_APP_DIRECTORY"
    else
        echo "Cloning repository $REPO_URL with branch $BRANCH_NAME into folder $NODE_APP_DIRECTORY..."
        git clone --branch "$BRANCH_NAME" --single-branch "$REPO_URL" "$NODE_APP_DIRECTORY"

        if [ $? -eq 0 ]; then
            echo "Cloning is successful."
            cd "$NODE_APP_DIRECTORY" || exit
            echo "Switched into $NODE_APP_DIRECTORY."
        else
            echo "Failed to clone repository. Please check if the branch $BRANCH_NAME exists or the repository URL is correct."
            exit 1
        fi
    fi
}

NODE_APP_DIRECTORY="$WORKSPACE/nurwandi-ntx-devops-test"
REPO_URL="https://github.com/nurwandi/ntx-devops-test.git"
BRANCH_NAME="$BRANCH_NAME"

repo-clone "$BRANCH_NAME" "$REPO_URL" "$NODE_APP_DIRECTORY"

#!/bin/bash

# Define your source repos and branches
REPOS=(
  "https://github.com/raviteja119-pixel/ravi.git ravi"
  "https://github.com/raviteja119-pixel/personal.git personal"
)

mkdir temp
cd temp

for entry in "${REPOS[@]}"; do
  set -- $entry
  REPO_URL=$1
  BRANCH=$2
  REPO_NAME=$(basename "$REPO_URL" .git)

  git clone --branch $BRANCH --depth 1 "$REPO_URL" "$REPO_NAME-$BRANCH"
  rsync -av --exclude=".git" "$REPO_NAME-$BRANCH/" "../central-repsitory/$REPO_NAME-$BRANCH/"
done

cd ../central-repsitory/
git add .
git commit -m "Auto-sync files from multiple branches"
git push

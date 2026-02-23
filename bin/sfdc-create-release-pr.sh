#!/bin/bash

# create-release-pr.sh
# Usage: ./create-release-pr.sh <merge-commit> <release-branch>
# Example: ./create-release-pr.sh 79942ea release/4.55.0

set -e

MERGE_COMMIT=$1
RELEASE_BRANCH=$2

if [ -z "$MERGE_COMMIT" ] || [ -z "$RELEASE_BRANCH" ]; then
  echo "Usage: ./create-release-pr.sh <merge-commit> <release-branch>"
  echo "Example: ./create-release-pr.sh 79942ea release/4.55.0"
  exit 1
fi

# Check for dirty working tree
if [ -n "$(git status --porcelain)" ]; then
  echo "Working tree is dirty. Stash or commit your changes first."
  exit 1
fi

# Extract ticket number from commit message (e.g., EFEI-49816)
TICKET=$(git log --format=%s -n 1 "$MERGE_COMMIT" | grep -oE '[A-Z]+-[0-9]+' | head -1)

if [ -z "$TICKET" ]; then
  echo "Could not extract ticket number from commit message"
  exit 1
fi

BRANCH_NAME="${TICKET}-release"

echo "Ticket: $TICKET"
echo "Creating branch: $BRANCH_NAME from $RELEASE_BRANCH"

# Fetch latest
git fetch origin

# Create branch from release branch
git checkout -b "$BRANCH_NAME" "origin/$RELEASE_BRANCH"

# Cherry-pick the merge commit
git cherry-pick -m 1 "$MERGE_COMMIT"

# Push the branch
git push origin "$BRANCH_NAME"

# Get the repo URL and open PR creation page
REPO_URL=$(git remote get-url origin | sed 's/git@github.com:/https:\/\/github.com\//' | sed 's/\.git$//')
PR_URL="${REPO_URL}/compare/${RELEASE_BRANCH}...${BRANCH_NAME}?expand=1"

echo ""
echo "Branch pushed!"
echo "Open PR: $PR_URL"

# Try to open in browser (macOS)
if command -v open &> /dev/null; then
  open "$PR_URL"
elif command -v xdg-open &> /dev/null; then
  xdg-open "$PR_URL"
else
  echo "(Copy the URL above to open your PR)"
fi

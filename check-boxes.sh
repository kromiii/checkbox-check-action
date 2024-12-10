#!/bin/bash

set -e

# Extract owner and repo from GITHUB_REPOSITORY
OWNER=$(echo $GITHUB_REPOSITORY | cut -d '/' -f1)
REPO=$(echo $GITHUB_REPOSITORY | cut -d '/' -f2)

# Get the pull request body
PR_BODY=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "https://api.github.com/repos/$OWNER/$REPO/pulls/$PR_NUMBER" \
  | jq -r .body)

# Check if there are any unchecked boxes ([ ])
if echo "$PR_BODY" | grep -q "\[ \]"; then
  echo "Error: Found unchecked checkboxes in the pull request description"
  exit 1
else
  echo "All checkboxes are checked!"
  exit 0
fi

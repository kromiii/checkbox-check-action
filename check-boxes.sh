#!/bin/bash

set -e

# Use custom API URL if provided, otherwise default to api.github.com
GITHUB_API_URL=${GITHUB_API_URL:-"https://api.github.com"}

# Extract owner and repo from GITHUB_REPOSITORY
OWNER=$(echo $GITHUB_REPOSITORY | cut -d '/' -f1)
REPO=$(echo $GITHUB_REPOSITORY | cut -d '/' -f2)

# Get the pull request body
PR_BODY=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
  "$GITHUB_API_URL/repos/$OWNER/$REPO/pulls/$PR_NUMBER" \
  | jq -r .body)

if [ $? -ne 0 ] || [ "$PR_BODY" = "null" ]; then
  echo "Error: Failed to fetch pull request data"
  echo "API URL: $GITHUB_API_URL"
  echo "Repository: $OWNER/$REPO"
  echo "PR Number: $PR_NUMBER"
  exit 1
fi

# Check if there are any unchecked boxes ([ ])
if echo "$PR_BODY" | grep -q "\[ \]"; then
  echo "Error: Found unchecked checkboxes in the pull request description"
  exit 1
else
  echo "All checkboxes are filled!"
  exit 0
fi

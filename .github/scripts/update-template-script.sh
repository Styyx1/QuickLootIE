#!/bin/bash

# Fetch the latest release version from GitHub API
LATEST_VERSION=$(curl -s https://api.github.com/repos/MissCorruption/QuickLootEE-NG/releases/latest | jq -r .tag_name)

# Define the path to the issue template file
TEMPLATE_PATH=".github/ISSUE_TEMPLATE/bug_report.yml"

# Update the version dropdown in the issue template
jq "(.body[] | select(.id == \"version\") | .attributes.options) |= [\"$LATEST_VERSION\"] + ." "$TEMPLATE_PATH" > temp.yml && mv temp.yml "$TEMPLATE_PATH"

# Check if the file has been updated
if ! git diff --exit-code "$TEMPLATE_PATH"; then
  # Commit and push changes
  git add "$TEMPLATE_PATH"
  git commit -m "Update issue template with new release version $LATEST_VERSION"
  git push origin main
else
  echo "No changes to commit"
fi

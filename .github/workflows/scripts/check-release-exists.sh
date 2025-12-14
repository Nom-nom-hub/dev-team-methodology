#!/usr/bin/env bash
set -euo pipefail

# check-release-exists.sh
# Check if a release with the given tag already exists
# Usage: check-release-exists.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version-with-v-prefix>" >&2
  exit 1
fi

NEW_VERSION="$1"
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like v0.0.0" >&2
  exit 1
fi

# Check if release already exists (requires GITHUB_TOKEN)
API_RESPONSE=$(curl -s -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/$GITHUB_REPOSITORY/releases/tags/$NEW_VERSION")

if [[ "$API_RESPONSE" != '{"message":"Not Found","documentation_url":"https://docs.github.com/rest/releases/releases#get-a-release-by-tag-name"}' ]]; then
  if [[ -n "$(echo "$API_RESPONSE" | jq -r '.url // empty' 2>/dev/null)" ]]; then
    echo "exists=true" >> $GITHUB_OUTPUT
    echo "Release $NEW_VERSION already exists"
    exit 0
  fi
fi

echo "exists=false" >> $GITHUB_OUTPUT
echo "Release $NEW_VERSION does not exist"
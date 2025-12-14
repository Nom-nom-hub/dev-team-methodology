#!/usr/bin/env bash
set -euo pipefail

# create-github-release.sh
# Create a GitHub release with the generated packages
# Usage: create-github-release.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version-with-v-prefix>" >&2
  exit 1
fi

NEW_VERSION="$1"
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like v0.0.0" >&2
  exit 1
fi

# Get release notes
RELEASE_NOTES_FILE=".github/workflows/scripts/release-notes.md"
if [[ ! -f "$RELEASE_NOTES_FILE" ]]; then
  echo "Release notes file not found: $RELEASE_NOTES_FILE" >&2
  exit 1
fi

RELEASE_NOTES=$(cat "$RELEASE_NOTES_FILE")

# Create the release with assets
ASSETS=()
for asset in .genreleases/*.zip; do
  if [[ -f "$asset" ]]; then
    ASSETS+=("$asset")
  fi
done

# Create release using GitHub API
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$GITHUB_REPOSITORY/releases \
  -d "{
    \"tag_name\":\"$NEW_VERSION\",
    \"target_commitish\":\"main\",
    \"name\":\"$NEW_VERSION\",
    \"body\":\"$(printf '%s\n' "$RELEASE_NOTES" | sed 's/"/\\"/g' | tr '\n\r' '\n\n')\",
    \"draft\":false,
    \"prerelease\":false,
    \"generate_release_notes\":false
  }"

echo "GitHub release created for $NEW_VERSION"
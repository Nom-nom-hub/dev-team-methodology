#!/usr/bin/env bash
set -euo pipefail

# update-version.sh
# Update the version in pyproject.toml
# Usage: update-version.sh <version>

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version-with-v-prefix>" >&2
  exit 1
fi

NEW_VERSION="$1"
if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Version must look like v0.0.0" >&2
  exit 1
fi

# Remove 'v' prefix for pyproject.toml
VERSION_NUMBER="${NEW_VERSION#v}"

# Update version in pyproject.toml
if [[ -f "pyproject.toml" ]]; then
  sed -i.bak "s/version = \".*\"/version = \"$VERSION_NUMBER\"/g" pyproject.toml
  rm pyproject.toml.bak
  echo "Updated pyproject.toml to version $VERSION_NUMBER"
else
  echo "pyproject.toml not found, skipping version update"
fi
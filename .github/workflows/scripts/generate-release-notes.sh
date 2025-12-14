#!/usr/bin/env bash
set -euo pipefail

# generate-release-notes.sh
# Generate release notes for the new version
# Usage: generate-release-notes.sh <new_version> <latest_tag>

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <new_version_with_v_prefix> <latest_tag>" >&2
  exit 1
fi

NEW_VERSION="$1"
LATEST_TAG="$2"

if [[ ! $NEW_VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "New version must look like v0.0.0" >&2
  exit 1
fi

if [[ ! $LATEST_TAG =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]] && [[ $LATEST_TAG != "v0.0.0" ]]; then
  echo "Latest tag must look like v0.0.0" >&2
  exit 1
fi

# Generate release notes
cat > ".github/workflows/scripts/release-notes.md" << EOF
# Release $NEW_VERSION

## What's New

This release provides template packages for the Team Methodology framework, enabling AI agents to assist with team-driven development processes that incorporate perspectives from multiple team personas.

## Template Packages

This release includes template packages for all supported AI agents:
- Claude, Gemini, Copilot, Cursor, Qwen, Opencode, Codex, Windsurf, Kilocode, Auggie, Roo, CodeBuddy, Qoder, Amp, SHAI, Amazon Q, and IBM Bob
- Both bash (sh) and PowerShell (ps) script variants
- Complete command templates for team-driven development workflow

## Team Methodology Features

The Team Methodology includes commands for:
- **/team.constitution**: Establish project principles
- **/team.personas**: Define team roles and responsibilities  
- **/team.specify**: Create baseline specification with team input
- **/team.review**: Review specification from all team perspectives
- **/team.plan**: Create implementation plan with team input
- **/team.tasks**: Generate actionable tasks with team ownership
- **/team.implement**: Execute implementation with team collaboration

## Team Personas

The methodology incorporates perspectives from:
- Product Manager
- Technical Architect
- UX Designer
- Quality Assurance
- Developer
- DevOps Engineer

Each specification, plan, and task includes validation from all relevant team personas to ensure comprehensive coverage of user value, technical feasibility, user experience, quality standards, implementation approach, and operational concerns.

## Usage

Download the appropriate template package for your AI agent and script environment. The packages include all necessary configuration files, command templates, and scripts to enable the Team Methodology workflow.

For more information, see the documentation at [repository URL].
EOF

echo "Release notes generated for $NEW_VERSION"
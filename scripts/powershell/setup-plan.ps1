# PowerShell script to setup implementation plan for team methodology
# Usage: setup-plan.ps1 [-Json]

[CmdletBinding()]
param(
    [switch]$Json
)

# Load common functions
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
. (Join-Path $scriptDir "common.ps1")

# Get all paths and variables from common functions
$paths = Get-FeaturePaths

# Check if we're on a proper feature branch (only for git repos)
if (-not (Test-FeatureBranch -Branch $paths.CURRENT_BRANCH -HasGitRepo $paths.HAS_GIT)) {
    exit 1
}

# Ensure the feature directory exists
New-Item -ItemType Directory -Path $paths.FEATURE_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $paths.PERSONAS_DIR -Force | Out-Null
New-Item -ItemType Directory -Path $paths.CHECKLISTS_DIR -Force | Out-Null

# Copy plan template if it exists
$template = Join-Path $paths.REPO_ROOT ".team" "templates" "plan-template.md"
if (Test-Path $template) {
    Copy-Item $template $paths.IMPL_PLAN
    Write-Output "Copied plan template to $($paths.IMPL_PLAN)"
} else {
    Write-Warning "Warning: Plan template not found at $template"
    # Create a basic plan file if template doesn't exist
    Set-Content -Path $paths.IMPL_PLAN -Value ""
}

# Output results
if ($Json) {
    $result = @{
        FEATURE_SPEC = $paths.FEATURE_SPEC
        IMPL_PLAN = $paths.IMPL_PLAN
        SPECS_DIR = $paths.FEATURE_DIR
        BRANCH = $paths.CURRENT_BRANCH
        HAS_GIT = $paths.HAS_GIT
        PERSONAS_DIR = $paths.PERSONAS_DIR
        CHECKLISTS_DIR = $paths.CHECKLISTS_DIR
    }
    $result | ConvertTo-Json
} else {
    Write-Output "FEATURE_SPEC: $($paths.FEATURE_SPEC)"
    Write-Output "IMPL_PLAN: $($paths.IMPL_PLAN)"
    Write-Output "SPECS_DIR: $($paths.FEATURE_DIR)"
    Write-Output "BRANCH: $($paths.CURRENT_BRANCH)"
    Write-Output "HAS_GIT: $($paths.HAS_GIT)"
    Write-Output "PERSONAS_DIR: $($paths.PERSONAS_DIR)"
    Write-Output "CHECKLISTS_DIR: $($paths.CHECKLISTS_DIR)"
}
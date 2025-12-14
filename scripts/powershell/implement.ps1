# PowerShell script to execute implementation following team methodology
# Usage: implement.ps1 [-Focus "research|implementation|testing|deployment"] [-UpdateLog] [-Json]

[CmdletBinding()]
param(
    [string]$Focus,
    [switch]$UpdateLog,
    [switch]$Json
)

# Load common functions
$scriptDir = $PSScriptRoot
. (Join-Path $scriptDir "common.ps1")

# Get all paths and variables from common functions
$paths = Get-FeaturePaths

# Validate feature directory exists
if (-not (Test-Path $paths.FEATURE_DIR)) {
    Write-Error "Feature directory not found at $($paths.FEATURE_DIR)"
    exit 1
}

# Validate required files exist
$tasksFile = Join-Path $paths.FEATURE_DIR "tasks.md"
$planFile = Join-Path $paths.FEATURE_DIR "plan.md"
$specFile = Join-Path $paths.FEATURE_DIR "spec.md"

if (-not (Test-Path $tasksFile)) {
    Write-Error "Tasks file not found at $tasksFile"
    exit 1
}

if (-not (Test-Path $planFile)) {
    Write-Error "Plan file not found at $planFile"
    exit 1
}

if (-not (Test-Path $specFile)) {
    Write-Error "Spec file not found at $specFile"
    exit 1
}

# Parse tasks file to find current status
$tasksContent = Get-Content $tasksFile -Raw
$inProgressTasks = @()
$todoTasks = @()

# Extract task status from markdown tables
$lines = Get-Content $tasksFile
foreach ($line in $lines) {
    if ($line -match '^\|.*\|.*\|.*\|.*\|.*Done\|') {
        # Done task - skip
    }
    elseif ($line -match '^\|.*\|.*\|.*\|.*\|.*In Progress\|') {
        # Extract task info
        if ($line -match '^\|\s*(\w+-\d+)\s*\|') {
            $taskId = $matches[1]
            $inProgressTasks += $taskId
        }
    }
    elseif ($line -match '^\|.*\|.*\|.*\|.*\|.*To Do\|') {
        # Extract task info
        if ($line -match '^\|\s*(\w+-\d+)\s*\|') {
            $taskId = $matches[1]
            $todoTasks += $taskId
        }
    }
}

# Determine implementation phase
$hasResearchTasks = $tasksContent -match 'RD-\d+'
$hasImplTasks = $tasksContent -match 'IMPL-\d+'
$hasTestTasks = $tasksContent -match 'TEST-\d+'
$hasDeployTasks = $tasksContent -match 'DEPLOY-\d+'

# Output implementation status
Write-Host "Implementation Status for $($paths.CURRENT_BRANCH)"
Write-Host ""
Write-Host "To Do Tasks: $($todoTasks.Count)"
Write-Host "In Progress Tasks: $($inProgressTasks.Count)"
Write-Host ""

if ($todoTasks.Count -gt 0) {
    Write-Host "Next tasks to complete (in priority order):"
    $todoTasks | ForEach-Object {
        Write-Host "  - $_"
    }
    Write-Host ""
}

Write-Host "IMPORTANT: Before marking tasks as 'Done', ensure:"
Write-Host ""
Write-Host "✓ Research tasks: Document ACTUAL findings in research.md (not just plans)"
Write-Host "✓ Implementation tasks: Create ACTUAL code files (not just outlines)"
Write-Host "✓ Testing tasks: Write ACTUAL test code and run tests"
Write-Host "✓ Deployment tasks: Create ACTUAL packages/artifacts"
Write-Host ""

Write-Host "Update task status in tasks.md and run this script again to track progress."
Write-Host ""

if ($Json) {
    $result = @{
        BRANCH = $paths.CURRENT_BRANCH
        FEATURE_DIR = $paths.FEATURE_DIR
        TODO_TASKS = $todoTasks
        IN_PROGRESS_TASKS = $inProgressTasks
        TODO_COUNT = $todoTasks.Count
        IN_PROGRESS_COUNT = $inProgressTasks.Count
        HAS_RESEARCH = $hasResearchTasks
        HAS_IMPLEMENTATION = $hasImplTasks
        HAS_TESTING = $hasTestTasks
        HAS_DEPLOYMENT = $hasDeployTasks
    }
    $result | ConvertTo-Json
}

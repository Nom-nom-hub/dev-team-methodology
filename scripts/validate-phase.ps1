# validate-phase.ps1 - Validate Team-Driven Development phase gates
# Usage: .\scripts\validate-phase.ps1 -Phase specify
# Usage: .\scripts\validate-phase.ps1 -Phase plan -Feature 001-user-auth

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet('specify', 'review', 'plan', 'tasks', 'implement', 'help')]
    [string]$Phase = 'help',
    
    [Parameter(Mandatory=$false)]
    [string]$Feature
)

# Color functions
function Write-Error-Custom {
    param([string]$Message)
    Write-Host "✗ ERROR: $Message" -ForegroundColor Red
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "⚠ WARNING: $Message" -ForegroundColor Yellow
}

function Write-Info {
    param([string]$Message)
    Write-Host "ℹ $Message" -ForegroundColor Cyan
}

function Write-Header {
    param([string]$Message)
    Write-Host ""
    Write-Host ("=" * 50) -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host ("=" * 50) -ForegroundColor Cyan
    Write-Host ""
}

# Check git
function Test-Git {
    try {
        git rev-parse --git-dir > $null 2>&1
        Write-Success "Git repository found"
    }
    catch {
        Write-Error-Custom "Not in a git repository. Initialize git first: git init"
        exit 1
    }
}

# Validate specify phase
function Validate-Specify {
    Write-Header "VALIDATING /team.specify PHASE"
    
    Write-Info "Checking prerequisites..."
    
    # Check .team directory
    if (-not (Test-Path ".team")) {
        Write-Error-Custom ".team/ directory not found. Run 'team init' first."
        exit 1
    }
    Write-Success ".team/ directory exists"
    
    # Check constitution
    if (-not (Test-Path ".team/memory/constitution.md")) {
        Write-Warning-Custom "constitution.md not found. Create with /team.constitution"
        return $false
    }
    Write-Success "Constitution found"
    
    # Get feature name from branch if not provided
    if ([string]::IsNullOrWhiteSpace($Feature)) {
        $Feature = git rev-parse --abbrev-ref HEAD
        if ($Feature -eq "main" -or $Feature -eq "master") {
            Write-Error-Custom "Not on a feature branch. Create one first."
            exit 1
        }
    }
    
    Write-Info "Using feature: $Feature"
    
    # Check spec directory
    $specPath = ".team/specs/$Feature"
    if (Test-Path $specPath) {
        if (Test-Path "$specPath/spec.md") {
            Write-Success "Specification found"
        }
        else {
            Write-Warning-Custom "specs/$Feature/ directory exists but spec.md not found"
        }
    }
    else {
        Write-Info "No spec yet. Run /team.specify to create one."
    }
    
    Write-Success "SPECIFY phase validated ✓"
}

# Validate review phase
function Validate-Review {
    Write-Header "VALIDATING /team.review PHASE"
    
    if ([string]::IsNullOrWhiteSpace($Feature)) {
        Write-Error-Custom "Feature name required"
        exit 1
    }
    
    $specDir = ".team/specs/$Feature"
    Write-Info "Checking feature: $Feature"
    
    # Check spec.md
    if (-not (Test-Path "$specDir/spec.md")) {
        Write-Error-Custom "spec.md not found in $specDir"
        exit 1
    }
    Write-Success "spec.md found"
    
    # Check checklist
    if (-not (Test-Path "$specDir/checklists/validation-checklist.md")) {
        Write-Warning-Custom "validation-checklist.md not found (should exist after /team.review)"
    }
    else {
        Write-Success "validation checklist found"
    }
    
    Write-Success "REVIEW phase validated ✓"
}

# Validate plan phase
function Validate-Plan {
    Write-Header "VALIDATING /team.plan PHASE"
    
    if ([string]::IsNullOrWhiteSpace($Feature)) {
        Write-Error-Custom "Feature name required"
        exit 1
    }
    
    $specDir = ".team/specs/$Feature"
    Write-Info "Checking feature: $Feature"
    
    # Check spec.md
    if (-not (Test-Path "$specDir/spec.md")) {
        Write-Error-Custom "spec.md not found. Run /team.specify first."
        exit 1
    }
    Write-Success "spec.md exists"
    
    # Check validation checklist
    if (-not (Test-Path "$specDir/checklists/validation-checklist.md")) {
        Write-Error-Custom "validation-checklist.md not found. Run /team.review first."
        exit 1
    }
    Write-Success "validation checklist exists"
    
    # Check plan.md
    if (-not (Test-Path "$specDir/plan.md")) {
        Write-Info "plan.md not yet created. Run /team.plan to create it."
    }
    else {
        Write-Success "plan.md found"
    }
    
    Write-Success "PLAN phase validated ✓"
}

# Validate tasks phase
function Validate-Tasks {
    Write-Header "VALIDATING /team.tasks PHASE"
    
    if ([string]::IsNullOrWhiteSpace($Feature)) {
        Write-Error-Custom "Feature name required"
        exit 1
    }
    
    $specDir = ".team/specs/$Feature"
    Write-Info "Checking feature: $Feature"
    
    # Check required files
    foreach ($file in @("spec.md", "plan.md")) {
        if (-not (Test-Path "$specDir/$file")) {
            Write-Error-Custom "$file not found. Complete previous phases first."
            exit 1
        }
    }
    Write-Success "spec.md and plan.md exist"
    
    # Check tasks.md
    if (-not (Test-Path "$specDir/tasks.md")) {
        Write-Info "tasks.md not yet created. Run /team.tasks to create it."
    }
    else {
        Write-Success "tasks.md found"
        
        # Count tasks
        $content = Get-Content "$specDir/tasks.md" -Raw
        $taskCount = ($content | Select-String -Pattern "^### Task|^## Task" -AllMatches).Matches.Count
        
        if ($taskCount -gt 0) {
            Write-Success "Found $taskCount tasks in tasks.md"
            
            if ($taskCount -lt 5) {
                Write-Warning-Custom "Only $taskCount tasks - may be under-scoped"
            }
            if ($taskCount -gt 100) {
                Write-Warning-Custom "$taskCount tasks - may be over-scoped"
            }
        }
    }
    
    Write-Success "TASKS phase validated ✓"
}

# Validate implement phase
function Validate-Implement {
    Write-Header "VALIDATING /team.implement PHASE"
    
    if ([string]::IsNullOrWhiteSpace($Feature)) {
        Write-Error-Custom "Feature name required"
        exit 1
    }
    
    $specDir = ".team/specs/$Feature"
    Write-Info "Checking feature: $Feature"
    
    # Check required files
    foreach ($file in @("spec.md", "plan.md", "tasks.md")) {
        if (-not (Test-Path "$specDir/$file")) {
            Write-Error-Custom "$file not found. Complete previous phases first."
            exit 1
        }
    }
    Write-Success "All prerequisites exist (spec, plan, tasks)"
    
    # Check implementation-log
    if (Test-Path "$specDir/implementation-log.md") {
        Write-Success "implementation-log.md found"
    }
    else {
        Write-Info "implementation-log.md not created yet (optional)"
    }
    
    Write-Success "IMPLEMENT phase validated ✓"
}

# Show help
function Show-Help {
    @"
Team-Driven Development Phase Validator

Usage: .\scripts\validate-phase.ps1 -Phase <phase> [-Feature <feature-name>]

Phases:
  specify    - Validate /team.specify prerequisites
  review     - Validate /team.review prerequisites
  plan       - Validate /team.plan prerequisites
  tasks      - Validate /team.tasks prerequisites
  implement  - Validate /team.implement prerequisites
  help       - Show this help message

Examples:
  .\scripts\validate-phase.ps1 -Phase specify
  .\scripts\validate-phase.ps1 -Phase review -Feature 001-user-auth
  .\scripts\validate-phase.ps1 -Phase plan -Feature 001-user-auth
  .\scripts\validate-phase.ps1 -Phase tasks -Feature 001-user-auth
  .\scripts\validate-phase.ps1 -Phase implement -Feature 001-user-auth

This script validates that all prerequisites for each phase are in place
before executing the corresponding /team.* command.

"@ | Write-Host -ForegroundColor Cyan
}

# Main
Test-Git

switch ($Phase) {
    "specify" {
        Validate-Specify
    }
    "review" {
        Validate-Review
    }
    "plan" {
        Validate-Plan
    }
    "tasks" {
        Validate-Tasks
    }
    "implement" {
        Validate-Implement
    }
    "help" {
        Show-Help
    }
    default {
        Write-Error-Custom "Unknown phase: $Phase"
        Show-Help
        exit 1
    }
}

Write-Success "Phase validation complete!"
Write-Host ""

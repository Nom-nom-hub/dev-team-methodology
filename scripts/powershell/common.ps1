# PowerShell common functions for team methodology

# Get repository root, with fallback for non-git repositories
function Get-RepoRoot {
    try {
        # Try git first
        $gitRoot = git rev-parse --show-toplevel 2>$null
        if ($gitRoot) {
            return $gitRoot
        }
    }
    catch {
        # Git not available, fall back to script location
    }
    
    # Fall back to script location for non-git repos
    $scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
    return (Resolve-Path "$scriptDir\..\..").Path
}

# Get current branch, with fallback for non-git repositories
function Get-CurrentBranch {
    # First check if TEAM_FEATURE environment variable is set
    if ($env:TEAM_FEATURE) {
        return $env:TEAM_FEATURE
    }

    # Then check git if available
    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($branch) {
            return $branch
        }
    }
    catch {
        # Git not available
    }

    # For non-git repos, try to find the latest feature directory
    $repoRoot = Get-RepoRoot
    $specsDir = Join-Path $repoRoot ".team/specs"

    if (Test-Path $specsDir) {
        $latestFeature = ""
        $highest = 0

        Get-ChildItem $specsDir -Directory | ForEach-Object {
            $dirname = $_.Name
            if ($dirname -match '^(\d{3})-') {
                $number = [int]$matches[1]
                if ($number -gt $highest) {
                    $highest = $number
                    $latestFeature = $dirname
                }
            }
        }

        if ($latestFeature) {
            return $latestFeature
        }
    }

    return "main"  # Final fallback
}

# Check if we have git available
function Test-HasGit {
    try {
        git rev-parse --show-toplevel 2>$null
        return $true
    }
    catch {
        return $false
    }
}

function Test-FeatureBranch {
    param(
        [string]$Branch,
        [bool]$HasGitRepo
    )

    # For non-git repos, we can't enforce branch naming but still provide output
    if (-not $HasGitRepo) {
        Write-Warning "[team] Warning: Git repository not detected; skipped branch validation"
        return $true
    }

    if ($Branch -notmatch '^\d{3}-') {
        Write-Error "ERROR: Not on a feature branch. Current branch: $Branch"
        Write-Error "Feature branches should be named like: 001-feature-name"
        return $false
    }

    return $true
}

# Find feature directory by numeric prefix instead of exact branch match
function Find-FeatureDirByPrefix {
    param(
        [string]$RepoRoot,
        [string]$BranchName
    )

    $specsDir = Join-Path $RepoRoot ".team/specs"

    # Extract numeric prefix from branch (e.g., "004" from "004-whatever")
    if ($BranchName -notmatch '^\d{3}-') {
        # If branch doesn't have numeric prefix, fall back to exact match
        return Join-Path $specsDir $BranchName
    }

    $prefix = $matches[0].TrimEnd('-')

    # Search for directories in specs/ that start with this prefix
    $matches = @()
    if (Test-Path $specsDir) {
        Get-ChildItem $specsDir -Directory | ForEach-Object {
            if ($_.Name -match "^${prefix}-") {
                $matches += $_.Name
            }
        }
    }

    # Handle results
    if ($matches.Count -eq 0) {
        # No match found - return the branch name path (will fail later with clear error)
        return Join-Path $specsDir $BranchName
    }
    elseif ($matches.Count -eq 1) {
        # Exactly one match - perfect!
        return Join-Path $specsDir $matches[0]
    }
    else {
        # Multiple matches - this shouldn't happen with proper naming convention
        Write-Error "ERROR: Multiple spec directories found with prefix '$prefix': $($matches -join ', ')"
        Write-Error "Please ensure only one spec directory exists per numeric prefix."
        return Join-Path $specsDir $BranchName  # Return something to avoid breaking the script
    }
}

function Get-FeaturePaths {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    $hasGitRepo = Test-HasGit

    # Use prefix-based lookup to support multiple branches per spec
    $featureDir = Find-FeatureDirByPrefix -RepoRoot $repoRoot -BranchName $currentBranch

    $featureSpec = Join-Path $featureDir "spec.md"
    $implPlan = Join-Path $featureDir "plan.md"
    $tasks = Join-Path $featureDir "tasks.md"
    $research = Join-Path $featureDir "research.md"
    $dataModel = Join-Path $featureDir "data-model.md"
    $quickstart = Join-Path $featureDir "quickstart.md"
    $personasDir = Join-Path $featureDir "personas"
    $checklistsDir = Join-Path $featureDir "checklists"
    $contractsDir = Join-Path $featureDir "contracts"

    return @{
        REPO_ROOT = $repoRoot
        CURRENT_BRANCH = $currentBranch
        HAS_GIT = $hasGitRepo
        FEATURE_DIR = $featureDir
        FEATURE_SPEC = $featureSpec
        IMPL_PLAN = $implPlan
        TASKS = $tasks
        RESEARCH = $research
        DATA_MODEL = $dataModel
        QUICKSTART = $quickstart
        PERSONAS_DIR = $personasDir
        CHECKLISTS_DIR = $checklistsDir
        CONTRACTS_DIR = $contractsDir
    }
}
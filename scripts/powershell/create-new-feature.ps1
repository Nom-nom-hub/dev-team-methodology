# PowerShell script to create a new feature with team methodology
# Usage: create-new-feature.ps1 [-Json] [-ShortName "name"] [-Number N] "feature description"

[CmdletBinding()]
param(
    [switch]$Json,
    [string]$ShortName,
    [int]$Number,
    [Parameter(ValueFromRemainingArguments=$true)]
    [string]$FeatureDescription
)

# Validate that we have a feature description
if (-not $FeatureDescription) {
    Write-Error "Usage: $MyInvocation.MyCommand.Name [-Json] [-ShortName 'name'] [-Number N] 'feature description'"
    Write-Error "At least a feature description is required"
    exit 1
}

# Function to find the repository root by searching for existing project markers
function Find-RepoRoot {
    param([string]$StartDir = $(Get-Location))
    
    $dir = $StartDir
    while ($dir -ne (Split-Path $dir -Parent)) {
        if (Test-Path (Join-Path $dir ".git") -PathType Container) {
            return $dir
        }
        if (Test-Path (Join-Path $dir ".team") -PathType Container) {
            return $dir
        }
        $dir = Split-Path $dir -Parent
    }
    return $null
}

# Function to get highest number from specs directory
function Get-HighestFromSpecs {
    param([string]$SpecsDir)
    
    $highest = 0
    
    if (Test-Path $SpecsDir) {
        Get-ChildItem $SpecsDir -Directory | ForEach-Object {
            $dirname = $_.Name
            if ($dirname -match '^\d+') {
                $number = [int]$matches[0]
                if ($number -gt $highest) {
                    $highest = $number
                }
            }
        }
    }
    
    return $highest
}

# Function to get highest number from git branches
function Get-HighestFromBranches {
    try {
        $branches = git branch -a 2>$null
        if ($branches) {
            $highest = 0
            $branches | ForEach-Object {
                # Clean branch name: remove leading markers and remote prefixes
                $cleanBranch = $_ -replace '^\*\s*', '' -replace '^\s+', '' -replace '^remotes/[^/]+/', ''
                
                # Extract feature number if branch matches pattern ###-*
                if ($cleanBranch -match '^\d{3}-') {
                    $number = [int]$matches[0].TrimEnd('-')
                    if ($number -gt $highest) {
                        $highest = $number
                    }
                }
            }
            return $highest
        }
    }
    catch {
        # Git not available or error occurred
        return 0
    }
    return 0
}

# Function to check existing branches (local and remote) and return next available number
function Check-ExistingBranches {
    param([string]$SpecsDir)
    
    # Fetch all remotes to get latest branch info (suppress errors if no remotes)
    try {
        git fetch --all --prune 2>$null | Out-Null
    }
    catch {
        # Silently ignore git fetch errors
    }

    # Get highest number from ALL branches
    $highestBranch = Get-HighestFromBranches

    # Get highest number from ALL specs
    $highestSpec = Get-HighestFromSpecs -SpecsDir $SpecsDir

    # Take the maximum of both
    $maxNum = [Math]::Max($highestBranch, $highestSpec)

    # Return next number
    return ($maxNum + 1)
}

# Function to clean and format a branch name
function Format-BranchName {
    param([string]$Name)
    
    return $Name.ToLower() -replace '[^a-z0-9]', '-' -replace '-+', '-' -replace '^-', '' -replace '-$', ''
}

# Resolve repository root
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$repoRoot = git rev-parse --show-toplevel 2>$null

if (-not $repoRoot) {
    $repoRoot = Find-RepoRoot -StartDir $scriptDir
    if (-not $repoRoot) {
        Write-Error "Error: Could not determine repository root. Please run this script from within the repository." 
        exit 1
    }
    $hasGit = $false
} else {
    $hasGit = $true
}

Set-Location $repoRoot

$specsDir = Join-Path $repoRoot ".team/specs"
if (-not (Test-Path $specsDir)) {
    New-Item -ItemType Directory -Path $specsDir -Force | Out-Null
}

# Function to generate branch name with stop word filtering and length filtering
function Generate-BranchName {
    param([string]$Description)
    
    # Common stop words to filter out (as regex pattern)
    $stopWords = '^(i|a|an|the|to|for|of|in|on|at|by|with|from|is|are|was|were|be|been|being|have|has|had|do|does|did|will|would|should|could|can|may|might|must|shall|this|that|these|those|my|your|our|their|want|need|add|get|set)$'

    # Convert to lowercase and split into words
    $cleanName = $Description.ToLower() -replace '[^a-z0-9]', ' ' -split ' ' | Where-Object { $_ }

    # Filter words: remove stop words and words shorter than 3 chars (unless they're uppercase acronyms in original)
    $meaningfulWords = @()
    foreach ($word in $cleanName) {
        # Skip empty words
        if (-not $word) { continue }

        # Keep words that are NOT stop words AND (length >= 3 OR are potential acronyms)
        if ($word -notmatch $stopWords) {
            if ($word.Length -ge 3) {
                $meaningfulWords += $word
            }
            elseif ($Description -match "\b$($word.ToUpper())\b") {
                # Keep short words if they appear as uppercase in original (likely acronyms)
                $meaningfulWords += $word
            }
        }
    }

    # If we have meaningful words, use first 3-4 of them
    if ($meaningfulWords.Count -gt 0) {
        $maxWords = if ($meaningfulWords.Count -eq 4) { 4 } else { 3 }

        $result = ""
        for ($i = 0; $i -lt [Math]::Min($maxWords, $meaningfulWords.Count); $i++) {
            if ($result) { $result += "-" }
            $result += $meaningfulWords[$i]
        }
        return $result
    } else {
        # Fallback to original logic if no meaningful words found
        $cleaned = Format-BranchName -Name $Description
        $parts = $cleaned -split '-' | Where-Object { $_ } | Select-Object -First 3
        return ($parts -join '-')
    }
}

# Generate branch name
if ($ShortName) {
    # Use provided short name, just clean it up
    $branchSuffix = Format-BranchName -Name $ShortName
} else {
    # Generate from description with smart filtering
    $branchSuffix = Generate-BranchName -Name $FeatureDescription
}

# Determine branch number
if (-not $Number) {
    if ($hasGit) {
        # Check existing branches on remotes
        $branchNumber = Check-ExistingBranches -SpecsDir $specsDir
    } else {
        # Fall back to local directory check
        $highest = Get-HighestFromSpecs -SpecsDir $specsDir
        $branchNumber = $highest + 1
    }
} else {
    $branchNumber = $Number
}

# Format the feature number with leading zeros
$featureNum = "{0:D3}" -f $branchNumber
$branchName = "${featureNum}-${branchSuffix}"

# GitHub enforces a 244-byte limit on branch names
# Validate and truncate if necessary
$maxBranchLength = 244
if ($branchName.Length -gt $maxBranchLength) {
    # Calculate how much we need to trim from suffix
    # Account for: feature number (3) + hyphen (1) = 4 chars
    $maxSuffixLength = $maxBranchLength - 4

    # Truncate suffix at word boundary if possible
    $truncatedSuffix = $branchSuffix.Substring(0, [Math]::Min($maxSuffixLength, $branchSuffix.Length))
    # Remove trailing hyphen if truncation created one
    $truncatedSuffix = $truncatedSuffix.TrimEnd('-')

    $originalBranchName = $branchName
    $branchName = "${featureNum}-${truncatedSuffix}"

    Write-Warning "[team] Warning: Branch name exceeded GitHub's 244-byte limit"
    Write-Warning "[team] Original: $originalBranchName ($($originalBranchName.Length) bytes)"
    Write-Warning "[team] Truncated to: $branchName ($($branchName.Length) bytes)"
}

if ($hasGit) {
    try {
        # Try to create new branch
        git checkout -b $branchName 2>$null
        if ($LASTEXITCODE -ne 0) {
            # If branch already exists, switch to it
            git checkout $branchName 2>$null
        }
    }
    catch {
        Write-Warning "[team] Warning: Git repository not detected; skipped branch creation for $branchName"
    }
} else {
    Write-Warning "[team] Warning: Git repository not detected; skipped branch creation for $branchName"
}

$featureDir = Join-Path $specsDir $branchName
New-Item -ItemType Directory -Path $featureDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $featureDir "personas") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $featureDir "checklists") -Force | Out-Null

$template = Join-Path $repoRoot ".team" "templates" "spec-template.md"
$specFile = Join-Path $featureDir "spec.md"

if (Test-Path $template) {
    Copy-Item $template $specFile
} else {
    # Create a basic spec file if template doesn't exist
    Set-Content -Path $specFile -Value ""
}

# Set the TEAM_FEATURE environment variable for the current session
$env:TEAM_FEATURE = $branchName

# Output results
if ($Json) {
    $result = @{
        BRANCH_NAME = $branchName
        SPEC_FILE = $specFile
        FEATURE_NUM = $featureNum
    }
    $result | ConvertTo-Json
} else {
    Write-Output "BRANCH_NAME: $branchName"
    Write-Output "SPEC_FILE: $specFile"
    Write-Output "FEATURE_NUM: $featureNum"
    Write-Output "TEAM_FEATURE environment variable set to: $branchName"
}
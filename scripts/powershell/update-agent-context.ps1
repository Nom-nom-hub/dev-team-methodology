# PowerShell script to update agent context files for team methodology
# Usage: update-agent-context.ps1 [agent-type]
# Agent types: claude, gemini, copilot, cursor-agent, qwen, opencode, codex, windsurf, kilocode, auggie, shai, q, bob, qoder

param(
    [string]$AgentType
)

# Enable strict error handling
$ErrorActionPreference = "Stop"

# Load common functions
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
. (Join-Path $scriptDir "common.ps1")

# Get all paths and variables from common functions
$paths = Get-FeaturePaths
$newPlan = $paths.IMPL_PLAN
$featureSpec = $paths.FEATURE_SPEC

# Agent-specific file paths for team methodology
$agentFiles = @{
    CLAUDE_FILE = Join-Path $paths.REPO_ROOT "CLAUDE.md"
    GEMINI_FILE = Join-Path $paths.REPO_ROOT "GEMINI.md"
    COPILOT_FILE = Join-Path $paths.REPO_ROOT ".github" "agents" "team-copilot-instructions.md"
    CURSOR_FILE = Join-Path $paths.REPO_ROOT ".cursor" "rules" "team-rules.mdc"
    QWEN_FILE = Join-Path $paths.REPO_ROOT "QWEN.md"
    AGENTS_FILE = Join-Path $paths.REPO_ROOT "AGENTS.md"
    WINDSURF_FILE = Join-Path $paths.REPO_ROOT ".windsurf" "rules" "team-rules.md"
    KILOCODE_FILE = Join-Path $paths.REPO_ROOT ".kilocode" "rules" "team-rules.md"
    AUGGIE_FILE = Join-Path $paths.REPO_ROOT ".augment" "rules" "team-rules.md"
    ROO_FILE = Join-Path $paths.REPO_ROOT ".roo" "rules" "team-rules.md"
    CODEBUDDY_FILE = Join-Path $paths.REPO_ROOT "CODEBUDDY.md"
    QODER_FILE = Join-Path $paths.REPO_ROOT "QODER.md"
    AMP_FILE = Join-Path $paths.REPO_ROOT "AGENTS.md"
    SHAI_FILE = Join-Path $paths.REPO_ROOT "SHAI.md"
    Q_FILE = Join-Path $paths.REPO_ROOT "AGENTS.md"
    BOB_FILE = Join-Path $paths.REPO_ROOT "AGENTS.md"
}

# Template file
$templateFile = Join-Path $paths.REPO_ROOT ".team" "templates" "agent-file-template.md"

# Global variables for parsed plan data
$newLang = ""
$newFramework = ""
$newDb = ""
$newProjectType = ""
$newTeamPerspectives = ""

function Write-Info {
    param([string]$Message)
    Write-Host "INFO: $Message"
}

function Write-Success {
    param([string]$Message)
    Write-Host "✓ $Message" -ForegroundColor Green
}

function Write-ErrorCustom {
    param([string]$Message)
    Write-Host "ERROR: $Message" -ForegroundColor Red
}

function Write-WarningCustom {
    param([string]$Message)
    Write-Host "WARNING: $Message" -ForegroundColor Yellow
}

# Validation Functions
function Validate-Environment {
    # Check if we have a current branch/feature (git or non-git)
    if (-not $paths.CURRENT_BRANCH) {
        Write-ErrorCustom "Unable to determine current feature"
        if ($paths.HAS_GIT) {
            Write-Info "Make sure you're on a feature branch"
        } else {
            Write-Info "Set TEAM_FEATURE environment variable or create a feature first"
        }
        exit 1
    }

    # Check if plan.md exists
    if (-not (Test-Path $newPlan)) {
        Write-ErrorCustom "No plan.md found at $newPlan"
        Write-Info "Make sure you're working on a feature with a corresponding spec directory"
        if (-not $paths.HAS_GIT) {
            Write-Info "Use: `$env:TEAM_FEATURE='your-feature-name' or create a new feature first"
        }
        exit 1
    }

    # Check if spec.md exists
    if (-not (Test-Path $featureSpec)) {
        Write-ErrorCustom "No spec.md found at $featureSpec"
        Write-Info "Make sure you have a specification file in the feature directory"
        exit 1
    }

    # Check if template exists (needed for new files)
    if (-not (Test-Path $templateFile)) {
        Write-WarningCustom "Template file not found at $templateFile"
        Write-WarningCustom "Creating new agent files will fail"
    }
}

# Plan Parsing Functions
function Extract-PlanField {
    param(
        [string]$FieldPattern,
        [string]$PlanFile
    )

    $content = Get-Content $PlanFile -Raw
    $pattern = "\*\*$FieldPattern\*\*: (.+?)(?=\n|\*\*|$)"
    $match = [regex]::Match($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
    
    if ($match.Success) {
        $value = $match.Groups[1].Value.Trim()
        if ($value -ne "NEEDS CLARIFICATION" -and $value -ne "N/A") {
            return $value
        }
    }
    return ""
}

function Parse-PlanData {
    param([string]$PlanFile)

    if (-not (Test-Path $PlanFile)) {
        Write-ErrorCustom "Plan file not found: $PlanFile"
        return $false
    }

    Write-Info "Parsing plan data from $PlanFile"

    $newLang = Extract-PlanField -FieldPattern "Language/Version" -PlanFile $PlanFile
    $newFramework = Extract-PlanField -FieldPattern "Primary Dependencies" -PlanFile $PlanFile
    $newDb = Extract-PlanField -FieldPattern "Storage" -PlanFile $PlanFile
    $newProjectType = Extract-PlanField -FieldPattern "Project Type" -PlanFile $PlanFile

    # Update global variables
    Set-Variable -Name "newLang" -Value $newLang -Scope Global
    Set-Variable -Name "newFramework" -Value $newFramework -Scope Global
    Set-Variable -Name "newDb" -Value $newDb -Scope Global
    Set-Variable -Name "newProjectType" -Value $newProjectType -Scope Global

    # Log what we found
    if ($newLang) {
        Write-Info "Found language: $newLang"
    } else {
        Write-WarningCustom "No language information found in plan"
    }

    if ($newFramework) {
        Write-Info "Found framework: $newFramework"
    }

    if ($newDb -and $newDb -ne "N/A") {
        Write-Info "Found database: $newDb"
    }

    if ($newProjectType) {
        Write-Info "Found project type: $newProjectType"
    }

    return $true
}

# Function to extract team persona information from spec file
function Extract-TeamPerspectives {
    param([string]$SpecFile)
    
    if (-not (Test-Path $SpecFile)) {
        Write-ErrorCustom "Spec file not found: $SpecFile"
        return $false
    }

    Write-Info "Extracting team perspectives from $SpecFile"

    $content = Get-Content $SpecFile -Raw

    # Extract sections using regex
    $pmSection = ""
    $archSection = ""
    $uxSection = ""
    $qaSection = ""
    $devSection = ""
    $devopsSection = ""

    # Using regex to extract sections - look for headers and content until next header
    $pattern = "(?s)(^### Product Manager Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $pmSection = $match.Value.Trim()
    }

    $pattern = "(?s)(^### Technical Architect Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $archSection = $match.Value.Trim()
    }

    $pattern = "(?s)(^### UX Designer Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $uxSection = $match.Value.Trim()
    }

    $pattern = "(?s)(^### Quality Assurance Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $qaSection = $match.Value.Trim()
    }

    $pattern = "(?s)(^### Developer Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $devSection = $match.Value.Trim()
    }

    $pattern = "(?s)(^### DevOps Perspective.*?)(?=\n###|\z)"
    $match = [regex]::Match($content, $pattern)
    if ($match.Success) {
        $devopsSection = $match.Value.Trim()
    }

    # Combine all sections for context
    $teamPerspectives = ""
    if ($pmSection) { $teamPerspectives += "$pmSection`n" }
    if ($archSection) { $teamPerspectives += "$archSection`n" }
    if ($uxSection) { $teamPerspectives += "$uxSection`n" }
    if ($qaSection) { $teamPerspectives += "$qaSection`n" }
    if ($devSection) { $teamPerspectives += "$devSection`n" }
    if ($devopsSection) { $teamPerspectives += "$devopsSection`n" }

    # Limit the length to avoid very long agent context
    if ($teamPerspectives.Length -gt 2000) {
        Write-WarningCustom "Team perspectives are quite long, truncating to first 2000 characters"
        $teamPerspectives = $teamPerspectives.Substring(0, 2000) + "..."
    }

    # Update global variable
    Set-Variable -Name "newTeamPerspectives" -Value $teamPerspectives -Scope Global

    return $true
}

function Format-TechnologyStack {
    param(
        [string]$Lang,
        [string]$Framework
    )

    $parts = @()
    
    if ($Lang -and $Lang -ne "NEEDS CLARIFICATION") {
        $parts += $Lang
    }
    
    if ($Framework -and $Framework -ne "NEEDS CLARIFICATION" -and $Framework -ne "N/A") {
        $parts += $Framework
    }

    if ($parts.Count -eq 0) {
        return ""
    } elseif ($parts.Count -eq 1) {
        return $parts[0]
    } else {
        return ($parts -join " + ")
    }
}

function Get-ProjectStructure {
    param([string]$ProjectType)
    
    if ($ProjectType -match "web") {
        return "backend/`nfrontend/`ntests/"
    } else {
        return "src/`ntests/"
    }
}

function Get-CommandsForLanguage {
    param([string]$Lang)
    
    switch -Wildcard ($Lang) {
        "*Python*" { return "cd src && pytest && ruff check ." }
        "*Rust*" { return "cargo test && cargo clippy" }
        "*JavaScript*" { return "npm test ``&``& npm run lint" }
        "*TypeScript*" { return "npm test ``&``& npm run lint" }
        default { return "# Add commands for $Lang" }
    }
}

function Get-LanguageConventions {
    param([string]$Lang)
    return "$Lang: Follow standard conventions"
}

function Create-NewAgentFile {
    param(
        [string]$TargetFile,
        [string]$ProjectName,
        [string]$CurrentDate
    )

    if (-not (Test-Path $templateFile)) {
        Write-ErrorCustom "Template not found at $templateFile"
        return $false
    }

    Write-Info "Creating new agent context file from template..."

    # Read template content
    $templateContent = Get-Content $templateFile -Raw

    # Replace template placeholders
    $projectStructure = Get-ProjectStructure -ProjectType $newProjectType
    $commands = Get-CommandsForLanguage -Lang $newLang
    $languageConventions = Get-LanguageConventions -Lang $newLang

    # Build technology stack and recent change strings conditionally
    $techStack = ""
    if ($newLang -and $newFramework) {
        $techStack = "- $newLang + $newFramework ($paths.CURRENT_BRANCH)"
    } elseif ($newLang) {
        $techStack = "- $newLang ($paths.CURRENT_BRANCH)"
    } elseif ($newFramework) {
        $techStack = "- $newFramework ($paths.CURRENT_BRANCH)"
    } else {
        $techStack = "- ($paths.CURRENT_BRANCH)"
    }

    $recentChange = ""
    if ($newLang -and $newFramework) {
        $recentChange = "- $paths.CURRENT_BRANCH: Added $newLang + $newFramework"
    } elseif ($newLang) {
        $recentChange = "- $paths.CURRENT_BRANCH: Added $newLang"
    } elseif ($newFramework) {
        $recentChange = "- $paths.CURRENT_BRANCH: Added $newFramework"
    } else {
        $recentChange = "- $paths.CURRENT_BRANCH: Added"
    }

    # Replace placeholders in template
    $templateContent = $templateContent -replace '\[PROJECT NAME\]', $ProjectName
    $templateContent = $templateContent -replace '\[DATE\]', $CurrentDate
    $templateContent = $templateContent -replace '\[EXTRACTED FROM ALL PLAN.MD FILES\]', $techStack
    $templateContent = $templateContent -replace '\[ACTUAL STRUCTURE FROM PLANS\]', $projectStructure
    $templateContent = $templateContent -replace '\[ONLY COMMANDS FOR ACTIVE TECHNOLOGIES\]', $commands
    $templateContent = $templateContent -replace '\[LANGUAGE-SPECIFIC, ONLY FOR LANGUAGES IN USE\]', $languageConventions
    $templateContent = $templateContent -replace '\[LAST 3 FEATURES AND WHAT THEY ADDED\]', $recentChange
    $templateContent = $templateContent -replace '\[TEAM PERSPECTIVES\]', $newTeamPerspectives

    # Convert \n sequences to actual newlines
    $templateContent = $templateContent -replace '\\n', "`n"

    # Create directory if it doesn't exist
    $targetDir = Split-Path $TargetFile -Parent
    if (-not (Test-Path $targetDir)) {
        New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    }

    # Write the file
    Set-Content -Path $TargetFile -Value $templateContent -Encoding UTF8

    return $true
}

function Update-ExistingAgentFile {
    param(
        [string]$TargetFile,
        [string]$CurrentDate
    )

    Write-Info "Updating existing agent context file..."

    # Read the existing file
    $lines = Get-Content $TargetFile

    # Process the file line by line
    $newLines = @()
    $inTechSection = $false
    $inChangesSection = $false
    $inTeamSection = $false
    $techEntriesAdded = $false
    $changesEntriesAdded = $false
    $teamEntriesAdded = $false
    $existingChangesCount = 0
    
    $techStack = Format-TechnologyStack -Lang $newLang -Framework $newFramework
    $hasActiveTechnologies = $false
    $hasRecentChanges = $false
    $hasTeamCollaboration = $false

    # Check if sections exist
    $fileContent = $lines -join "`n"
    if ($fileContent -match "^## Active Technologies") { $hasActiveTechnologies = $true }
    if ($fileContent -match "^## Recent Changes") { $hasRecentChanges = $true }
    if ($fileContent -match "^## Team Collaboration") { $hasTeamCollaboration = $true }

    # Prepare new technology entries
    $newTechEntries = @()
    if ($techStack -and $fileContent -notmatch [regex]::Escape($techStack)) {
        $newTechEntries += "- $techStack ($paths.CURRENT_BRANCH)"
    }
    if ($newDb -and $newDb -ne "N/A" -and $newDb -ne "NEEDS CLARIFICATION" -and $fileContent -notmatch [regex]::Escape($newDb)) {
        $newTechEntries += "- $newDb ($paths.CURRENT_BRANCH)"
    }

    # Prepare new change entry
    $newChangeEntry = ""
    if ($techStack) {
        $newChangeEntry = "- $paths.CURRENT_BRANCH: Added $techStack"
    } elseif ($newDb -and $newDb -ne "N/A" -and $newDb -ne "NEEDS CLARIFICATION") {
        $newChangeEntry = "- $paths.CURRENT_BRANCH: Added $newDb"
    }

    foreach ($line in $lines) {
        # Handle Active Technologies section
        if ($line -match "^## Active Technologies") {
            $newLines += $line
            $inTechSection = $true
            continue
        } elseif ($inTechSection -and $line -match "^##\s") {
            # Add new tech entries before closing the section
            if (-not $techEntriesAdded -and $newTechEntries.Count -gt 0) {
                $newLines += $newTechEntries
                $techEntriesAdded = $true
            }
            $newLines += $line
            $inTechSection = $false
            continue
        } elseif ($inTechSection -and $line -match "^\s*$") {
            # Add new tech entries before empty line in tech section
            if (-not $techEntriesAdded -and $newTechEntries.Count -gt 0) {
                $newLines += $newTechEntries
                $techEntriesAdded = $true
            }
            $newLines += $line
            continue
        }

        # Handle Recent Changes section
        if ($line -match "^## Recent Changes") {
            $newLines += $line
            # Add new change entry right after the heading
            if ($newChangeEntry) {
                $newLines += $newChangeEntry
            }
            $inChangesSection = $true
            $changesEntriesAdded = $true
            continue
        } elseif ($inChangesSection -and $line -match "^##\s") {
            $newLines += $line
            $inChangesSection = $false
            continue
        } elseif ($inChangesSection -and $line -match "^-\s") {
            # Keep only first 2 existing changes
            if ($existingChangesCount -lt 2) {
                $newLines += $line
                $existingChangesCount++
            }
            continue
        }

        # Handle Team Collaboration section
        if ($line -match "^## Team Collaboration") {
            $newLines += $line
            # Add team perspectives if available
            if ($newTeamPerspectives) {
                $newLines += $newTeamPerspectives
            }
            $inTeamSection = $true
            $teamEntriesAdded = $true
            continue
        } elseif ($inTeamSection -and $line -match "^##\s") {
            $newLines += $line
            $inTeamSection = $false
            continue
        }

        # Update timestamp
        if ($line -match "\*\*Last updated\*\*:\s*.*\d{4}-\d{2}-\d{2}") {
            $newLines += [regex]::Replace($line, "\d{4}-\d{2}-\d{2}", $CurrentDate)
        } else {
            $newLines += $line
        }
    }

    # Post-loop check: if we're still in the Active Technologies section and haven't added new entries
    if ($inTechSection -and -not $techEntriesAdded -and $newTechEntries.Count -gt 0) {
        $newLines += $newTechEntries
        $techEntriesAdded = $true
    }

    # If sections don't exist, add them at the end of the file
    if (-not $hasActiveTechnologies -and $newTechEntries.Count -gt 0) {
        $newLines += "", "## Active Technologies"
        $newLines += $newTechEntries
        $techEntriesAdded = $true
    }

    if (-not $hasRecentChanges -and $newChangeEntry) {
        $newLines += "", "## Recent Changes"
        $newLines += $newChangeEntry
        $changesEntriesAdded = $true
    }

    if (-not $hasTeamCollaboration -and $newTeamPerspectives) {
        $newLines += "", "## Team Collaboration"
        $newLines += $newTeamPerspectives
        $teamEntriesAdded = $true
    }

    # Write the updated file
    Set-Content -Path $TargetFile -Value ($newLines -join "`n") -Encoding UTF8

    return $true
}

function Update-AgentFile {
    param(
        [string]$TargetFile,
        [string]$AgentName
    )

    if (-not $TargetFile -or -not $AgentName) {
        Write-ErrorCustom "Update-AgentFile requires TargetFile and AgentName parameters"
        return $false
    }

    Write-Info "Updating $AgentName context file: $TargetFile"

    $projectName = Split-Path $paths.REPO_ROOT -Leaf
    $currentDate = Get-Date -Format "yyyy-MM-dd"

    # Create directory if it doesn't exist
    $targetDir = Split-Path $TargetFile -Parent
    if (-not (Test-Path $targetDir)) {
        try {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        catch {
            Write-ErrorCustom "Failed to create directory: $targetDir"
            return $false
        }
    }

    if (-not (Test-Path $TargetFile)) {
        # Create new file from template
        if (Create-NewAgentFile -TargetFile $TargetFile -ProjectName $projectName -CurrentDate $currentDate) {
            Write-Success "Created new $AgentName context file"
            return $true
        } else {
            Write-ErrorCustom "Failed to create new agent file"
            return $false
        }
    } else {
        # Update existing file
        if (Test-Path $TargetFile -PathType Leaf) {
            if (Update-ExistingAgentFile -TargetFile $TargetFile -CurrentDate $currentDate) {
                Write-Success "Updated existing $AgentName context file"
                return $true
            } else {
                Write-ErrorCustom "Failed to update existing agent file"
                return $false
            }
        } else {
            Write-ErrorCustom "Cannot read existing file: $TargetFile"
            return $false
        }
    }
}

function Update-SpecificAgent {
    param([string]$Type)

    switch ($Type) {
        "claude" { return Update-AgentFile -TargetFile $agentFiles.CLAUDE_FILE -AgentName "Claude Code" }
        "gemini" { return Update-AgentFile -TargetFile $agentFiles.GEMINI_FILE -AgentName "Gemini CLI" }
        "copilot" { return Update-AgentFile -TargetFile $agentFiles.COPILOT_FILE -AgentName "GitHub Copilot" }
        "cursor-agent" { return Update-AgentFile -TargetFile $agentFiles.CURSOR_FILE -AgentName "Cursor IDE" }
        "qwen" { return Update-AgentFile -TargetFile $agentFiles.QWEN_FILE -AgentName "Qwen Code" }
        "opencode" { return Update-AgentFile -TargetFile $agentFiles.AGENTS_FILE -AgentName "opencode" }
        "codex" { return Update-AgentFile -TargetFile $agentFiles.AGENTS_FILE -AgentName "Codex CLI" }
        "windsurf" { return Update-AgentFile -TargetFile $agentFiles.WINDSURF_FILE -AgentName "Windsurf" }
        "kilocode" { return Update-AgentFile -TargetFile $agentFiles.KILOCODE_FILE -AgentName "Kilo Code" }
        "auggie" { return Update-AgentFile -TargetFile $agentFiles.AUGGIE_FILE -AgentName "Auggie CLI" }
        "roo" { return Update-AgentFile -TargetFile $agentFiles.ROO_FILE -AgentName "Roo Code" }
        "codebuddy" { return Update-AgentFile -TargetFile $agentFiles.CODEBUDDY_FILE -AgentName "CodeBuddy CLI" }
        "qoder" { return Update-AgentFile -TargetFile $agentFiles.QODER_FILE -AgentName "Qoder CLI" }
        "amp" { return Update-AgentFile -TargetFile $agentFiles.AMP_FILE -AgentName "Amp" }
        "shai" { return Update-AgentFile -TargetFile $agentFiles.SHAI_FILE -AgentName "SHAI" }
        "q" { return Update-AgentFile -TargetFile $agentFiles.Q_FILE -AgentName "Amazon Q Developer CLI" }
        "bob" { return Update-AgentFile -TargetFile $agentFiles.BOB_FILE -AgentName "IBM Bob" }
        default {
            Write-ErrorCustom "Unknown agent type '$Type'"
            Write-ErrorCustom "Expected: claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|roo|amp|shai|q|bob|qoder"
            exit 1
        }
    }
}

function Update-AllExistingAgents {
    $foundAgent = $false

    # Check each possible agent file and update if it exists
    if (Test-Path $agentFiles.CLAUDE_FILE) {
        Update-AgentFile -TargetFile $agentFiles.CLAUDE_FILE -AgentName "Claude Code" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.GEMINI_FILE) {
        Update-AgentFile -TargetFile $agentFiles.GEMINI_FILE -AgentName "Gemini CLI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.COPILOT_FILE) {
        Update-AgentFile -TargetFile $agentFiles.COPILOT_FILE -AgentName "GitHub Copilot" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.CURSOR_FILE) {
        Update-AgentFile -TargetFile $agentFiles.CURSOR_FILE -AgentName "Cursor IDE" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.QWEN_FILE) {
        Update-AgentFile -TargetFile $agentFiles.QWEN_FILE -AgentName "Qwen Code" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.AGENTS_FILE) {
        Update-AgentFile -TargetFile $agentFiles.AGENTS_FILE -AgentName "Codex/opencode" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.WINDSURF_FILE) {
        Update-AgentFile -TargetFile $agentFiles.WINDSURF_FILE -AgentName "Windsurf" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.KILOCODE_FILE) {
        Update-AgentFile -TargetFile $agentFiles.KILOCODE_FILE -AgentName "Kilo Code" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.AUGGIE_FILE) {
        Update-AgentFile -TargetFile $agentFiles.AUGGIE_FILE -AgentName "Auggie CLI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.ROO_FILE) {
        Update-AgentFile -TargetFile $agentFiles.ROO_FILE -AgentName "Roo Code" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.CODEBUDDY_FILE) {
        Update-AgentFile -TargetFile $agentFiles.CODEBUDDY_FILE -AgentName "CodeBuddy CLI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.SHAI_FILE) {
        Update-AgentFile -TargetFile $agentFiles.SHAI_FILE -AgentName "SHAI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.QODER_FILE) {
        Update-AgentFile -TargetFile $agentFiles.QODER_FILE -AgentName "Qoder CLI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.Q_FILE) {
        Update-AgentFile -TargetFile $agentFiles.Q_FILE -AgentName "Amazon Q Developer CLI" | Out-Null
        $foundAgent = $true
    }

    if (Test-Path $agentFiles.BOB_FILE) {
        Update-AgentFile -TargetFile $agentFiles.BOB_FILE -AgentName "IBM Bob" | Out-Null
        $foundAgent = $true
    }

    # If no agent files exist, create a default Claude file
    if (-not $foundAgent) {
        Write-Info "No existing agent files found, creating default Claude file..."
        Update-AgentFile -TargetFile $agentFiles.CLAUDE_FILE -AgentName "Claude Code" | Out-Null
    }
}

function Print-Summary {
    Write-Host ""
    Write-Info "Summary of changes:"

    if ($newLang) {
        Write-Host "  - Added language: $newLang"
    }

    if ($newFramework) {
        Write-Host "  - Added framework: $newFramework"
    }

    if ($newDb -and $newDb -ne "N/A") {
        Write-Host "  - Added database: $newDb"
    }

    if ($newTeamPerspectives) {
        Write-Host "  - Added team perspectives from specification"
    }

    Write-Host ""
    Write-Info "Usage: $(Split-Path $MyInvocation.MyCommand.Path -Leaf) [claude|gemini|copilot|cursor-agent|qwen|opencode|codex|windsurf|kilocode|auggie|codebuddy|shai|q|bob|qoder]"
}

# Main execution
Write-Info "=== Updating team methodology agent context files for feature $($paths.CURRENT_BRANCH) ==="

# Validate environment before proceeding
Validate-Environment

# Parse the plan file to extract project information
if (-not (Parse-PlanData -PlanFile $newPlan)) {
    Write-ErrorCustom "Failed to parse plan data"
    exit 1
}

# Parse the spec file to extract team perspectives
if (-not (Extract-TeamPerspectives -SpecFile $featureSpec)) {
    Write-ErrorCustom "Failed to extract team perspectives from spec"
    exit 1
}

# Process based on agent type argument
$success = $true

if (-not $AgentType) {
    # No specific agent provided - update all existing agent files
    Write-Info "No agent specified, updating all existing agent files..."
    try {
        Update-AllExistingAgents
    }
    catch {
        $success = $false
    }
} else {
    # Specific agent provided - update only that agent
    Write-Info "Updating specific agent: $AgentType"
    try {
        $result = Update-SpecificAgent -Type $AgentType
        if (-not $result) { $success = $false }
    }
    catch {
        $success = $false
    }
}

# Print summary
Print-Summary

if ($success) {
    Write-Success "Team methodology agent context update completed successfully"
} else {
    Write-ErrorCustom "Some agent files failed to update"
    exit 1
}
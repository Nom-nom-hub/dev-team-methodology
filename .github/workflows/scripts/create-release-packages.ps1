# create-release-packages.ps1 (workflow-local)
# Build Team Methodology template release archives for each supported AI assistant and script type.
# Usage: .github\workflows\scripts\create-release-packages.ps1 -Version <version>
#   Version argument should include leading 'v'.

param(
    [Parameter(Mandatory=$true)]
    [string]$Version
)

if ($Version -notmatch '^v\d+\.\d+\.\d+$') {
    Write-Error "Version must look like v0.0.0"
    exit 1
}

Write-Host "Building release packages for $Version"

# Create and use .genreleases directory for all build artifacts
$GENRELEASES_DIR = ".genreleases"
if (Test-Path $GENRELEASES_DIR) {
    Remove-Item -Path $GENRELEASES_DIR -Recurse -Force
}
New-Item -ItemType Directory -Path $GENRELEASES_DIR -Force | Out-Null

function Rewrite-Paths {
    param([string]$Content)
    
    $Content = $Content -replace '(/?)memory/@', '.team/memory/'
    $Content = $Content -replace '(/?)scripts/@', '.team/scripts/'
    $Content = $Content -replace '(/?)templates/@', '.team/templates/'
    return $Content
}

function Generate-Commands {
    param(
        [string]$Agent,
        [string]$Ext,
        [string]$ArgFormat,
        [string]$OutputDir,
        [string]$ScriptVariant
    )
    
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
    
    Get-ChildItem -Path "templates/commands/*.md" | ForEach-Object {
        $template = $_.FullName
        $name = $_.BaseName
        
        # Read template content
        $fileContent = Get-Content $template -Raw
        
        # Extract description and script command from YAML frontmatter
        $descriptionMatch = [regex]::Match($fileContent, '^description:\s*(.*)$', [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $description = if ($descriptionMatch.Success) { $descriptionMatch.Groups[1].Value.Trim() } else { "" }
        
        $scriptCommandMatch = [regex]::Match($fileContent, "^[[:space:]]*$ScriptVariant:[[:space:]]*(.*)$", [System.Text.RegularExpressions.RegexOptions]::Multiline)
        $scriptCommand = if ($scriptCommandMatch.Success) { $scriptCommandMatch.Groups[1].Value.Trim() } else { "(Missing script command for $ScriptVariant)" }
        
        # Replace {SCRIPT} placeholder with the script command
        $body = $fileContent -replace '\{SCRIPT\}', $scriptCommand
        
        # Remove the scripts: and agent_scripts: sections from frontmatter
        $body = [regex]::Replace($body, '(?s)^---$.*?^---$(.*?)(?=\n\w+:|\z)', {
            param($match)
            $frontmatter = $match.Value
            # Remove scripts and agent_scripts sections from frontmatter
            $cleanedFrontmatter = [regex]::Replace($frontmatter, '(?m)^\s*scripts:\s*$(\s*^\s*[a-z]+\s*:.*)*', '', [System.Text.RegularExpressions.RegexOptions]::Multiline)
            $cleanedFrontmatter = [regex]::Replace($cleanedFrontmatter, '(?m)^\s*agent_scripts:\s*$(\s*^\s*[a-z]+\s*:.*)*', '', [System.Text.RegularExpressions.RegexOptions]::Multiline)
            return $cleanedFrontmatter
        }, [System.Text.RegularExpressions.RegexOptions]::MultiLine)
        
        # Apply other substitutions
        $body = $body -replace '\{ARGS\}', $ArgFormat
        $body = $body -replace '__AGENT__', $Agent
        $body = Rewrite-Paths -Content $body
        
        # Write the file based on extension
        switch ($Ext) {
            "toml" {
                $bodyEscaped = $body -replace '\\', '\\'
                $output = "description = `"$description`"`n`nprompt = `"`"`n$bodyEscaped`n`"`"`n"
                Set-Content -Path "$OutputDir/team.$name.$ext" -Value $output
            }
            { @("md", "agent.md") -contains $_ } {
                Set-Content -Path "$OutputDir/team.$name.$ext" -Value $body
            }
        }
    }
}

function Generate-CopilotPrompts {
    param([string]$AgentsDir, [string]$PromptsDir)
    
    New-Item -ItemType Directory -Path $PromptsDir -Force | Out-Null
    
    Get-ChildItem -Path "$AgentsDir/team.*.agent.md" | ForEach-Object {
        $agentFile = $_.FullName
        $basename = $_.BaseName -replace '.agent.md', ''
        $promptFile = "$PromptsDir/${basename}.prompt.md"
        
        # Create prompt file with agent frontmatter
        $content = "---`nagent: $basename`n---`n"
        Set-Content -Path $promptFile -Value $content
    }
}

function Build-Variant {
    param([string]$Agent, [string]$Script)
    
    $baseDir = "$GENRELEASES_DIR/tdm-${Agent}-package-$script"
    Write-Host "Building $Agent ($Script) package..."
    New-Item -ItemType Directory -Path $baseDir -Force | Out-Null

    # Copy base structure but filter scripts by variant
    $TEAM_DIR = "$baseDir/.team"
    New-Item -ItemType Directory -Path $TEAM_DIR -Force | Out-Null

    if (Test-Path "memory") {
        Copy-Item -Path "memory" -Destination "$TEAM_DIR/" -Recurse
        Write-Host "Copied memory -> .team"
    }

    # Only copy the relevant script variant directory
    if (Test-Path "scripts") {
        New-Item -ItemType Directory -Path "$TEAM_DIR/scripts" -Force | Out-Null
        switch ($script) {
            "sh" {
                if (Test-Path "scripts/bash") {
                    Copy-Item -Path "scripts/bash" -Destination "$TEAM_DIR/scripts/" -Recurse
                    Write-Host "Copied scripts/bash -> .team/scripts"
                }
                # Copy any script files that aren't in variant-specific directories
                Get-ChildItem "scripts" -File | Where-Object { $_.Name -notin @("bash", "powershell") } | ForEach-Object {
                    Copy-Item -Path $_.FullName -Destination "$TEAM_DIR/scripts/"
                }
            }
            "ps" {
                if (Test-Path "scripts/powershell") {
                    Copy-Item -Path "scripts/powershell" -Destination "$TEAM_DIR/scripts/" -Recurse
                    Write-Host "Copied scripts/powershell -> .team/scripts"
                }
                # Copy any script files that aren't in variant-specific directories
                Get-ChildItem "scripts" -File | Where-Object { $_.Name -notin @("bash", "powershell") } | ForEach-Object {
                    Copy-Item -Path $_.FullName -Destination "$TEAM_DIR/scripts/"
                }
            }
        }
    }

    if (Test-Path "templates") {
        New-Item -ItemType Directory -Path "$TEAM_DIR/templates" -Force | Out-Null
        Get-ChildItem -Path "templates" -File -Recurse | Where-Object {
            $_.FullName -notmatch "templates/commands/" -and $_.Name -ne "vscode-settings.json"
        } | ForEach-Object {
            $destPath = Join-Path "$TEAM_DIR/templates" $_.FullName.Substring("templates".Length + 1)
            $destDir = Split-Path $destPath -Parent
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            Copy-Item -Path $_.FullName -Destination $destPath
        }
        Write-Host "Copied templates -> .team/templates"
    }

    # Process commands based on agent type
    $outputDir = $null
    switch ($agent) {
        "claude" { $outputDir = "$baseDir/.claude/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "gemini" { 
            $outputDir = "$baseDir/.gemini/commands"
            Generate-Commands -Agent $agent -Ext "toml" -ArgFormat "{{args}}" -OutputDir $outputDir -ScriptVariant $script
            if (Test-Path "agent_templates/gemini/GEMINI.md") {
                Copy-Item -Path "agent_templates/gemini/GEMINI.md" -Destination "$baseDir/GEMINI.md"
            }
        }
        "copilot" {
            $outputDir = "$baseDir/.github/agents"
            Generate-Commands -Agent $agent -Ext "agent.md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script
            # Generate companion prompt files
            Generate-CopilotPrompts -AgentsDir $outputDir -PromptsDir "$baseDir/.github/prompts"
            # Create VS Code workspace settings
            New-Item -ItemType Directory -Path "$baseDir/.vscode" -Force | Out-Null
            if (Test-Path "templates/vscode-settings.json") {
                Copy-Item -Path "templates/vscode-settings.json" -Destination "$baseDir/.vscode/settings.json"
            }
        }
        "cursor-agent" { $outputDir = "$baseDir/.cursor/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "qwen" { 
            $outputDir = "$baseDir/.qwen/commands"
            Generate-Commands -Agent $agent -Ext "toml" -ArgFormat "{{args}}" -OutputDir $outputDir -ScriptVariant $script
            if (Test-Path "agent_templates/qwen/QWEN.md") {
                Copy-Item -Path "agent_templates/qwen/QWEN.md" -Destination "$baseDir/QWEN.md"
            }
        }
        "opencode" { $outputDir = "$baseDir/.opencode/command"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "windsurf" { $outputDir = "$baseDir/.windsurf/workflows"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "codex" { $outputDir = "$baseDir/.codex/prompts"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "kilocode" { $outputDir = "$baseDir/.kilocode/workflows"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "auggie" { $outputDir = "$baseDir/.augment/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "roo" { $outputDir = "$baseDir/.roo/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "codebuddy" { $outputDir = "$baseDir/.codebuddy/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "qoder" { $outputDir = "$baseDir/.qoder/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "amp" { $outputDir = "$baseDir/.agents/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "shai" { $outputDir = "$baseDir/.shai/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "q" { $outputDir = "$baseDir/.amazonq/prompts"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
        "bob" { $outputDir = "$baseDir/.bob/commands"; Generate-Commands -Agent $agent -Ext "md" -ArgFormat "`$ARGUMENTS" -OutputDir $outputDir -ScriptVariant $script }
    }

    # Create the zip archive
    $zipFile = "$GENRELEASES_DIR/dev-team-methodology-template-${agent}-${script}-${Version}.zip"
    Compress-Archive -Path "$baseDir/*" -DestinationPath $zipFile -Force
    Write-Host "Created $zipFile"
}

# Determine agent and script lists
$ALL_AGENTS = @("claude", "gemini", "copilot", "cursor-agent", "qwen", "opencode", "windsurf", "codex", "kilocode", "auggie", "roo", "codebuddy", "amp", "shai", "q", "bob", "qoder")
$ALL_SCRIPTS = @("sh", "ps")

# Use all agents and scripts by default
$AGENT_LIST = $ALL_AGENTS
$SCRIPT_LIST = $ALL_SCRIPTS

Write-Host "Agents: $($AGENT_LIST -join ' ')"
Write-Host "Scripts: $($SCRIPT_LIST -join ' ')"

foreach ($agent in $AGENT_LIST) {
    foreach ($script in $SCRIPT_LIST) {
        Build-Variant -Agent $agent -Script $script
    }
}

Write-Host "Archives in $GENRELEASES_DIR:"
Get-ChildItem -Path "$GENRELEASES_DIR/dev-team-methodology-template-*-*$Version.zip" | ForEach-Object { Write-Host $_.Name }
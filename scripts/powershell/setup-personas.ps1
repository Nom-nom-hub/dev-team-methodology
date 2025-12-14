# PowerShell script for setting up team personas
# Usage: setup-personas.ps1 -Json "{json with personas}"

param(
    [string]$Json
)

# Parse JSON if provided
$personas = @("Product Manager", "Technical Architect", "UX Designer", "Quality Assurance", "Developer", "DevOps Engineer")

if ($Json) {
    try {
        $jsonObj = $Json | ConvertFrom-Json
        if ($jsonObj.personas) {
            $personasInput = $jsonObj.personas
            if ($personasInput -is [string]) {
                $personas = $personasInput -split ','
                $personas = $personas | ForEach-Object { $_.Trim() }
            }
        }
    }
    catch {
        Write-Error "Invalid JSON: $_"
        exit 1
    }
}

# Create personas directory if it doesn't exist
New-Item -ItemType Directory -Path "personas" -Force | Out-Null

# Create each persona file
foreach ($persona in $personas) {
    $personaClean = $persona.ToLower() -replace ' ', '-'
    $personaFile = "personas\$personaClean.md"
    
    if (-not (Test-Path $personaFile)) {
        $personaContent = @"
# $persona Persona

## Role Overview
The $persona is responsible for...

## Key Responsibilities
- [Responsibilities to be defined]

## Focus Areas
- **Focus Area 1**: [Details]
- **Focus Area 2**: [Details]

## Contribution to Development Process
[How this persona contributes]

## Key Questions to Ask During Specification Review
[Questions this persona asks]

## Validation Checklist
- [ ] [Validation item]
- [ ] [Validation item]

## Constraints and Guidelines
[Guidelines for this persona]

## Integration with Other Personas
[How this persona works with others]

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]
"@
        
        Set-Content -Path $personaFile -Value $personaContent
        Write-Host "Created $personaFile"
    }
    else {
        Write-Host "File $personaFile already exists, skipping..."
    }
}

Write-Host "Setup completed successfully!"
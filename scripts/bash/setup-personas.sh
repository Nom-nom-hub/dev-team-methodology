#!/bin/bash

# Team Methodology - Setup personas script
# Usage: setup-personas.sh --json "personas to create"

set -e

# Default values
PERSONAS=""
JSON_INPUT=""

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --json)
            JSON_INPUT="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter: $1"
            exit 1
            ;;
    esac
done

# Function to create persona files
create_persona_files() {
    local personas_list="$1"
    
    # Create personas directory if it doesn't exist
    mkdir -p "personas"
    
    # Create each persona file based on the list
    IFS=',' read -ra PERSONA_ARRAY <<< "$personas_list"
    
    for persona in "${PERSONA_ARRAY[@]}"; do
        persona_clean=$(echo "$persona" | xargs | sed 's/ /-/g' | tr '[:upper:]' '[:lower:]')
        
        # Create persona file if it doesn't exist
        if [[ ! -f "personas/$persona_clean.md" ]]; then
            cat > "personas/$persona_clean.md" << EOF
# $(echo "$persona" | xargs) Persona

## Role Overview
The $(echo "$persona" | xargs) is responsible for...

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
EOF
            echo "Created personas/$persona_clean.md"
        else
            echo "File personas/$persona_clean.md already exists, skipping..."
        fi
    done
}

# Main execution
if [[ -n "$JSON_INPUT" ]]; then
    # Parse JSON input to extract personas
    PERSONAS=$(echo "$JSON_INPUT" | grep -o '"personas":"[^"]*"' | cut -d'"' -f4)
    if [[ -z "$PERSONAS" ]]; then
        PERSONAS="$JSON_INPUT"  # Use as-is if not proper JSON
    fi
else
    PERSONAS="Product Manager,Technical Architect,UX Designer,Quality Assurance,Developer,DevOps Engineer"
fi

create_persona_files "$PERSONAS"

echo "Setup completed successfully!"
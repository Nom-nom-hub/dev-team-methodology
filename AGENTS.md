# Team Methodology for AI Agents

This document provides instructions for AI agents to understand and implement the Team-Driven Development methodology.

## Overview

The Team Methodology is a framework for software development that incorporates perspectives from multiple team personas:
- **Product Manager**: Defines user value and success metrics
- **Technical Architect**: Validates technical feasibility and architecture
- **UX Designer**: Ensures user experience and accessibility
- **Quality Assurance**: Defines testing approach and quality standards
- **Developer**: Implements technical solution and code quality
- **DevOps**: Manages deployment and operational concerns

## Command Structure

The methodology provides these slash commands:

- `/team.constitution` - Establish project principles
- `/team.personas` - Define team roles and responsibilities
- `/team.specify` - Create baseline specification with team input
- `/team.review` - Review specification from all team perspectives
- `/team.plan` - Create implementation plan with team input
- `/team.tasks` - Generate actionable tasks with team ownership
- `/team.implement` - Execute implementation with team collaboration
- `/team.checklist` - Generate quality checklists
- `/team.clarify` - Ask structured questions to de-risk areas
- `/team.analyze` - Cross-artifact consistency report

## Integration Notes

When implementing the Team Methodology:

1. **Always consider team perspectives**: Each specification, plan, and task should incorporate input from relevant team personas.

2. **Validate across team roles**: Requirements should be validated by Product Manager (value), Technical Architect (feasibility), UX Designer (experience), QA (testability), Developer (implementation), and DevOps (operations).

3. **Maintain traceability**: Keep track of how each team persona's input influences the development artifacts.

4. **Follow the workflow**: Use the commands in sequence (specify → review → plan → tasks → implement) for best results.

## Key Principles

- **Collaboration First**: All decisions require input from relevant team personas
- **Cross-Validation**: Every requirement must be validated by all applicable team members
- **Incremental Value**: Features deliver value at each stage of development
- **Quality Integration**: Quality assurance is built into every phase
- **Continuous Feedback**: Regular team communication and feedback loops

## Directories and Files

- `specs/` - Feature specifications with team perspective inputs
- `specs/[feature]/personas/` - Individual team persona perspectives
- `specs/[feature]/checklists/` - Team validation checklists
- `.team/` - Team methodology configuration and templates
- `memory/constitution.md` - Project principles and team agreements

## Agent-Specific Instructions

Different AI agents may have specific configurations:
- Claude: Uses `.claude/commands/` directory
- Copilot: Uses `.github/agents/` directory
- Cursor: Uses `.cursor/commands/` directory
- Qwen: Uses `.qwen/commands/` directory
- And others...

Each agent will have team methodology commands available in their respective directories when the template packages are installed.
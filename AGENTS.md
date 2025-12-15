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

1. **Always consider team perspectives**: Each specification, plan, and task should incorporate input from relevant team
   personas.

1. **Validate across team roles**: Requirements should be validated by Product Manager (value), Technical Architect
   (feasibility), UX Designer (experience), QA (testability), Developer (implementation), and DevOps (operations).

1. **Maintain traceability**: Keep track of how each team persona's input influences the development artifacts.

1. **Follow the workflow**: Use the commands in sequence (specify → review → plan → tasks → implement) for best results.

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

Different AI agents have specific configurations and optimized workflows:

### Claude
- **Location**: `.claude/commands/` directory for custom instructions
- **Strengths**: Multi-perspective reasoning, detailed planning, excellent documentation
- **Best for**: `/team.specify`, `/team.review`, `/team.plan`
- **Context**: 200k tokens (sufficient for large features)
- **Setup**: Install Claude Code; runs team commands natively with full context

### Amp
- **Location**: `.amp/` directory for configuration (if present)
- **Strengths**: Fast code generation, multi-file handling, context switching
- **Best for**: `/team.tasks`, `/team.implement`, code review phases
- **Context**: Varies by usage tier; excellent for rapid iteration
- **Setup**: Works in free mode with ads; no special installation needed
- **Amp-Specific Optimization Tips**:
  - Use Amp after Claude has established specification and plan
  - Amp excels at reading existing code and generating compatible implementations
  - Leverage multi-file awareness for cross-module changes and refactoring
  - Effective for code review with fresh perspective
  - Fast context switching between features and components
  - Good for rapid iteration and small refinements

### Cursor
- **Location**: `.cursor/commands/` directory
- **Strengths**: IDE integration, file-aware refactoring, real-time feedback
- **Best for**: `/team.implement`, refactoring, local code modifications
- **Context**: 180k tokens with IDE file context
- **Setup**: Cursor Agent with slash commands enabled

### GitHub Copilot
- **Location**: `.github/agents/` directory
- **Strengths**: GitHub Actions integration, accessibility, editor integration
- **Best for**: Code completion, smaller implementation tasks
- **Context**: 128k tokens
- **Note**: Limited context for `/team.specify` and `/team.plan`; best used in implementation phase

### Gemini
- **Location**: `.gemini/` directory (if configured)
- **Strengths**: Massive context window (2M tokens), cost-effective, good exploration
- **Best for**: Large features, comprehensive specifications, design exploration
- **Context**: 2M tokens (largest of all agents)
- **Setup**: Google Gemini API integration

### Other Agents (Qwen, Qoder, CodeBuddy, Roo, SHAI, etc.)
- **Location**: Agent-specific configuration directories created during `team init`
- **Setup**: Run `team init . --ai <agent-name>` to configure
- **See**: [AGENT-CAPABILITIES.md](./docs/AGENT-CAPABILITIES.md) for detailed comparison

### Recommended Agent Pairings by Workflow Phase

| Phase | Primary | Secondary | Rationale |
|-------|---------|-----------|-----------|
| Specify | Claude | Gemini | Need reasoning about user value and feasibility |
| Review | Amp | Claude | Fresh perspective on specifications |
| Plan | Claude | Gemini | Architecture and technical decisions |
| Tasks | Amp | Claude | Speed valuable for task generation |
| Implement | Amp, Cursor | Claude | Speed and code quality essential |
| Refactor | Cursor | Amp | IDE integration or fast multi-file changes |

### Cross-Agent Workflows

Teams can switch agents between phases without losing context. All artifacts are **plain markdown** and **agent-agnostic**:

```
Project: 001-feature-name/
├── spec.md (created with Claude)
├── plan.md (created with Claude)
├── tasks.md (created with Amp)
├── implementation/ (created with Cursor + Amp)
└── refactoring/ (improved with Cursor)
```

**Any agent can**:
- Read and understand existing specs, plans, and code
- Generate new tasks or implementation based on artifacts
- Review and refactor code from other agents
- Continue work started by another agent

### Best Practices for Agent Switching

1. **Keep artifacts in plain markdown** - No proprietary formats
2. **Provide context** - When switching agents, paste relevant sections of specs/plans
3. **Leverage strengths** - Use each agent where it excels most
4. **Validate transitions** - Run `/team.analyze` after agent hand-offs to catch inconsistencies
5. **Document decisions** - In `decision-log.md` when changing agents or approaches

Each agent will have team methodology commands available in their respective directories when the template packages are installed.

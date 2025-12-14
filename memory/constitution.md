# [PROJECT_NAME] Constitution

<!-- Example: Team Constitution, DevFlow Constitution, etc. -->

## Core Principles

### I. Library-First (Developer & Architect Focus)

Every feature starts as a standalone library; Libraries must be self-contained, independently testable, documented;
Clear purpose required - no organizational-only libraries. Both Developers and Technical Architects must validate this
requirement.

### II. CLI Interface (Developer & DevOps Focus)

Every library exposes functionality via CLI; Text in/out protocol: stdin/args → stdout, errors → stderr; Support JSON +
human-readable formats; Must be deployable and monitorable by DevOps.

### III. Test-First (QA Focus) - NON-NEGOTIABLE

TDD mandatory: Tests written → QA approved → Tests fail → Then implement; Red-Green-Refactor cycle strictly enforced.

### IV. Integration Testing (QA & DevOps Focus)

Focus areas requiring integration tests: New library contract tests, Contract changes, Inter-service communication,
Shared schemas. DevOps perspective required for realistic environment testing.

### V. Product Value (Product Manager Focus)

Every feature must clearly demonstrate user value and business justification. Product Manager must validate that
features align with user needs and business goals.

### VI. Technical Feasibility (Technical Architect Focus)

All features must be technically viable within constraints. Technical Architect must assess and approve all technical
approaches before implementation.

### VII. Simplicity (Architect Focus)

Start simple, YAGNI principles. Maximum 3 projects for initial implementation. Additional projects require documented
justification by Technical Architect.

### VIII. Anti-Abstraction (Architect Focus)

Use framework features directly rather than wrapping them. Technical Architect must validate each abstraction decision.

### IX. Operational Excellence (DevOps Focus)

All features must be deployable, monitorable, and maintainable. DevOps Engineer must approve all operational
requirements.

## Additional Constraints

### User Experience Requirements (UX Designer Focus)

All features must meet accessibility standards and provide good user experience. UX Designer must validate all
user-facing elements.

### Quality Standards (QA Focus)

All features must meet defined quality metrics and risk assessments. QA must approve test strategies and quality gates.

## Development Workflow

### Team Review Process

All specifications and plans must be reviewed by relevant team personas:

- Product Manager checks user value
- Technical Architect assesses feasibility
- UX Designer evaluates experience
- QA considers testability
- Developer reviews implementation
- DevOps Engineer validates operations

### Quality Gates

- Product Manager approval required for user value
- Technical Architect approval for architecture
- QA approval for testability
- DevOps approval for operational requirements

## Governance

All PRs/reviews must verify constitutional compliance from all relevant team personas. Complexity must be justified by
multiple personas. Use [TEAM_GUIDANCE_FILE] for runtime development guidance from all team perspectives.

**Version**: [CONSTITUTION_VERSION] | **Ratified**: [RATIFICATION_DATE] | **Last Amended**: [LAST_AMENDED_DATE]

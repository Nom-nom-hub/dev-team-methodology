<!--
TEMPLATE METADATA
  Name: Team Implementation Plan Template
  Version: 1.0
  Purpose: Create technical implementation plans considering team perspectives
  Last Updated: 2025-12-15
  Compatibility: Team Methodology v1.0+
  Usage: Used by /team.plan command; requires completed specification
  See Also: spec-template.md, tasks-template.md
-->

# Team Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link] **Input**: Feature specification from
`/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/team.plan` command. See `.team/templates/commands/plan.md` for the
execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Team Technical Context

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION] **Primary Dependencies**: \[e.g.,
FastAPI, UIKit, LLVM or NEEDS CLARIFICATION\] **Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION] **Target Platform**: \[e.g., Linux server, iOS
15+, WASM or NEEDS CLARIFICATION\] **Project Type**: [single/web/mobile - determines source structure] **Performance
Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION] **Constraints**:
[domain-specific, e.g., \<200ms p95, \<100MB memory, offline-capable or NEEDS CLARIFICATION] **Scale/Scope**:
[domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Team Persona Input Summary

### Product Manager Input

- **Technical Decision Impact**: [How PM influences technical decisions]
- **Success Metrics Alignment**: [How technical approach aligns with PM's success metrics]
- **Risk Considerations**: [PM's perspective on technical risks]

### Technical Architect Input

- **Architecture Decisions**: [Technical architecture decisions made]
- **Feasibility Validation**: [How technical feasibility was validated]
- **Constraints Definition**: [Technical constraints defined]

### UX Designer Input

- **User Experience Implementation**: [How UX requirements are implemented]
- **Design System Integration**: [How design system is integrated]
- **Accessibility Implementation**: [How accessibility is ensured]

### Quality Assurance Input

- **Testing Strategy**: [Testing approach defined]
- **Quality Gates**: [Quality checkpoints defined]
- **Risk Assessment**: [Quality risks identified]

### Developer Input

- **Implementation Approach**: [Development approach defined]
- **Code Quality Standards**: [Code quality requirements defined]
- **Performance Considerations**: [Performance optimizations planned]

### DevOps Input

- **Deployment Strategy**: [Deployment approach defined]
- **Infrastructure Needs**: [Infrastructure requirements defined]
- **Operational Considerations**: [Operational requirements defined]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/team.plan command output)
├── research.md          # Phase 0 output (/team.plan command)
├── data-model.md        # Phase 1 output (/team.plan command)
├── quickstart.md        # Phase 1 output (/team.plan command)
├── contracts/           # Phase 1 output (/team.plan command)
├── personas/            # Team persona perspectives (/team.plan command)
├── checklists/          # Team validation checklists (/team.plan command)
└── tasks.md             # Phase 2 output (/team.tasks command - NOT created by /team.plan)
```

### Source Code (repository root)

```text
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]
```

**Structure Decision**: [Document the selected structure and reference the real directories captured above]

## Team Implementation Phases

### Phase 0: Research

- **Research Lead**: [Team member responsible]
- **Deliverables**: research.md
- **Team Involvement**: [Which team members contribute to research]

### Phase 1: Design

- **Design Lead**: [Team member responsible]
- **Deliverables**: data-model.md, quickstart.md, contracts/, personas/, checklists/
- **Team Involvement**: [Which team members contribute to design]

### Phase 2: Implementation Planning

- **Implementation Lead**: [Team member responsible]
- **Deliverables**: tasks.md
- **Team Involvement**: [Which team members contribute to task planning]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation                  | Why Needed         | Simpler Alternative Rejected Because | Team Validation                             |
| -------------------------- | ------------------ | ------------------------------------ | ------------------------------------------- |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        | [Team perspective on why this is justified] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  | [Team perspective on why this is justified] |

## Team Risk Assessment

### Product Manager Risks

- [Business risks identified by PM]

### Technical Architect Risks

- [Technical risks identified by Architect]

### UX Designer Risks

- [UX/UI risks identified by UX Designer]

### Quality Assurance Risks

- [Quality risks identified by QA]

### Developer Risks

- [Implementation risks identified by Developer]

### DevOps Risks

- [Operational risks identified by DevOps]

## Team Success Criteria

### Technical Success Metrics

- [Metrics for technical success]

### Team Collaboration Success Metrics

- [Metrics for team collaboration success]

### Delivery Success Metrics

- [Metrics for delivery success]

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

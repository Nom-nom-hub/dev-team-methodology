# Team Methodology Variables and Standardization

## Variable Naming Standard

All team methodology commands use a consistent variable naming pattern:

### Feature Identifier Pattern

```
[FEATURE-NUMBER]-[FEATURE-NAME]
```

- **FEATURE-NUMBER**: Sequential integer (001, 002, 003, etc.) - increments per feature name
- **FEATURE-NAME**: Kebab-case short name (2-4 words, action-noun format)

### Examples

- `001-user-auth` - First feature for "user authentication"
- `002-analytics-dashboard` - Second feature for "analytics dashboard"
- `001-fix-payment-timeout` - First bugfix for "payment timeout"
- `003-oauth2-api-integration` - Third feature for "OAuth2 API integration"

### Variable Mapping

In templates, use these standard variables:

| Variable | Meaning | Example |
|----------|---------|---------|
| `[FEATURE]` | Full feature identifier | `001-user-auth` |
| `[FEATURE-NUMBER]` | Numeric prefix only | `001` |
| `[FEATURE-NAME]` | Kebab-case name only | `user-auth` |
| `[SPEC_DIR]` | Directory path | `specs/001-user-auth` |
| `[BRANCH]` | Git branch name (same as feature) | `001-user-auth` |
| `[SPEC_FILE]` | Full path to specification | `specs/001-user-auth/spec.md` |
| `[PLAN_FILE]` | Full path to implementation plan | `specs/001-user-auth/plan.md` |
| `[TASKS_FILE]` | Full path to tasks | `specs/001-user-auth/tasks.md` |

### Directory Structure

```
specs/
├── 001-user-auth/
│   ├── spec.md
│   ├── plan.md
│   ├── tasks.md
│   ├── research.md
│   ├── implementation-log.md
│   ├── checklists/
│   │   ├── team-spec-checklist.md
│   │   └── team-validation-checklist.md
│   ├── personas/
│   │   ├── product-manager.md
│   │   ├── technical-architect.md
│   │   ├── ux-designer.md
│   │   ├── quality-assurance.md
│   │   ├── developer.md
│   │   └── devops.md
│   └── contracts/
│       ├── api-contracts.md
│       └── data-models.md
├── 002-analytics-dashboard/
│   └── ...
```

## Command Workflow Phases

### Phase 1: Specification (`/team.specify`)

**Inputs**: Feature description (natural language)

**Prerequisites**: None

**Outputs**:
- `specs/[FEATURE]/spec.md` - Feature specification
- `specs/[FEATURE]/checklists/team-spec-checklist.md` - Quality validation checklist
- Git branch `[FEATURE]` created and checked out

**Next Phase**: `/team.review` or `/team.plan`

---

### Phase 2: Specification Review (`/team.review`)

**Inputs**: Feature description (scope or focus for review)

**Prerequisites**:
- `specs/[FEATURE]/spec.md` must exist and be completed
- Feature branch must be checked out

**Outputs**:
- Updated `specs/[FEATURE]/spec.md` with team validations
- `specs/[FEATURE]/checklists/team-validation-checklist.md` - Team review results
- Validation summary with pass/fail status per persona

**Next Phase**: `/team.plan`

---

### Phase 3: Planning (`/team.plan`)

**Inputs**: Planning focus or additional requirements

**Prerequisites**:
- `specs/[FEATURE]/spec.md` must be complete
- `specs/[FEATURE]/checklists/team-validation-checklist.md` must show all passed
- Feature branch must be checked out

**Outputs**:
- `specs/[FEATURE]/plan.md` - Implementation plan
- `specs/[FEATURE]/research.md` - Research findings (if applicable)
- `specs/[FEATURE]/personas/` - Team persona perspectives
- `specs/[FEATURE]/contracts/` - Architecture contracts

**Next Phase**: `/team.tasks`

---

### Phase 4: Task Generation (`/team.tasks`)

**Inputs**: Task generation focus or additional requirements

**Prerequisites**:
- `specs/[FEATURE]/spec.md` must exist
- `specs/[FEATURE]/plan.md` must exist
- Feature branch must be checked out

**Outputs**:
- `specs/[FEATURE]/tasks.md` - Detailed task breakdown by phase

**Next Phase**: `/team.implement`

---

### Phase 5: Implementation (`/team.implement`)

**Inputs**: Implementation focus or current status

**Prerequisites**:
- `specs/[FEATURE]/spec.md` must exist
- `specs/[FEATURE]/plan.md` must exist
- `specs/[FEATURE]/tasks.md` must exist
- Feature branch must be checked out

**Outputs**:
- Code files implementing the feature
- Updated `specs/[FEATURE]/tasks.md` with task status changes
- `specs/[FEATURE]/implementation-log.md` - Implementation progress log

**Next Phase**: Merge to main

---

## Phase Transition Gates

Before proceeding to the next phase, verify:

### Specify → Review

- [ ] `spec.md` has all mandatory sections filled
- [ ] No critical [NEEDS CLARIFICATION] markers remain (max 3 allowed)
- [ ] All team perspectives are included
- [ ] Checklist at `specs/[FEATURE]/checklists/team-spec-checklist.md` is created

### Review → Plan

- [ ] All validation checklist items pass (or documented as N/A)
- [ ] All 6 team personas have validated their perspectives
- [ ] No unresolved conflicts between team perspectives
- [ ] Spec is in FINAL state (no pending clarifications)

### Plan → Tasks

- [ ] `plan.md` covers all phases (Research, Design, Implementation Planning)
- [ ] Technical Architect approves architecture
- [ ] All team personas have provided input
- [ ] Project structure is defined and approved
- [ ] Risk assessment is complete

### Tasks → Implement

- [ ] All tasks have clear ownership and priority
- [ ] Dependencies between tasks are identified
- [ ] Resource allocation is approved by all team leads
- [ ] Communication plan is defined
- [ ] First "To Do" task is ready to start

### Implement → Done

- [ ] All tasks marked "Done" with evidence (code, tests, docs)
- [ ] Success criteria from spec are achieved
- [ ] Quality standards from QA are met
- [ ] Operational requirements from DevOps are met
- [ ] User value is validated by Product Manager

---

## Critical Notes for AI Agents

1. **Always verify prerequisites** before starting a command. If required files don't exist, stop and report missing prerequisites.

2. **Variable substitution** in command templates:
   - Templates use `[FEATURE]`, `[FEATURE-NUMBER]`, `[FEATURE-NAME]`
   - Replace these with actual values extracted from current branch or user input
   - Example: If on branch `001-user-auth`, use `specs/001-user-auth/` as the directory

3. **File path consistency**:
   - Always use absolute paths in directory operations
   - Use forward slashes in examples, backslashes on Windows
   - Reference files relative to spec directory: `specs/[FEATURE]/`

4. **Task type distinctions**:
   - Research tasks: Document findings, not just "do research"
   - Implementation tasks: Create code files, not just "implement"
   - Testing tasks: Write test code, not just "create tests"
   - Deployment tasks: Create artifacts, not just "deploy"

---

**Version**: 1.0 | **Created**: 2025-12-14

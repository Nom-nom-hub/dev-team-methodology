# Agent Command Execution Checklist

Use this checklist before executing any team methodology command. This prevents workflow breakdowns by verifying prerequisites.

---

## /team.specify - Create Feature Specification

### Before Starting

- [ ] User has provided a feature description (natural language requirement)
- [ ] No existing `specs/[FEATURE-NAME]` directory for this feature

### Execution Checklist

- [ ] Extract feature name from description (2-4 words, kebab-case)
- [ ] Check git branches and specs directories for highest number with this name
- [ ] Calculate next feature number correctly
- [ ] Create branch: `git checkout -b [FEATURE-NUMBER]-[FEATURE-NAME]`
- [ ] Create spec file at: `specs/[FEATURE]/spec.md`
- [ ] Create checklist at: `specs/[FEATURE]/checklists/team-spec-checklist.md`
- [ ] Fill all mandatory spec sections with team persona input
- [ ] Limit [NEEDS CLARIFICATION] to maximum 3 markers
- [ ] Generate quality checklist file

### Success Criteria

- [ ] `specs/[FEATURE]/spec.md` exists and is filled out
- [ ] `specs/[FEATURE]/checklists/team-spec-checklist.md` exists
- [ ] Branch `[FEATURE]` is created and checked out
- [ ] Output shows team personas' input sections
- [ ] Report ready for `/team.review` or `/team.plan`

### Common Failures

❌ Missing: User never provided feature description → ERROR
❌ Missing: No checklist file created → Proceed but warn
❌ Failed: More than 3 [NEEDS CLARIFICATION] markers → Ask user to reduce to 3
❌ Failed: Feature already exists with same name → Check if user wants to update existing

---

## /team.review - Validate Specification from Team Perspectives

### Before Starting - REQUIRED

- [ ] File exists: `specs/[FEATURE]/spec.md`
- [ ] File is complete (no placeholder text)
- [ ] Feature branch is checked out: `git branch` shows `* [FEATURE]`
- [ ] Previous phase `/team.specify` completed successfully

### Execution Checklist

- [ ] Load spec.md completely
- [ ] Validate against each team persona checklist:
  - [ ] Product Manager: User value, success metrics, business case
  - [ ] Technical Architect: Feasibility, architecture, performance
  - [ ] UX Designer: User experience, accessibility, design constraints
  - [ ] Quality Assurance: Testability, quality metrics, risks
  - [ ] Developer: Implementation clarity, complexity, code quality
  - [ ] DevOps: Operations, deployment, monitoring
- [ ] Create/update validation checklist at: `specs/[FEATURE]/checklists/team-validation-checklist.md`
- [ ] Document validation results (pass/fail per persona)
- [ ] Identify failing sections and specific issues

### Success Criteria

- [ ] All 6 team personas have validation results (pass/fail/N/A)
- [ ] `team-validation-checklist.md` is updated with results
- [ ] No unresolved conflicts between personas
- [ ] All spec sections are validated
- [ ] Ready for `/team.plan`

### Common Failures

❌ Missing: spec.md doesn't exist → ERROR, can't proceed
❌ Missing: Validation checklist not created → Stop and create it
❌ Failed: Validation items are failing → List failing items, recommend spec updates
❌ Failed: Team personas conflict → Document conflicts and halt for team decision

---

## /team.plan - Create Implementation Plan

### Before Starting - REQUIRED

- [ ] File exists: `specs/[FEATURE]/spec.md` (fully completed)
- [ ] File exists: `specs/[FEATURE]/checklists/team-validation-checklist.md` (all items pass)
- [ ] Feature branch is checked out
- [ ] Previous phase `/team.review` completed successfully

### Execution Checklist

- [ ] Load spec.md and validation checklist
- [ ] Verify all validation items pass (or N/A)
- [ ] Run setup-plan script: `{SCRIPT}`
- [ ] Create plan.md at: `specs/[FEATURE]/plan.md`
- [ ] Fill plan with:
  - [ ] Product Manager input (success metrics, business alignment)
  - [ ] Technical Architect input (architecture, feasibility, constraints)
  - [ ] UX Designer input (design system, UX approach)
  - [ ] Quality Assurance input (testing strategy, quality gates)
  - [ ] Developer input (implementation approach, patterns)
  - [ ] DevOps input (deployment strategy, operations)
- [ ] Define implementation phases (Research, Design, Implementation Planning)
- [ ] Create persona input files at: `specs/[FEATURE]/personas/`
- [ ] Document project structure decision
- [ ] Create risk assessment
- [ ] Define success criteria

### Success Criteria

- [ ] `specs/[FEATURE]/plan.md` exists and is complete
- [ ] All 6 team personas have input sections
- [ ] All phases are defined with deliverables
- [ ] Risk assessment is documented
- [ ] Project structure is approved
- [ ] Ready for `/team.tasks`

### Common Failures

❌ Missing: spec.md incomplete → ERROR, request spec updates
❌ Missing: Validation checklist missing or failing items → ERROR, run `/team.review` first
❌ Missing: plan.md not created → Stop and create from template
❌ Failed: Team persona inputs missing → Identify missing personas and request input

---

## /team.tasks - Generate Implementation Tasks

### Before Starting - REQUIRED

- [ ] File exists: `specs/[FEATURE]/spec.md`
- [ ] File exists: `specs/[FEATURE]/plan.md` (fully completed)
- [ ] Feature branch is checked out
- [ ] Previous phase `/team.plan` completed successfully

### Execution Checklist

- [ ] Load spec.md and plan.md
- [ ] Extract phases from plan (Research, Design, Implementation, Testing, Deployment)
- [ ] For each phase, create tasks:
  - [ ] Research & Design tasks (RD-xxx): Reference TASK-TYPES.md structure
  - [ ] Implementation tasks (IMPL-xxx): Reference TASK-TYPES.md structure
  - [ ] Testing tasks (TEST-xxx): Reference TASK-TYPES.md structure
  - [ ] Deployment tasks (DEPLOY-xxx): Reference TASK-TYPES.md structure
- [ ] Assign specific owners (not "Developer" but name/role)
- [ ] Set priority (P1/P2/P3) based on user story importance
- [ ] Estimate duration (in days)
- [ ] Identify dependencies between tasks
- [ ] Create tasks.md at: `specs/[FEATURE]/tasks.md`
- [ ] Define resource allocation per team member
- [ ] Create milestones
- [ ] Define communication plan
- [ ] Create risk mitigation plan

### Task Quality Validation

Before marking tasks complete, verify each task against TASK-TYPES.md:

- [ ] **Research tasks**: Specify WHAT research, evaluation criteria, document location
- [ ] **Implementation tasks**: Specify FILE PATH, COMPONENT, METHODS, BEHAVIOR, ACCEPTANCE CRITERIA
- [ ] **Testing tasks**: Specify TEST FILE PATH, NUMBER of tests, TYPE, SCENARIOS, COVERAGE
- [ ] **Deployment tasks**: Specify ARTIFACT FILES, COMPONENT, TARGET, VALIDATION

### Success Criteria

- [ ] `specs/[FEATURE]/tasks.md` exists with all phases
- [ ] Each task has clear ownership and priority
- [ ] All tasks follow TASK-TYPES.md structure
- [ ] Dependencies are identified
- [ ] Resource allocation is realistic
- [ ] Communication and risk mitigation plans are defined
- [ ] Ready for `/team.implement`

### Common Failures

❌ Missing: plan.md doesn't exist or is incomplete → ERROR, request plan first
❌ Failed: Tasks are vague (e.g., "Implement feature") → Reference TASK-TYPES.md and rewrite
❌ Failed: Tasks missing file paths or specific details → Rewrite per TASK-TYPES.md
❌ Failed: Ownership not assigned → Assign specific team roles
❌ Failed: No dependencies identified → Review tasks and link related ones

---

## /team.implement - Execute Implementation

### Before Starting - REQUIRED

- [ ] File exists: `specs/[FEATURE]/spec.md`
- [ ] File exists: `specs/[FEATURE]/plan.md`
- [ ] File exists: `specs/[FEATURE]/tasks.md` (complete with all phases)
- [ ] Feature branch is checked out
- [ ] Previous phase `/team.tasks` completed successfully

### Execution Checklist

- [ ] Load spec.md, plan.md, tasks.md
- [ ] Identify current phase and first uncompleted task
- [ ] Execute tasks in order:
  - [ ] For Research tasks: Conduct research and document findings in research.md
  - [ ] For Implementation tasks: Create actual code files and implement features
  - [ ] For Testing tasks: Write actual test code and run tests
  - [ ] For Deployment tasks: Create artifacts and validate deployment
- [ ] For each completed task:
  - [ ] Create actual deliverable (code file, test file, research document, etc.)
  - [ ] Update task status to "In Progress" when starting
  - [ ] Update task status to "Done" only with evidence
  - [ ] Document completion in implementation-log.md
- [ ] Track progress against milestones
- [ ] Report daily progress and blockers

### Task Completion Validation

A task is "Done" ONLY when:

- [ ] **Research task**: Findings documented in research.md with specific results (not just "planning to research")
- [ ] **Implementation task**: Code file created with working implementation (not just outline)
- [ ] **Testing task**: Test file created with passing tests (not just "will test")
- [ ] **Deployment task**: Artifact created and tested (not just "configured")

### Success Criteria

- [ ] All tasks in tasks.md are marked "Done" with evidence
- [ ] All success criteria from spec.md are achieved
- [ ] Quality standards from plan.md are met
- [ ] implementation-log.md is updated
- [ ] Code is committed to feature branch
- [ ] Ready for merge to main

### Common Failures

❌ Missing: spec.md, plan.md, or tasks.md → ERROR, request these files first
❌ Failed: Task marked "Done" without deliverable → Require evidence (code, test, document)
❌ Failed: Implementation doesn't match spec → Review spec and adjust
❌ Failed: Quality standards not met → Request fixes before marking done

---

## Workflow Validation Map

```
START
  ↓
/team.specify ← Prerequisites: None
  ✓ spec.md created, checklist created
  ✓ Feature branch created
  ✓ Max 3 [NEEDS CLARIFICATION] markers
  ↓
/team.review ← Prerequisites: spec.md exists
  ✓ All 6 personas validated
  ✓ Validation checklist created
  ✓ No unresolved conflicts
  ↓
/team.plan ← Prerequisites: spec.md + validation checklist
  ✓ plan.md created with all phases
  ✓ All team personas provided input
  ✓ Risk assessment complete
  ↓
/team.tasks ← Prerequisites: spec.md + plan.md
  ✓ tasks.md created with all phases
  ✓ All tasks follow TASK-TYPES.md
  ✓ All tasks have clear ownership
  ✓ Dependencies identified
  ↓
/team.implement ← Prerequisites: spec.md + plan.md + tasks.md
  ✓ Tasks executed in order
  ✓ Deliverables created for each task
  ✓ All success criteria achieved
  ↓
MERGE TO MAIN
```

---

## Quick Reference: File Locations

```
specs/
├── [FEATURE]/                          ← Feature directory
│   ├── spec.md                        ← Specification (required for all phases)
│   ├── plan.md                        ← Implementation plan (required after plan phase)
│   ├── tasks.md                       ← Task breakdown (required after tasks phase)
│   ├── research.md                    ← Research findings (created during implement)
│   ├── implementation-log.md          ← Implementation progress (created during implement)
│   ├── checklists/
│   │   ├── team-spec-checklist.md     ← Spec quality (created in specify)
│   │   └── team-validation-checklist.md ← Review results (created in review)
│   ├── personas/
│   │   ├── product-manager.md         ← PM perspective
│   │   ├── technical-architect.md     ← TA perspective
│   │   ├── ux-designer.md             ← UX perspective
│   │   ├── quality-assurance.md       ← QA perspective
│   │   ├── developer.md               ← Dev perspective
│   │   └── devops.md                  ← DevOps perspective
│   └── contracts/
│       ├── api-contracts.md           ← API definitions
│       └── data-models.md             ← Data structure definitions
```

---

## Error Codes and Recovery

| Code | Error | Recovery |
|------|-------|----------|
| **SPEC_MISSING** | spec.md doesn't exist | Run `/team.specify` |
| **PLAN_MISSING** | plan.md doesn't exist | Run `/team.plan` |
| **TASKS_MISSING** | tasks.md doesn't exist | Run `/team.tasks` |
| **VALIDATION_FAIL** | Validation items failing | Update spec and re-validate |
| **TASK_VAGUE** | Task is not specific enough | Rewrite per TASK-TYPES.md |
| **NO_EVIDENCE** | Task marked Done without deliverable | Create deliverable and update |
| **BRANCH_WRONG** | Not on feature branch | `git checkout [FEATURE]` |
| **TEAM_CONFLICT** | Team personas conflict on decision | Document and halt for team discussion |

---

**Version**: 1.0 | **Created**: 2025-12-14 | **Last Updated**: 2025-12-14

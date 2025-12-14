# Template Improvements Summary

This document summarizes the three major improvements made to the team methodology templates to improve agent workflow quality.

---

## 1. Input/Output Contracts (PREREQUISITE GATES)

### What Was Wrong

Previously, command templates didn't explicitly state what files must exist before running. An agent could run `/team.tasks` without `plan.md` existing, leading to workflow failures.

### Solution Implemented

Added **Prerequisites** section to each command template specifying:
- Files that must exist
- Branch requirements
- Team roles needed
- Previous phase requirements

### Updated Files

- `templates/commands/specify.md` - Starting phase (no prerequisites)
- `templates/commands/review.md` - Requires spec.md
- `templates/commands/plan.md` - Requires spec.md + validation checklist
- `templates/commands/tasks.md` - Requires spec.md + plan.md
- `templates/commands/implement.md` - Requires spec.md + plan.md + tasks.md

### Example

```markdown
## Prerequisites

- **Files Required**: 
  - `specs/[FEATURE]/spec.md` (completed specification)
  - `specs/[FEATURE]/plan.md` (completed implementation plan)
- **Branch Required**: Feature branch checked out
- **Team Roles Required**: All team personas for task planning
- **Previous Phase**: `/team.plan` must be complete
- **Important**: Use TASK-TYPES.md for task structure and examples
```

### Impact

- **Before**: Agent could attempt impossible operations (file not found errors)
- **After**: Agent validates prerequisites before starting, provides clear error messages with recovery steps

---

## 2. Task Type Variations (TASK-TYPES.md)

### What Was Wrong

The implement.md template complained that tasks were vague ("Implement parser functionality") but the tasks template didn't distinguish between different task types. All tasks used the same structure, which doesn't match how research vs implementation vs testing vs deployment actually work.

### Solution Implemented

Created **TASK-TYPES.md** with specific templates for each task type:

#### Research & Design Tasks (RD-xxx)
```
Must specify: WHAT to research, EVALUATION CRITERIA, SPECIFIC FINDINGS expected, document location
Example: "Research tree-sitter parsing library: evaluate parsing speed, language coverage, memory usage. 
Document in research.md with comparison table, benchmarks, and recommendation."
```

#### Implementation Tasks (IMPL-xxx)
```
Must specify: FILE PATH, COMPONENT name, METHODS/PROPERTIES, BEHAVIOR, ACCEPTANCE CRITERIA
Example: "Create src/parsers/javascript_parser.py: Implement JSParser class with parse() method 
that returns AST structure. Acceptance: Parser successfully parses 100+ real JavaScript files."
```

#### Testing Tasks (TEST-xxx)
```
Must specify: TEST FILE PATH, NUMBER of tests, TYPE (unit/integration/e2e), SCENARIOS, COVERAGE METRIC
Example: "Create tests/test_parser.py: Write 12 unit tests for JSParser.parse() covering valid JS, 
syntax errors, empty files, ES6 features. Acceptance: 100% code coverage, all tests pass."
```

#### Deployment Tasks (DEPLOY-xxx)
```
Must specify: ARTIFACT FILES, COMPONENT, DEPLOYMENT TARGET, CONFIGURATION, VALIDATION CRITERIA
Example: "Create setup.py and pyproject.toml: Package tool for pip distribution with entry points. 
Acceptance: Tool installs cleanly in fresh venv, CLI commands run without errors."
```

### Included Resources

- **Task Structure Template** - Template for each task type
- **Examples** - Good vs bad examples for each type
- **Task Distinction Matrix** - When to use each type
- **Common Mistakes** - What NOT to do
- **Task Quality Checklist** - Validation criteria

### Impact

- **Before**: Agents could generate vague tasks that didn't guide implementation
- **After**: Agents generate specific, actionable tasks with clear acceptance criteria for each phase

---

## 3. Variable Standardization (WORKFLOW-VARIABLES.md)

### What Was Wrong

Templates mixed `[FEATURE_NAME]`, `[BRANCH]`, `[FEATURE-NUMBER]-[FEATURE-NAME]`, and `[BRANCH]` inconsistently. Agents and humans couldn't tell what each meant or which to use when.

### Solution Implemented

Created **WORKFLOW-VARIABLES.md** with:

#### Unified Naming Pattern
```
[FEATURE-NUMBER]-[FEATURE-NAME]
  ↓              ↓
  001            user-auth
  Sequential     Kebab-case
  integer        short name
```

#### Standard Variable Map
```
[FEATURE]           = 001-user-auth (complete identifier)
[FEATURE-NUMBER]    = 001 (just the number)
[FEATURE-NAME]      = user-auth (just the name)
[SPEC_DIR]          = specs/001-user-auth
[BRANCH]            = 001-user-auth (git branch name)
[SPEC_FILE]         = specs/001-user-auth/spec.md
[PLAN_FILE]         = specs/001-user-auth/plan.md
[TASKS_FILE]        = specs/001-user-auth/tasks.md
```

#### Directory Structure Diagram
```
specs/
├── 001-user-auth/
│   ├── spec.md
│   ├── plan.md
│   ├── tasks.md
│   ├── checklists/
│   ├── personas/
│   └── contracts/
├── 002-analytics-dashboard/
│   └── ...
```

#### Phase Transition Gates
Explicit checkpoints between phases with validation items:
- Specify → Review: Spec complete, checklist created
- Review → Plan: All validation items pass
- Plan → Tasks: All phases defined, team input complete
- Tasks → Implement: All tasks have ownership
- Implement → Done: All deliverables created, success criteria met

### Impact

- **Before**: Agents could use inconsistent variable names, confused about directory structure
- **After**: Single standard naming convention, clear directory structure, explicit phase transitions

---

## New Reference Documents Created

### 1. WORKFLOW-VARIABLES.md (150 lines)
- Unified variable naming standard
- Variable mapping table
- Directory structure diagram
- Phase transition gates
- Critical notes for AI agents

### 2. TASK-TYPES.md (300 lines)
- Research & Design task structure and examples
- Implementation task structure and examples
- Testing task structure and examples
- Deployment task structure and examples
- Task distinction matrix
- Common mistakes to avoid
- Task quality checklist

### 3. AGENT-CHECKLIST.md (350 lines)
- Pre-execution checklist for each command
- Step-by-step execution guidance
- Success criteria for each phase
- Common failure modes
- Workflow validation map (with ASCII diagram)
- Quick file location reference
- Error codes and recovery procedures

### 4. IMPROVEMENTS-SUMMARY.md (this file)
- Explains what was wrong
- Describes solutions
- Shows impact before/after

---

## How to Use These Improvements

### For AI Agents

1. **Before running any command**, check AGENT-CHECKLIST.md for prerequisites
2. **When generating tasks**, use TASK-TYPES.md for structure and examples
3. **When referencing files**, use WORKFLOW-VARIABLES.md for standard names
4. **When validating quality**, use TASK-TYPES.md checklist

### For Humans

1. **Creating a feature**: Follow workflow: specify → review → plan → tasks → implement
2. **Understanding prerequisites**: Check WORKFLOW-VARIABLES.md phase transition gates
3. **Evaluating task quality**: Use TASK-TYPES.md good vs bad examples
4. **Debugging failures**: Check AGENT-CHECKLIST.md error codes

### For Team Leads

1. **Onboarding agents**: Point them to AGENT-CHECKLIST.md
2. **Reviewing tasks**: Use TASK-TYPES.md task quality checklist
3. **Troubleshooting**: Use AGENT-CHECKLIST.md error recovery procedures

---

## Integration Points

These improvements integrate with existing templates:

| Improvement | Applies To | Section |
|------------|-----------|---------|
| Prerequisites | specify.md, review.md, plan.md, tasks.md, implement.md | New section |
| TASK-TYPES.md | tasks.md | Referenced in Prerequisites |
| WORKFLOW-VARIABLES.md | All command templates | Used for file path examples |
| AGENT-CHECKLIST.md | All phases | Complete workflow reference |

---

## Before and After Comparison

### Before

```
Agent runs /team.tasks
  ↓
No error if plan.md is missing → Fails at runtime
  ↓
Task generation is vague ("Implement parser")
  ↓
No clear file naming (spec.md? [SPEC_FILE]? [FEATURE]/spec.md?)
  ↓
Agent produces unusable output
```

### After

```
Agent checks AGENT-CHECKLIST.md for /team.tasks
  ↓
Validates: plan.md exists ✓
  ↓
Reads TASK-TYPES.md for implementation task structure
  ↓
Uses WORKFLOW-VARIABLES.md for correct file paths
  ↓
Generates: "Create src/parsers/parser.py: Implement Parser class with parse() 
method that returns AST structure. Acceptance: Successfully parses 100+ real files."
  ↓
Clear, actionable output that guides implementation
```

---

## Backward Compatibility

These improvements are **purely additive**:
- Existing command templates still work
- New Prerequisites sections clarify requirements but don't change behavior
- TASK-TYPES.md, WORKFLOW-VARIABLES.md, and AGENT-CHECKLIST.md are reference documents
- No breaking changes to existing specs, plans, or tasks

---

## Next Steps (Optional Future Improvements)

These improvements could be added later without affecting current workflow:

1. **Decision Log Template** - Track architectural decisions and their rationale
2. **Progress Tracking Template** - Structured implementation-log.md with metrics
3. **Cross-File Navigation** - Add "See Also" sections linking related sections
4. **Validation Checklists** - Automated checking of phase gates
5. **Metrics Dashboard** - Track team performance across features

---

## Files Modified

- `templates/commands/specify.md` - Added Prerequisites section
- `templates/commands/review.md` - Added Prerequisites section
- `templates/commands/plan.md` - Added Prerequisites section
- `templates/commands/tasks.md` - Added Prerequisites section
- `templates/commands/implement.md` - Added Prerequisites section

## Files Created

- `WORKFLOW-VARIABLES.md` - Variable naming and standardization
- `TASK-TYPES.md` - Task type structures and examples
- `AGENT-CHECKLIST.md` - Phase-by-phase execution guide
- `IMPROVEMENTS-SUMMARY.md` - This document

---

**Version**: 1.0 | **Created**: 2025-12-14 | **Impact**: High (Prevents workflow failures, improves task quality, clarifies agent requirements)

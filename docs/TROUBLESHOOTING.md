# Troubleshooting Guide

Solutions for common issues when using Team-Driven Development.

## Installation & Setup

### Issue: `team` command not found after installation

**Symptoms:**
```
$ team init my-project
command not found: team
```

**Causes & Solutions:**

1. **Installation didn't complete**
   ```bash
   uv tool install team-cli --from git+https://github.com/Nom-nom-hub/dev-team-methodology.git
   ```

2. **uv not installed**
   ```bash
   # Install uv first
   curl -LsSf https://astral.sh/uv/install.sh | sh
   # Then install team-cli
   uv tool install team-cli --from git+https://github.com/Nom-nom-hub/dev-team-methodology.git
   ```

3. **PATH not updated** (Linux/Mac)
   ```bash
   # Add to ~/.zshrc or ~/.bashrc
   export PATH="$HOME/.local/bin:$PATH"
   # Then reload
   source ~/.zshrc
   ```

4. **PowerShell execution policy** (Windows)
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

---

### Issue: Agent commands not available after `team init`

**Symptoms:**
```
$ /team.specify
Command not found
```

**Causes & Solutions:**

1. **Not in project directory**
   ```bash
   cd my-project
   # Then open your agent
   ```

2. **Agent not recognized**
   ```bash
   team init . --ai amp  # Specify your agent explicitly
   ```

3. **Templates didn't copy**
   - Check if `.team/` directory exists: `ls -la .team/`
   - If not: `team init . --force --ai amp`

4. **Agent needs restart**
   - Close and reopen your agent
   - Some agents cache command definitions

---

### Issue: Git initialization failed

**Symptoms:**
```
Error: Failed to initialize git repository
```

**Solution:**
```bash
# Initialize git manually first
git init
git config user.name "Your Name"
git config user.email "your.email@example.com"

# Then run team init
team init . --ai amp
```

---

## Workflow Phases

### `/team.specify` Issues

#### Issue: Spec file not created

**Symptoms:**
```
/team.specify Created branch but no spec.md file
```

**Check:**
1. Did it create a branch? `git branch -a`
2. Is `.team/specs/` directory missing?

**Solution:**
```bash
# Create structure manually if needed
mkdir -p .team/specs/001-feature-name
# Copy template
cp templates/spec-template.md .team/specs/001-feature-name/spec.md
```

---

#### Issue: Branch created but wrong name

**Symptoms:**
```
Branch name is "feature" instead of "001-feature-name"
```

**Cause:** Feature numbering failed

**Solution:**
```bash
# Rename branch manually
git branch -m 001-feature-name

# Or redo specification
/team.specify Your clear feature description here
```

---

### `/team.review` Issues

#### Issue: Review didn't include all personas

**Symptoms:**
```
Review only has Product Manager and Developer perspectives
```

**Cause:** Specification was incomplete

**Solution:**
```bash
# Run clarify first
/team.clarify

# Then re-run review
/team.review Have all 6 personas review the spec
```

---

### `/team.plan` Issues

#### Issue: Plan file created but very short

**Symptoms:**
```
plan.md is only 500 words when it should be 2000+
```

**Cause:** Specification was vague

**Solution:**
```bash
# Make spec more detailed
/team.clarify

# Then regenerate plan
/team.plan [Your detailed tech stack description]
```

---

#### Issue: Agent suggests technology you don't want

**Symptoms:**
```
Plan recommends PostgreSQL but you want MongoDB
```

**Solution:**
```bash
# Regenerate with explicit constraint
/team.plan Use MongoDB instead of PostgreSQL for data storage. [Other tech stack details]
```

---

### `/team.tasks` Issues

#### Issue: Tasks are too vague (e.g., "Implement parser")

**Symptoms:**
```
Task: "Implement parser functionality"
Missing: File path, methods, acceptance criteria
```

**Check:** TASK-TYPES.md section on implementation tasks

**Solution:**
```bash
# Provide more detail to /team.plan
/team.plan [More detailed implementation approach]

# Regenerate tasks
/team.tasks
```

---

#### Issue: Too many tasks (100+) for a small feature

**Symptoms:**
```
Feature has 150 tasks but should have 20-30
```

**Cause:** Over-scoped feature or over-granular tasks

**Solution:**
1. Split into multiple features
2. Combine related tasks
3. Apply constitution simplicity principle

---

#### Issue: Task dependencies unclear

**Symptoms:**
```
Tasks don't indicate which must run first
Can't tell if tasks are parallel [P] or sequential
```

**Solution:**
- Check WORKFLOW-VARIABLES.md for task ordering rules
- Regenerate with: `/team.tasks`
- Or manually add markers: `[P]` for parallel, `[AFTER X]` for dependencies

---

### `/team.implement` Issues

#### Issue: Code generation stops or freezes

**Symptoms:**
```
Agent starts implementing then stalls
Nothing happens for 5+ minutes
```

**Cause:** Complex task or agent context limit

**Solution:**
1. Check task complexity - split into smaller tasks
2. Reduce context by breaking feature into smaller specs
3. Try with different agent (Amp for speed, Claude for quality)

---

#### Issue: Generated code doesn't compile/run

**Symptoms:**
```
TypeError: Cannot find module
SyntaxError: Unexpected token
```

**Diagnosis:**
```bash
# Run the code locally
npm run test  # or python -m pytest, etc.
# Copy error to agent
```

**Solution:**
```
/team.implement 
Here's the error from running task X:
[paste full error message]
Please fix this and regenerate.
```

---

#### Issue: Code doesn't match specification

**Symptoms:**
```
Spec says "store in SQLite" but code uses MongoDB
Feature says "dark mode toggle" but code has no UI
```

**Solution:**
1. Note the specific discrepancy
2. Point agent to the specification section
3. Ask agent to regenerate with specification reference:
   ```
   /team.implement
   Review the spec section on [X]. The implementation doesn't match. 
   Please regenerate [component] to align with the spec.
   ```

---

## Common Errors

### Error: `[NEEDS XXX CLARIFICATION]` markers remain in spec

**Meaning:** Ambiguous requirements for that persona

**Solution:**
```bash
/team.clarify

# Then manually answer the clarification markers
# Example: Replace [NEEDS ARCHITECT CLARIFICATION: Database choice]
# With: Database will be PostgreSQL for ACID compliance
```

---

### Error: Prerequisites not met for `/team.plan`

**Meaning:** Missing spec.md or validation checklist

**Diagnostic:**
```bash
# Check what files exist
ls specs/001-*/

# Must have:
# - spec.md ✓
# - checklists/ directory ✓
```

**Solution:**
```bash
# If spec.md missing
/team.specify [Describe feature]

# If checklists missing
# Run /team.review to generate them
/team.review [Review from all perspectives]
```

---

### Error: File paths conflict

**Meaning:** Multiple tasks write to same file

**Example:**
```
Task 1: Create src/models/user.py
Task 2: Create src/models/user.py
```

**Solution:**
```bash
# Regenerate tasks with more granular separation
/team.tasks

# Or manually edit tasks.md to assign to sequential tasks
```

---

## Performance Issues

### Issue: Agent responds very slowly

**Symptoms:**
```
Takes 2-3 minutes to respond to `/team.plan`
```

**Cause:** Large specification or context limit

**Solutions:**

1. **Break feature into smaller specs**
   ```bash
   # Instead of one 5000-word spec
   # Create: 001-auth-login (spec), 002-auth-logout (spec), etc.
   ```

2. **Reduce context**
   - Remove examples that aren't necessary
   - Don't paste the entire README into spec

3. **Use faster agent**
   - Amp is generally faster than Claude for implementation
   - Qoder for quality-focused work

---

### Issue: Agent reaches context limit (red error)

**Symptoms:**
```
Error: Context limit exceeded
```

**Solution:**
1. **Simplify current task**
   - Focus on one user story at a time
   - Split large features into smaller specs

2. **Use larger-context agent**
   - Gemini (2M tokens)
   - Or Claude (200k tokens)

3. **Use state management**
   ```bash
   # Save progress, then continue in new session
   # Keep spec.md, plan.md in repository
   # Start fresh `/team.implement` for next batch of tasks
   ```

---

## Team Collaboration Issues

### Issue: Two agents generated conflicting code

**Symptoms:**
```
Claude's implementation uses one pattern
Amp's refactoring uses another pattern
Code quality inconsistent
```

**Solution:**
```bash
/team.analyze

# This checks consistency from all perspectives
# Then regenerate with winner's approach:
/team.implement [Specify preferred pattern from constitution]
```

---

### Issue: Team disagrees on approach

**Symptoms:**
```
Product Manager wants Feature X
Architect says "too complex"
QA says "untestable"
```

**Solution:**
```bash
# This is what /team.review is for!
/team.review [Specific question about the disagreement]

# Disagreement should be documented
# Create decision-log.md with:
- Options considered
- Each persona's perspective
- Final decision and rationale
```

---

## Git & Version Control

### Issue: Feature branch conflicts with main

**Symptoms:**
```
Merge conflict when trying to pull to main
```

**Solution:**
```bash
# Resolve conflicts
git status  # See conflicts
# Edit files to resolve
git add .
git commit -m "Resolve merge conflicts"

# Update spec/plan documentation
/team.plan [Describe resolved changes]
```

---

### Issue: Lost track of which branch has which feature

**Cause:** Poor branch naming

**Solution:**
```bash
# Use consistent naming
001-feature-name
002-another-feature

# Document in PROJECT.md
| Branch | Feature | Status | Owner |
|--------|---------|--------|-------|
| 001-user-auth | User authentication | In Review | Alice |
| 002-todo-crud | Todo CRUD operations | Implementing | Bob |
```

---

## Documentation Issues

### Issue: Specification is too long to read

**Symptoms:**
```
spec.md is 10,000 words
No one wants to read it
```

**Solution:**
```bash
# Split into multiple features
# Instead of one massive "Build everything" spec
# Break into:
# - 001-core-api
# - 002-auth
# - 003-notifications
# - etc.

# Each spec should be 2,000-4,000 words
```

---

### Issue: Decision log entries are vague

**Example - Bad:**
```
Decision: Architecture
We picked microservices.
```

**Example - Good:**
```
## Decision: Monolith vs Microservices

**Question:** Should application be monolith or microservices?

**Options:**
1. Monolith (Node.js + SQLite)
2. Microservices (Node.js + PostgreSQL + messaging)

**Decision:** Monolith (initial version)

**Rationale:**
- Simpler deployment (constitution simplicity principle)
- Sufficient for MVP (PM user needs)
- Easier testing (QA perspective)

**Trade-offs:**
- Harder to scale later (accepted technical debt)
- Single point of failure (monitoring mitigates)

**Reviewed By:** Architect, DevOps, QA
**Revisit Date:** 2026-03-15
```

---

## File Organization Issues

### Issue: Can't find specification for a feature

**Solution:** Use standard directory structure

```
.team/
├── specs/
│   ├── 001-user-auth/
│   │   ├── spec.md (What to build)
│   │   ├── plan.md (How to build it)
│   │   ├── tasks.md (Specific tasks)
│   │   ├── decision-log.md (Decisions made)
│   │   ├── checklists/ (Validation checklists)
│   │   ├── personas/ (Team perspective files)
│   │   └── contracts/ (API/data contracts)
│   └── 002-todo-crud/
│       └── (same structure)
```

See WORKFLOW-VARIABLES.md for complete structure.

---

## Success: Common "Errors" That Aren't

### "My specification changed during implementation"
✅ **This is normal!** The spec is the source of truth; update it:
```bash
/team.plan [With updated requirements]
/team.tasks [Regenerate]
Continue implementation
```

---

### "My agent suggested something better than I thought"
✅ **This is valuable!** Evaluate the suggestion:
```bash
/team.review [The suggestion from agent perspective]
Update spec if it's truly better
Regenerate plan/tasks
```

---

### "We're iterating more than we expected"
✅ **This is TDD working!** Multiple iterations prevent costly rework:
- Better spec → Better code
- Better plan → Fewer surprises
- Better tasks → Cleaner implementation

---

## Getting Help

1. **Check relevant doc first:**
   - [FAQ.md](./FAQ.md) - General questions
   - [QUICK-START.md](./QUICK-START.md) - Getting started
   - [AGENT-CAPABILITIES.md](./AGENT-CAPABILITIES.md) - Agent selection

2. **Check AGENT-CHECKLIST.md:**
   - Phase-by-phase validation
   - Success criteria for each phase

3. **Open a GitHub issue:**
   - https://github.com/Nom-nom-hub/dev-team-methodology/issues
   - Include: Error message, steps to reproduce, your setup

4. **Relevant files to read:**
   - team-driven.md - Full methodology explanation
   - TASK-TYPES.md - Task structure reference
   - WORKFLOW-VARIABLES.md - Naming conventions

---

## Tips for Prevention

1. **Run `/team.review` before `/team.plan`** - Catches issues early
2. **Run `/team.clarify` before `/team.plan`** - Removes ambiguity
3. **Run `/team.analyze` after `/team.tasks`** - Validates completeness
4. **Keep specifications focused** - One feature per spec
5. **Document decisions** - Why did you choose X over Y?
6. **Use consistent naming** - Follow WORKFLOW-VARIABLES.md
7. **Iterate frequently** - Small changes are easier to fix than large ones

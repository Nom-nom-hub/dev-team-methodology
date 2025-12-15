# Amp Integration Guide: Team-Driven Development

This guide optimizes the Team-Driven Development methodology for use with [Amp](https://ampcode.com/), a fast, context-aware AI coding agent.

## Overview

Amp excels at:
- Fast code generation from specifications
- Multi-file awareness and cross-module changes
- Reading existing code and generating compatible implementations
- Rapid iteration and refinement cycles
- Fresh perspective code reviews

This guide shows how to leverage Amp's strengths within the Team Methodology workflow.

---

## Quick Start with Amp

### 1. Project Initialization

Initialize your project with Amp support:

```bash
uv tool install team-cli --from git+https://github.com/Nom-nom-hub/dev-team-methodology.git
team init my-project --ai amp
```

Or in an existing project:

```bash
team init . --ai amp
```

### 2. Establish Team Foundations

In your Amp chat:

```
/team.constitution Create principles focused on code quality, testing standards, user experience consistency, and performance requirements.
```

```
/team.personas Define the team personas: Product Manager, Technical Architect, UX Designer, Quality Assurance, Developer, DevOps.
```

### 3. Create Specification (Can use Claude for this)

If you have Claude available, use it for the initial specification:

```
/team.specify [Your feature description]
```

Or paste the specification directly into Amp:

> "Here's my feature specification: [paste spec content]"

### 4. Execute with Amp

Amp is optimized for **tasks generation** and **implementation**:

```
/team.tasks
```

```
/team.implement
```

---

## How Amp Fits in the Workflow

### Recommended Agent Pairing

| Phase | Primary | Secondary | Why |
|-------|---------|-----------|-----|
| **Specify** | Claude | Gemini | Need reasoning about user value |
| **Review** | Amp | Claude | Fresh perspective validation |
| **Plan** | Claude | Gemini | Architecture decisions |
| **Tasks** | **Amp** ⭐ | Claude | Amp excels at breaking down work |
| **Implement** | **Amp** ⭐ | Cursor | Amp generates compatible code fast |

### Amp's Strongest Phases

#### Phase: Tasks Generation (`/team.tasks`)

**Why Amp Excels**:
- Reads implementation plans quickly
- Generates 20-50 actionable tasks from a plan
- Understands dependencies and parallelization
- Suggests task ordering
- Creates clear acceptance criteria

**Amp Approach**:
1. Paste the implementation plan
2. Request: "Generate 24-30 actionable tasks from this plan, following the tasks-template.md structure"
3. Amp reads the entire plan, generates compatible tasks in seconds
4. Review and refine the task breakdown
5. Save to `specs/[feature]/tasks.md`

#### Phase: Implementation (`/team.implement`)

**Why Amp Excels**:
- Multi-file awareness: Can create/update multiple files in one response
- Context switching: Quickly pivots between different modules
- Code compatibility: Generates code that fits existing patterns
- Rapid iteration: Fast feedback loop for "tweak this" requests
- Example learning: Learns from your codebase examples and replicates style

**Amp Approach**:
1. Provide Amp with the complete plan and tasks
2. Amp reads task-by-task requirements
3. Generate code files that satisfy acceptance criteria
4. Use follow-up requests to refine, fix, or extend
5. Leverage Amp's speed for rapid iteration

---

## Using Amp Effectively

### Context Provision Strategy

Amp works best with complete context. Provide:

1. **The Plan** - Give Amp the full `plan.md`
2. **Task List** - Paste relevant tasks you're working on
3. **Existing Code** - Let Amp read your codebase structure
4. **Requirements** - Include acceptance criteria from tasks
5. **Constraints** - Technical constraints from the plan

**Example Prompt**:

```
Here's our implementation plan:
[paste plan.md]

Here's the task I'm working on:
[paste specific task]

Here's my current project structure:
[paste file tree]

Generate the implementation for [specific component]. 
Follow the architecture from the plan and match the existing code style.
```

### Multi-File Capabilities

Amp can create/update multiple files in one response:

```
Generate the following files:
1. src/models/User.ts - User entity
2. src/services/UserService.ts - User service layer
3. tests/UserService.test.ts - Unit tests

Follow the architecture pattern from the plan.
```

Amp will generate all three files with proper imports and relationships.

### Iteration & Refinement

Leverage Amp's speed for rapid iteration:

```
❌ "That's not quite right"
→ Amp: "What needs to change?"
→ You: "The validation should check for..."
→ Amp regenerates instantly

✅ Repeat 2-3 times until perfect
```

This rapid feedback loop is Amp's superpower.

### Code Review with Amp

Use Amp for fresh-perspective code reviews:

```
Review this code for:
1. Code quality and best practices
2. Performance issues
3. Security concerns
4. Test coverage gaps
5. Refactoring opportunities

[paste code]

Suggest improvements following [your tech stack] best practices.
```

---

## Amp-Optimized Workflow

### Day 1-2: Planning Phase (Use Claude if available, otherwise Amp)

```
If using Claude:
- /team.specify [feature]
- /team.review [validate spec]
- /team.plan [technical plan]

If using Amp only:
- Provide manual spec or specification
- Request: /team.plan
```

### Day 2-3: Task Breakdown with Amp

```
/team.tasks

Paste plan.md → Amp generates tasks → Save to tasks.md
Time: 15-30 minutes
Quality: High
```

### Day 3+: Implementation with Amp

**Day 3 Morning**:
```
Generate Phase 1 files (setup/models):
[paste Phase 1 tasks]

Create these files with implementations...
```

**Day 3 Afternoon**:
```
Generate Phase 2 files (services):
[paste Phase 2 tasks]

Create these files matching the architecture...
```

**Day 4+**: Continue Phase by Phase

**Benefits**:
- Each phase completes in hours, not days
- Multi-file generation speeds development
- Amplearns your patterns and applies consistently
- Iteration loop is fast enough for real-time feedback

---

## Amp Optimization Tips

### 1. Provide Full Context Upfront

**Better** ✅:
```
Here's the full plan [paste all 500 lines]
Here's the existing codebase structure [paste structure]
Now generate [specific file]
```

**Weaker** ❌:
```
Generate this file
```

### 2. Use Task-by-Task Approach

**Better** ✅:
```
Task IMPL-001: Create User model
- File: src/models/User.ts
- Requirements: [from task]
- Acceptance Criteria: [from task]

Generate this implementation
```

### 3. Leverage Acceptance Criteria

Amp uses acceptance criteria to validate its own work:

```
Acceptance Criteria (from tasks.md):
☐ User can create account
☐ Email validation works
☐ Password hashed properly
☐ Database persists user

Generate implementation that satisfies these criteria
```

### 4. Specify Your Tech Stack Clearly

```
Tech Stack:
- Language: TypeScript 5.2
- Framework: Express.js 4.18
- Database: PostgreSQL
- ORM: Prisma 5.0
- Testing: Jest 29

Follow these standards:
- [list specific patterns from your existing code]
- [list code style rules]
- [list file organization rules]
```

### 5. Use "Match Existing Patterns"

Amp learns from examples:

```
Here's how we structure services in this project:
[paste existing service file]

Generate the UserService following this pattern
```

### 6. Iterative "Fix" Requests

```
Amp, fix this:
- [specific issue]
- [specific change]
- [specific enhancement]

Regenerate the file
```

This is much faster than starting over.

---

## Common Amp Workflows

### Workflow 1: Rapid API Generation

```
1. Paste OpenAPI spec or endpoint requirements
2. Request: "Generate all API controllers for these endpoints"
3. Amp generates all route files
4. Request: "Add authentication middleware to these routes"
5. Amp updates all files
```

**Time**: 30 minutes for 10-15 API endpoints

### Workflow 2: Multi-Layer Feature

```
1. Paste feature requirement
2. "Generate: database models, services, API controllers, tests"
3. Amp generates 4 files simultaneously
4. Request: "Add validation and error handling"
5. Amp refines all 4 files
```

**Time**: 1-2 hours for complete feature

### Workflow 3: Code Quality Pass

```
1. Paste code files
2. "Review for: style consistency, performance, security"
3. Amp identifies issues with specific line references
4. "Fix these issues"
5. Amp regenerates improved code
```

**Time**: 20 minutes per file

### Workflow 4: Refactoring

```
1. Paste existing code
2. "Refactor for [specific goal]"
3. Amp regenerates
4. "That's better, now also [enhancement]"
5. Amp refactors again
```

**Time**: 10 minutes per module

---

## Integration with Team Methodology

### Spec Template - Amp Usage

When using `/team.specify`, Amp can:
- Generate user stories from requirements
- Fill in team persona perspectives
- Create acceptance scenarios
- Suggest success criteria

**Tip**: Use Claude for initial spec, Amp for iterating/expanding

### Plan Template - Amp Usage

When using `/team.plan`, Amp can:
- Outline technical approaches
- Identify project structure options
- List implementation phases
- Assess team risks

**Tip**: This works well with Amp

### Tasks Template - Amp Usage ⭐

Amp **excels** at generating task breakdowns:

```
/team.tasks [with implementation plan loaded]
```

Amp generates 20-50 specific, actionable tasks with:
- Clear ownership assignment
- Dependency identification
- Time estimates
- Acceptance criteria
- File paths

### Implement Template - Amp Usage ⭐

Amp **dominates** the implementation phase:

```
/team.implement [with full plan and tasks loaded]
```

Amp can generate entire implementation in phases:
- Creates correct file structure
- Writes actual code (not pseudocode)
- Follows team patterns
- Includes tests
- Handles cross-file dependencies

---

## When to Use Amp vs Other Agents

### Use Amp When:

✅ You need **task generation** from a complex plan  
✅ You need **multi-file code generation** fast  
✅ You need **rapid iteration** on implementations  
✅ You need **fresh code review** perspective  
✅ You need **cross-module** understanding  
✅ You're working with **existing codebases** (Amp learns patterns)  
✅ You need **real-time feedback** on code quality  

### Use Claude When:

- Creating the initial specification (reasoning about user value)
- Complex architecture decisions (needs deep reasoning)
- Design system work (UX-focused thinking)

### Use Cursor When:

- Local refactoring (IDE integration)
- File-by-file tweaks
- In-editor code completion

### Use Gemini When:

- You need massive context window (2M tokens)
- Exploring architectural options
- Large-scale code exploration

---

## Amp + Team Methodology Checklist

Before starting implementation with Amp:

- [ ] **Specification**: Complete and team-reviewed
- [ ] **Plan**: Technical decisions made and documented
- [ ] **Tasks**: Broken down with acceptance criteria
- [ ] **Architecture**: Clear patterns established
- [ ] **Technology Stack**: Documented with examples
- [ ] **Codebase**: Example files for pattern learning
- [ ] **Standards**: Code style guide available

With these in place, Amp can generate production-quality code rapidly.

---

## Example: From Plan to Code in 2 Hours (with Amp)

### Timeline

**00:00-00:15**: Provide Plan & Context
- Paste implementation plan (500 lines)
- Paste 2-3 existing service examples
- Paste project structure

**00:15-00:45**: Generate Tasks
```
/team.tasks
```
- Amp generates 30 specific tasks
- Review and adjust if needed

**00:45-01:30**: Implement Phase 1 (Setup)
```
Generate database models and migrations:
[paste Phase 1 tasks]
```

**01:30-02:00**: Implement Phase 2 (Services)
```
Generate service layer:
[paste Phase 2 tasks]
```

**Total**: 2 hours from plan to working code

---

## Best Practices

### Context Management

- Keep total context under 50KB when possible
- Prioritize plan and relevant tasks
- Include file paths with context
- Provide existing code examples

### Validation

After Amp generates code:

1. **Readability**: Can you understand it in 30 seconds?
2. **Acceptance Criteria**: Does it satisfy all criteria?
3. **Style**: Does it match your codebase style?
4. **Dependencies**: Are all imports correct?
5. **Tests**: Are tests included and meaningful?

### Iteration Strategy

- Start with "good enough"
- Refine through 2-3 iteration cycles
- Each iteration focused on one improvement area
- Rapid feedback loop essential

---

## Troubleshooting

### "Amp Generated Incomplete Code"

**Solution**: 
- Paste complete acceptance criteria
- Explicitly state: "Include complete implementation, not pseudocode"
- Provide more context files

### "Code Doesn't Match Project Style"

**Solution**:
- Paste existing code examples explicitly
- Add style guide as context
- Request: "Follow the patterns from [example file]"

### "Lost Context Between Requests"

**Solution**:
- Restate key requirements before each request
- Paste the full plan at start of session
- Maintain thread continuity

### "Too Many Edge Cases"

**Solution**:
- Start with happy path
- Use iteration: "Now add error handling"
- Break into separate requests

---

## Resources

- [Quick Start Guide](./QUICK-START.md)
- [FAQ](./FAQ.md)
- [AGENTS.md](../AGENTS.md)
- [Complete Workflow](../team-driven.md)
- [Example Project](./EXAMPLES/001-simple-todo-list/WALKTHROUGH.md)

---

## Getting Help

- **Questions**: See [FAQ](./FAQ.md)
- **Issues**: Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
- **Examples**: Study [complete example](./EXAMPLES/001-simple-todo-list/)
- **Community**: [GitHub Issues](https://github.com/Nom-nom-hub/dev-team-methodology/issues)

---

**Version**: 1.0 | **Last Updated**: 2025-12-15

**Related**: [AGENTS.md](../AGENTS.md) | [Agent Capabilities](./AGENT-CAPABILITIES.md) | [Quick Start](./QUICK-START.md)

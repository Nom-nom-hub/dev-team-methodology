# Frequently Asked Questions

## Getting Started

### Q: Do I need to follow the exact workflow (specify → review → plan → tasks → implement)?
**A:** The workflow is designed to work sequentially, but you can adapt it:
- **Spike/exploratory work?** Use `/team.specify` and `/team.plan` to explore options
- **Existing codebase?** Start at `/team.plan` with your current architecture
- **Small feature?** You can skip `/team.review` if your spec is simple, but not recommended
- **Architecture changes?** Always run `/team.review` to catch cross-team impacts

---

### Q: How long does a full feature cycle take?
**A:** Typical timeline:

| Phase | Time | Effort |
|-------|------|--------|
| `/team.specify` | 15-30 min | Describe what to build |
| `/team.review` | 10-15 min | Team validation |
| `/team.clarify` | 10-20 min | Q&A on ambiguities |
| `/team.plan` | 15-30 min | Tech stack + architecture |
| `/team.tasks` | 5-10 min | Task generation |
| `/team.implement` | Varies | Code generation & testing |

**Total for small feature:** 2-3 hours spec + planning + initial code generation

---

### Q: Can I use Team-Driven Development in existing projects?
**A:** Yes. Run `team init . --ai <agent>` in your existing repo:
- Creates `.team/` directory with templates
- Doesn't modify existing code
- Adds agent-specific command files
- Use `/team.plan` to onboard new features into the methodology

---

## Specifications

### Q: My specification is 10,000 words. Is that too long?
**A:** No, but consider splitting:
- **One spec per user story collection**: Group related stories
- **Cross-cutting concerns separate**: Auth, logging, monitoring
- **Complexity indicator**: 5,000+ words suggests multiple features
- **Rule of thumb**: 2,000-4,000 words is typical

Use `/team.analyze` to check if your spec is too ambitious.

---

### Q: What do I do if the AI's specification doesn't match my vision?
**A:** Iterate:
```
User: "This isn't quite right. Change X to Y, and add Z"
/team.review (again, on the updated spec)
/team.clarify (to identify remaining gaps)
```

Don't treat first-generation specs as final. They're v0.1.

---

### Q: Should I include UI mockups in the specification?
**A:** Use this decision tree:
- **Existing design?** Add mockups/screenshots to specification
- **Designer on team?** Have UX Designer contribute early with visuals
- **Still exploring?** Use spec `/team.review` and have UX Designer propose patterns
- **Simple CRUD app?** Often unnecessary; specification text is enough

---

## Planning

### Q: How detailed should the implementation plan be?
**A:** The plan bridges specifications to code:

**TOO VAGUE:**
> "Implement user authentication"

**TOO DETAILED:**
> "Create file X with class Y implementing interface Z with methods A, B, C using pattern..."

**JUST RIGHT:**
> "Implement JWT-based authentication using Auth0 library. Store tokens in localStorage. Validate on page load and API requests. Handle refresh token flow. Fallback for missing tokens."

**Rule:** Someone reading the plan should know what to code without reading the spec again.

---

### Q: Can I use a different tech stack than the agent suggested?
**A:** Absolutely. Use `/team.plan` to specify:
```
/team.plan Use Next.js instead of Vite, PostgreSQL instead of SQLite, Redis for caching. Consider all team perspectives on scalability and deployment.
```

The agent will regenerate the plan with your constraints. You're in control.

---

## Tasks & Implementation

### Q: My tasks are too vague. What should I do?
**A:** Check TASK-TYPES.md for examples:
- **Research tasks** must specify evaluation criteria
- **Implementation tasks** must specify file paths, methods, acceptance criteria
- **Test tasks** must specify test file, number of tests, coverage target
- **Deployment tasks** must specify artifacts, target, validation

Vague tasks = vague implementations. Spend time on clear tasks.

---

### Q: Can I run tasks in parallel?
**A:** Yes! The task list marks parallelizable tasks with `[P]`:
```
[P] Create data model for User entity
[P] Create data model for Task entity
[AFTER P tasks] Create database migration
```

Run `[P]` tasks simultaneously; sequential tasks must wait.

---

### Q: What do I do if implementation reveals a specification problem?
**A:** Common and expected:
1. Stop implementation on that task
2. Update the specification section that's wrong
3. Regenerate the plan with `/team.plan`
4. Regenerate tasks with `/team.tasks`
5. Resume implementation

This is why TDD emphasizes specs as the source of truth, not code.

---

### Q: How do I handle breaking changes mid-implementation?
**A:** 
1. Document the change in specification
2. Run `/team.review` on the change
3. Update `/team.plan` with new architecture
4. Regenerate `/team.tasks` 
5. Re-estimate timeline with team

This is faster than manual rework because specs drive regeneration.

---

## Team Collaboration

### Q: How do we handle disagreement between team personas?
**A:** This is what `/team.review` is for:
- Product Manager wants feature X
- Architect says it's too complex for timeline
- Resolution: documented in `/team.analyze` output
- Update specification with compromise

Disagreement early saves months of rework.

---

### Q: Can I use this methodology with a distributed team?
**A:** Yes, it's actually ideal for distributed:
- Specifications become the async communication medium
- Team personas can review async
- Personas don't need to be in same timezone
- Git branches keep everyone synchronized

---

### Q: What if we don't have a dedicated UX Designer or QA?
**A:** Still define the personas; they can be roles rather than people:
- Developer can also play "UX Designer" hat
- Product Manager can also think "QA" perspective
- The framework ensures all viewpoints are considered

---

## Constitutional Principles

### Q: Can I customize the constitution?
**A:** Yes. The constitution is YOUR project's rules:
- Start with the template
- Modify to match your team's values
- Reference it during specification and planning phases
- Update when you learn better approaches

Example customizations:
- Add "we only use frameworks with 1M+ weekly npm downloads"
- Add "all code must have integration tests"
- Add "maximum 3 npm dependencies per feature"

---

### Q: What if we violate the constitution?
**A:** Document the exception:
```
Section 2.2 Amendment Log:
2025-12-15: Used 2 additional npm packages for [feature X]
Rationale: No existing library provided necessary functionality
Impact: Increased bundle by 50KB, saved 2 weeks dev time
Approved by: Technical Architect, Product Manager
```

The constitution is guidelines, not law. Document exceptions.

---

## Common Mistakes

### Q: I skipped `/team.review` and now implementation is stuck. What do I do?
**A:** Run it now:
```
/team.review Have each persona review this specification for gaps and feasibility issues.
```

Then update the spec based on findings and re-plan.

---

### Q: The task list is 200 tasks. Is that too many?
**A:** Usually yes. This indicates:
- ❌ Feature is too ambitious (split into 3-5 features)
- ❌ Tasks are too granular (combine related tasks)
- ❌ Over-engineering (apply constitution simplicity principle)

Typical healthy feature: 15-30 well-scoped tasks.

---

### Q: We implemented everything but forgot to write tests. Now what?
**A:** Time to pay technical debt:
1. Add tests to specification (you'll wish you had done this)
2. Update plan to include test implementation
3. Regenerate tasks
4. Add test tasks to backlog

This is why Article III of the constitution mandates tests FIRST.

---

### Q: Can I use this for refactoring work?
**A:** Yes, it's excellent for refactoring:
1. `/team.specify` - Describe current vs desired architecture
2. `/team.review` - Ensure all personas support the refactor
3. `/team.plan` - Step-by-step refactoring strategy
4. `/team.tasks` - Incremental refactoring tasks
5. `/team.implement` - Execute with safety

---

## Agent-Specific Questions

### Q: Which AI agent should I use?
**A:** See [AGENT-CAPABILITIES.md](./AGENT-CAPABILITIES.md) for detailed comparison.

**Quick answer:**
- **Claude:** Best for understanding complex specifications, excellent documentation
- **Amp:** Fast context switches, good multi-file handling, excellent for code review
- **Cursor:** Best IDE integration, excellent for local refactoring
- **Copilot:** Good for code completion, some planning limitations
- **Gemini:** Good for exploration, emerging capabilities

---

### Q: Can I switch agents mid-project?
**A:** Yes. Team-Driven Development is agent-agnostic:
1. All artifacts (specs, plans, tasks) are in plain markdown
2. Any agent can read and work with them
3. Switch anytime without loss of context

Recommended: Stick with one agent per feature for consistency.

---

### Q: My agent says "I don't understand this specification." What do I do?
**A:** Run `/team.clarify`:
```
/team.clarify Break down ambiguities in the specification into specific questions that need answers.
```

This generates Q&A that clarifies the spec without rewriting it.

---

### Q: Can I use Team-Driven Development without an AI agent?
**A:** Technically yes, but you'll do all the template work manually:
- Write specifications yourself
- Create plans yourself  
- Generate task lists yourself

Much slower, but the methodology is valid. AI agents just amplify the process.

---

## Troubleshooting

### Q: `/team.specify` created a branch but didn't create a spec file. What happened?
**A:** Check:
1. Is the `.team/` directory properly initialized?
2. Run `team check` to verify installation
3. Ensure git is initialized: `git init`
4. Try again with explicit feature: `/team.specify Create a user login feature`

See [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) for detailed error recovery.

---

### Q: The generated specification has syntax errors or is incomplete.
**A:** Common causes and fixes:

| Issue | Cause | Fix |
|-------|-------|-----|
| Markdown formatting broken | Agent misunderstood format | Copy the spec, fix formatting, ask agent to re-review |
| Missing sections | Spec was cut off | Regenerate or manually add missing sections |
| Wrong file paths | Agent used incorrect naming | Use WORKFLOW-VARIABLES.md to correct paths |

---

## Advanced Usage

### Q: Can I generate multiple implementation plans from one specification?
**A:** Yes! This is called "design exploration":
1. Keep one specification
2. Create multiple plans: `plan-v1.md`, `plan-v2.md`, `plan-v3.md`
3. Have team evaluate trade-offs
4. Pick the best approach
5. Use that plan for implementation

---

### Q: How do I document architectural decisions?
**A:** Create a `decision-log.md` in the feature directory:

```markdown
## Decision: Database Choice

**Question:** SQLite vs PostgreSQL for task storage?

**Options Considered:**
- SQLite: Simple, local, file-based
- PostgreSQL: Scalable, networked, ACID guarantees
- MongoDB: Flexible schema, document-oriented

**Decision:** PostgreSQL

**Rationale:** 
- Planned growth to multi-user requires network access
- ACID guarantees important for financial features
- Standard deployment process across team projects

**Consequences:**
- Requires deployment infrastructure (vs SQLite simplicity)
- Better long-term scalability
- Team standard for data consistency

**Reviewed By:** Technical Architect, DevOps Engineer
**Date:** 2025-12-15
```

---

### Q: How do I track progress across multiple features?
**A:** Create a `PROJECT.md` at repo root:

```markdown
# Project Status

## Features

| Feature | Status | Owner | ETA |
|---------|--------|-------|-----|
| 001-user-auth | Implementing | Developer | 2025-12-20 |
| 002-todo-crud | Planning | Architect | 2025-12-22 |
| 003-real-time | Specified | PM | 2025-12-25 |

## Key Metrics
- Features completed: 1/3
- Story points done: 8/34
- Risk items: 2 (see RISKS.md)
```

---

## Getting Help

**Still stuck?** Try:
1. Search this FAQ for your question
2. Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)
3. Review [team-driven.md](../team-driven.md) for deep dive
4. Open a [GitHub issue](https://github.com/Nom-nom-hub/dev-team-methodology/issues)

**Want to contribute?** See [CONTRIBUTING.md](../CONTRIBUTING.md)

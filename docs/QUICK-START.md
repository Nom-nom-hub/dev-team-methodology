# Quick Start: 5-Minute Guide

Get up and running with Team-Driven Development in 5 minutes.

## Installation (2 minutes)

### Step 1: Install team CLI
```bash
uv tool install team-cli --from git+https://github.com/Nom-nom-hub/dev-team-methodology.git
```

### Step 2: Create your project
```bash
team init my-project --ai amp
```
(Replace `amp` with your AI agent: `claude`, `copilot`, `cursor`, `gemini`, etc.)

### Step 3: Verify installation
```bash
cd my-project
team check
```

You should see the `/team.*` commands available in your agent.

---

## Your First Feature (3 minutes)

### Step 1: Establish principles (30 seconds)
In your agent:
```
/team.constitution Create principles for code quality, testing, and user experience.
```

### Step 2: Define your team (30 seconds)
```
/team.personas Define team personas: Product Manager, Technical Architect, UX Designer, QA, Developer, DevOps.
```

### Step 3: Describe what you want to build (1 minute)
```
/team.specify I want to build a simple todo list application. Users can create tasks, mark them complete, delete them, and filter by status. Tasks are stored locally.
```

### Step 4: Review the specification (1 minute)
```
/team.review Have each team persona review the spec from their perspective.
```

---

## What Happens Next

After these 4 steps, you'll have:

✅ **constitution.md** - Your project's governing principles  
✅ **personas/** - Detailed team role descriptions  
✅ **specs/001-todo-list/** - Complete feature specification with user stories  
✅ **Branch** - Feature branch `001-todo-list` created automatically

The specification incorporates input from all 6 team personas and is ready for planning.

---

## Continue the Workflow

When ready to plan:
```
/team.plan Store tasks in local SQLite database. Use vanilla HTML, CSS, JavaScript. Consider scalability, security, and maintainability.
```

When ready to execute:
```
/team.tasks
/team.implement
```

---

## Key Commands

| Command | Purpose |
|---------|---------|
| `/team.constitution` | Define project principles |
| `/team.personas` | Define team roles |
| `/team.specify` | Create feature specification |
| `/team.review` | Review from all perspectives |
| `/team.plan` | Create implementation plan |
| `/team.tasks` | Generate task breakdown |
| `/team.implement` | Execute implementation |
| `/team.clarify` | Clarify ambiguous requirements |
| `/team.analyze` | Check for gaps/inconsistencies |

---

## Need Help?

- **Getting stuck?** See [FAQ.md](./FAQ.md)
- **Errors?** Check [TROUBLESHOOTING.md](./TROUBLESHOOTING.md)  
- **Examples?** See [EXAMPLES/](./EXAMPLES/)
- **Agent-specific help?** See [AGENT-CAPABILITIES.md](./AGENT-CAPABILITIES.md)

---

## Pro Tips

1. **Don't skip `/team.review`** - Catching issues early saves rework
2. **Be specific in `/team.specify`** - "Build a photo app" is vague; describe what users do
3. **Use `/team.clarify` before planning** - Structured questioning prevents downstream confusion
4. **Leverage `/team.analyze`** - Find gaps before implementation costs time
5. **Keep constitution focused** - 5-10 core principles, not 50 rules

---

**Next:** Ready to dig deeper? Read [team-driven.md](../team-driven.md) for the full methodology.

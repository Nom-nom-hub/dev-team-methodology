# Examples & Real Walkthroughs

This directory contains real, completed examples of Team-Driven Development features from start to finish.

## 📚 Available Examples

### Example 1: Simple Todo List Application

Location: `EXAMPLES/001-simple-todo-list/`

What it demonstrates:

- Complete workflow from specification to implementation
- How to structure a feature specification
- Technical planning with team input
- Task breakdown and execution
- Lessons learned and decisions made

Files included:

- `WALKTHROUGH.md` - Step-by-step walkthrough of the feature
- `spec.md` - Complete specification with all personas
- `plan.md` - Implementation plan
- `tasks.md` - Task breakdown
- `decision-log.md` - Key architectural decisions
- `LESSONS-LEARNED.md` - What went well, what to improve

Estimated reading time: 20 minutes for full walkthrough

Best for:

- First-time TDD users
- Understanding the complete workflow
- Learning how to structure specifications

---

## 🚀 Quick Navigation

| Question | Example | File |
|----------|---------|------|
| "How do I write a spec?" | Todo List | `EXAMPLES/001-simple-todo-list/spec.md` |
| "How detailed should a plan be?" | Todo List | `EXAMPLES/001-simple-todo-list/plan.md` |
| "What should tasks look like?" | Todo List | `EXAMPLES/001-simple-todo-list/tasks.md` |
| "How do I document decisions?" | Todo List | `EXAMPLES/001-simple-todo-list/decision-log.md` |
| "What should I learn from this?" | Todo List | `EXAMPLES/001-simple-todo-list/LESSONS-LEARNED.md` |

---

## 📖 How to Use These Examples

### For Learning
1. **Start with WALKTHROUGH.md** - Read the full story of how the feature was built
2. **Read spec.md** - See how requirements are documented
3. **Read plan.md** - Understand technical decision-making
4. **Review tasks.md** - Learn how work is broken down
5. **Check decision-log.md** - See how architectural choices are documented

### For Reference
- **Need a spec template?** Look at `spec.md` and adapt for your feature
- **Need a plan template?** Look at `plan.md` to understand depth and detail level
- **Need task examples?** Look at `tasks.md` for task structure and acceptance criteria
- **Need decision documentation?** Look at `decision-log.md` for format

### For Comparison
- **Building something similar?** Compare against the example to see if your approach is aligned
- **Team disagreement?** Use example decision rationale as discussion starting point
- **Estimating timeline?** Use example to calibrate effort

---

## 🎓 Learning Objectives

After working through these examples, you should understand:

✅ How to write clear, unambiguous specifications with team input  
✅ How to create technical plans that bridge specs to implementation  
✅ How to break plans into actionable tasks  
✅ How to document architectural decisions  
✅ How different team personas contribute to each phase  
✅ When to iterate vs when to proceed  
✅ How to handle mid-feature changes  

---

## 📝 Common Patterns You'll See

### Pattern 1: Specification Ambiguity
**What happens:** Specification has `[NEEDS CLARIFICATION]` markers

**Why:** This is normal! Markers show what needs team input

**How it's resolved:** 
- Team member answers the question
- Marker is removed and replaced with decision
- Related sections are updated

### Pattern 2: Plan Adjustments  
**What happens:** Plan is regenerated after specification changes

**Why:** Tech stack or architecture might change

**How it works:**
- Update specification
- Regenerate plan with new constraints
- Re-plan reflects changes

### Pattern 3: Task Splitting
**What happens:** Tasks are combined or split for clarity

**Why:** Task granularity affects execution

**How it's handled:**
- Original task might be too big → split into 2-3 tasks
- Original tasks might be too small → combine into larger task
- Dependencies clarified

---

## ⚙️ Before You Copy Examples

### Do

✅ Use as templates for your own specifications  
✅ Adapt decision rationale to your context  
✅ Copy task structures for similar features  
✅ Reference as examples in team discussions  

### Don't

❌ Copy examples verbatim without adaptation  
❌ Assume your feature is exactly like the example  
❌ Use example tasks without your team's input  
❌ Skip the walkthrough and jump to files  

---

## 🔄 Creating Your Own Examples

After completing a feature, consider documenting it as an example:

1. **Copy your feature directory** to `EXAMPLES/00X-feature-name/`
2. **Create WALKTHROUGH.md** - Step-by-step story of the feature
3. **Create LESSONS-LEARNED.md** - What went well, what to improve
4. **Ensure all files are present** - spec.md, plan.md, tasks.md, decision-log.md
5. **Create a pull request** to contribute back

This helps the community learn from real examples!

---

## 📚 Example Difficulty Levels

| Level | Example | Focus | Audience |
|-------|---------|-------|----------|
| **Beginner** | Simple Todo List | Basic CRUD, learning workflow | New to TDD |
| **Intermediate** | (Coming soon) | Authentication, relationships | Familiar with basics |
| **Advanced** | (Coming soon) | Real-time, complex architecture | Experienced teams |

---

## 🤔 FAQ About Examples

**Q: Can I copy an example exactly?**  
A: Not recommended. Use as inspiration but adapt to your feature and team.

**Q: Are these examples "correct"?**  
A: They're one valid approach. Your team's approach might be different (and equally valid).

**Q: What if my feature is different?**  
A: That's expected! Use the structure and decision-making process, not the specific details.

**Q: Can I contribute an example?**  
A: Yes! See [CONTRIBUTING.md](../CONTRIBUTING.md) for guidelines.

---

## 🚀 Next Steps

Ready to build your first feature?

1. **Read [QUICK-START.md](./QUICK-START.md)** (5 minutes)
2. **Study this todo list example** (20 minutes)
3. **Follow the workflow** on your feature (varies)
4. **Reference examples** when stuck

---

## 📖 Related Documentation

- [QUICK-START.md](./QUICK-START.md) - Get started in 5 minutes
- [FAQ.md](./FAQ.md) - Common questions
- [TROUBLESHOOTING.md](./TROUBLESHOOTING.md) - Problem solving
- [team-driven.md](../team-driven.md) - Full methodology
- [CONTRIBUTING.md](../CONTRIBUTING.md) - Contributing examples


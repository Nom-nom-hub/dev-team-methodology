# AI Agent Capabilities Comparison

Choose the right AI agent for your Team-Driven Development workflow.

## Quick Summary

| Agent | Best For | Speed | Context | Strengths |
|-------|----------|-------|---------|-----------|
| **Claude** | Specifications & Planning | Medium | 200k | Excellent reasoning, documentation |
| **Amp** | Code & Fast iteration | Fast | Varies | Context switching, code review |
| **Cursor** | Refactoring & Local work | Very Fast | 180k | IDE integration, file awareness |
| **Copilot** | Code completion & features | Fast | 128k | Editor integration, accessibility |
| **Gemini** | Exploration & creativity | Medium | 2M | Largest context, cost-effective |
| **Qoder** | Code generation | Medium | 128k | Accuracy, minimal hallucination |

---

## Detailed Comparison

### Specification & Planning Phase

| Agent | Rating | Notes |
|-------|--------|-------|
| **Claude** | ⭐⭐⭐⭐⭐ | Best for `/team.specify` and `/team.plan`. Excellent multi-perspective reasoning. Understands team dynamics. |
| **Gemini** | ⭐⭐⭐⭐ | Large context allows detailed specifications. Good at exploring multiple options. |
| **Amp** | ⭐⭐⭐⭐ | Fast specification generation. Good for rapid iteration on requirements. |
| **Cursor** | ⭐⭐⭐ | Works well but less specialized for planning. Shines in implementation phase. |
| **Copilot** | ⭐⭐⭐ | Can handle specs but less structured reasoning than Claude. |
| **Qoder** | ⭐⭐⭐ | Capable but not optimized for specification work. |

---

### Review Phase (`/team.review`)

| Agent | Rating | Notes |
|-------|--------|-------|
| **Claude** | ⭐⭐⭐⭐⭐ | Excellent at multi-perspective review. Naturally thinks from different personas. |
| **Gemini** | ⭐⭐⭐⭐ | Good reasoning about trade-offs and perspectives. Large context helps. |
| **Amp** | ⭐⭐⭐⭐ | Can review effectively. Faster turnaround than Claude. |
| **Cursor** | ⭐⭐⭐ | Reviews code quality better than specifications. Limited for requirements review. |
| **Copilot** | ⭐⭐ | Not designed for specification review. Better used in code phases. |
| **Qoder** | ⭐⭐⭐ | Capable but not specialized for multi-perspective analysis. |

---

### Planning Phase (`/team.plan`)

| Agent | Rating | Notes |
|-------|--------|-------|
| **Claude** | ⭐⭐⭐⭐⭐ | Excels at technical planning. Strong at architecture decisions. Natural at considering team perspectives. |
| **Gemini** | ⭐⭐⭐⭐ | Good planning capabilities. Large context for complex architectures. |
| **Amp** | ⭐⭐⭐⭐ | Fast planning with good accuracy. Excellent for iterating plans. |
| **Cursor** | ⭐⭐⭐⭐ | IDE context helps with existing architecture. Better than in specification phase. |
| **Copilot** | ⭐⭐⭐ | Can create plans but less comprehensive than Claude/Gemini. |
| **Qoder** | ⭐⭐⭐ | Capable planning but less flexibility in approach. |

---

### Implementation Phase (`/team.implement`)

| Agent | Rating | Notes |
|-------|--------|-------|
| **Cursor** | ⭐⭐⭐⭐⭐ | Best in class. IDE integration, file awareness, instant refactoring. |
| **Amp** | ⭐⭐⭐⭐⭐ | Excellent code generation. Fast iteration. Great multi-file handling. |
| **Claude** | ⭐⭐⭐⭐ | Solid implementation. Large context handles complex features. Some token waste in IDE-less workflow. |
| **Copilot** | ⭐⭐⭐⭐ | Fast, accessible in editor. Less context than Claude/Amp. |
| **Gemini** | ⭐⭐⭐ | Can implement but slower than Cursor/Amp. Large context sometimes confuses. |
| **Qoder** | ⭐⭐⭐⭐ | Very accurate code. Good for quality-first teams. Slightly slower than Amp/Cursor. |

---

### Testing Phase

| Agent | Rating | Notes |
|-------|--------|-------|
| **Claude** | ⭐⭐⭐⭐⭐ | Excellent at test-driven development. Understands test strategy holistically. |
| **Amp** | ⭐⭐⭐⭐⭐ | Fast test generation. Good at property-based and edge cases. |
| **Qoder** | ⭐⭐⭐⭐ | High test quality. Accurate coverage analysis. Slightly slower than Amp. |
| **Cursor** | ⭐⭐⭐⭐ | Good test generation within IDE. See tests running immediately. |
| **Copilot** | ⭐⭐⭐ | Adequate test completion. Limited strategic test planning. |
| **Gemini** | ⭐⭐⭐ | Can generate tests but less test-focused than Claude/Amp. |

---

### Refactoring

| Agent | Rating | Notes |
|-------|--------|-------|
| **Cursor** | ⭐⭐⭐⭐⭐ | Best refactoring experience. IDE integration, instant changes, file awareness. |
| **Amp** | ⭐⭐⭐⭐ | Fast multi-file refactoring. Good at preserving behavior. |
| **Claude** | ⭐⭐⭐⭐ | Thoughtful refactoring. May struggle with very large codebases. |
| **Copilot** | ⭐⭐⭐ | Good for small local refactors. Limited cross-file awareness. |
| **Qoder** | ⭐⭐⭐ | Capable but slower than Cursor/Amp. |
| **Gemini** | ⭐⭐⭐ | Can refactor but may lose nuance in large changes. |

---

### Documentation Quality

| Agent | Rating | Notes |
|-------|--------|-------|
| **Claude** | ⭐⭐⭐⭐⭐ | Exceptional documentation. Clear examples. Natural prose. |
| **Gemini** | ⭐⭐⭐⭐ | Good documentation with large context for detail. |
| **Amp** | ⭐⭐⭐⭐ | Solid documentation. Clear and concise. |
| **Qoder** | ⭐⭐⭐⭐ | Good documentation quality. Accurate technical details. |
| **Copilot** | ⭐⭐⭐ | Adequate documentation. Sometimes verbose. |
| **Cursor** | ⭐⭐⭐ | Good documentation within code. Limited standalone doc generation. |

---

## Workflow Recommendations

### Small Team, Single Feature
**Recommended: Claude + Amp**
- Claude: `/team.specify`, `/team.review`, `/team.plan`
- Amp: `/team.tasks`, `/team.implement`, testing

**Rationale:** Claude excels at planning; Amp accelerates implementation.

---

### Large Team, Multiple Features
**Recommended: Claude + Cursor + Amp**
- Claude: Specification and planning (async)
- Cursor: Implementation and refactoring (real-time in IDE)
- Amp: Code review and testing (fresh perspective)

**Rationale:** Parallelize across team; each agent optimized for their phase.

---

### Rapid Prototyping
**Recommended: Amp + Cursor**
- Amp: Fast spec and plan generation
- Cursor: Immediate IDE feedback and refactoring

**Rationale:** Speed matters more than polish.

---

### Quality-First (Financial/Healthcare)
**Recommended: Claude + Qoder**
- Claude: Comprehensive planning with safety focus
- Qoder: Accurate implementation and rigorous testing

**Rationale:** Accuracy and reasoning over speed.

---

### Learning/Educational
**Recommended: Claude (primarily)**
- Claude: Excellent explanations of decisions
- Pair with: Cursor or Amp for implementation

**Rationale:** Claude explains the "why" effectively.

---

### Brownfield/Refactoring
**Recommended: Cursor (primary) + Claude (planning)**
- Cursor: Real-time IDE refactoring and safety
- Claude: Big-picture refactoring strategy

**Rationale:** Cursor sees your actual code; Claude sees the architecture.

---

## Context Window Comparison

| Agent | Context | Use Case |
|-------|---------|----------|
| **Gemini** | 2M tokens | Extremely large features, comprehensive documentation, exploration |
| **Claude** | 200k tokens | Most features, complex specifications, planning |
| **Amp** | Varies | Fast iteration, code review, implementation |
| **Cursor** | 180k tokens | Local refactoring, file-specific work |
| **Copilot** | 128k tokens | Code completion, smaller features |
| **Qoder** | 128k tokens | Focused tasks, accurate implementations |

**Rule of thumb:** More context = better for complex specifications; less important for small implementation tasks.

---

## Cost Considerations

(As of December 2025 - verify current pricing)

| Agent | Model | Cost | Best Value For |
|-------|-------|------|----------------|
| **Claude** | Claude 3.5 | $3-15/MTok | Quality-focused work |
| **Gemini** | Gemini 2.0 | $0.075-1.5/MTok | Budget-friendly, large context |
| **Amp** | Various | Free (Ads) | Teams with ads acceptance |
| **Cursor** | Claude 3.5 | $20/month subscription | IDE-based work |
| **Copilot** | GPT-4o | $10-20/month | GitHub Copilot users |
| **Qoder** | Specialized | Variable | Accuracy-focused orgs |

---

## Switching Between Agents

Team-Driven Development is **agent-agnostic**. All artifacts are plain markdown:

```
Workflow: Claude for spec → Amp for implementation → Cursor for refactoring
↓
All artifacts remain in specs/ directory
↓
Any agent can pick up where another left off
```

**Best practice:** Assign agents by phase, not by feature.

---

## Known Limitations

### Claude
- ❌ Cannot see file tree directly (requires manual file context)
- ✅ Workaround: Paste file paths or use Claude Code with project context

### Amp
- ❌ Context length varies by usage tier
- ✅ Workaround: Break large features into smaller specs

### Cursor
- ❌ Limited context outside current IDE workspace
- ✅ Workaround: Use for local refactoring, other agents for cross-repo work

### Copilot
- ❌ Limited context in `/team.specify` and `/team.plan`
- ✅ Workaround: Use Claude for planning, Copilot for implementation

### Gemini
- ❌ Large context sometimes confuses reasoning
- ✅ Workaround: Be specific in prompts; limit to focused tasks

---

## Agent Selection Checklist

Ask yourself:

- **Need planning/architecture focus?** → Claude or Gemini
- **Need fast iteration?** → Amp or Cursor  
- **Need IDE integration?** → Cursor
- **Need accuracy over speed?** → Qoder
- **Need large context for complex features?** → Gemini
- **Need best all-around?** → Claude

---

## Advanced: Agent Orchestration

For very large projects, orchestrate agents by phase:

```
Phase 1 (Specify): Claude
↓
Phase 2 (Review): Amp (fresh perspective)
↓
Phase 3 (Plan): Claude + Gemini (parallel exploration)
↓
Phase 4 (Tasks): Amp (quick breakdown)
↓
Phase 5 (Implement): Cursor + Amp (parallel coding)
↓
Phase 6 (Review): Claude (fresh eyes on code quality)
↓
Phase 7 (Refactor): Cursor (IDE-based improvements)
```

**Benefit:** Each agent used where strongest; parallel phases accelerate timeline.

---

## See Also

- [QUICK-START.md](./QUICK-START.md) - Get started in 5 minutes
- [FAQ.md](./FAQ.md) - Common questions
- [team-driven.md](../team-driven.md) - Full methodology

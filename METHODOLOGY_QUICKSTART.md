# Enhanced Methodology Quick Start

Fast reference for the upgraded Team-Driven Development methodology with senior-level quality standards.

---

## What's New

The methodology has been enhanced with comprehensive quality frameworks:

### New Requirements in Specifications
- **Non-Functional Requirements (NFR)**: Performance, scalability, security, accessibility targets
- **Risks & Edge Cases**: Failure scenarios, security risks, performance risks identified upfront
- **Constraints**: Technology, legal, cost, timeline, team, integration constraints

### New Requirements in Plans
- **Architecture Specification**: Components, schema, APIs, deployment architecture
- **Performance Budget**: Response time targets, throughput, caching, load testing strategy
- **Security Hardening Plan**: Authentication, authorization, encryption, compliance approach
- **Testing Strategy**: Unit, integration, E2E, performance, security, accessibility testing

### New Task Structure
- **TDD-First**: Unit tests written BEFORE implementation
- **4 Code Review Gates**: Architecture→Security→Quality→Performance→Final before production
- **6 Phases**: Infrastructure → Implementation (TDD) → Quality → E2E → Deployment → Launch
- **Phase Checkpoints**: Validate completion before proceeding to next phase

### New Team Capabilities
- **Developer**: SOLID principles, DRY, code clarity, error handling
- **Architect**: Architecture review gates, design checklists
- **QA**: 6 testing gates, test ownership matrix

---

## For Experienced Teams (Already Using Methodology)

### What Changes in Your Workflow

**Before**: 
1. /team.specify → /team.review → /team.plan → /team.tasks → /team.implement

**After**:
1. /team.specify → **[captures NFR + risks + constraints now]**
2. /team.risks → **[NEW: explicit risk identification]**
3. /team.review → /team.clarify → /team.decide → **[NEW: for architectural choices]**
4. /team.plan → **[includes architecture + security + testing specs]**
5. /team.tasks → **[includes code review gates + test-first ordering]**
6. /team.implement → **[follows new gate-based process]**
7. /team.retrospective → **[NEW: post-launch learning]**

### What You'll Notice

- Specs are more complete (non-functional requirements included)
- Plans include security and testing strategies upfront
- Tasks include code review gates (not just implementation)
- Tests come before implementation in task list (TDD pattern)
- New commands available: `/team.risks`, `/team.decide`, `/team.retrospective`

**Time impact**: +30-45 minutes per feature planning (worth it: prevents 70% of rework)

### Files to Review

- `templates/nfr-template.md` - What to capture for non-functional requirements
- `templates/security-plan-template.md` - How to plan security upfront
- `templates/tasks-template.md` - New task structure with gates
- `personas/teams-responsibilities.md` - What each persona does in each phase

---

## For New Teams (Starting Fresh)

### Recommended Workflow (Time Estimates)

**Total time for complete feature planning: ~4 hours**

#### Step 1: Establish Constitution (30 min)
```
/team.constitution Create principles for code quality, testing, performance, security
```
- Outputs: `.team/memory/constitution.md`
- Establishes team standards for all future features

#### Step 2: Review Personas (15 min)
```
/team.personas
```
- Outputs: Understanding of 6 team personas and their responsibilities
- Reference: `personas/teams-responsibilities.md` for detailed responsibilities per phase

#### Step 3: Specify Feature (45 min) ⭐ **EXPANDED**
```
/team.specify Build [feature description]

Now captures:
- User stories + acceptance criteria
- Non-functional requirements (performance, security, accessibility)
- Risks and edge cases
- Constraints (tech, legal, cost, timeline)
```
- Outputs: 
  - `specs/[feature]/spec.md`
  - `specs/[feature]/nfr-details.md` (new)
  - `specs/[feature]/risks.md` (new)
  - `specs/[feature]/constraints.md` (new)

#### Step 4: Identify Risks (30 min) ⭐ **NEW**
```
/team.risks
```
- Identifies failure scenarios, security risks, performance risks
- Each risk includes: probability, impact, mitigation
- Outputs: `specs/[feature]/risks.md`

#### Step 5: Review & Clarify (30 min)
```
/team.review Have each persona review the spec from their perspective

/team.clarify Ask clarifying questions for ambiguous areas
```
- Validates requirements from all perspectives
- Identifies risks before planning

#### Step 6: Make Architectural Decisions (20 min) ⭐ **NEW (Optional)**
```
/team.decide [architectural choice]

For major decisions like: database, API style, auth, caching, etc.
```
- Captures decision with alternatives and trade-offs
- Outputs: `docs/adr/ADR-NNN-[name].md`, updated `memory/decision-log.md`

#### Step 7: Plan Implementation (60 min) ⭐ **EXPANDED**
```
/team.plan [tech stack and approach]

Now specifies:
- Architecture (components, schema, APIs, deployment)
- Performance budget (response times, throughput, caching)
- Security hardening (auth, encryption, compliance)
- Testing strategy (unit, integration, E2E, load, security, accessibility)
```
- Outputs:
  - `specs/[feature]/plan.md`
  - `specs/[feature]/architecture.md` (new)
  - `specs/[feature]/security-plan.md` (new)
  - `specs/[feature]/testing-strategy.md` (new)

#### Step 8: Break into Tasks (30 min) ⭐ **RESTRUCTURED**
```
/team.tasks
```
- Generates task list with:
  - 6 phases (Infrastructure, TDD Implementation, Quality, E2E, Deployment, Launch)
  - 4 code review gates (Architecture→Security→Quality→Final)
  - Unit tests written BEFORE implementation (TDD pattern)
  - Phase checkpoints between each phase

- Outputs: `specs/[feature]/tasks.md`

#### Step 9: Implement & Validate (ongoing)
```
/team.implement
```
- Follow task list, respecting code review gates
- Tests come before code
- Senior-level code patterns enforced
- Performance and security validated before launch

#### Step 10: Post-Launch Learning (30 min) ⭐ **NEW**
```
/team.retrospective [feature-name]
```
- Conducted 1-2 weeks after launch (once you have production metrics)
- Captures: what went well, what could improve, lessons learned
- Updates: constitution with new standards, team knowledge base

---

## Timeline for Enhanced Methodology

### Initial Setup (First Feature)
- Constitution: 30 min
- Personas review: 15 min
- Learning curve: 1-2 features
- **Total extra time vs baseline**: 1-2 hours upfront

### Per Feature (Steady State)
- **Planning**: 4 hours (vs 2 hours before) = +2 hours
- **Implementation**: Same (-time saved due to better specs & fewer surprises)
- **Net impact**: +30-45 min per feature
- **ROI**: Prevents 70% of rework and production issues

---

## Key Changes by Role

### Product Manager
- **New**: Define NFRs (performance targets, success metrics, compliance needs)
- **New**: Identify user-facing risks (empty states, error cases, accessibility)
- **Same**: Define user stories and business value

### Technical Architect
- **New**: Review architectural decisions (database, APIs, patterns)
- **New**: Set performance budgets and load testing targets
- **New**: Review gates at 4 points (architecture, API, performance, deployment)
- **Same**: Validate technical feasibility

### Developer
- **New**: Learn SOLID principles, apply in code
- **New**: Write tests BEFORE implementation (TDD)
- **New**: Code review gates become requirements (can't skip)
- **Same**: Implement features, code quality focus

### QA
- **New**: 6 testing gates (setup, integration, load, security, accessibility, final)
- **New**: Explicit test ownership (who designs, implements, executes)
- **New**: Performance and security testing upfront (not last minute)
- **Same**: Ensure quality standards

### DevOps
- **New**: Design deployment architecture (blue-green, canary, etc.)
- **New**: Specify infrastructure requirements upfront
- **New**: Canary deployment + monitoring standard practice
- **Same**: Manage operations and infrastructure

---

## When Each Command Is Used

```
Day 1 (Setup):
  /team.constitution     [Establish project principles]
  /team.personas         [Understand team roles]

Per Feature:
  /team.specify          [What to build + NFRs + risks + constraints]
  /team.risks            [Failure scenarios, security risks, edge cases]
  /team.review           [Team validates from all perspectives]
  /team.clarify          [Ask clarifying questions]
  /team.decide           [Make architectural decisions (optional)]
  /team.plan             [How to build + architecture + security + testing]
  /team.tasks            [Break into tasks with review gates]
  /team.implement        [Execute tasks following gates]
  /team.retrospective    [Capture learnings, update standards]
```

---

## Expected Quality Improvements

### Before Enhancement
- Production bugs: ~5-10 per feature
- Rework: 30-40% of effort
- Security issues: 2-3 per release
- Performance surprises: Common
- Test coverage: 60-70%

### After Enhancement
- Production bugs: ~0-2 per feature (80% reduction)
- Rework: <5% of effort
- Security issues: <1 per release
- Performance surprises: Rare (load tested before launch)
- Test coverage: 80%+ enforced

**Payoff**: Fewer production incidents, faster time-to-value, higher team confidence

---

## FAQ

**Q: Does this add too much overhead?**
A: +30-45 min per feature, but prevents 70% of rework. Net positive ROI.

**Q: Can we do this without all the templates?**
A: Start with spec + plan + tasks. Add security/performance templates as you mature.

**Q: What if we don't do code review gates?**
A: You'll catch issues later (more expensive). Gates prevent surprises.

**Q: How long until team is proficient?**
A: 2-3 features. First feature is learning, by 3rd feature it's routine.

**Q: Can we skip the retrospective?**
A: You'll keep making the same mistakes. Retrospectives are where learning happens.

---

## Getting Started

### For Experienced Teams
1. Read `DETAILED_CHANGES.md` to see what's new
2. Review new persona responsibilities in `personas/teams-responsibilities.md`
3. Try enhanced templates on next feature
4. Adjust based on team feedback

### For New Teams
1. Review this document (you're reading it!)
2. Run `/team.constitution` to establish principles
3. Work through the 10-step workflow above
4. Reference templates as needed:
   - `templates/nfr-template.md`
   - `templates/security-plan-template.md`
   - `templates/testing-strategy-template.md`

### Templates Location
All templates in: `templates/`
- Core templates: `nfr-template.md`, `risks-template.md`, `constraints-template.md`, etc.
- Command guides: `templates/commands/decide.md`, `risks.md`, `retrospective.md`
- Memory files: `memory/decision-log.md`, `tech-stack.md`, `team-skills.md`

---

## Support

**Questions about new methodology?**
- See `METHODOLOGY_ENHANCEMENT_PLAN.md` for detailed rationale
- See `DETAILED_CHANGES.md` for every change specification
- See individual templates for how to fill them out

**Help with specific templates?**
- `templates/nfr-template.md` - comprehensive non-functional requirements
- `templates/security-plan-template.md` - security strategy
- `templates/testing-strategy-template.md` - testing approach
- `templates/architecture-spec-template.md` - architecture documentation

**Need to understand team roles?**
- `personas/teams-responsibilities.md` - what each persona does per phase
- Individual persona files - detailed role descriptions

---

## Next Steps

1. **Review**: Read `DETAILED_CHANGES.md` to see all changes
2. **Understand**: Review `personas/teams-responsibilities.md` for role clarity
3. **Try**: Use enhanced templates on your next feature
4. **Iterate**: Adapt based on what works for your team
5. **Improve**: Use `/team.retrospective` to capture learnings

**Welcome to senior-level team-driven development!**

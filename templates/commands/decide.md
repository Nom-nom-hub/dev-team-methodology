# /team.decide - Architectural Decision Making

## Purpose

Document architectural and technical decisions with full context, alternatives, and
trade-offs. Generates Architectural Decision Records (ADRs) for institutional memory.

## Usage

```
/team.decide [decision statement or question]
```

## Examples

```
/team.decide Should we use REST API or GraphQL?

/team.decide Which database: PostgreSQL or MongoDB?

/team.decide Monolith or microservices architecture?

/team.decide Should we use serverless for batch processing?

/team.decide Implement authentication with OAuth2 or JWT?
```

## What It Does

1. **Captures decision context**: What problem are we solving? Why now?
2. **Documents alternatives**: What are 3+ viable options?
3. **Scores options**: Performance, scalability, security, maintainability, cost, team skills
4. **Records rationale**: Why we chose this option
5. **Generates ADR file**: Stored in `docs/adr/ADR-NNN-[name].md`
6. **Updates decision log**: Adds entry to `memory/decision-log.md`

## Output: Architectural Decision Record (ADR)

### File Location

`docs/adr/ADR-001-[decision-name].md`

Example: `docs/adr/ADR-001-api-design-rest-vs-graphql.md`

### ADR Template

```markdown
# ADR-001: [Decision Title]

**Date**: 2024-01-15
**Status**: Accepted | Pending | Rejected | Superseded
**Author**: [Your name]
**Stakeholders**: [Who cares about this decision?]

## Context

What is the issue we're addressing? What are the forces at play?

- Business drivers: [Why does this matter to business?]
- Technical constraints: [What limits our options?]
- Team capabilities: [What can we realistically do?]
- Timeline: [How urgent is this decision?]

**Problem Statement**: [One paragraph summarizing the issue]

## Decision

What is the decision we're making?

**We will use [Option A] for [purpose].**

## Alternatives Considered

### Option A: [Name]
- **Description**: [How would this work?]
- **Pros**: [What's good about this?]
  - Pro 1
  - Pro 2
  - Pro 3
- **Cons**: [What's bad about this?]
  - Con 1
  - Con 2
  - Con 3
- **Score**: 8/10 (see scoring below)

### Option B: [Name]
- **Description**: [How would this work?]
- **Pros**:
  - Pro 1
  - Pro 2
- **Cons**:
  - Con 1
  - Con 2
- **Score**: 6/10

### Option C: [Name]
- **Description**: [How would this work?]
- **Pros**:
  - Pro 1
- **Cons**:
  - Con 1
  - Con 2
  - Con 3
- **Score**: 4/10

## Decision Scoring

Scored options on 1-5 scale in critical areas:

| Criteria | Weight | Option A | Option B | Option C |
|----------|--------|----------|----------|----------|
| Performance | 3x | 5 | 4 | 2 |
| Scalability | 3x | 5 | 4 | 3 |
| Security | 2x | 4 | 5 | 3 |
| Maintainability | 2x | 4 | 3 | 4 |
| Cost | 1x | 4 | 5 | 3 |
| Team Skills | 2x | 5 | 2 | 3 |
| **Weighted Score** | | **8.2** | **6.8** | **4.4** |

**Why Option A won**:
- Highest performance and scalability (critical for us)
- Team has strong JavaScript experience (easier adoption)
- Cost acceptable given performance gains
- Security adequate (not weakest in any area)

## Rationale

Why are we making this decision?

1. **Performance matters more than cost**: We need p95 response time < 200ms, and [Option A] is only one that achieves this.
2. **Team skills matter**: Team knows [Option A] well, reduces learning curve and risk.
3. **Operational simplicity**: [Option A] has mature tooling and community support.
4. **Future flexibility**: [Option A] allows us to scale horizontally later.

## Consequences

### Positive Consequences

- [ ] Faster response times (target: 200ms p95)
- [ ] Can scale to 10,000 concurrent users
- [ ] Team productive immediately (less learning)
- [ ] Mature ecosystem, lots of tutorials

### Negative Consequences / Trade-offs

- [ ] Higher infrastructure cost ($2000/month vs $500/month for Option C)
- [ ] Requires specific expertise (can't use any junior dev)
- [ ] Vendor lock-in (AWS specific if we use Lambda)

### Mitigation for Negatives

- Cost: Accept as worthwhile for performance
- Expertise: Hire consultant to train team
- Lock-in: Build abstraction layer to allow switching

## Implementation Plan

How do we implement this decision?

### Phase 1: Proof of Concept (Week 1)
- [ ] Set up [Option A] locally
- [ ] Build spike to verify assumptions
- [ ] Document integration points
- [ ] Get team feedback

### Phase 2: Adoption (Weeks 2-3)
- [ ] Convert existing services to [Option A]
- [ ] Establish patterns and best practices
- [ ] Create reusable libraries/modules
- [ ] Document for future developers

### Phase 3: Validation (Week 4)
- [ ] Load test against targets
- [ ] Measure actual performance vs predicted
- [ ] Training for team on [Option A]
- [ ] Update runbooks and procedures

## Related Decisions

- ADR-002: [Related to authentication method]
- ADR-005: [Related to caching strategy]

## Supersedes

[If this replaces an earlier decision, reference it]

- ADR-003: [Old decision this replaces]

## Superseded By

[If this decision was later changed, reference the replacement]

- ADR-009: [Newer decision that overrides this]

## Validation

How do we know this decision was the right one?

### Success Metrics

- [ ] API response time p95 < 200ms (target: measure in Week 4)
- [ ] Team productivity matches velocity expectations
- [ ] Operational incidents < 1 per month
- [ ] Team satisfaction survey >= 4/5

### Review Points

- **Week 2**: Any blockers? Need to pivot?
- **Month 1**: Is performance meeting targets? Any surprises?
- **Month 3**: Would we make the same decision again?

### Failure Indicators (Pivot if observed)

- Response time degrading over time
- Team struggling significantly (taking 2x longer than expected)
- Operational incidents > 3 per month
- Cost exceeding budget by > 50%

## Questions Answered

This decision answers these questions:

- Q: How will we handle [problem]?
  - A: By using [Option A]'s [specific feature]

- Q: What happens if [failure scenario]?
  - A: We have [mitigation]

- Q: Who is responsible for [aspect]?
  - A: [Role] owns this

## Open Questions

Questions this decision doesn't answer (for future decisions):

- [ ] How will we handle [future concern]?
- [ ] What about [edge case]?

## Appendix

### Comparison Table (Quick Reference)

| Feature | Option A | Option B | Option C |
|---------|----------|----------|----------|
| Response Time | < 100ms | < 500ms | > 1s |
| Cost | $2k/mo | $500/mo | $100/mo |
| Team Learning Curve | 1 week | 2 weeks | 3 weeks |
| Vendor Lock-in | Medium | Low | High |

### References

- [Link to documentation for Option A]
- [Link to benchmark comparison]
- [Link to team discussion]
- [Link to POC code]

### Change Log

- **2024-01-15**: ADR Created, Option A accepted
- **2024-02-01**: Week 2 review - no changes needed
- **2024-03-01**: Month 1 review - performing as expected
```

## Workflow Integration

### When to use /team.decide

**Use it for**:
- Major technology choices (database, framework, language)
- Architectural patterns (monolith vs microservices)
- Build vs buy decisions
- Significant process changes
- Trade-off decisions with pros/cons

**Don't use it for**:
- Minor implementation details (how to name a function)
- Decisions already made by others (use existing pattern)
- Time-sensitive decisions (document after if critical)

### When During Feature Development

```
/team.specify     ← Define what to build
  ↓
/team.risks       ← Identify risks
  ↓
/team.review      ← Validate from team perspectives
  ↓
/team.decide      ← Make architectural decisions ← YOU ARE HERE
  ↓
/team.plan        ← Detail implementation
  ↓
/team.tasks       ← Generate tasks
  ↓
/team.implement   ← Build it
```

**Best time**: Right before /team.plan, when you need to decide on tech stack

## Output Files

### 1. ADR File

Location: `docs/adr/ADR-NNN-[name].md`

This is the main output - the decision record itself.

### 2. Decision Log Entry

Location: `memory/decision-log.md`

Automatically updated with summary:

```markdown
## [Date] - [Decision Title]
**ADR**: ADR-001
**Decided by**: [Team members involved]
**Rationale**: [Why this decision]
**Alternatives rejected**: [What wasn't chosen and why]
**Status**: [Implemented, Pending, Blocked]
```

## Example Usage

### User Input
```
/team.decide What's our database strategy - PostgreSQL, MongoDB, or DynamoDB?
```

### System Response
```
I'll help you make this decision systematically.

Let me gather information:

1. What's the primary concern driving this decision?
   - Performance requirements?
   - Data model?
   - Team expertise?
   - Cost?

2. For each option, I'll score on:
   - Performance (query speed, throughput)
   - Scalability (growth capacity)
   - Security (encryption, compliance)
   - Maintainability (ease of ops)
   - Cost (infrastructure budget)
   - Team Skills (team expertise)

3. I'll document the decision, trade-offs, and implementation plan

4. Output: ADR-NNN-database-choice.md + updated decision log

Ready? Let me ask clarifying questions...
```

## Tips for Better Decisions

1. **Be explicit about trade-offs**: "We're choosing cost over performance" is fine
2. **Consider future flexibility**: Can we change this later if needed?
3. **Document assumptions**: "We assume < 1TB data in year 1"
4. **Involve the right people**: Tech lead, architect, team members who'll implement
5. **Set review points**: When do we revisit this decision?
6. **Don't over-decide**: Not every decision needs an ADR (only architectural ones)

## Common Pitfalls

❌ **Too detailed**: ADR that's 20 pages is too much. Keep to 2-3 pages.
❌ **No alternatives**: If there's only one option, it's not a decision.
❌ **Missing trade-offs**: Every choice has trade-offs - document them.
❌ **No review plan**: How will you know if this was right?
❌ **Never updated**: ADRs can be superseded - update the record.

## Success Criteria

A good decision record:

- ✅ Makes it clear why this option was chosen
- ✅ Documents trade-offs explicitly
- ✅ Includes alternatives considered
- ✅ Has implementation guidance
- ✅ Sets success metrics
- ✅ Identifies future decisions it enables/blocks
- ✅ Can be understood by someone new to the project

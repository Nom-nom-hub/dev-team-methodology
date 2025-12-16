# /team.retrospective - Capture Learnings & Improve

## Purpose

After a feature launches, conduct a structured retrospective to capture what went well,
what could improve, and update team knowledge for next features.

## Usage

```
/team.retrospective [feature-name]
```

## Examples

```
/team.retrospective 001-user-comments

/team.retrospective 002-payment-integration

/team.retrospective 003-mobile-responsive-design
```

## When to Use

```
/team.implement    ← Build the feature
  ↓
[Feature ships to production]
  ↓
/team.retrospective ← Conduct retrospective ← YOU ARE HERE
  ↓
[Update constitution, patterns, team knowledge]
  ↓
[Apply learnings to next feature]
```

**Best time**: 1-2 weeks after launch (once you have production metrics)

**Why**: Capture feedback while fresh, update team knowledge while learning is high

## What It Does

1. **Gathers data**:
   - Spec, plan, tasks, git history
   - Production metrics (performance, errors, usage)
   - Team feedback (what was hard, what was easy)
   - Bugs found (count, severity, root causes)

2. **Analyzes outcomes**:
   - Did we hit performance targets?
   - Did we hit reliability targets?
   - Test coverage vs plan
   - Actual effort vs estimated
   - Quality (bugs per 1000 LOC)

3. **Generates retrospective.md**:
   - What went well (repeat these)
   - What could be better (avoid next time)
   - Recommendations for next feature
   - Updates to constitution (if needed)

4. **Updates team knowledge**:
   - Patterns to reuse
   - Pitfalls to avoid
   - Tech stack decisions validated or questioned

## Output: retrospective.md

Location: `specs/[feature-name]/retrospective.md`

### File Contents

```markdown
# Retrospective - [Feature Name]

**Date**: 2024-02-01
**Duration**: [How long did the feature take?]
**Deployed**: 2024-01-25
**Retrospective Conducted**: 2024-02-01 (1 week after launch)

## Feature Overview
- **Scope**: [What was built?]
- **Team**: [Who worked on it?]
- **Effort**: [X weeks, Y engineers]

## Performance Metrics vs Targets

### API Performance
| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Response time p95 | < 200ms | 150ms | ✅ Pass |
| Error rate | < 0.1% | 0.05% | ✅ Pass |
| Throughput | 1000 req/sec | 1200 req/sec | ✅ Pass |

### Frontend Performance
| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Page load (LCP) | < 2.5s | 1.8s | ✅ Pass |
| Bundle size | < 150KB | 145KB | ✅ Pass |
| Accessibility score | 90+ | 94 | ✅ Pass |

### Infrastructure
| Metric | Target | Actual | Status |
|--------|--------|--------|--------|
| Memory usage | < 512MB | 380MB | ✅ Pass |
| CPU usage peak | < 70% | 55% | ✅ Pass |
| Uptime | 99.9% | 99.95% | ✅ Pass |

**Analysis**:
- Met all performance targets
- Actual performance better than targets (good margin for growth)
- Indicates realistic planning, good estimation

---

## Quality Metrics

### Test Coverage
| Phase | Target | Actual | Status |
|-------|--------|--------|--------|
| Unit tests | 80% | 85% | ✅ Pass |
| Integration tests | 70% | 72% | ✅ Pass |
| E2E critical journeys | 100% | 100% | ✅ Pass |
| Overall code coverage | 75%+ | 79% | ✅ Pass |

### Bugs Found
| Category | Count | Severity | Caught By |
|----------|-------|----------|-----------|
| Frontend CSS | 3 | Low | Beta users |
| API edge case | 1 | Medium | Load test |
| Security | 0 | - | Security scan |
| Performance | 0 | - | Monitoring |
| Data consistency | 0 | - | Integration tests |

**Total bugs in production**: 4 (all minor)
**Bugs per 1000 LOC**: 0.2 (excellent, target is < 1.0)
**Critical bugs**: 0 (excellent, goal is zero)

**Analysis**:
- Test coverage excellent, caught most issues
- User feedback surfaced low-priority issues
- No critical issues, no data loss
- Security process effective (zero security bugs)

---

## Effort & Timeline

### Actual vs Estimated
| Phase | Estimated | Actual | Variance |
|-------|-----------|--------|----------|
| Spec & Design | 1 week | 0.8 weeks | -20% |
| Planning | 0.5 weeks | 0.6 weeks | +20% |
| Implementation | 2 weeks | 2.1 weeks | +5% |
| Testing | 1 week | 1.2 weeks | +20% |
| Deployment | 0.5 weeks | 0.3 weeks | -40% |
| **Total** | **5 weeks** | **5.0 weeks** | **0%** |

**Analysis**:
- Overall estimation excellent (0% variance)
- Spec faster (team clear on requirements)
- Testing took longer (good - thorough)
- Deployment smooth (automation paid off)

---

## What Went Well ✅

### 1. Clear Specification
- Team knew exactly what to build
- Minimal back-and-forth during implementation
- "Did you mean X?" questions rare

**How to repeat**: NFR + risks + constraints upfront

### 2. Performance-First Mindset
- Performance budgets set during planning
- Load testing done before launch
- No performance surprises in production

**How to repeat**: Always define perf budgets, test before launch

### 3. Team Collaboration
- QA caught issues early
- Architect reviewed design decisions
- DevOps prepared runbooks proactively

**How to repeat**: Involve all personas in planning phase

### 4. Automated Testing
- 85% code coverage caught 99% of bugs
- E2E tests confident before launch
- No critical issues found in production

**How to repeat**: Enforce testing targets, require tests before code

### 5. Gradual Rollout
- Canary deployment caught 1 issue
- Rollback procedure ready (not needed)
- Monitor-first approach prevented escalation

**How to repeat**: Always canary deploy, have rollback tested

---

## What Could Be Better 📈

### 1. Early Load Testing
- Load tests ran week before launch
- Caught edge case, but late for architectural change
- Ideally would run during planning, not before launch

**Action for next feature**: Run load testing during Week 2 of planning

### 2. API Documentation
- Swagger docs auto-generated, but examples missing
- Team spent time figuring out parameters

**Action for next feature**: Require examples in API docs, generate from tests

### 3. Database Migration Testing
- Migration script worked fine, but took 2 hours
- Didn't impact users, but queued during maintenance window
- Took longer than expected

**Action for next feature**: Test migrations on production-sized data, estimate conservatively

### 4. Onboarding for Beta Users
- Beta users confused about feature flag
- No docs for how to enable beta features

**Action for next feature**: Create beta user guide, document feature flags

### 5. Stakeholder Communication
- No heads-up sent before launch
- Product team surprised by feature
- Coordination could have been better

**Action for next feature**: Send launch announcement 1 week before, include rollout plan

---

## User Feedback

### What Users Loved 💚
- "Comments feel instant, very responsive"
- "UI is clean and intuitive"
- "No spam comments getting through"
- "Able to edit comments easily"

### What Users Struggled With 🤔
- "Where's the reply/threaded comments?" (out of scope, v2 feature)
- "Can I sort comments by date?" (available, not discoverable)
- "Why can't I upload images in comments?" (security reason, needs policy)
- "Notifications for replies would be nice" (future feature)

### Usage Metrics
- 45% of users commenting (exceeds 30% target)
- Average comments per post: 3.2 (normal distribution)
- Average comment length: 120 chars (expected)
- Comment deletion rate: 0.3% (low, good UX)
- Reported spam rate: 0.1% (low, good filtering)

---

## Production Incidents

### Incident 1: Comment Cache Stale (Severity: Low)
**What happened**: User posted comment, didn't see it immediately (5 min delay)

**Root cause**: Cache TTL set to 5 minutes, high traffic caused cache miss

**What we did**: Invalidated cache on new comment (manual fix)

**Prevention**: Cache invalidation now automatic on new comment

**Impact**: 1 user affected, no data loss, issue lasted 5 minutes

### No Critical Incidents
No P1 or P2 incidents in production. Zero downtime.

---

## Technology Decisions Review

### Decision 1: REST API vs GraphQL ✅
**Decision made**: REST API
**Actual**: Worked great, simple endpoints
**Status**: ✅ Good decision, would repeat
**For next feature**: REST is good for this team and problem domain

### Decision 2: PostgreSQL Database ✅
**Decision made**: PostgreSQL (vs MongoDB)
**Actual**: Easy queries, no issues, scalable
**Status**: ✅ Good decision, would repeat
**For next feature**: Continue with PostgreSQL

### Decision 3: Redis Caching ✅
**Decision made**: Redis for cache
**Actual**: Cache hit rate 92%, reduced DB load 70%
**Status**: ✅ Good decision, would repeat
**For next feature**: Continue Redis strategy

### Decision 4: Serverless for Moderation Lambda ⚠️
**Decision made**: AWS Lambda for comment moderation
**Actual**: Works, but cold starts cause 2-3 sec delays on first comment
**Status**: ⚠️ Acceptable but suboptimal
**For next feature**: Might switch to container service or scheduled job instead

---

## Constitution Updates Recommended

Based on learnings, recommend updates to `.team/memory/constitution.md`:

### 1. Add to Testing Standards
**Current**: "Unit test coverage > 80%"
**Recommend**: "Unit test coverage > 80%, Integration tests for all APIs, E2E for critical journeys"

**Reason**: High coverage directly correlated with low bug rate

### 2. Add to Performance Standards
**Current**: "API response time p95 < 200ms"
**Recommend**: "API response time p95 < 200ms, load test before launch, perf budgets in every plan"

**Reason**: Load testing caught issue before production, prevented customer impact

### 3. Add to Quality Standards
**Current**: "Zero critical vulnerabilities"
**Recommend**: Add "Zero critical security bugs, security scan on every commit, penetration test before launch"

**Reason**: Security scan prevented injection vulnerability

### 4. Add Deployment Standards
**Current**: [Undefined]
**Recommend**: "Canary deploy first 5% of users, monitor for 24 hours, rollback procedure tested"

**Reason**: Canary caught cache issue before full rollout

---

## Patterns to Reuse

### Pattern 1: API Design
**What we did**: Designed REST endpoints with consistent naming, proper HTTP methods

**Result**: Team implemented quickly, minimal confusion

**Reuse for**: All future API endpoints

**Documentation**: See `docs/api-design-pattern.md`

### Pattern 2: Performance Testing
**What we did**: Created load test scenario, ran it weekly before launch

**Result**: Caught edge cases, validated targets

**Reuse for**: All features with API endpoints

**Documentation**: See `docs/load-testing-guide.md`

### Pattern 3: Database Migrations
**What we did**: Reversible migrations, tested on staging, scheduled during maintenance

**Result**: Zero downtime, quick rollback if needed

**Reuse for**: All database schema changes

**Documentation**: See `docs/migration-strategy.md`

---

## Pitfalls to Avoid

### Pitfall 1: Skipping Load Testing
**What we did**: Ran load test before launch
**Result**: Caught issue in advance
**For next feature**: Never skip load testing for user-facing features

### Pitfall 2: Unclear Feature Flags
**What we did**: Had feature flag, but didn't document
**Result**: Confusion with beta users
**For next feature**: Always document feature flags, include in runbook

### Pitfall 3: Late API Documentation
**What we did**: Documented API after implementation
**Result**: Took extra time, examples missing
**For next feature**: Document as you build, examples from tests

---

## Recommendations for Next Feature

### High Priority
1. **Run load testing during Week 2 of planning** (not Week 4)
   - Catch architectural issues earlier
   - Allow time for optimization
   
2. **Create beta user guide** for any feature flags
   - Reduce user confusion
   - Improve feedback quality

3. **Send launch announcement** 1 week before launch
   - Prepare stakeholders
   - Gather pre-launch feedback

### Medium Priority
4. **Document feature flags** in runbook
   - Quick reference for ops team
   - Clear on/off procedures

5. **Test migrations** on production-sized data
   - More accurate timing estimates
   - Identify performance issues

### Nice to Have
6. **Threaded comments** for v2 (major feature request)
7. **Image uploads** for v2 (security review needed)
8. **Email notifications** for replies (requires new service)

---

## Team Feedback

### What the Team Loved
- "Architecture was clear, implementation straightforward"
- "Testing requirements helped catch bugs early"
- "Load testing before launch gave confidence"
- "Clear spec meant less back-and-forth"

### Challenges Faced
- "Deployment took longer than expected (db migration)"
- "Feature flag documentation lacking"
- "Beta user onboarding unclear"
- "Performance testing tooling could be easier"

### Skills Developed
- X learned REST API design best practices
- Y became expert in PostgreSQL optimization
- Z mastered load testing with k6
- W led first successful security review

---

## Metrics Summary

| Category | Metric | Target | Actual | Status |
|----------|--------|--------|--------|--------|
| **Performance** | Response time p95 | < 200ms | 150ms | ✅ |
| | Error rate | < 0.1% | 0.05% | ✅ |
| **Quality** | Code coverage | 75%+ | 79% | ✅ |
| | Bugs in production | < 5 | 4 | ✅ |
| **Effort** | Estimation accuracy | 90-110% | 100% | ✅ |
| **Reliability** | Uptime | 99.9% | 99.95% | ✅ |
| **Adoption** | Users engaging | 30%+ | 45% | ✅ |

---

## Conclusion

Overall assessment: **Excellent execution**

This feature demonstrated the team's ability to:
- Plan thoroughly (clear specs prevent surprises)
- Test comprehensively (high coverage prevents bugs)
- Deploy safely (canary + rollback prevent customer impact)
- Learn continuously (retrospective improves future features)

**Recommendation**: Apply these learnings to next feature, consider promoting these patterns to constitution.

---

## Appendix: Data Sources

- Git history: commits, PRs, reviews
- Performance data: production metrics from [monitoring tool]
- Test results: coverage report from pytest/jest
- User feedback: support tickets, analytics events
- Team feedback: 1-on-1 conversations, feedback survey
```

## Integration with Other Commands

**After** `/team.implement` - conduct retrospective 1-2 weeks into production

**Updates**:
- `memory/constitution.md` - recommended standard updates
- `memory/decision-log.md` - validated decisions
- `memory/tech-stack.md` - confirmed technology choices
- `memory/team-skills.md` - skills developed
- `specs/[feature-name]/` - retrospective.md added

## Using Retrospective Results

### Constitution Updates
- Incorporate successful patterns into standards
- Tighten requirements that were too loose
- Relax requirements that were too strict

### Pattern Documentation
- Document patterns that worked well
- Create guides for reuse
- Share with team

### Team Knowledge
- Celebrate wins
- Acknowledge challenges
- Plan training for skill gaps

### Next Feature Planning
- Apply lessons learned
- Use patterns from successful features
- Avoid pitfalls identified

## Tips for Effective Retrospectives

1. **Be honest**: Include both successes and failures
2. **Be specific**: "Went well" is vague. "Load testing found N+1 query issue" is specific
3. **Forward-looking**: Focus on lessons for next feature, not blame
4. **Action-oriented**: Recommendations should be actionable ("run load tests week 2")
5. **Celebrate wins**: Acknowledge what the team did well
6. **Psychological safety**: This is about learning, not judgment

## Common Pitfalls

❌ **Blame-focused**: "X made a mistake" - avoid blame, focus on learnings
❌ **Ignored**: Retrospective conducted but recommendations never implemented
❌ **Too late**: Conducted 3 months after launch - memories fade
❌ **Too much detail**: 50-page doc nobody reads - keep to 5-10 pages
❌ **No action**: Good analysis but no Constitution updates or pattern docs

## Success Criteria

A good retrospective:

- ✅ Captures what went well (celebrate wins)
- ✅ Identifies what could improve (forward-looking, not blame)
- ✅ Validates or questions technology decisions
- ✅ Includes team feedback (not just metrics)
- ✅ Generates actionable recommendations
- ✅ Updates Constitution with learnings
- ✅ Captures patterns for reuse
- ✅ Is reviewed and discussed with team

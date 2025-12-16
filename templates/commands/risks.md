# /team.risks - Risk & Edge Case Identification

## Purpose

Systematically identify failure scenarios, edge cases, and risks before implementation. Prevents surprises in testing and production.

## Usage

```
/team.risks [after creating spec with /team.specify]
```

## What It Does

1. **Reads your spec**: Analyzes what you're building
2. **Prompts team personas**: Each persona identifies risks from their perspective
3. **Categorizes risks**:
   - Failure scenarios (what could break?)
   - Edge cases (boundary conditions)
   - Security risks (how could it be attacked?)
   - Performance risks (where could it slow down?)
   - Operational risks (what could go wrong in production?)
4. **Generates risks.md**: Complete risk analysis
5. **Suggests mitigations**: How to prevent or handle each risk

## When to Use

```
/team.specify     ← Define what to build
  ↓
/team.risks       ← Identify risks ← YOU ARE HERE
  ↓
/team.review      ← Validate from team perspectives
  ↓
/team.clarify     ← Ask clarifying questions
  ↓
/team.plan        ← Detail implementation
```

**Best time**: Right after /team.specify, before /team.review

**Why**: Address concerns early, before they become architectural problems

## Output: risks.md

Location: `specs/[feature-name]/risks.md`

Contains:
- Failure scenarios (probability, impact, mitigation)
- Edge cases (data boundaries, load boundaries, user boundaries)
- Security risks (auth, data, injection, API security)
- Performance risks (queries, memory, load)
- Operational risks (deployment, monitoring, incident response)

## Team Persona Involvement

### QA (Quality Assurance)
**Identifies**:
- What could fail?
- What edge cases break the system?
- What's the most likely failure mode?
- What scenarios are hardest to test?

**Questions asked**:
- "What if database is down?"
- "What if user double-clicks submit button?"
- "What if we get 10x normal traffic suddenly?"
- "What if data is corrupted mid-operation?"

### Architect (Technical Architect)
**Identifies**:
- Scalability ceiling (when does it break?)
- Technical failure modes
- Performance bottlenecks
- Dependency risks
- Architectural assumptions

**Questions asked**:
- "What's the maximum data size before we need sharding?"
- "What happens if third-party API is down?"
- "Are there any single points of failure?"
- "What's our recovery time objective (RTO)?"

### UX Designer
**Identifies**:
- Edge case UX (empty states, errors, loading)
- User confusion points
- Accessibility gaps
- Mobile-specific edge cases

**Questions asked**:
- "What does empty state look like?"
- "What error message should show if operation fails?"
- "How does this work on slow network?"
- "Can user access feature on old browser?"

### Developer
**Identifies**:
- Implementation complexity risks
- Known technical debt
- Skill gaps
- Testing difficulty

**Questions asked**:
- "How many edge cases are in this logic?"
- "Is there existing code we can reuse or does it have issues?"
- "What's the hardest part to test?"

### DevOps
**Identifies**:
- Deployment risks
- Operational complexity
- Monitoring gaps
- Incident response requirements

**Questions asked**:
- "Can this be deployed without downtime?"
- "What happens if deployment fails halfway?"
- "What should we alert on?"
- "How do we rollback if needed?"

## Example: Risk Analysis for "User Comments" Feature

### Failure Scenarios

| Scenario | Probability | Impact | Mitigation | Detection |
|----------|-------------|--------|-----------|-----------|
| Comment fails to save but user sees success | Medium | High | Use transactions, verify before confirming | Error logging, user tests |
| Comments load very slowly as count grows | High | Medium | Add pagination, index on post_id | Load test at 100k comments |
| User deletes comment, it still shows for some users | Low | High | Invalidate cache immediately | Cache tests, canary deployment |
| Comment contains injection attack | Medium | High | Sanitize input, use parameterized queries | Security scan, OWASP tests |

### Edge Cases

**Empty state**:
- [ ] No comments yet - show helpful message, not blank page
- [ ] Loading comments - show skeleton or spinner

**Boundaries**:
- [ ] Very long comment (10k characters) - truncate gracefully
- [ ] Comment with emoji - handle UTF-8 correctly
- [ ] Deleted user - show "[deleted user]" not broken reference
- [ ] Concurrent edits - last edit wins? Merge? Lock?

**Load**:
- [ ] Single comment - loads instantly
- [ ] 100 comments - loads quickly (pagination or lazy load)
- [ ] 1M comments - system doesn't crash

### Security Risks

**Authentication**:
- [ ] User can comment as other user? (verify auth on every request)
- [ ] User can comment on private post? (check permissions)
- [ ] Session hijacking? (use secure, HttpOnly cookies)

**Data protection**:
- [ ] Comments logged in plaintext? (sanitize logs)
- [ ] Comment database encrypted at rest? (enable RDS encryption)

**Injection**:
- [ ] SQL injection - use parameterized queries
- [ ] XSS injection - sanitize on output
- [ ] CSRF - use CSRF token on comment form

### Performance Risks

**Database**:
- [ ] N+1 queries (loading user for each comment) - use JOIN or batch load
- [ ] Missing index on post_id - add index
- [ ] Comments table grows unbounded - archive old comments

**Caching**:
- [ ] Cache never invalidates - set TTL and invalidate on new comment
- [ ] Cache stampede (all requests hit DB when cache expires) - use cache locks

**API**:
- [ ] Loading all comments for post - paginate
- [ ] Comment text is huge in database - consider separate storage

### Operational Risks

**Deployment**:
- [ ] New comment column added - migration might lock table
- [ ] Rollback needed mid-deployment - have rollback procedure tested
- [ ] Canary deployment shows errors - have rollback trigger

**Monitoring**:
- [ ] Comment creation fails silently - log all errors
- [ ] Slow comment load - monitor response time
- [ ] Comment corruption - have consistency check

**Incidents**:
- [ ] Comments service down - graceful degradation (hide comments, no errors)
- [ ] Database down - service shouldn't crash, should fail fast
- [ ] Cache down - continue working, just slower

## Workflow

### Step 1: QA & Architect Brainstorm Failure Scenarios

```
User: What are failure scenarios for comments feature?

System response (QA perspective):
- Comment database connection fails → user sees timeout
- User double-clicks submit → duplicate comment created
- Comment very long (100k chars) → truncation or error
- Comment contains special chars → encoding issues
- Too many comments load → UI slowdown or crash
- Comment marked spam by filter → user unaware
- Delete fails → orphaned comment
- User logged out mid-edit → data loss

System response (Architect perspective):
- Database reaches capacity → performance degradation
- Third-party content moderation API down → comments blocked
- Cache invalidation fails → stale comments shown
- Replica lag → comment visible in one region, not another
- Disk full → can't save new comments
```

### Step 2: Identify Edge Cases Per Category

```
User: What are edge cases for comments?

System response (Data boundaries):
- Empty comment (0 characters) → should reject
- Max length comment (1M characters) → truncate or reject
- Comment with only whitespace → should reject
- Comment with HTML/markdown → escape or render?
- Comment with links → linkify or plain text?
- Comment with images → embed or text only?
- Comment in unsupported language → encoding?

System response (User boundaries):
- Anonymous user commenting → allow or require login?
- Deleted user's comments → show as [deleted]?
- User commenting on own post → allow?
- User commenting on deleted post → prevent?
- Banned user → block all comments?
- User with edit permission → can edit others' comments?

System response (Load boundaries):
- 10 comments → instant load
- 1,000 comments → paginate or lazy load?
- 1M comments → archive to separate storage?
```

### Step 3: Security Risk Mapping

```
User: What are security risks for comments?

System response (Authentication):
- Can anon user comment? If yes, verify email first
- Can user impersonate another? (Verify auth token)
- Session hijacking? (Use secure cookies)
- CSRF? (Use CSRF token on form)

System response (Authorization):
- Can user comment on private post? (Check post permissions)
- Can user edit others' comments? (Verify ownership)
- Can user delete others' comments? (Admin only)

System response (Data protection):
- Comments encrypted? (RDS encryption + TLS)
- Comments in logs? (Mask sensitive data)
- Backups secured? (Encrypted backups only)

System response (Injection):
- SQL injection? (Use parameterized queries)
- XSS? (Escape output, use CSP)
- Command injection? (No shell commands)
```

### Step 4: Performance Bottlenecks

```
User: What are performance risks for comments?

System response (Database):
- Loading comments for post with 100k comments
  → Mitigation: Paginate, fetch 20 at a time
  → Verification: Load test with 100k comments

- User lookup for each comment
  → Mitigation: Batch load users, cache user objects
  → Verification: Check query count matches (no N+1)

- Comment search by content
  → Mitigation: Full-text index, use LIKE sparingly
  → Verification: Benchmark search performance

System response (Caching):
- Cache never invalidates
  → Mitigation: TTL of 5 minutes, invalidate on new comment
  → Verification: Test cache invalidation

- Cache stampede when TTL expires
  → Mitigation: Use cache locks or probabilistic revalidation
  → Verification: Load test cache expiration

System response (API):
- Comment text huge in response (entire posts + all comments)
  → Mitigation: Separate endpoint for full comment, return excerpt
  → Verification: Monitor response size
```

### Step 5: Operational Concerns

```
User: What are operational risks for comments?

System response (Deployment):
- New comments table migration
  → Risk: ALTER TABLE locks table, blocks comments temporarily
  → Mitigation: Use online migration tool or blue-green deploy
  → Testing: Test migration on staging with production data

- Rollback needed after deploy
  → Risk: Comments created after deploy, rollback loses them
  → Mitigation: Have rollback procedure tested, maybe don't rollback data
  → Testing: Practice rollback regularly

System response (Monitoring):
- Comments creation silently fails
  → Mitigation: Log all errors, alert on error rate > 1%
  → Testing: Monitor error logs in staging

- Comment load slow (p95 > 500ms)
  → Mitigation: Alert if p95 > 500ms, page on-call
  → Testing: Baseline response time in staging

System response (Incident response):
- Comments service down
  → Mitigation: Hide comments section, show "unavailable" message
  → Testing: Kill database, verify graceful failure

- Database down completely
  → Mitigation: Fail fast (don't timeout), show message to user
  → Testing: Connection timeout test, verify user experience

- Corruption discovered (comments with wrong author)
  → Mitigation: Have consistency check query, rollback procedure
  → Testing: Data validation tests, backup restoration drill
```

## Prioritization Matrix

After identifying all risks, prioritize by impact × probability:

```
IMPACT (how bad if happens)
    ↑
    │
High│ ┌─────────────────────────────┐
    │ │  P1: Fix ASAP               │
    │ │ - Auth bypass               │
    │ │ - Data corruption           │
    │ │ - Complete outage           │
    │ ├─────────────────────────────┤
    │ │  P2: Mitigate               │
    │ │ - Comment fails silently     │
    │ │ - Slow load (but works)      │
    │ │ - Cache stale (24 hours)     │
    │ ├─────────────────────────────┤
    │ │  P3: Monitor                │
Med │ │ - Empty state UX unclear     │
    │ │ - Typo in error message      │
    │ │ - CSS broken on old browser  │
    │ └─────────────────────────────┘
Low │
    │_________________________________→ PROBABILITY
        Low         Medium        High
```

## Output: risks.md Contents

```markdown
# Risks & Edge Cases - Comments Feature

[Generated from /team.risks analysis]

## Failure Scenarios
[Table with probability, impact, mitigation, detection]

## Edge Cases
[Organized by category: data, user, load, boundaries]

## Security Risks
[Auth, data protection, injection, API security]

## Performance Risks
[Database, caching, API]

## Operational Risks
[Deployment, monitoring, incidents]

## Mitigation Checklist
- [ ] Unit tests cover edge cases
- [ ] Load test at 100k comments
- [ ] Security scan passes
- [ ] Canary deployment plan created
- [ ] Incident response documented
```

## How to Use the Output

### During Planning
- Use risks.md to inform architecture decisions
- Allocate time for mitigations
- Plan testing strategy based on risks

### During Implementation
- Reference risks when writing tests
- Implement mitigations identified
- Add test cases for each edge case

### During Testing
- Verify each risk has mitigation
- Load test to failure point
- Security test attack vectors

### During Deployment
- Use runbook from operational risks
- Monitor alerts defined in risks
- Have incident response ready

## Tips for Good Risk Analysis

1. **Be specific**: "Performance risk" is vague. "N+1 queries when loading 100k comments" is specific.
2. **Include mitigations**: Don't just list risks, also list how to handle them.
3. **Involve domain experts**: QA knows test edge cases, DevOps knows deployment risks.
4. **Think like an attacker**: What would you try to break?
5. **Consider time pressure**: Some risks only appear under load.

## Common Pitfalls

❌ **Too many risks**: If > 20 risks, you probably lumped related ones together. Consolidate.
❌ **Vague risks**: "Possible data issue" - what issue? What data?
❌ **No mitigations**: If you can't mitigate it, accept and monitor instead.
❌ **Ignored**: Risks analysis only works if you act on it.
❌ **Static**: Risks change as you learn. Update this throughout development.

## Integration with Other Commands

- **After** `/team.specify` - analyze what you're building
- **Before** `/team.review` - share with team for feedback
- **Inputs to** `/team.plan` - plan mitigations into architecture
- **Used during** `/team.tasks` - generate test tasks for risks
- **Referenced during** `/team.implement` - implement mitigations

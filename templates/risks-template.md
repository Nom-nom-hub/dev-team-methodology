# Risks & Edge Cases

## Failure Scenarios

What could go wrong? Identify key failure modes with probability and mitigation.

| Scenario | Probability | Impact | Mitigation | Detection |
|----------|-------------|--------|-----------|-----------|
| [System component fails] | Low/Med/High | [severity] | [how to prevent] | [how to detect] |
| [Example: Database becomes unreachable] | Medium | High | Replica DB ready, failover tested | Health checks every 30s |
| [Example: Third-party API rate limit exceeded] | High | Medium | Queue requests, implement backoff | Monitor API response codes |

**Questions for QA + Architect personas**:
- What are the top 3 failure modes?
- What's the mean time to recovery (MTTR) target?
- How should the system fail? (gracefully vs hard error?)
- What's unacceptable data loss?

---

## Edge Cases

Behaviors at boundaries that are easy to miss.

### Data Boundaries

- **Empty state**: What happens when there's no data? (e.g., new user, empty search results)
- **Null/undefined values**: How are missing fields handled?
- **Maximum values**: What if user provides unexpectedly large numbers?
- **Duplicate submissions**: What if user double-clicks submit?
- **Concurrent modifications**: What if two users edit same record simultaneously?
- **Data types**: What if user provides wrong type? (text instead of number)

### Load Boundaries

- **Single user**: Does system work with just one person?
- **Peak load**: What happens at 10x normal traffic?
- **Sustained load**: Can system handle peak for 24 hours?
- **Slow degradation**: What if performance degrades gradually?
- **Resource exhaustion**: What happens when memory/disk fills up?

### User Boundaries

- **First-time user**: What's the onboarding experience?
- **Returning user**: Are previous preferences preserved?
- **Inactive user**: What if user hasn't logged in for 6 months?
- **Deleted user**: What happens to their data? References?
- **Permission changes**: If user loses access, what data should they not see?

### Authorization Boundaries

- **User accessing other user's data**: Is this prevented?
- **Privilege escalation**: Can non-admin user become admin?
- **Session hijacking**: Is session replay possible?
- **Token expiration**: What happens if token expires mid-request?
- **Cross-tenant data leakage**: In multi-tenant system, data isolation enforced?

### Integration Boundaries

- **Third-party service down**: How long until system notices? What's fallback?
- **Network latency**: What if third-party service is slow?
- **Partial failures**: What if integration partially fails mid-transaction?
- **Webhook retries**: If webhook fails, is it retried? How many times?
- **Version mismatches**: What if third-party API updated unexpectedly?

### Time Boundaries

- **Timezone differences**: Are times handled correctly across timezones?
- **Daylight saving time**: Does DST transition break anything?
- **Leap seconds**: Are time calculations leap-second safe?
- **Expired data**: What happens if accessing old/archived data?
- **Clock skew**: What if server clocks are slightly out of sync?

---

## Security Risks

Potential attack vectors and vulnerabilities specific to this feature.

### Authentication & Authorization

- **Weak password requirements**: Could user choose "password" as password?
- **Session fixation**: Can attacker pre-set user session?
- **Privilege escalation**: Can unprivileged user access admin features?
- **Cross-site request forgery (CSRF)**: Can attacker trick user into unintended action?
- **Insecure direct object reference (IDOR)**: Can user access /api/user/2 if they're user/1?

### Data Protection

- **Unencrypted data in transit**: Is HTTPS enforced? TLS version?
- **Unencrypted data at rest**: Are sensitive fields encrypted in database?
- **Secrets in logs**: Could API keys appear in log files?
- **Secrets in version control**: Could someone commit AWS keys to git?
- **Backup security**: Are encrypted backups tested? Who can access?

### Input Validation

- **SQL injection**: Are all database queries parameterized?
- **Cross-site scripting (XSS)**: Are user inputs escaped before rendering?
- **Command injection**: Could user input be executed as shell command?
- **XML external entity (XXE)**: If parsing XML, are XXE attacks prevented?
- **Path traversal**: Could user access `/api/files/../../../../etc/passwd`?

### API Security

- **Rate limiting**: Can attacker hammer endpoint? Cost of attack?
- **DDoS resilience**: How much traffic can system handle?
- **API key leakage**: If key leaked, impact? Rotation process?
- **Dependency vulnerabilities**: Are dependencies scanned for known CVEs?
- **Supply chain attacks**: Could malicious code in dependency?

### Compliance & Legal

- **GDPR violations**: Is user data portable/deletable on request?
- **PCI-DSS (if handling cards)**: Are card details ever stored?
- **Data residency**: Is data stored in correct country?
- **Consent tracking**: Is user consent recorded before collecting data?
- **Audit trails**: Can changes be tracked to which user made them?

**Questions for Architect + Developer personas**:
- What's the threat model?
- What's acceptable security debt (must-fix vs can-postpone)?
- How are secrets managed? (vault, env vars, other?)
- What's the incident response plan?

---

## Performance Risks

Where performance bottlenecks could hide.

| Risk | Symptom | Verification |
|------|---------|--------------|
| **N+1 database queries** | Load test shows 10x more queries than expected | Query logging during load test |
| **Missing database indexes** | Query time degrades as data grows | EXPLAIN ANALYZE on slow queries |
| **Unbounded recursion** | Stack overflow with deep data structures | Unit test with maximum nesting |
| **Memory leaks** | Memory usage grows over time without recovery | Extended soak test (24h) with memory monitoring |
| **Cache invalidation failures** | Stale data served after updates | Test cache behavior after mutations |
| **Blocking I/O in hot path** | Response time degrades with more users | Load test with simultaneous requests |
| **Unnecessary string concatenation loops** | String building in tight loop is slow | Benchmark before/after optimization |
| **Synchronous external API calls** | Response time = internal + external latency | Move to async or queue |

**Questions for Architect + Developer personas**:
- What's the single biggest performance risk?
- What's your caching strategy?
- Are there any synchronous calls that should be async?
- How will you detect performance regressions?

---

## Operational Risks

Deployment, monitoring, and runtime surprises.

| Risk | Consequence | Mitigation |
|------|-------------|-----------|
| **Deployment failure** | Service down, data inconsistent | Blue-green deployment, rollback tested |
| **Database migration failure** | Data lost or corrupted | Migration tested on production-like data |
| **Missing monitoring** | Issues in production not detected | Monitoring setup before launch |
| **Incomplete runbooks** | On-call engineer can't respond | Runbooks reviewed, tested, and drilled |
| **No rollback plan** | Bad deployment can't be undone | Rollback procedure documented and tested |
| **Configuration drift** | Production environment doesn't match expectations | Infrastructure-as-code, validated on deploy |
| **Insufficient alerting** | Critical issues go unnoticed for hours | Alert thresholds set based on SLAs |
| **No incident response plan** | Team confused during outage | Incident severity levels and escalation defined |

**Questions for DevOps + Architect personas**:
- How is production monitored?
- What's the on-call rotation and escalation?
- How is rollback tested?
- What metrics indicate the system is healthy?

---

## Risk Prioritization Matrix

After listing all risks, prioritize by impact × probability:

```
High Impact + High Probability → Fix immediately
High Impact + Low Probability  → Mitigate/Plan
Low Impact  + High Probability → Monitor
Low Impact  + Low Probability  → Accept/Watch
```

**Example**:
- Authentication bypass (High Impact, High Prob) → MUST FIX before launch
- Database corruption (High Impact, Low Prob) → Implement backups and recovery plan
- Slow dashboard (Medium Impact, Medium Prob) → Optimize after launch if needed
- Typo in error message (Low Impact, Medium Prob) → Fix in next release

---

## Validation Strategy

How will you verify these risks are mitigated?

- [ ] **Security review**: Penetration test or security scan
- [ ] **Load test**: Verify performance at 10x normal load
- [ ] **Chaos test**: Kill database, service, etc. and verify recovery
- [ ] **Data consistency test**: Concurrent operations don't corrupt data
- [ ] **Accessibility test**: Screen reader works, keyboard navigation works
- [ ] **Integration test**: Third-party service failures handled gracefully
- [ ] **Canary deployment**: Roll out to 5% of users first
- [ ] **Incident response drill**: Practice responding to failures

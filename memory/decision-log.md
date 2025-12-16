# Decision Log

Running log of all architectural decisions made for this project. Each decision has an ADR (Architectural Decision Record) in `docs/adr/`.

---

## Format

Each decision entry includes:
- **Date**: When decision was made
- **ADR**: Reference to ADR file (e.g., ADR-001)
- **Decided by**: Team personas involved
- **Decision**: What was decided
- **Rationale**: Why this decision
- **Alternatives rejected**: What wasn't chosen and why
- **Status**: Accepted, Pending, Blocked, Superseded

---

## Decision Log Entries

### [Date] - [Decision Title]

**ADR**: ADR-NNN
**Decided by**: [Personas: Architect, Developer, DevOps]
**Decision**: [What was decided]
**Rationale**: [Why this decision]
**Alternatives rejected**:
- Alternative A: [Rejected because...]
- Alternative B: [Rejected because...]
**Status**: Accepted | Pending | Blocked | Superseded

---

## Example Entries (Delete these)

### 2024-01-15 - API Design: REST vs GraphQL

**ADR**: ADR-001
**Decided by**: Architect, Developer, QA
**Decision**: Use REST API for all public endpoints
**Rationale**: 
- Team has strong REST experience
- Simpler to implement and test
- GraphQL complexity not justified for initial scope
- Better caching strategies available with REST
**Alternatives rejected**:
- GraphQL: Rejected because team needs ramp-up time, adds complexity, caching harder
- gRPC: Rejected because not web-friendly, internal-only use case
**Status**: Accepted

---

### 2024-01-20 - Database: PostgreSQL vs MongoDB

**ADR**: ADR-002
**Decided by**: Architect, Developer, DevOps
**Decision**: PostgreSQL 15 as primary relational database
**Rationale**:
- Data is highly relational (users, posts, comments)
- Need ACID transactions for data consistency
- PostgreSQL proven in production at scale
- Team expertise strong in SQL
- Cost predictable
**Alternatives rejected**:
- MongoDB: Rejected because data is relational, ACID required, schema validation important
- DynamoDB: Rejected because cost would be higher for query patterns, less flexible
**Status**: Accepted

---

### 2024-01-22 - Caching: Redis vs Memcached

**ADR**: ADR-003
**Decided by**: Architect, DevOps
**Decision**: Redis for all caching and session storage
**Rationale**:
- Redis supports complex data structures (lists, sets, hashes)
- Better eviction policies
- Pub/sub for cache invalidation
- Team experience with Redis
- Single namespace (simpler operations)
**Alternatives rejected**:
- Memcached: Rejected because lacks advanced features, no pub/sub
**Status**: Accepted

---

### 2024-01-25 - Authentication: JWT vs Session Cookies

**ADR**: ADR-004
**Decided by**: Architect, Developer, Security
**Decision**: JWT tokens in HttpOnly cookies (hybrid approach)
**Rationale**:
- JWT allows stateless API scaling
- HttpOnly prevents JavaScript access (XSS mitigation)
- Cookies easier for browser-based clients
- Can support both cookie and header-based auth
**Alternatives rejected**:
- Pure session cookies: Works but requires server-side state
- JWT in localStorage: Security risk (XSS vulnerability)
- Custom token scheme: Reinventing the wheel
**Status**: Accepted

---

### 2024-02-01 - Infrastructure: Kubernetes vs Docker Compose

**ADR**: ADR-005
**Decided by**: Architect, DevOps
**Decision**: Kubernetes on AWS EKS for production, Docker Compose for development
**Rationale**:
- Kubernetes provides high availability and scaling
- Managed service (EKS) reduces ops burden
- Team learning to use K8s (investment in future)
- Supports our scaling targets (10k concurrent users)
**Alternatives rejected**:
- Docker Compose: Only for dev, not production-ready
- Raw EC2: More ops overhead, harder to scale
- Serverless: Not suitable for always-on API
**Status**: Accepted

---

### 2024-02-05 - Secrets Management: AWS Secrets Manager vs HashiCorp Vault

**ADR**: ADR-006
**Decided by**: Architect, DevOps, Security
**Decision**: AWS Secrets Manager with 90-day rotation
**Rationale**:
- Integrated with AWS (no additional tool)
- Automatic rotation available
- Audit logging built-in
- Managed service (less ops overhead)
- Cost lower than self-hosted Vault
**Alternatives rejected**:
- HashiCorp Vault: Powerful but requires team to operate it
- Environment variables: Not secure enough for production
- Hard-coded: Security risk
**Status**: Accepted

---

### 2024-02-10 - Monitoring: Prometheus+Grafana vs Datadog

**ADR**: ADR-007
**Decided by**: Architect, DevOps
**Decision**: Prometheus + Grafana (open source) for metrics, ELK Stack for logs
**Rationale**:
- Cost effective (free open source)
- Full control over data
- Strong community and documentation
- Good Kubernetes integration
- Can scale to our needs
**Alternatives rejected**:
- Datadog: Powerful but expensive ($3000+/month)
- New Relic: Similar cost concerns
- CloudWatch alone: Less flexible, harder to customize
**Status**: Accepted

---

### 2024-02-12 - Testing: Jest vs Mocha for JavaScript

**ADR**: ADR-008
**Decided by**: Developer, QA
**Decision**: Jest for all JavaScript testing (unit + integration)
**Rationale**:
- Zero-config setup saves time
- Built-in code coverage
- Parallel test execution (faster)
- Snapshot testing useful for UI
- Single tool instead of multiple
**Alternatives rejected**:
- Mocha: More flexible but requires setup, no coverage built-in
- Vitest: Newer but less mature, team less familiar
**Status**: Accepted

---

## Template for New Decisions

When you make a new decision, add it to this log:

```
### [YYYY-MM-DD] - [Decision Title]

**ADR**: ADR-NNN
**Decided by**: [Personas: list]
**Decision**: [What was decided?]
**Rationale**: [Why?]
- Point 1
- Point 2
- Point 3

**Alternatives rejected**:
- [Alt A]: [Why rejected]
- [Alt B]: [Why rejected]

**Status**: Accepted | Pending | Blocked | Superseded
```

---

## Reviewing Decisions

### Accepted Decisions
- Live, being used
- Update ADR if learnings suggest changes
- Reference in future similar decisions

### Pending Decisions
- Awaiting implementation or final decision
- Review on [target date]
- May be blocked by other decisions

### Blocked Decisions
- Can't proceed due to blocker
- What's blocking? [Dependency X]
- Expected unblock date: [date]
- Who's working on unblocking? [Owner]

### Superseded Decisions
- Replaced by newer decision
- What replaced it? [ADR-NNN]
- When was it superseded? [date]
- Why? [Reason]

---

## Statistics

- **Total decisions**: [Count]
- **Accepted**: [Count]
- **Pending**: [Count]
- **Superseded**: [Count]
- **Average decision age**: [Days]

---

## Decision Patterns

Are there patterns in your decisions?

- **Technology choices**: Preference for [language/framework/tool]?
- **Build vs buy**: Trend towards building or buying?
- **Complexity**: Are decisions getting simpler or more complex?
- **Reversibility**: Are decisions easily reversible or permanent?

---

## Next Review

When to review this decision log:
- [ ] Monthly: Any pending decisions needing closure?
- [ ] Quarterly: Any superseded decisions to clean up?
- [ ] Before new features: Reference similar past decisions

# Constraints & Assumptions

Use this document to capture all constraints and assumptions upfront. This prevents
rework later when constraints are discovered mid-implementation.

---

## Technology Constraints

### Language & Framework

- **Required languages**: [e.g., "Must use Python 3.11+"]
- **Banned languages**: [e.g., "No PHP"]
- **Required frameworks**: [e.g., "Must use FastAPI or Django"]
- **Banned frameworks**: [e.g., "No Electron apps, web-only"]
- **Version constraints**: [e.g., "Node.js 18.x or 20.x only"]
- **Reason for constraints**: [Why these constraints? Who decided?]

### Database

- **Allowed databases**: [e.g., "PostgreSQL 13+ or MySQL 8.0+"]
- **Banned databases**: [e.g., "No MongoDB (compliance requirement)"]
- **Database location**: [e.g., "Must be US-based"]
- **Migration tool requirements**: [e.g., "Must use Alembic for migrations"]

### Infrastructure & Deployment

- **Required cloud provider**: [e.g., "AWS only (corporate agreement)"]
- **Banned providers**: [e.g., "No DigitalOcean (lack of compliance)"]
- **Container requirement**: [e.g., "Must be Docker-based"]
- **Orchestration**: [e.g., "Kubernetes on EKS"]
- **Serverless vs traditional**: [e.g., "No serverless (cost predictability)"]

### Libraries & Dependencies

- **Forbidden libraries**: [List with reasons]
  - [e.g., "No jQuery (maintenance burden, use vanilla JS)"]
  - [e.g., "No axios (prefer fetch or httpx)"]
- **Preferred libraries**: [List with reasons]
  - [e.g., "Prefer requests over httpx for Python"]
- **License constraints**: [e.g., "No GPL (corporate policy), Apache 2.0 or MIT only"]

---

## Legal & Compliance Constraints

### Data Residency

- **Data location requirements**: [e.g., "EU data must stay in EU (GDPR)"]
- **Backup location**: [e.g., "Backups must be in same region"]
- **Disaster recovery requirements**: [e.g., "Must be recoverable from different country"]

### Industry Standards & Certifications

- **GDPR compliance** (EU personal data): [Required? Relevant features?]
- **HIPAA** (healthcare): [Required? Data encryption, audit logging needed?]
- **PCI-DSS** (payment cards): [Required? No storing card data?]
- **SOC 2 Type II**: [Required? Auditing, monitoring needed?]
- **CCPA** (California privacy): [Required? Consumer data rights?]
- **FedRAMP** (US Government): [Required? Additional security?]
- **Other standards**: [ISO 27001, NIST, etc.]

### Data Handling

- **Right to be forgotten**: [Required? (GDPR) Must delete user data on request]
- **Data portability**: [Required? User can export data in standard format?]
- **Consent management**: [Required? Track explicit consent before collecting data?]
- **Retention policy**: [How long keep data after user leaves?]
- **PII handling**: [What's considered personally identifiable? Special handling?]

### Open Source & Licensing

- **Acceptable licenses**: [e.g., "MIT, Apache 2.0, BSD only"]
- **Forbidden licenses**: [e.g., "No GPL, AGPL, SSPL"]
- **License audit requirement**: [Required before shipping? By whom?]
- **Contribution guidelines**: [Can we use GPL library if we contribute back?]

---

## Cost Constraints

### Infrastructure Budget

- **Monthly infrastructure budget**: [e.g., "$5,000/month"]
- **Cost per user limit**: [e.g., "< $0.01 per user"]
- **Annual budget cap**: [e.g., "$60,000/year max"]
- **Cost monitoring requirement**: [Who tracks? Alerts if exceeding?]

### Third-Party Services

- **Total third-party budget**: [e.g., "$2,000/month"]
- **Allowed services**: [e.g., "Stripe, SendGrid, Datadog approved"]
- **Banned services**: [e.g., "No expensive monitoring tool, use Prometheus"]

### Development & Team

- **Development time budget**: [e.g., "8 weeks, 2 engineers"]
- **Effort estimate constraints**: [Must fit in 500 engineering hours?]
- **License cost constraints**: [e.g., "All tools must be free or < $100/month"]

### Optimization Requirements

- **Cost optimization target**: [e.g., "Must be cheaper than current solution by 30%"]
- **Acceptable tech debt for cost**: [e.g., "Can use serverless even if harder to debug?"]

---

## Timeline Constraints

### Hard Deadlines

- **MVP deadline**: [e.g., "Q2 2024 by June 30"]
- **Feature complete deadline**: [e.g., "Full feature by July 31"]
- **Production launch deadline**: [Hard date or flexible?]

### Dependency Constraints

- **Must complete after**: [e.g., "Can't start until database migration (Task X) done"]
- **Blocking on external team**: [e.g., "Waiting for design team to deliver mockups"]
- **Prerequisite features**: [e.g., "Authentication system must be in place first"]

### Phasing

- **Phase 1 (MVP)**: [What's included? Rough scope]
- **Phase 2**: [What's deferred? When?]
- **Phase 3**: [Advanced features, when?]

---

## Team & Resource Constraints

### Team Composition

- **Team size**: [e.g., "2 engineers, 1 designer"]
- **Dedicated vs shared**: [Full-time or part-time on this feature?]
- **Roles needed**: [Designer, DevOps, QA, etc.]
- **Time zone constraints**: [All distributed? Any timezone overlap needed?]

### Skill Gaps

- **What team doesn't know**: [e.g., "No K8s experience"]
- **Training budget**: [Budget to train on new tech?]
- **Hiring required**: [Need to hire? How many? By when?]
- **External consultants**: [Budget for expert contractor?]

### Knowledge Dependencies

- **Key person risk**: [Anyone without backup knowledge?]
- **Documentation requirements**: [Because of knowledge gaps?]
- **Mentoring plan**: [How to transfer knowledge?]

---

## Integration Constraints

### Third-Party APIs

- **Required APIs**: [e.g., "Must integrate with Stripe"]
- **SLA requirements**: [99.9% uptime OK? Or need higher?]
- **Rate limit constraints**: [API limits requests/sec? Factor in?]
- **Authentication**: [API keys? OAuth? Limitations?]

### Legacy System Compatibility

- **Must work with existing system**: [How integrated?]
- **Data migration from old system**: [Must import existing data?]
- **API compatibility**: [Must match old API for backward compatibility?]

### Single Sign-On (SSO)

- **Required SSO provider**: [e.g., "Must use Okta"]
- **Fallback authentication**: [If SSO unavailable?]
- **User provisioning**: [Automatic sync from Okta?]

---

## Platform & Device Constraints

### Mobile vs Web

- **Mobile required**: [Native? React Native? Web?]
- **Desktop required**: [Windows? Mac? Linux?]
- **Web-only acceptable**: [Or must have native?]

### Browser Support

- **Minimum browser versions**: [e.g., "Chrome 90+, Firefox 88+, Safari 14+"]
- **Internet Explorer support**: [Required? (probably not)]
- **Modern browser features OK**: [Can use WebAssembly, Web Workers, etc.?]

### Device Constraints

- **Minimum screen size**: [Mobile: 320px? Tablet: 768px?]
- **Touch vs mouse**: [Mobile-first? Mouse-only OK?]
- **Network**: [Must work on 3G? Offline capability?]
- **Storage**: [App size limit? (mobile app))]

---

## Assumptions

What are we assuming to be true? If wrong, what's the impact?

| Assumption | Impact if Wrong | How to Validate |
|-----------|-----------------|-----------------|
| [e.g., "< 1TB data in year 1"] | [Scaling architecture might break] | [Monitor data growth, test at 5TB] |
| [e.g., "< 1000 concurrent users"] | [Performance targets missed] | [Load test with 10000 users] |
| [e.g., "Third-party API 99.9% uptime"] | [Application can't meet its SLA] | [Review SLA docs, test failure mode] |
| [e.g., "Team has Python experience"] | [Schedule slips, code quality suffers] | [Team assessment, training planned] |

### Monitoring Assumptions

For each critical assumption, define:
- **Metric to track**: How do we measure?
- **Alert threshold**: When do we need to act?
- **Review frequency**: How often do we check?
- **Remediation plan**: What if assumption breaks?

---

## Constraint Conflicts & Decisions

List any conflicting constraints and how you resolved them.

| Conflict | Options | Decision | Reason |
|----------|---------|----------|--------|
| [e.g., "Cost < $5k/mo vs high availability"] | [Cheaper: single region, Higher cost: multi-region] | [Multi-region] | [SLA requirement wins] |

---

## Checklist

Before moving to planning, verify:

- [ ] Technology constraints documented and agreed
- [ ] Compliance requirements understood and feasible
- [ ] Cost constraints realistic and tracked
- [ ] Timeline constraints achievable
- [ ] Team skills align with constraints (or training planned)
- [ ] Third-party dependencies identified and SLAs known
- [ ] Critical assumptions identified and monitoring in place
- [ ] Conflicts resolved and documented
- [ ] No hidden constraints that will emerge mid-implementation

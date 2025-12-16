# Team Implementation Plan: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Spec**: [link] **Input**: Feature specification from
`/specs/[###-feature-name]/spec.md`

**Note**: This template is filled in by the `/team.plan` command. See `.team/templates/commands/plan.md` for the
execution workflow.

## Summary

[Extract from feature spec: primary requirement + technical approach from research]

## Team Technical Context

**Language/Version**: [e.g., Python 3.11, Swift 5.9, Rust 1.75 or NEEDS CLARIFICATION] **Primary Dependencies**: \[e.g.,
FastAPI, UIKit, LLVM or NEEDS CLARIFICATION\] **Storage**: [if applicable, e.g., PostgreSQL, CoreData, files or N/A]
**Testing**: [e.g., pytest, XCTest, cargo test or NEEDS CLARIFICATION] **Target Platform**: \[e.g., Linux server, iOS
15+, WASM or NEEDS CLARIFICATION\] **Project Type**: [single/web/mobile - determines source structure] **Performance
Goals**: [domain-specific, e.g., 1000 req/s, 10k lines/sec, 60 fps or NEEDS CLARIFICATION] **Constraints**:
[domain-specific, e.g., \<200ms p95, \<100MB memory, offline-capable or NEEDS CLARIFICATION] **Scale/Scope**:
[domain-specific, e.g., 10k users, 1M LOC, 50 screens or NEEDS CLARIFICATION]

## Team Persona Input Summary

### Product Manager Input

- **Technical Decision Impact**: [How PM influences technical decisions]
- **Success Metrics Alignment**: [How technical approach aligns with PM's success metrics]
- **Risk Considerations**: [PM's perspective on technical risks]

### Technical Architect Input

- **Architecture Decisions**: [Technical architecture decisions made]
- **Feasibility Validation**: [How technical feasibility was validated]
- **Constraints Definition**: [Technical constraints defined]

### UX Designer Input

- **User Experience Implementation**: [How UX requirements are implemented]
- **Design System Integration**: [How design system is integrated]
- **Accessibility Implementation**: [How accessibility is ensured]

### Quality Assurance Input

- **Testing Strategy**: [Testing approach defined]
- **Quality Gates**: [Quality checkpoints defined]
- **Risk Assessment**: [Quality risks identified]

### Developer Input

- **Implementation Approach**: [Development approach defined]
- **Code Quality Standards**: [Code quality requirements defined]
- **Performance Considerations**: [Performance optimizations planned]

### DevOps Input

- **Deployment Strategy**: [Deployment approach defined]
- **Infrastructure Needs**: [Infrastructure requirements defined]
- **Operational Considerations**: [Operational requirements defined]

---

## Architecture Specification *(new)*

<!--
   ACTION REQUIRED: Define the system architecture in detail.
   See templates/architecture-spec-template.md for detailed guidance.
-->

### System Components

| Component | Responsibility | Technology |
|-----------|-----------------|-----------|
| [API Gateway] | [Route requests, auth] | [nginx, AWS ALB] |
| [Database] | [Persistent storage] | [PostgreSQL 15] |
| [Cache] | [Performance optimization] | [Redis 7] |

### Component Interactions

- [Client sends request to API Gateway]
- [API Gateway routes to appropriate service]
- [Service queries Database or Cache]
- [Response returned to Client]

### Database Schema

- **[Table 1]**: [Columns: id, name, created_at]
- **[Table 2]**: [Columns: id, user_id, content]
- **Indexes**: [What's indexed and why]

### API Contracts

- **GET /api/[resource]**: [Returns list of resources]
- **POST /api/[resource]**: [Creates new resource]
- **Response format**: [JSON schema or example]

### Configuration Management

- **Environment variables**: [DATABASE_URL, API_KEY, etc.]
- **Feature flags**: [Flags for gradual rollout]
- **Secrets**: [Stored in Secrets Manager]

### Deployment Architecture

- **Containerization**: [Docker images, registries]
- **Orchestration**: [Kubernetes clusters, replicas]
- **Load balancing**: [How traffic is distributed]
- **Scaling**: [Auto-scaling policies]

---

## Performance Budget *(new)*

<!--
   ACTION REQUIRED: Define performance targets and budgets.
   See templates/performance-budget-template.md for detailed guidance.
-->

### Response Time Targets

| Endpoint | p95 | p99 | Rationale |
|----------|-----|-----|-----------|
| [GET /api/users/{id}] | [50ms] | [200ms] | [Simple lookup] |
| [GET /api/posts] | [150ms] | [500ms] | [List endpoint] |
| [POST /api/posts] | [300ms] | [1000ms] | [Create operation] |

### Throughput & Load

- **Normal load**: [1000 concurrent users, 500 req/sec]
- **Peak load**: [10,000 concurrent, 5000 req/sec]
- **Sustained load**: [5000 concurrent for 24 hours]

### Caching Strategy

- **User profiles**: [Cache 1 hour, invalidate on update]
- **Post lists**: [Cache 5 minutes, invalidate on new post]
- **Cache hit target**: [80%+ hit rate]

### Load Testing

- **Tool**: [k6, JMeter, or Locust]
- **Scenarios**: [Ramp-up, spike, sustained load]
- **Acceptance criteria**: [p95 < 200ms, error rate < 0.1%]

---

## Security Hardening Plan *(new)*

<!--
   ACTION REQUIRED: Define security approach in detail.
   See templates/security-plan-template.md for detailed guidance.
-->

### Authentication & Authorization

- **Method**: [JWT, OAuth2, session cookies]
- **Token expiration**: [15 min access, 7 day refresh]
- **Roles**: [Admin, User, Guest]
- **Per-role permissions**: [What each role can do]

### Data Protection

- **Encryption in transit**: [TLS 1.2+]
- **Encryption at rest**: [AES-256]
- **Secrets management**: [AWS Secrets Manager]
- **Key rotation**: [Every 90 days]

### Input Validation & Sanitization

- **SQL injection prevention**: [Parameterized queries]
- **XSS prevention**: [Input escaping, CSP headers]
- **CSRF prevention**: [CSRF tokens]
- **Rate limiting**: [5 failed logins per 15 min]

### Compliance & Auditing

- **Standards**: [GDPR, HIPAA, SOC2, PCI-DSS - if applicable]
- **Audit logging**: [What events logged and retained]
- **Data retention**: [How long to keep data]
- **Right to be forgotten**: [Process to delete user data]

### Vulnerability Management

- **SAST scanning**: [SonarQube, Snyk on every commit]
- **Dependency scanning**: [npm audit, pip audit]
- **Penetration testing**: [Before launch]
- **Incident response**: [Notification procedure, SLA]

---

## Testing Strategy *(new)*

<!--
   ACTION REQUIRED: Define comprehensive testing approach.
   See templates/testing-strategy-template.md for detailed guidance.
-->

### Unit Tests

- **Coverage target**: [80%+ of code]
- **Framework**: [Jest, pytest, etc.]
- **Critical paths**: [List functions that must have tests]

### Integration Tests

- **Scenarios**: [Component interactions, API calls]
- **Database**: [Use test database with fixtures]
- **Coverage**: [All APIs tested]

### End-to-End Tests

- **Critical journeys**: [User signup, login, create post]
- **Tool**: [Cypress, Playwright, or Selenium]
- **Browser coverage**: [Chrome, Firefox, Safari]
- **Mobile testing**: [Responsive design on mobile]

### Performance Testing

- **Load test scenarios**: [Normal, spike, sustained]
- **Tool**: [k6]
- **Acceptance criteria**: [p95 < 200ms, error rate < 0.1%]
- **Baseline**: [Compare against previous releases]

### Security Testing

- **Static analysis**: [SonarQube, Snyk]
- **Dynamic analysis**: [OWASP ZAP]
- **Penetration testing**: [Before launch]
- **Dependency scanning**: [Every commit]

### Accessibility Testing

- **Standards**: [WCAG 2.1 Level AA]
- **Automated**: [Axe, Lighthouse]
- **Manual**: [Keyboard navigation, screen readers]

### Regression Testing

- **Suite**: [Unit + integration + E2E critical tests]
- **Execution**: [On every commit, nightly full suite]
- **Coverage**: [All features touched by change]

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

[Gates determined based on constitution file]

## Project Structure

### Documentation (this feature)

```text
specs/[###-feature]/
├── plan.md              # This file (/team.plan command output)
├── research.md          # Phase 0 output (/team.plan command)
├── data-model.md        # Phase 1 output (/team.plan command)
├── quickstart.md        # Phase 1 output (/team.plan command)
├── contracts/           # Phase 1 output (/team.plan command)
├── personas/            # Team persona perspectives (/team.plan command)
├── checklists/          # Team validation checklists (/team.plan command)
└── tasks.md             # Phase 2 output (/team.tasks command - NOT created by /team.plan)
```

### Source Code (repository root)

```text
# [REMOVE IF UNUSED] Option 1: Single project (DEFAULT)
src/
├── models/
├── services/
├── cli/
└── lib/

tests/
├── contract/
├── integration/
└── unit/

# [REMOVE IF UNUSED] Option 2: Web application (when "frontend" + "backend" detected)
backend/
├── src/
│   ├── models/
│   ├── services/
│   └── api/
└── tests/

frontend/
├── src/
│   ├── components/
│   ├── pages/
│   └── services/
└── tests/

# [REMOVE IF UNUSED] Option 3: Mobile + API (when "iOS/Android" detected)
api/
└── [same as backend above]

ios/ or android/
└── [platform-specific structure: feature modules, UI flows, platform tests]
```

**Structure Decision**: [Document the selected structure and reference the real directories captured above]

## Team Implementation Phases

### Phase 0: Research

- **Research Lead**: [Team member responsible]
- **Deliverables**: research.md
- **Team Involvement**: [Which team members contribute to research]

### Phase 1: Design

- **Design Lead**: [Team member responsible]
- **Deliverables**: data-model.md, quickstart.md, contracts/, personas/, checklists/
- **Team Involvement**: [Which team members contribute to design]

### Phase 2: Implementation Planning

- **Implementation Lead**: [Team member responsible]
- **Deliverables**: tasks.md
- **Team Involvement**: [Which team members contribute to task planning]

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation                  | Why Needed         | Simpler Alternative Rejected Because | Team Validation                             |
| -------------------------- | ------------------ | ------------------------------------ | ------------------------------------------- |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        | [Team perspective on why this is justified] |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  | [Team perspective on why this is justified] |

## Team Risk Assessment

### Product Manager Risks

- [Business risks identified by PM]

### Technical Architect Risks

- [Technical risks identified by Architect]

### UX Designer Risks

- [UX/UI risks identified by UX Designer]

### Quality Assurance Risks

- [Quality risks identified by QA]

### Developer Risks

- [Implementation risks identified by Developer]

### DevOps Risks

- [Operational risks identified by DevOps]

## Team Success Criteria

### Technical Success Metrics

- [Metrics for technical success]

### Team Collaboration Success Metrics

- [Metrics for team collaboration success]

### Delivery Success Metrics

- [Metrics for delivery success]

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

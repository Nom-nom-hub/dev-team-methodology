# Team Feature Specification: [FEATURE NAME]

**Feature Branch**: `[###-feature-name]` **Created**: [DATE] **Status**: Draft **Input**: User description: "$ARGUMENTS"

## Team Persona Input Summary

### Product Manager Perspective

**User Value**: [PM_USER_VALUE] **Success Metrics**: [PM_SUCCESS_METRICS] **Business Justification**:
[PM_BUSINESS_JUSTIFICATION] **Key Considerations**: [PM_CONSIDERATIONS]

### Technical Architect Perspective

**Feasibility Assessment**: [ARCH_FEASIBILITY] **Technical Constraints**: [ARCH_CONSTRAINTS] **Architecture Patterns**:
[ARCH_PATTERNS] **Key Considerations**: [ARCH_CONSIDERATIONS]

### UX Designer Perspective

**User Experience Goals**: [UX_GOALS] **Accessibility Requirements**: [UX_ACCESSIBILITY] **Design Constraints**:
[UX_CONSTRAINTS] **Key Considerations**: [UX_CONSIDERATIONS]

### Quality Assurance Perspective

**Quality Metrics**: [QA_METRICS] **Testing Requirements**: [QA_TESTING] **Risk Assessment**: [QA_RISKS] **Key
Considerations**: [QA_CONSIDERATIONS]

### Developer Perspective

**Implementation Complexity**: [DEV_COMPLEXITY] **Technical Approach**: [DEV_APPROACH] **Code Quality Requirements**:
[DEV_QUALITY] **Key Considerations**: [DEV_CONSIDERATIONS]

### DevOps Perspective

**Deployment Requirements**: [DEVOPS_DEPLOYMENT] **Infrastructure Needs**: [DEVOPS_INFRA] **Operational
Considerations**: [DEVOPS_OPERATIONAL] **Key Considerations**: [DEVOPS_CONSIDERATIONS]

## User Scenarios & Testing *(mandatory)*

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.

  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - [Brief Title] (Priority: P1)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: \[Describe how this can be tested independently - e.g., "Can be fully tested by [specific action]
and delivers [specific value]"\]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]
1. **Given** [initial state], **When** [action], **Then** [expected outcome]

**Team Validation**:

- **Product Manager**: [Validate business value alignment]
- **Technical Architect**: [Validate technical feasibility]
- **UX Designer**: [Validate user experience]
- **Quality Assurance**: [Validate testability]
- **Developer**: [Validate implementation approach]
- **DevOps**: [Validate deployment requirements]

####

### User Story 2 - [Brief Title] (Priority: P2)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]

**Team Validation**:

- **Product Manager**: [Validate business value alignment]
- **Technical Architect**: [Validate technical feasibility]
- **UX Designer**: [Validate user experience]
- **Quality Assurance**: [Validate testability]
- **Developer**: [Validate implementation approach]
- **DevOps**: [Validate deployment requirements]

####

### User Story 3 - [Brief Title] (Priority: P3)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]

**Team Validation**:

- **Product Manager**: [Validate business value alignment]
- **Technical Architect**: [Validate technical feasibility]
- **UX Designer**: [Validate user experience]
- **Quality Assurance**: [Validate testability]
- **Developer**: [Validate implementation approach]
- **DevOps**: [Validate deployment requirements]

####

[Add more user stories as needed, each with an assigned priority]

### Edge Cases

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right edge cases.
  Include team perspectives on edge cases.
-->

- What happens when [boundary condition]⚡ **[Team Perspective]**
- How does system handle [error scenario]⚡ **[Team Perspective]**
- What if [failure condition]⚡ **[Team Perspective]**

## Requirements *(mandatory)*

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right functional requirements.
  Include team perspectives on each requirement.
-->

### Functional Requirements

- **FR-001**: System MUST [specific capability, e.g., "allow users to create accounts"] **[Team Validation]**
- **FR-002**: System MUST [specific capability, e.g., "validate email addresses"] **[Team Validation]**
- **FR-003**: Users MUST be able to [key interaction, e.g., "reset their password"] **[Team Validation]**
- **FR-004**: System MUST [data requirement, e.g., "persist user preferences"] **[Team Validation]**
- **FR-005**: System MUST [behavior, e.g., "log all security events"] **[Team Validation]**

*Example of marking unclear requirements:*

- **FR-006**: System MUST authenticate users via \[NEEDS CLARIFICATION: auth method not specified - email/password, SSO,
  OAuth?\] **[Team Perspective Needed]**
- **FR-007**: System MUST retain user data for [NEEDS CLARIFICATION: retention period not specified] **\[Team
  Perspective Needed\]**

### Key Entities *(include if feature involves data)*

- **[Entity 1]**: [What it represents, key attributes without implementation] **[Team Validation]**
- **[Entity 2]**: [What it represents, relationships to other entities] **[Team Validation]**

## Non-Functional Requirements *(new)*

<!--
   ACTION REQUIRED: Define non-functional requirements.
   These describe how the system should behave (performance, scalability, security, accessibility).
   See templates/nfr-template.md for detailed guidance.
-->

### Performance & Scalability

- **Response time targets**: [e.g., API p95 < 200ms, page load < 1s]
- **Throughput targets**: [e.g., 1000 requests/sec, 1000 concurrent users]
- **Scalability ceiling**: [e.g., must scale to 10,000 concurrent users]

### Security & Compliance

- **Data encryption**: [in transit and at rest requirements]
- **Authentication**: [OAuth2, JWT, SAML, or other method]
- **Compliance**: [GDPR, HIPAA, SOC2, PCI-DSS, or others]

### Accessibility & Usability

- **WCAG compliance level**: [A, AA, or AAA]
- **Browser support**: [List minimum versions]
- **Mobile responsiveness**: [Yes/No, which devices]

### Reliability & Availability

- **Target uptime**: [e.g., 99.9%, 99.99%]
- **Recovery time objective (RTO)**: [e.g., < 1 hour]
- **Recovery point objective (RPO)**: [e.g., < 5 minutes]

---

## Risks & Edge Cases *(new)*

<!--
   ACTION REQUIRED: Identify failure scenarios, edge cases, and risks.
   See templates/risks-template.md for detailed guidance.
-->

### Failure Scenarios

- **Scenario 1**: [What fails, probability, impact, mitigation]
- **Scenario 2**: [e.g., "Database down: Probability High, Impact High, Mitigation: Replica ready"]

### Edge Cases

- **Empty state**: [e.g., "No data yet - show helpful message"]
- **Max load**: [e.g., "1000+ concurrent users - paginate results"]
- **Boundary conditions**: [e.g., "Very long input - truncate gracefully"]

### Security Risks

- **Authentication bypass**: [Mitigation: Use parameterized queries, validate inputs]
- **Data exposure**: [Mitigation: Encrypt at rest and in transit]
- **Injection attacks**: [Mitigation: Validate and sanitize all inputs]

### Performance Risks

- **N+1 queries**: [Load test with 100k records to verify]
- **Memory leaks**: [Monitor memory over 24-hour soak test]
- **Cache invalidation**: [Define cache TTLs and invalidation strategy]

---

## Constraints & Assumptions *(new)*

<!--
   ACTION REQUIRED: Document all constraints and assumptions.
   See templates/constraints-template.md for detailed guidance.
-->

### Technology Constraints

- **Allowed technologies**: [e.g., Python 3.11+, PostgreSQL, React 18+]
- **Forbidden technologies**: [e.g., No PHP, No Internet Explorer support]
- **Database requirements**: [e.g., PostgreSQL only, not MongoDB]

### Legal & Compliance

- **Data residency**: [e.g., EU data must stay in EU per GDPR]
- **Industry standards**: [e.g., PCI-DSS if handling cards]
- **Data retention**: [e.g., Delete after 30 days of inactivity]

### Cost Constraints

- **Infrastructure budget**: [e.g., < $5000/month]
- **Third-party services**: [e.g., < $2000/month total]

### Timeline & Team

- **Hard deadline**: [e.g., Q2 2024 by June 30]
- **Team size**: [e.g., 2 engineers, 1 designer]
- **Skill gaps**: [e.g., No K8s experience]

### Key Assumptions

- **Assumption 1**: [e.g., "< 1TB data in year 1"]
  - Impact if wrong: [e.g., "Scaling architecture might break"]
  - Monitoring: [e.g., "Alert if data > 500GB"]

- **Assumption 2**: [e.g., "Third-party API 99.9% uptime"]
  - Impact if wrong: [e.g., "Can't meet our SLA"]
  - Monitoring: [e.g., "Track API uptime weekly"]

---

## Success Criteria *(mandatory)*

<!--
   ACTION REQUIRED: Define measurable success criteria.
   These must be technology-agnostic and measurable.
   Include team perspectives on success criteria.
-->

### Measurable Outcomes

- **SC-001**: [Measurable metric, e.g., "Users can complete account creation in under 2 minutes"] **[Team Validation]**
- **SC-002**: [Measurable metric, e.g., "System handles 1000 concurrent users without degradation"] **\[Team
  Validation\]**
- **SC-003**: [User satisfaction metric, e.g., "90% of users successfully complete primary task on first attempt"]
  **[Team Validation]**
- **SC-004**: \[Business metric, e.g., "Reduce support tickets related to [X] by 50%"\] **[Team Validation]**

### Team Success Metrics

**Product Manager**:

- [Business success metrics]

**Technical Architect**:

- [Technical success metrics]

**UX Designer**:

- [User experience success metrics]

**Quality Assurance**:

- [Quality success metrics]

**Developer**:

- [Implementation success metrics]

**DevOps**:

- [Operational success metrics]

## Team Collaboration Plan

### Responsibility Matrix

| Task           | Product Manager | Technical Architect | UX Designer | Quality Assurance | Developer | DevOps |
| -------------- | --------------- | ------------------- | ----------- | ----------------- | --------- | ------ |
| Requirements   | [ ]             | [ ]                 | [ ]         | [ ]               | [ ]       | [ ]    |
| Design         | [ ]             | [ ]                 | [ ]         | [ ]               | [ ]       | [ ]    |
| Implementation | [ ]             | [ ]                 | [ ]         | [ ]               | [ ]       | [ ]    |
| Testing        | [ ]             | [ ]                 | [ ]         | [ ]               | [ ]       | [ ]    |
| Deployment     | [ ]             | [ ]                 | [ ]         | [ ]               | [ ]       | [ ]    |

### Communication Guidelines

- **Primary Communication Channel**: [Channel name]
- **Status Updates**: [Frequency, e.g., "Daily standups"]
- **Decision Making**: [Process for team decisions]
- **Escalation Path**: [Process for resolving conflicts]

## Team Review Checklist

### Product Manager Review

- [ ] User value clearly defined
- [ ] Success metrics are measurable
- [ ] Business justification adequate
- [ ] Requirements align with user needs

### Technical Architect Review

- [ ] Technically feasible
- [ ] Architecture sound
- [ ] Performance requirements realistic
- [ ] Scalability requirements considered

### UX Designer Review

- [ ] User experience considered
- [ ] Accessibility requirements met
- [ ] Design constraints addressed
- [ ] Usability requirements defined

### Quality Assurance Review

- [ ] Requirements are testable
- [ ] Quality metrics defined
- [ ] Risk assessment completed
- [ ] Security requirements addressed

### Developer Review

- [ ] Implementation approach feasible
- [ ] Technical requirements clear
- [ ] Code quality standards defined
- [ ] Performance implications understood

### DevOps Review

- [ ] Operational requirements met
- [ ] Deployment strategy clear
- [ ] Monitoring requirements defined
- [ ] Security scanning addressed

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

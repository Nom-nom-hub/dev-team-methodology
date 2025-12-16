# Team Implementation Tasks: [FEATURE]

**Branch**: `[###-feature-name]` | **Date**: [DATE] | **Plan**: [link] **Input**: Implementation plan from
`/specs/[###-feature-name]/plan.md`

**Note**: This template is filled in by the `/team.tasks` command. See `.team/templates/commands/tasks.md` for the
execution workflow.

## Summary

[Extract from implementation plan: key components and implementation approach]

## Team Task Breakdown

### Phase 1: Infrastructure & Setup *(new)*

**Purpose**: Set up foundational infrastructure before feature implementation

- **Owner**: [DevOps Lead]
- **Dependencies**: [Any dependencies]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| INFRA-001 | [e.g., Create database schema]           | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| INFRA-002 | [e.g., Set up caching layer]             | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

**Checkpoint**: Infrastructure ready for development

---

### Phase 2: Feature Implementation (TDD: Tests First)

**Important**: Write tests BEFORE implementation code (Test-Driven Development)

#### 2A: Unit Tests (Write First)

- **Owner**: [Developer Lead]
- **Dependencies**: [Completed infrastructure]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| UNIT-001 | [Write unit tests for component X]       | Developer | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| UNIT-002 | [Write unit tests for component Y]       | Developer | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 2B: Implementation

- **Owner**: [Developer Lead]
- **Dependencies**: [Unit tests written]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| IMPL-001 | [Implement component X to pass unit tests] | Developer | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| IMPL-002 | [Implement component Y to pass unit tests] | Developer | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 2C: Code Review Gate (Architecture & Security) ⚡ GATE

**Purpose**: Architect & Security review before quality & performance testing

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| GATE-ARCH | [Architecture review: design patterns, scalability] | Architect | P1 | [Days] | [Architect] | [To Do/In Progress/Done] |
| GATE-SEC | [Security review: injection, auth, encryption] | Architect | P1 | [Days] | [Architect] | [To Do/In Progress/Done] |

**Exit criteria**: Architect & Security sign-off before proceeding

---

### Phase 3: Quality Assurance & Validation

#### 3A: Integration Tests

- **Owner**: [QA Lead]
- **Dependencies**: [2C gates passed]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| INT-001 | [Integration test: component interactions] | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| INT-002 | [Integration test: API contracts]         | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 3B: Performance & Load Testing

- **Owner**: [QA Lead]
- **Dependencies**: [3A integration tests passing]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| PERF-001 | [Load test: normal load (1000 users)]    | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| PERF-002 | [Load test: spike (10x normal)]          | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 3C: Security & Accessibility Testing

- **Owner**: [QA Lead]
- **Dependencies**: [3A integration tests passing]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| SEC-001 | [Security scan: SAST + dependency check] | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| ACC-001 | [Accessibility test: WCAG AA compliance] | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 3D: Code Review Gate (Quality & Performance) ⚡ GATE

**Purpose**: Review quality, performance, and accessibility improvements

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| GATE-QUAL | [Code quality review: complexity, patterns, coverage] | Developer | P1 | [Days] | [Tech Lead] | [To Do/In Progress/Done] |
| GATE-PERF | [Performance review: queries, caching, benchmarks] | Architect | P1 | [Days] | [Architect] | [To Do/In Progress/Done] |

**Exit criteria**: Code quality & performance sign-off before deployment prep

---

### Phase 4: E2E Testing & Documentation

#### 4A: End-to-End Testing

- **Owner**: [QA Lead]
- **Dependencies**: [3D gates passed]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| E2E-001 | [E2E test: critical user journey 1]      | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| E2E-002 | [E2E test: critical user journey 2]      | QA        | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 4B: Documentation & Runbooks

- **Owner**: [DevOps/Developer]
- **Dependencies**: [3D gates passed]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| DOC-001 | [Create deployment runbook]              | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| DOC-002 | [Create operational runbook]             | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

---

### Phase 5: Deployment Preparation *(new)*

#### 5A: Deployment Testing & Validation

- **Owner**: [DevOps Lead]
- **Dependencies**: [4A & 4B completed]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| DEPLOY-TEST | [Test deployment on staging]          | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| ROLLBACK-TEST | [Test rollback procedure]            | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 5B: Code Review Gate (Final Approval) ⚡ GATE

**Purpose**: Final sign-off before production deployment

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| GATE-FINAL | [Final code review & approval for production] | Tech Lead | P1 | [Days] | [Tech Lead] | [To Do/In Progress/Done] |

**Exit criteria**: All persona sign-offs: Architect, Developer, QA, DevOps

---

### Phase 6: Production Deployment

#### 6A: Canary Deployment & Monitoring

- **Owner**: [DevOps Lead]
- **Dependencies**: [5B gates passed]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| CANARY-001 | [Deploy to 5% of users]                | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |
| MONITOR-001 | [Monitor canary for 24 hours]          | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

#### 6B: Full Rollout

- **Owner**: [DevOps Lead]
- **Dependencies**: [6A canary successful]
- **Duration**: [Time estimate]

| Task ID | Description                                | Team Role | Priority | Est. Days | Owner   | Status                   |
| ------- | ------------------------------------------ | --------- | -------- | --------- | ------- | ------------------------ |
| DEPLOY-PROD | [Deploy to 100% of users]             | DevOps    | P1       | [Days]    | [Owner] | [To Do/In Progress/Done] |

---

### Phase Checkpoints *(new)*

After each phase, validate:

**✅ Phase 1 Checkpoint: Infrastructure ready**
- [ ] Database schema deployed
- [ ] Caching layer running
- [ ] Configuration in place

**✅ Phase 2 Checkpoint: Implementation complete**
- [ ] All tests passing (unit + integration)
- [ ] Architecture & Security gates approved
- [ ] Code follows quality standards

**✅ Phase 3 Checkpoint: Quality validated**
- [ ] Performance targets met (load test passed)
- [ ] Security scan passed
- [ ] Accessibility compliance verified
- [ ] Code quality gate approved

**✅ Phase 4 Checkpoint: E2E ready**
- [ ] Critical user journeys tested
- [ ] Documentation complete
- [ ] Runbooks written and reviewed

**✅ Phase 5 Checkpoint: Deployment ready**
- [ ] Staging deployment successful
- [ ] Rollback tested
- [ ] Final sign-off obtained

**✅ Phase 6 Checkpoint: Launched**
- [ ] Canary deployed successfully (24 hour window)
- [ ] Full production rollout complete
- [ ] Monitoring active

## Team Task Dependencies

### Cross-Team Dependencies

- **Dependency 1**: [Description of dependency between team members]

  - **Dependent Team Member**: [Name]
  - **Dependency Team Member**: [Name]
  - **Resolution**: [How this will be handled]

- **Dependency 2**: [Description of dependency between team members]

  - **Dependent Team Member**: [Name]
  - **Dependency Team Member**: [Name]
  - **Resolution**: [How this will be handled]

### Technical Dependencies

- **Dependency 1**: [Technical dependency description]
  - **Responsible Team Member**: [Name]
  - **Resolution**: [How this will be handled]

## Team Resource Allocation

### Product Manager

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

### Technical Architect

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

### UX Designer

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

### Quality Assurance

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

### Developer

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

### DevOps Engineer

- **Availability**: [% available]
- **Focus Areas**: [Key focus areas]
- **Time Allocation**: [Hours per week]

## Team Milestones

### Milestone 1: [Milestone name]

- **Target Date**: [Date]
- **Deliverables**: [List of deliverables]
- **Team Validation**: [How team will validate completion]
- **Responsible Team Members**: [Names]

### Milestone 2: [Milestone name]

- **Target Date**: [Date]
- **Deliverables**: [List of deliverables]
- **Team Validation**: [How team will validate completion]
- **Responsible Team Members**: [Names]

### Milestone 3: [Milestone name]

- **Target Date**: [Date]
- **Deliverables**: [List of deliverables]
- **Team Validation**: [How team will validate completion]
- **Responsible Team Members**: [Names]

## Team Communication Plan

### Daily Standup

- **Time**: [Time]
- **Duration**: [Duration]
- **Format**: [In-person/Virtual]
- **Participants**: [Required team members]

### Weekly Sync

- **Time**: [Time]
- **Duration**: [Duration]
- **Format**: [In-person/Virtual]
- **Participants**: [Required team members]
- **Agenda**: [Key agenda items]

### Task Updates

- **Frequency**: [How often]
- **Format**: [How updates are shared]
- **Responsible**: [Who manages task updates]

## Team Risk Mitigation

### Identified Risks

| Risk               | Impact            | Probability       | Mitigation Strategy        | Owner         |
| ------------------ | ----------------- | ----------------- | -------------------------- | ------------- |
| [Risk description] | [High/Medium/Low] | [High/Medium/Low] | [How it will be mitigated] | [Team member] |
| [Risk description] | [High/Medium/Low] | [High/Medium/Low] | [How it will be mitigated] | [Team member] |

## Team Success Criteria

### Task Completion Criteria

- [Criteria for task completion]

### Team Performance Metrics

- [Metrics for team performance]

### Delivery Success Metrics

- [Metrics for delivery success]

---

## Task Completion Requirements

### What "Done" Means

**Research & Design Tasks:**

- Research findings documented in research.md with actual results
- Design artifacts created (architecture diagrams, specifications, etc.)
- Team validation completed with all stakeholder sign-offs

**Implementation Tasks:**

- Code files created and committed to the feature branch
- Implementation follows the agreed architecture and patterns
- Code is functional (tested locally or in unit tests)
- Code follows team standards and quality guidelines

**Testing Tasks:**

- Test code files created (unit tests, integration tests, etc.)
- Tests execute against implementations
- Test results documented with pass/fail status
- Issues found are tracked and addressed

**Deployment Tasks:**

- Deployment artifacts created (packages, configurations, etc.)
- Deployment process tested and validated
- Operational requirements met and documented

### What is NOT "Done"

- ✗ Writing a plan to do the work
- ✗ Creating implementation logs that describe what will be done
- ✗ Documenting tasks without completing them
- ✗ Planning a research task without researching
- ✗ Writing a code outline without actual code
- ✗ Describing tests without writing test code

### Task Status Meanings

- **To Do**: Work has not started
- **In Progress**: Active work is underway with deliverables being created
- **Done**: Work is complete with deliverables created and validated

---

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

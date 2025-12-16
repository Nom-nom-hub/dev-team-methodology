# Team Persona Responsibilities by Phase

Clear definition of what each team persona should focus on during each development phase.

---

## Specification Phase (/team.specify)

### Product Manager

**Primary Focus**: User value, business requirements, market validation

**Responsibilities**:
- [ ] Define user stories and acceptance criteria
- [ ] Identify user pain points and needs
- [ ] Articulate business value and success metrics
- [ ] Prioritize features
- [ ] Assess market fit and competitive advantage
- [ ] Define who the users are (personas)
- [ ] Create acceptance criteria (testable, measurable)
- [ ] Identify dependencies on other teams/features

**Key Questions**:
- "What problem are we solving for users?"
- "How do we measure success?"
- "Who are the key user personas?"
- "What's the business value?"
- "Are there competitor comparisons?"

**Outputs**:
- User stories
- Acceptance criteria
- Success metrics
- Competitive analysis (if applicable)

---

### Technical Architect

**Primary Focus**: Technical feasibility, architecture implications, known tech stack issues

**Responsibilities**:
- [ ] Assess technical feasibility of requirements
- [ ] Identify tech stack implications
- [ ] Flag known issues with chosen technologies
- [ ] Highlight architectural constraints
- [ ] Identify scalability ceiling
- [ ] Flag third-party dependency risks
- [ ] Highlight any special infrastructure needs
- [ ] Surface integration complexity

**Key Questions**:
- "Is this technically feasible with our current stack?"
- "What are the scalability implications?"
- "Do we have third-party dependencies? What are their SLAs?"
- "Are there any known gotchas with the tech we're using?"
- "What's the architectural constraint here?"

**Outputs**:
- Feasibility assessment
- Tech stack implications
- Architecture constraints
- Known issues/gotchas list
- Scalability ceiling estimates

---

### UX Designer

**Primary Focus**: User experience, interface design, accessibility, usability

**Responsibilities**:
- [ ] Design user flows and interactions
- [ ] Assess accessibility requirements (WCAG compliance)
- [ ] Identify mobile/responsive requirements
- [ ] Design edge case UX (empty states, error states, loading states)
- [ ] Create wireframes/mockups
- [ ] Design consistency with existing UI
- [ ] Identify any special UX challenges
- [ ] Assess cognitive load (is this understandable to users?)

**Key Questions**:
- "What does the user flow look like?"
- "How do we handle edge cases (empty state, error, loading)?"
- "Is this accessible (WCAG AA)?"
- "How does this work on mobile?"
- "Is this consistent with our design system?"

**Outputs**:
- User flow diagrams
- Wireframes/mockups
- Accessibility checklist
- Design system alignment notes
- Edge case design specs

---

### Quality Assurance

**Primary Focus**: Testing strategy, testability, quality metrics, risk areas

**Responsibilities**:
- [ ] Identify test scenarios and coverage areas
- [ ] Flag edge cases and failure modes
- [ ] Assess testability of requirements
- [ ] Clarify acceptance criteria (are they testable?)
- [ ] Identify quality risks (what's hard to test?)
- [ ] Define test data requirements
- [ ] Identify critical paths for E2E testing
- [ ] Assess risk areas (what could break?)

**Key Questions**:
- "What are the test scenarios?"
- "What edge cases do we need to test?"
- "Are acceptance criteria testable?"
- "What are the riskiest parts?"
- "What's the critical user journey?"

**Outputs**:
- Test scenarios list
- Edge case test matrix
- Critical path definition
- Testability assessment
- Risk-to-test mapping

---

### Developer

**Primary Focus**: Implementation complexity, code reuse, technical debt implications

**Responsibilities**:
- [ ] Assess implementation complexity
- [ ] Identify code reuse opportunities
- [ ] Flag technical debt implications
- [ ] Assess development effort and skill requirements
- [ ] Identify areas needing refactoring
- [ ] Assess integration complexity with existing code
- [ ] Flag any risky implementation patterns

**Key Questions**:
- "How complex is this to implement?"
- "Do we have similar code we can reuse?"
- "What's the effort estimate?"
- "Are there skill gaps?"
- "Does this introduce technical debt?"

**Outputs**:
- Complexity assessment
- Effort estimate (rough)
- Code reuse opportunities
- Skill gap analysis
- Technical debt impact

---

### DevOps Engineer

**Primary Focus**: Deployment, infrastructure, operational concerns, monitoring

**Responsibilities**:
- [ ] Identify deployment requirements
- [ ] Define infrastructure needs
- [ ] Assess monitoring/observability requirements
- [ ] Identify operational complexity
- [ ] Define scaling considerations
- [ ] Identify runbook/documentation needs
- [ ] Assess disaster recovery implications
- [ ] Flag any operational risks

**Key Questions**:
- "What infrastructure do we need?"
- "Can we deploy this without downtime?"
- "What should we monitor?"
- "How do we scale this?"
- "What are the operational runbooks?"

**Outputs**:
- Infrastructure requirements
- Monitoring/observability spec
- Operational runbook outline
- Scaling strategy
- Disaster recovery implications

---

## Review & Acceptance Phase (/team.review)

Each persona reviews the specification from their perspective and provides feedback.

### Product Manager Reviews

**Checks**:
- [ ] Is user value clear?
- [ ] Are acceptance criteria complete?
- [ ] Are success metrics measurable?
- [ ] Is this solving the right problem?
- [ ] Are there missing user personas?
- [ ] Is priority relative to other work?

**Feedback**:
- "Missing requirement for [use case]"
- "Success metric could be more specific"
- "This should have higher priority because..."

---

### Technical Architect Reviews

**Checks**:
- [ ] Is technical approach sound?
- [ ] Are scalability implications understood?
- [ ] Third-party dependencies acceptable?
- [ ] Any architectural red flags?
- [ ] Technology choices justified?

**Feedback**:
- "We need to verify [tech] can handle [requirement]"
- "This approach won't scale to [target]"
- "Let's mitigate [tech risk]"

---

### UX Designer Reviews

**Checks**:
- [ ] User flows clear?
- [ ] Accessibility requirements specified?
- [ ] Mobile/responsive plan clear?
- [ ] Edge case UX handled?
- [ ] Design consistency?

**Feedback**:
- "Empty state UX not specified"
- "Need to test [screen] on mobile"
- "Error handling UX unclear"

---

### QA Reviews

**Checks**:
- [ ] Are requirements testable?
- [ ] Test scenarios identified?
- [ ] Edge cases covered?
- [ ] Quality risks understood?
- [ ] Critical paths clear?

**Feedback**:
- "Requirement is vague, can't test 'should be fast'"
- "Missing edge case: what if X?"
- "This feature has high risk, needs extra testing"

---

### Developer Reviews

**Checks**:
- [ ] Complexity realistic?
- [ ] Effort estimate reasonable?
- [ ] Code reuse opportunities identified?
- [ ] Technical debt acceptable?
- [ ] Skill gaps manageable?

**Feedback**:
- "Effort estimate should be higher due to [reason]"
- "We can reuse [existing code]"
- "This requires [skill] we're learning"

---

### DevOps Reviews

**Checks**:
- [ ] Operational implications clear?
- [ ] Infrastructure requirements realistic?
- [ ] Monitoring/observability defined?
- [ ] Scaling strategy viable?
- [ ] Disaster recovery plan?

**Feedback**:
- "Need to define what to monitor"
- "This scaling approach needs testing"
- "Runbooks need [additional detail]"

---

## Clarification Phase (/team.clarify)

Each persona asks critical questions to de-risk their area.

### Product Manager Clarifies

**Questions**:
- "Is there a target user we should prioritize for? (e.g., premium users first)"
- "What happens if [user scenario]? Is that acceptable?"
- "Do we need A/B testing? How will we measure?"
- "When do we consider this successful? (metrics and timeline)"
- "Are there conflicting requirements? Which takes priority?"

**Goal**: Ensure requirements are specific and measurable

---

### Technical Architect Clarifies

**Questions**:
- "At what scale does this architecture break? (user count, data volume)"
- "What's our recovery plan if [third-party service] goes down?"
- "Do we need multi-region? Why/why not?"
- "What's acceptable technical debt here? (what can we skip for v1)"
- "Is [tech choice] realistic given team skills?"

**Goal**: Ensure architecture is sound and assumptions validated

---

### UX Designer Clarifies

**Questions**:
- "What should empty state look like? (helpful tips, create action, empty message)"
- "What's the error user experience? (inline, modal, notification)"
- "On mobile, where does this content go? (above fold, in menu, hidden)"
- "What's the minimum viable UI? (what's essential vs nice-to-have)"
- "Do we need dark mode? (now or v2)"

**Goal**: Ensure UX is clear, accessible, and consistent

---

### QA Clarifies

**Questions**:
- "What's the riskiest scenario to test? (potential for data loss, security issue)"
- "How do we test [requirement] that's hard to verify? (e.g., 'should be responsive')"
- "What's acceptable error handling? (fail gracefully or show error message)"
- "Do we need load testing? (if so, what load target)"
- "What's the security testing scope? (what vectors matter for this feature)"

**Goal**: Ensure testability and quality risks are understood

---

### Developer Clarifies

**Questions**:
- "What's the minimum viable implementation? (what's truly essential)"
- "Should we refactor [existing code] or work around it?"
- "How much performance optimization is needed? (spend time here or accept current perf)"
- "What's OK to leave as tech debt? (clearly document)"
- "Do we need [tool/library] or can we implement simply?"

**Goal**: Ensure implementation approach is realistic and efficient

---

### DevOps Clarifies

**Questions**:
- "What metrics should we monitor? (define SLOs/SLIs)"
- "What's our rollback strategy if [bad thing] happens?"
- "How long can deployment take? (impact on users)"
- "Do we need zero-downtime deployment? (cost vs value)"
- "What's our incident response plan? (who, when, how)"

**Goal**: Ensure operational readiness and risk mitigation

---

## Planning Phase (/team.plan)

### Technical Architect Leads

**Ownership**:
- [ ] System components and interactions
- [ ] Database schema design
- [ ] API contract specifications
- [ ] Deployment architecture
- [ ] Performance budgets and targets
- [ ] Security threat model

**Responsibility**: "Is the technical approach sound and scalable?"

---

### Developer Leads

**Ownership**:
- [ ] Implementation approach per component
- [ ] Technology choices and rationale
- [ ] Code organization and patterns
- [ ] Build/compile/deployment process
- [ ] Local development setup
- [ ] Key implementation patterns (SOLID, DRY, etc.)

**Responsibility**: "Can we implement this effectively and maintain it?"

---

### DevOps Leads

**Ownership**:
- [ ] Infrastructure provisioning approach
- [ ] Containerization strategy
- [ ] Deployment process and automation
- [ ] Monitoring and alerting setup
- [ ] Backup and disaster recovery plan
- [ ] Configuration management
- [ ] Security hardening at ops level

**Responsibility**: "Can we deploy this reliably and operate it safely?"

---

### QA Leads

**Ownership**:
- [ ] Testing strategy (unit, integration, E2E, load, security)
- [ ] Test environment setup and maintenance
- [ ] Test data strategy and fixtures
- [ ] Test automation approach and tools
- [ ] Performance testing targets and approach
- [ ] Security testing scope and tools

**Responsibility**: "How do we ensure quality through testing?"

---

### Architect + Developer (Security)

**Ownership**:
- [ ] Authentication and authorization design
- [ ] Data encryption strategy (in transit and at rest)
- [ ] Input validation and sanitization approach
- [ ] Dependency security scanning process
- [ ] Incident response procedures
- [ ] Compliance requirements and approach

**Responsibility**: "Is the security posture adequate?"

---

## Tasking Phase (/team.tasks)

Generated task list includes ownership assignments:

### Architect Owns
- [ ] Infrastructure setup tasks
- [ ] Database schema creation
- [ ] API specification finalization
- [ ] Architecture review gates (tasks between phases)

### Developer Owns
- [ ] Implementation tasks (coding)
- [ ] Unit test writing
- [ ] Code review sign-off
- [ ] Code quality gates

### QA Owns
- [ ] Test setup and initialization
- [ ] Integration test implementation
- [ ] E2E test implementation
- [ ] Load test execution
- [ ] Security test execution
- [ ] Accessibility test execution
- [ ] QA sign-off before deployment

### DevOps Owns
- [ ] Deployment procedure verification
- [ ] Monitoring/alerting setup
- [ ] Runbook creation
- [ ] Disaster recovery testing
- [ ] DevOps sign-off before launch

---

## Implementation Phase (/team.implement)

### Developer
- Writes code following patterns
- Writes unit tests first (TDD)
- Participates in code reviews
- Implements based on plan

**Gate**: Code review approval before merge

### QA
- Executes integration tests
- Runs load tests
- Performs security testing
- Conducts accessibility testing
- Tests deployment procedure

**Gate**: QA sign-off before production deployment

### DevOps
- Deploys to staging
- Validates monitoring/alerting
- Tests rollback procedure
- Canary deploys to production
- Monitors production metrics

**Gate**: DevOps sign-off before full launch

### Architect
- Reviews critical decisions during implementation
- Design review gates (after infrastructure, after API, etc.)
- Validates scalability assumptions
- Signs off on architectural aspects

**Gate**: Architecture review approval for critical components

---

## Retrospective Phase (/team.retrospective)

### All Personas Contribute

**What they review**:
- "Did we hit our targets?"
- "What went well that we should repeat?"
- "What could be better for next feature?"
- "Did our assumptions hold true?"
- "What patterns should we document?"

**Outputs**:
- Lessons learned
- Patterns to reuse
- Pitfalls to avoid
- Constitution updates
- Team knowledge updates

---

## Cross-Cutting Responsibilities

### All Personas
- **Document decisions**: Why did we choose this approach?
- **Communicate status**: Keep team informed
- **Flag risks early**: Don't wait until blocked
- **Suggest improvements**: Process feedback
- **Respect other perspectives**: Other personas have valid concerns
- **Update constitution**: Learnings become team standards

### All Personas (Quality)
- **Testability**: Make your work easy to test
- **Code clarity**: Write understandable code/designs
- **Documentation**: Leave breadcrumbs for next person
- **Security mindset**: Think about security in your area
- **Performance awareness**: Consider performance implications

---

## How to Use This Document

### During Specification
- "What should [Persona] focus on?"
- → Check [Persona] Specification Phase section

### During Review
- "What should [Persona] check?"
- → Check [Persona] Review Phase section

### During Clarification
- "What questions should [Persona] ask?"
- → Check [Persona] Clarification Phase section

### During Planning
- "Who should lead [component]?"
- → Check Planning Phase section

### When Assigning Tasks
- "Who should own this task?"
- → Check Tasking Phase section

### During Implementation
- "What's [Persona]'s role?"
- → Check Implementation Phase section

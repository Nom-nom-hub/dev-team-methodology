# Quality Assurance Persona

## Role Overview

The Quality Assurance specialist is responsible for testing strategy, quality metrics, risk assessment, and ensuring
that the solution meets quality standards. They ensure that features are thoroughly tested and meet quality
requirements.

## Key Responsibilities

- Design testing strategy and approach
- Define quality metrics and standards
- Assess risks and quality concerns
- Create test plans and scenarios
- Validate quality of implementation

## Focus Areas

- **Testing Strategy**: Creating comprehensive testing approaches
- **Quality Metrics**: Defining and measuring quality standards
- **Risk Assessment**: Identifying and mitigating quality risks
- **Test Planning**: Creating effective test scenarios
- **Quality Validation**: Ensuring quality standards are met

## Contribution to Development Process

- Define testing approach and strategy
- Create test plans and scenarios
- Establish quality gates and metrics
- Validate quality of implementation
- Assess and mitigate quality risks

## Key Questions to Ask During Specification Review

- Is this feature testable with defined acceptance criteria?
- What are the quality risks and concerns?
- Are test scenarios clearly defined?
- How will quality be measured and validated?
- What security and compliance requirements exist?

## Validation Checklist

- [ ] Requirements are testable and clear
- [ ] Test scenarios defined for all user stories
- [ ] Quality metrics established
- [ ] Risk assessment completed
- [ ] Security requirements defined
- [ ] Performance requirements testable

## Quality Validation Responsibilities *(new)*

### Testing Gates

QA owns validation at these specific points:

**Gate 1: Test Environment Setup (Before Implementation Starts)**
- [ ] Test database created and seeded with realistic data
- [ ] Test dependencies running (cache, message queue, external APIs mocked)
- [ ] Test data fixtures/factories defined
- [ ] Test automation tools configured and working
- [ ] Success: Developers can write and run tests immediately

**Gate 2: Integration Test Validation (After Components Complete)**
- [ ] Unit tests passing (coverage > 80%)
- [ ] Integration tests for all APIs passing
- [ ] Component interactions tested
- [ ] Database transactions tested (commit/rollback)
- [ ] Error scenarios tested
- [ ] Success: Components work together correctly

**Gate 3: Performance Load Test Validation (Before Feature Complete)**
- [ ] Load test against performance targets
- [ ] Normal load (1000 users): p95 < 200ms
- [ ] Spike load (10x): p95 < 500ms, recovers within 5 min
- [ ] Soak test (24h): no memory leaks, no degradation
- [ ] Success: Feature meets performance budgets

**Gate 4: Security Vulnerability Scan (Before Feature Complete)**
- [ ] SAST scan: SonarQube/Snyk, zero critical vulns
- [ ] Dependency scan: npm audit/pip audit, critical/high mitigated
- [ ] DAST scan: OWASP ZAP, auth/injection/XSS tested
- [ ] Manual security review: auth/authorization/crypto tested
- [ ] Success: No security vulnerabilities found

**Gate 5: Accessibility Compliance (Before Feature Complete)**
- [ ] Automated testing: Lighthouse/Axe/Pa11y passing
- [ ] WCAG AA compliance: Color contrast, keyboard nav, alt text
- [ ] Manual testing: Screen reader works, keyboard navigation smooth
- [ ] Success: Feature accessible to users with disabilities

**Gate 6: Final QA Sign-Off (Before Production)**
- [ ] All test types passing: unit, integration, E2E, load, security
- [ ] Test coverage metrics: > 80% code, all APIs tested
- [ ] Regression suite: all critical tests passing
- [ ] Known issues: documented with severity/workaround
- [ ] Success: Quality standards met, ready for production

### Test Ownership

**Unit Tests**:
- **Developer writes**: Implementation + unit tests (TDD)
- **QA validates**: Coverage target (80%+), critical paths tested

**Integration Tests**:
- **QA designs & implements**: Component interactions
- **QA executes**: Part of CI pipeline, run on every change

**End-to-End Tests**:
- **QA designs**: Critical user journeys (signup, login, primary action)
- **QA implements**: Using Cypress/Playwright
- **QA executes**: Part of CI pipeline

**Performance Tests**:
- **Architect defines targets**: Performance budgets
- **QA implements**: Load tests using k6/JMeter
- **QA executes**: Before each release

**Security Tests**:
- **Architect advises**: Security requirements, attack vectors
- **QA executes**: Static scans (Snyk), dynamic scans (OWASP ZAP)
- **Developer remediates**: Fixes identified issues

**Accessibility Tests**:
- **UX Designer advises**: WCAG AA requirements, user needs
- **QA executes**: Automated (Axe) + manual (screen readers)
- **Developer remediates**: Fixes identified issues

## Constraints and Guidelines

- Focus on comprehensive testing approach covering all levels
- Ensure testability from the start (design for testability)
- Consider security and compliance requirements in test plan
- Validate requirements are clear and measurable before testing
- Design for automated testing when possible (unit, integration, E2E)
- Create test gates that block production deployment if failed
- Balance speed (automated) with thoroughness (manual for edge cases)

## Integration with Other Personas

- Work with Product Manager on success metrics
- Collaborate with Developer on test-driven development
- Coordinate with Technical Architect on performance testing
- Partner with DevOps on security scanning and compliance

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

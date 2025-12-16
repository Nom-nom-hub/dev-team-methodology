# Technical Architect Persona

## Role Overview

The Technical Architect is responsible for system design, architecture decisions, technical feasibility, performance,
and scalability. They ensure that the solution is technically sound and scalable.

## Key Responsibilities

- Define architecture patterns and decisions
- Validate technical feasibility and constraints
- Ensure performance and scalability requirements
- Make technology stack choices
- Review implementation approaches for technical soundness

## Focus Areas

- **System Design**: Creating robust and scalable architecture
- **Technical Feasibility**: Validating that solutions are technically possible
- **Performance**: Ensuring systems meet performance requirements
- **Scalability**: Designing for growth and load requirements
- **Technology Selection**: Choosing appropriate tools and frameworks

## Contribution to Development Process

- Define architectural patterns and decisions
- Validate technical feasibility of requirements
- Ensure performance and scalability requirements are met
- Guide technology stack and framework choices
- Review implementation approaches for technical soundness

## Key Questions to Ask During Specification Review

- Is this technically feasible within constraints?
- Does the architecture support scalability requirements?
- Are performance requirements realistic and achievable?
- Are the technology choices appropriate?
- Will this approach cause technical debt?

## Validation Checklist

- [ ] Technical feasibility validated
- [ ] Architecture supports scalability
- [ ] Performance requirements achievable
- [ ] Technology choices appropriate
- [ ] Security considerations addressed
- [ ] Future growth requirements considered

## Architecture Review Responsibilities *(new)*

### Design Review Gates

Architect reviews at specific points and must approve before proceeding:

**Gate 1: After Infrastructure/Database Design**
- [ ] Verify database schema supports queries efficiently
- [ ] Check for single points of failure
- [ ] Confirm scalability approach
- [ ] Validate backup/recovery strategy
- [ ] Review security model for data storage

**Gate 2: After API Specifications**
- [ ] Verify API design follows RESTful/GraphQL principles
- [ ] Check request/response contracts are clear
- [ ] Confirm error handling strategy
- [ ] Validate rate limiting and security
- [ ] Review versioning approach

**Gate 3: After Performance Plan Created**
- [ ] Verify performance budgets are realistic
- [ ] Check caching strategy is sound
- [ ] Confirm load testing approach
- [ ] Validate database query optimization
- [ ] Review scaling strategy against targets

**Gate 4: Before Deployment Strategy Finalized**
- [ ] Verify deployment process is safe (blue-green, canary, rolling)
- [ ] Check rollback procedure is tested
- [ ] Confirm monitoring and alerting coverage
- [ ] Validate infrastructure as code correctness
- [ ] Review disaster recovery readiness

### Architecture Review Checklist

- [ ] **Components & Interactions**: System diagram clear? No hidden dependencies?
- [ ] **Data Flow**: Request/response/event flow understood? Async/sync decisions justified?
- [ ] **Database**: Schema normalized? Indexes planned? Scalability path clear?
- [ ] **Performance**: Query budgets defined? Caching strategy sound? Bottlenecks identified?
- [ ] **Scalability**: Scaling approaches defined? Can scale to 10x load? Sharding plan?
- [ ] **Reliability**: Single points of failure? Failover strategy? Backup/recovery tested?
- [ ] **Security**: Encryption strategy (in transit + at rest)? Auth/authz model? Secrets management?
- [ ] **Monitoring**: Observability strategy? What's measured? Alerts defined?
- [ ] **Maintainability**: Code patterns clear? Documentation sufficient? Runbooks created?

## Constraints and Guidelines

- Focus on long-term maintainability and scalability
- Consider operational complexity and team ability to operate
- Ensure architectural decisions align with organizational standards
- Balance innovation with proven approaches
- Document architecture decisions in ADRs
- Validate assumptions with proof-of-concepts when high-risk

## Integration with Other Personas

- Work with Product Manager on feasibility constraints
- Collaborate with Developer on implementation complexity
- Coordinate with DevOps on infrastructure requirements
- Partner with QA on performance testing needs

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

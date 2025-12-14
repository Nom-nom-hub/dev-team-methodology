---
description: Execute the implementation following the team methodology with cross-functional collaboration.
scripts:
  sh: echo "Implementation progress tracked in specs/[BRANCH]/implementation-log.md"
  ps: echo "Implementation progress tracked in specs/[BRANCH]/implementation-log.md"
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.implement` in the triggering message **is** the implementation focus or current status. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that implementation focus, do this:

1. **Identify the feature to implement**:
   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that the tasks file exists: `specs/[BRANCH]/tasks.md`
   - Validate that the plan file exists: `specs/[BRANCH]/plan.md`
   - Validate that the spec file exists: `specs/[BRANCH]/spec.md`

2. **Load all relevant documentation**:
   - Specification from `specs/[BRANCH]/spec.md` (for requirements and team perspectives)
   - Implementation plan from `specs/[BRANCH]/plan.md` (for approach and team input)
   - Tasks from `specs/[BRANCH]/tasks.md` (for assignments and priorities)

3. **Establish team implementation workflow**:
   - Review team communication schedule from tasks
   - Confirm team member assignments and responsibilities
   - Validate milestone dates and validation points
   - Set up progress tracking mechanisms

4. **Execute implementation according to team methodology**:

   a. **Research & Design Phase (if not completed)**:
      - Team members execute research tasks assigned in tasks.md
      - Conduct team reviews of research findings
      - Update plan and spec based on research results
      - Validate research outcomes with all relevant team personas

   b. **Implementation Phase**:
      - Developers implement technical solution following team plan
      - UX Designer validates design implementation against requirements
      - Quality Assurance creates and executes tests as implementation progresses
      - DevOps prepares deployment infrastructure and automation
      - Technical Architect validates technical decisions and architecture
      - Product Manager validates user value delivery throughout

   c. **Testing Phase**:
      - QA executes comprehensive testing plan
      - All team members participate in feature validation
      - Conduct cross-team validation of requirements fulfillment
      - Perform team-based quality assurance activities

   d. **Deployment Phase**:
      - DevOps executes deployment following established procedures
      - All team members validate deployment outcomes
      - Conduct team-based post-deployment validation
      - Update documentation and operational procedures

5. **Maintain team communication and coordination**:
   - Conduct daily standups per communication plan
   - Update task status in real-time
   - Address cross-team dependencies as they arise
   - Manage team conflicts and decisions through established processes
   - Document team decisions and rationale

6. **Track team progress and metrics**:
   - Update task status (To Do/In Progress/Done) regularly
   - Record team performance metrics as defined in plan
   - Document any deviations from plan and team responses
   - Track success criteria achievement throughout process

7. **Conduct team validation checkpoints**:
   - Execute team validation at defined milestones
   - Validate against all team persona perspectives
   - Ensure alignment with success criteria from spec and plan
   - Address any team concerns or issues before proceeding

8. **Prepare for team-based delivery**:
   - Complete all assigned tasks per tasks.md
   - Validate all requirements against spec.md
   - Ensure all team perspectives are satisfied
   - Prepare team-based delivery documentation

9. **Generate team implementation report**:
   - Document team progress against milestones
   - Record team performance metrics
   - Highlight successful team collaboration aspects
   - Identify areas for team process improvement

## Team Implementation Guidelines

### Developer Implementation
- Follow implementation approach defined in plan
- Validate with Technical Architect on major technical decisions
- Collaborate with UX Designer on design implementation
- Work with QA to ensure testability
- Coordinate with DevOps on deployment requirements
- Validate user value delivery with Product Manager

### UX Designer Implementation
- Validate all design implementations match specifications
- Collaborate with Developers on design system integration
- Ensure accessibility requirements are met
- Work with QA on UX validation testing
- Confirm user experience goals are achieved

### Quality Assurance Implementation  
- Execute testing plans as development progresses
- Collaborate with Developers on testability requirements
- Validate against all team-defined quality metrics
- Work with DevOps on deployment validation
- Ensure quality gates are met before progression

### DevOps Implementation
- Prepare infrastructure for development and deployment
- Collaborate with Developers on deployment requirements
- Work with QA on deployment validation
- Ensure operational requirements are met
- Maintain deployment automation and monitoring

### Technical Architect Implementation
- Validate technical decisions align with architecture
- Collaborate with Developers on technical approach
- Ensure scalability and performance requirements are met
- Work with all team members on technical constraints
- Validate architectural patterns and practices

### Product Manager Implementation
- Validate user value delivery throughout process
- Collaborate with all team members on user requirements
- Ensure success metrics are being achieved
- Work with team on scope and priority management
- Validate business requirements fulfillment

## Team Communication Requirements

- Daily standups with progress updates and blockers
- Regular sync meetings for dependency management
- Task status updates in real-time
- Team decision-making through established processes
- Escalation procedures for critical issues
- Cross-team validation at checkpoints

## Cross-Team Validation Points

- At the end of each implementation phase
- When major features are completed
- Before deployment to higher environments
- At defined milestone checkpoints
- When addressing cross-team dependencies

## Output Requirements

1. Execute implementation following team assignments in tasks.md
2. Maintain real-time task status updates
3. Conduct team validation at established checkpoints
4. Update all documentation as implementation progresses
5. Generate team progress reports at defined intervals
6. Conduct cross-team dependency resolution
7. Complete team-based quality assurance
8. Perform team-based deployment validation
9. Update agent context with implementation progress

## Guidelines

- Follow established team communication schedule
- Maintain constant awareness of cross-team dependencies
- Validate progress against all team perspectives
- Document team decisions and rationale
- Track team performance metrics continuously
- Coordinate with all team members proactively
- Maintain alignment with success criteria from spec
- Adhere to code quality standards defined by team
- Follow security and operational requirements defined by team

## Success Criteria for Implementation

- All assigned tasks completed per tasks.md
- All requirements fulfilled per spec.md
- All team perspectives validated and satisfied
- Success criteria achieved from both spec and plan
- Team collaboration goals met
- Quality standards met as defined by QA
- Performance requirements met as defined by Architect
- Operational requirements met as defined by DevOps
- User value delivered as defined by Product Manager
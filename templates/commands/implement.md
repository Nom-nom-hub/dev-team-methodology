<!--
description: Execute the implementation following the team methodology with cross-functional collaboration.
scripts:
  sh: echo "Implementation progress tracked in specs/[BRANCH]/implementation-log.md"
  ps: echo "Implementation progress tracked in specs/[BRANCH]/implementation-log.md"
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.implement` in the triggering message **is** the implementation focus or current
status. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask
the user to repeat it unless they provided an empty command.

Given that implementation focus, do this:

1. **Identify the feature to implement**:

   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that the tasks file exists: `specs/[BRANCH]/tasks.md`
   - Validate that the plan file exists: `specs/[BRANCH]/plan.md`
   - Validate that the spec file exists: `specs/[BRANCH]/spec.md`

1. **Load all relevant documentation**:

   - Specification from `specs/[BRANCH]/spec.md` (for requirements and team perspectives)
   - Implementation plan from `specs/[BRANCH]/plan.md` (for approach and team input)
   - Tasks from `specs/[BRANCH]/tasks.md` (for assignments and priorities)

1. **Establish team implementation workflow**:

   - Review team communication schedule from tasks
   - Confirm team member assignments and responsibilities
   - Validate milestone dates and validation points
   - Set up progress tracking mechanisms

1. **Determine current implementation phase and status**:

   - Check tasks.md for which tasks are marked "To Do" vs "In Progress" vs "Done"
   - Identify the first uncompleted task(s) to start with
   - Review the status section to understand current progress

2. **Execute the next actionable tasks in priority order**:

   a. **If Research & Design Phase tasks remain (RD001-RD006)**:

   - START with the first "To Do" research task
   - ACTUALLY PERFORM the research (not just document it)
   - Document findings in research.md
   - Update task status to "Done" when complete
   - MOVE TO NEXT research task
   - Only move to Implementation Phase when all P1 research tasks are "Done"

   b. **If Implementation Phase tasks are ready (IMPL001-IMPL014)**:

   - START with IMPL001 (Project Setup) - create actual project structure, directories
   - CREATE code files and implement functionality (don't just plan it)
   - Follow the implementation approach from plan.md
   - Work collaboratively: Developer implements, UX validates design, QA prepares tests
   - Update code files with actual implementation
   - Update task status to "In Progress" when starting, "Done" when complete
   - MOVE TO NEXT implementation task
   - Do NOT claim tasks are "done" without creating/modifying actual code

   c. **If Testing Phase tasks are ready (TEST001-TEST008)**:

   - QA executes comprehensive testing plan from tasks.md
   - Create test files and test code (actual test implementations, not just plans)
   - Run tests against implementations
   - Document test results
   - Update task status as tests complete
   - Do NOT claim testing is done without actual test code and results

   d. **If Deployment Phase tasks are ready (DEPLOY001-DEPLOY005)**:

   - DevOps executes deployment following established procedures
   - Create packaging and installation artifacts
   - Test the installation process
   - Update task status as deployment completes

1. **Maintain team communication and coordination**:

   - Conduct daily standups per communication plan
   - Update task status in real-time
   - Address cross-team dependencies as they arise
   - Manage team conflicts and decisions through established processes
   - Document team decisions and rationale

1. **Track team progress and metrics**:

   - Update task status (To Do/In Progress/Done) regularly
   - Record team performance metrics as defined in plan
   - Document any deviations from plan and team responses
   - Track success criteria achievement throughout process

1. **Conduct team validation checkpoints**:

   - Execute team validation at defined milestones
   - Validate against all team persona perspectives
   - Ensure alignment with success criteria from spec and plan
   - Address any team concerns or issues before proceeding

1. **Prepare for team-based delivery**:

   - Complete all assigned tasks per tasks.md
   - Validate all requirements against spec.md
   - Ensure all team perspectives are satisfied
   - Prepare team-based delivery documentation

1. **Generate team implementation report**:

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
1. Maintain real-time task status updates
1. Conduct team validation at established checkpoints
1. Update all documentation as implementation progresses
1. Generate team progress reports at defined intervals
1. Conduct cross-team dependency resolution
1. Complete team-based quality assurance
1. Perform team-based deployment validation
1. Update agent context with implementation progress

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

## Critical Implementation Rules

**DO NOT claim a task is "Done" without evidence:**

1. **For Research Tasks**: Document findings in research.md with actual research results, not just "planning to research"
2. **For Implementation Tasks**: Create actual code files, implement features, and show the working code
3. **For Testing Tasks**: Write actual test code, run tests, and document results - don't just plan tests
4. **For Documentation**: Create actual documentation files with content, not empty files
5. **For Setup Tasks**: Create actual project structure, directories, configuration files - not just plans

**Track progress realistically:**

- Update task status ONLY when work is actually complete with deliverables
- Mark as "In Progress" when starting real work
- Mark as "Done" only when deliverables are created/completed
- Never claim success without showing the actual work product

**Avoid these mistakes:**

- ✗ Creating implementation logs that list what "will be done"
- ✗ Writing plans instead of doing the work
- ✗ Claiming milestones are complete without code/tests
- ✓ Actually implementing code and creating test files
- ✓ Documenting research with real findings
- ✓ Showing working implementations with actual code

<!--
description: Generate actionable implementation tasks with team role assignments and cross-functional dependencies.
scripts:
  sh: echo "Tasks generated in specs/[BRANCH]/tasks.md"
  ps: echo "Tasks generated in specs/[BRANCH]/tasks.md"
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.tasks` in the triggering message **is** the task generation focus or additional
requirements. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not
ask the user to repeat it unless they provided an empty command.

Given that task generation focus, do this:

1. **Identify the feature to generate tasks for**:

    - If on a feature branch, use the current branch
    - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
    - Validate that the plan file exists: `specs/[BRANCH]/plan.md`
    - Validate that the spec file exists: `specs/[BRANCH]/spec.md`

1. **Extract key information from the specification and plan**:

    - User stories and acceptance scenarios from spec
    - Functional requirements from spec
    - Implementation approach from plan
    - Team persona inputs from plan
    - Project structure from plan
    - Team implementation phases from plan
    - Success criteria from both spec and plan

1. **Generate tasks organized by implementation phase**:

    - Phase 1: Research & Design Tasks
    - Phase 2: Implementation Tasks
    - Phase 3: Testing Tasks
    - Phase 4: Deployment Tasks

1. **Assign team role ownership for each task**:

    - Product Manager: Tasks related to user value validation, success metrics
    - Technical Architect: Tasks related to architecture decisions, technical reviews
    - UX Designer: Tasks related to user experience implementation, design validation
    - Quality Assurance: Tasks related to testing, quality gates, risk assessment
    - Developer: Tasks related to coding, implementation, code quality
    - DevOps: Tasks related to deployment, infrastructure, operational concerns

1. **Define cross-team dependencies**:

    - Identify tasks that depend on other team members' completion
    - Document technical dependencies between tasks
    - Plan for team collaboration points

1. **Estimate task duration and priority**:

    - Assign P1/P2/P3 priorities based on user story importance
    - Provide time estimates in days
    - Consider team member availability and expertise

1. **Create team resource allocation plan**:

    - Define how much time each team member should dedicate
    - Consider current workload and competing priorities
    - Plan for handoffs between team members

1. **Define team milestones**:

    - Create checkpoints where team validates progress
    - Align milestones with user story completion
    - Include team validation points

1. **Establish team communication plan**:

    - Define daily standup schedule
    - Define weekly sync schedule
    - Plan for task update frequency
    - Establish escalation procedures

1. **Create team risk mitigation plan**:

    - Identify risks specific to task execution
    - Define mitigation strategies
    - Assign risk owners

1. **Define team success criteria for task execution**:

    - Task completion criteria
    - Team performance metrics
    - Delivery success metrics

1. **Write the tasks to** `specs/[BRANCH]/tasks.md` using the team template structure, with proper assignment and
    tracking information.

## Team Task Generation Guidelines

### Phase 1: Research & Design Tasks

- Focus on validation and planning activities
- Assign to team members with relevant expertise
- Include team validation steps
- Ensure alignment with plan and spec

### Phase 2: Implementation Tasks

- Focus on development and implementation activities
- Assign based on technical expertise and role
- Include code quality and review requirements
- Plan for iterative development and team feedback

### Phase 3: Testing Tasks

- Focus on validation and quality assurance activities
- Assign primarily to QA with developer support
- Include automated and manual testing
- Plan for team validation of quality gates

### Phase 4: Deployment Tasks

- Focus on operational and deployment activities
- Assign primarily to DevOps with team support
- Include monitoring and operational validation
- Plan for rollback and recovery procedures

## Team Task Structure

Each task should include:

- Task ID (with phase prefix: RD, IMPL, TEST, DEPLOY)
- Description (clear and actionable)
- Team Role (specific team member responsibility)
- Priority (P1/P2/P3)
- Estimated Duration (in days)
- Owner (specific team member)
- Status (To Do/In Progress/Done)
- Dependencies (other tasks or team members)

## Cross-Team Dependencies

Document dependencies between:

- UX Designer and Developer (design implementation)
- Developer and QA (feature delivery for testing)
- QA and DevOps (release validation)
- PM and all roles (validation of user value)
- Technical Architect and all roles (technical decisions)
- All roles and DevOps (operational concerns)

## Team Communication Requirements

- Daily standups to track progress
- Regular sync meetings for dependency management
- Task update procedures
- Escalation paths for blocked tasks
- Team validation checkpoints

## Output Requirements

1. Create comprehensive task breakdown in `specs/[BRANCH]/tasks.md`
1. Assign each task to specific team role with accountable owner
1. Identify all cross-team dependencies
1. Estimate duration and priority for all tasks
1. Define team resource allocation
1. Create milestone definitions with team validation points
1. Establish team communication schedule
1. Define team risk mitigation strategies
1. Update agent context with new task information

## Guidelines

- Ensure tasks are specific and actionable
- Validate task assignments with team role responsibilities
- Consider team member availability and expertise
- Plan for iterative development and team feedback
- Include team validation points throughout
- Maintain traceability back to user stories and requirements
- Plan for effective team collaboration and communication
- Align task priorities with user story priorities
- Consider team dynamics and communication styles
- Plan for cross-training and knowledge sharing

## Success Criteria for Task Generation

- All tasks are assigned to specific team roles
- Task dependencies are clearly identified and managed
- Timeline is realistic given team availability
- Team communication plan is clearly defined
- Risk mitigation strategies are in place
- Success criteria are measurable and tracked
- Team member workloads are balanced appropriately
- Cross-team collaboration is planned and documented

<!--
description: Create or update the project constitution that defines team principles and working agreements.
scripts:
  sh: echo "Constitution updated in memory/constitution.md"
  ps: echo "Constitution updated in memory/constitution.md"
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.constitution` in the triggering message **is** the constitution update focus or new
principles. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not
ask the user to repeat it unless they provided an empty command.

Given that constitution focus, do this:

1. **Locate or create the project constitution**:

   - Check for existing constitution file: `memory/constitution.md`
   - If exists, load the current constitution
   - If not exists, start with a basic framework

1. **Analyze user input for constitution updates**:

   - Identify new principles or working agreements mentioned
   - Identify updates or modifications to existing principles
   - Identify team collaboration guidelines to add or modify
   - Consider team persona responsibilities and guidelines

1. **Update the constitution structure**:

   - Maintain consistent structure with existing constitution if present
   - Add or update principles based on user input
   - Include team persona responsibilities and guidelines
   - Define team working agreements and processes

1. **Ensure team methodology alignment**:

   - Include all 6 team personas: Product Manager, Technical Architect, UX Designer, Quality Assurance, Developer,
     DevOps Engineer
   - Define collaboration guidelines for cross-functional work
   - Include decision-making processes for team conflicts
   - Define communication protocols and expectations
   - Establish quality standards and validation processes

1. **Integrate team persona perspectives**:

   - Document Product Manager responsibilities (user value, success metrics)
   - Document Technical Architect responsibilities (feasibility, architecture)
   - Document UX Designer responsibilities (user experience, accessibility)
   - Document Quality Assurance responsibilities (testing, quality standards)
   - Document Developer responsibilities (implementation, code quality)
   - Document DevOps responsibilities (deployment, operations)

1. **Define team collaboration processes**:

   - Communication protocols (meetings, updates, notifications)
   - Decision-making hierarchy and escalation paths
   - Conflict resolution procedures
   - Validation and review processes
   - Cross-team dependency management

1. **Document quality standards**:

   - Code quality standards and review processes
   - Testing requirements and quality gates
   - Documentation standards
   - Performance and security requirements
   - Operational and deployment standards

1. **Write the updated constitution** to `memory/constitution.md` preserving existing content while incorporating new
   principles from user input.

## Constitution Structure Requirements

The constitution should include these key sections:

### Team Personas and Responsibilities

- Clear definition of each team persona role
- Specific responsibilities for each persona
- Decision-making authorities for each persona
- Validation requirements for each persona

### Team Collaboration Guidelines

- Communication protocols and expectations
- Meeting structures and schedules
- Information sharing processes
- Conflict resolution procedures
- Escalation paths for issues

### Quality Standards

- Code quality requirements
- Testing standards and coverage
- Documentation requirements
- Performance and security standards
- Operational and deployment standards

### Decision-Making Processes

- How technical decisions are made
- How product decisions are made
- How design decisions are made
- How quality decisions are made
- How operational decisions are made

### Working Agreements

- Team availability and response time expectations
- Definition of "done" for different work types
- Change management processes
- Risk management procedures
- Continuous improvement processes

## Team Validation Requirements

Each constitution update should be validated against:

- Alignment with team persona responsibilities
- Consistency with team methodology principles
- Feasibility of implementation
- Clarity and understandability for all team members
- Effectiveness in improving team collaboration

## Output Requirements

1. Update or create `memory/constitution.md` with new principles
1. Ensure all team personas are properly represented
1. Define clear team working agreements
1. Establish decision-making and communication protocols
1. Document quality standards and validation processes
1. Update agent context with constitution changes

## Guidelines

- Maintain consistency with existing constitution if present
- Ensure all team persona responsibilities are clearly defined
- Focus on practical, actionable principles rather than abstract concepts
- Balance individual responsibilities with team collaboration
- Include both technical and human elements of team work
- Keep principles clear and concise for easy reference
- Ensure principles support effective team collaboration
- Consider both current and future team needs
- Align with industry best practices while maintaining team-specific elements

## Success Criteria for Constitution

- All 6 team personas have clearly defined responsibilities
- Team collaboration processes are clearly documented
- Quality standards are well-defined and achievable
- Decision-making processes are clear and fair
- Communication protocols are practical and effective
- Working agreements are realistic and agreed upon
- Constitution supports effective team methodology implementation
- Principles are actionable and measurable

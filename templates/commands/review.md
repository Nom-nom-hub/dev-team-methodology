<!--
description: Review and validate feature specifications from all team persona perspectives.
scripts:
  sh: scripts/bash/update-agent-context.sh {ARGS}
  ps: scripts/powershell/update-agent-context.ps1 {ARGS}
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.review` in the triggering message **is** the review description or validation
focus. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the
user to repeat it unless they provided an empty command.

Given that review description or focus, do this:

1. **Identify the feature to review**:

   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that the spec file exists: `specs/[BRANCH]/spec.md`

1. **Load the existing specification** from the feature directory.

1. **Validate specification against each team persona perspective**:

   a. **Product Manager Perspective Validation**:

   - User value alignment (does the spec deliver clear user value?)
   - Success metrics clarity (are success metrics specific and measurable?)
   - Business justification completeness (is the business case well-defined?)
   - Requirements alignment with user needs (do requirements serve user goals?)

   b. **Technical Architect Perspective Validation**:

   - Technical feasibility (is the approach technically achievable?)
   - Architecture soundness (does the architecture make sense?)
   - Performance considerations (are performance goals realistic?)
   - Scalability requirements (are growth needs addressed?)

   c. **UX Designer Perspective Validation**:

   - User experience adequacy (will users find this intuitive?)
   - Accessibility compliance (does it meet accessibility standards?)
   - Usability requirements (are user flows optimized?)
   - Design constraint addressing (are design limitations handled?)

   d. **Quality Assurance Perspective Validation**:

   - Requirement testability (can all requirements be tested independently?)
   - Quality metric definition (are quality standards clear?)
   - Risk assessment completeness (are quality risks identified?)
   - Security requirement addressing (are security concerns covered?)

   e. **Developer Perspective Validation**:

   - Implementation approach clarity (is the technical plan clear?)
   - Code quality standard definition (are quality expectations set?)
   - Performance implication understanding (are resource needs considered?)
   - Technical requirement clarity (are technical specs detailed enough?)

   f. **DevOps Perspective Validation**:

   - Operational requirement meeting (are operational needs met?)
   - Deployment strategy clarity (is deployment approach clear?)
   - Monitoring requirement definition (are monitoring needs addressed?)
   - Security scanning addressing (are security checks included?)

1. **Generate team validation checklist**:

   - Create or update `specs/[BRANCH]/checklists/team-validation-checklist.md`
   - Include validation items for each persona perspective
   - Track completion status for each validation item

1. **Create validation summary report**:

   - List all validation items that passed
   - List all validation items that failed
   - Provide specific recommendations for specification improvements
   - Identify which team personas need to review specific sections

1. **Update agent context files**:

   - Run the update script `{SCRIPT}` to update agent context with new validation information
   - This ensures AI agents are aware of team validation results

1. **Provide next steps recommendations**:

   - If validation is complete and all perspectives are satisfied: recommend `/team.plan`
   - If validation reveals issues: recommend specification updates followed by `/team.review` iteration
   - If team perspectives conflict: recommend team discussion and consensus building

## Team Validation Criteria

Each validation should result in one of these outcomes for each persona:

- **Validated**: Perspective fully incorporated and validated
- **Needs Update**: Perspective needs clarification or improvement
- **Not Applicable**: Perspective not relevant to this specific feature

## Output Requirements

1. Provide validation report with pass/fail status for each team persona
1. List specific sections that need attention or improvement
1. Suggest specific updates to address validation issues
1. Update the specification in place with team perspective validation notes
1. Create or update the team validation checklist
1. Update agent context files with validation results

## Guidelines

- Focus on validation rather than implementation details
- Ensure all team perspectives are equally considered
- Document any conflicts between team perspectives for team discussion
- Maintain alignment between all team success metrics
- Validate that cross-team dependencies are properly addressed
- Verify that team collaboration guidelines are followed
- Check that responsibility assignments are clear and appropriate

## Success Criteria for Review

- All 6 team personas have validated their respective perspectives
- All functional requirements are testable from QA perspective
- Technical feasibility is confirmed by Technical Architect
- User value is clear from Product Manager perspective
- Implementation approach is feasible from Developer perspective
- Operational requirements are addressed from DevOps perspective
- User experience is validated from UX Designer perspective

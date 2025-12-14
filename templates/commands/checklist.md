###
description: Generate quality checklists to validate requirements completeness, clarity, and consistency from all team perspectives.
scripts:
  sh: echo "Checklist generated in specs/[BRANCH]/checklists/requirements-checklist.md"
  ps: echo "Checklist generated in specs/[BRANCH]/checklists/requirements-checklist.md"
###

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.checklist` in the triggering message **is** the checklist focus or specific validation requirements. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask the user to repeat it unless they provided an empty command.

Given that checklist focus, do this:

1. **Identify the feature to create checklists for**:
   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that the spec file exists: `specs/[BRANCH]/spec.md`
   - Create or validate the checklists directory: `specs/[BRANCH]/checklists/`

2. **Analyze the specification** to identify all elements that need validation:
   - User stories and acceptance scenarios
   - Functional requirements
   - Success criteria
   - Key entities and data models
   - Team persona perspectives and inputs
   - Edge cases and error conditions
   - Constraints and assumptions

3. **Generate comprehensive team validation checklist** organized by team persona:

   a. **Product Manager Checklist**:
      - User value alignment validation
      - Success metrics clarity validation
      - Business justification validation
      - User story completeness validation
      - Requirement alignment validation

   b. **Technical Architect Checklist**:
      - Technical feasibility validation
      - Architecture pattern validation
      - Performance requirement validation
      - Scalability consideration validation
      - Technical constraint validation

   c. **UX Designer Checklist**:
      - User experience adequacy validation
      - Accessibility requirement validation
      - Design constraint validation
      - Usability requirement validation
      - User flow optimization validation

   d. **Quality Assurance Checklist**:
      - Requirement testability validation
      - Quality metric definition validation
      - Risk assessment completeness validation
      - Security requirement validation
      - Testing approach validation

   e. **Developer Checklist**:
      - Implementation approach clarity validation
      - Code quality standard validation
      - Performance consideration validation
      - Technical requirement clarity validation
      - Maintainability validation

   f. **DevOps Checklist**:
      - Operational requirement validation
      - Deployment strategy validation
      - Monitoring requirement validation
      - Security scanning validation
      - Infrastructure need validation

4. **Create cross-team validation checklist**:
   - All team perspectives included validation
   - Team collaboration plan validation
   - Communication guideline validation
   - Responsibility matrix validation

5. **Generate completeness checklist**:
   - All required sections completed validation
   - All team inputs incorporated validation
   - All validations performed validation
   - All risks identified and mitigated validation
   - All dependencies resolved validation

6. **Create sign-off checklist**:
   - Product Manager approval validation
   - Technical Architect approval validation
   - UX Designer approval validation
   - Quality Assurance approval validation
   - Developer approval validation
   - DevOps approval validation

7. **Write the checklist** to `specs/[BRANCH]/checklists/requirements-checklist.md` using the team template structure with all validation items.

## Checklist Structure Requirements

Each checklist should include:
- Clear, specific validation items
- Checkboxes for completion tracking ([ ] / [x])
- Validation owner (team persona responsible)
- Validation date and sign-off
- Remediation steps if validation fails

## Team Validation Process

For each checklist item:
- Verify the specification element meets team standards
- Check alignment with team persona perspectives
- Confirm completeness and clarity
- Validate testability and measurability
- Document any issues or concerns

## Cross-Team Validation Requirements

- Each requirement must be validated by relevant team personas
- Conflicts between team perspectives must be resolved
- All validations must be documented
- Sign-offs must be obtained from all relevant team members
- Validation results must be tracked and reported

## Output Requirements

1. Create comprehensive validation checklist in `specs/[BRANCH]/checklists/requirements-checklist.md`
2. Include validation items for all 6 team personas
3. Define validation owners and responsibilities
4. Create cross-team validation items
5. Establish completion criteria and sign-off process
6. Document remediation procedures for failed validations
7. Update agent context with validation process information

## Guidelines

- Ensure all validation items are specific and measurable
- Align validation criteria with team persona responsibilities
- Include both technical and business validation requirements
- Consider both current and future validation needs
- Make validation items actionable and clear
- Plan for validation tracking and reporting
- Include remediation steps for failed validations
- Ensure validation process is efficient and effective
- Maintain alignment with team methodology principles

## Success Criteria for Checklist

- All team personas have specific validation items
- Validation items are comprehensive and complete
- Process is clear and actionable
- Results are trackable and reportable
- Remediation process is defined and effective
- Sign-off process is clear and achievable
- Validation supports quality requirements
- Checklist improves specification quality
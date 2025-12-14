<!--
description: Perform cross-artifact consistency and alignment report from all team perspectives.
scripts:
  sh: echo "Analysis report generated in specs/[BRANCH]/analysis-report.md"
  ps: echo "Analysis report generated in specs/[BRANCH]/analysis-report.md"
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.analyze` in the triggering message **is** the analysis focus or specific areas to
examine. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not ask
the user to repeat it unless they provided an empty command.

Given that analysis focus, do this:

1. **Identify the feature to analyze**:

   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that all relevant files exist:
     - Specification: `specs/[BRANCH]/spec.md`
     - Implementation plan: `specs/[BRANCH]/plan.md`
     - Tasks: `specs/[BRANCH]/tasks.md`
     - Checklists: `specs/[BRANCH]/checklists/`
     - Team persona perspectives: `specs/[BRANCH]/personas/`

1. **Perform cross-artifact consistency analysis**:

   - Compare user stories between spec and plan
   - Validate that requirements in spec align with implementation approach in plan
   - Check that success criteria in spec match success criteria in plan
   - Verify that functional requirements match planned tasks
   - Confirm that team persona inputs in spec are reflected in plan
   - Validate that team assignments in tasks align with persona responsibilities

1. **Analyze consistency from each team persona perspective**:

   a. **Product Manager Consistency Analysis**:

   - User value alignment between spec, plan, and tasks
   - Success metrics consistency across artifacts
   - Business justification alignment
   - Requirement prioritization consistency

   b. **Technical Architect Consistency Analysis**:

   - Technical feasibility confirmation across artifacts
   - Architecture approach consistency between plan and tasks
   - Performance and scalability requirements alignment
   - Technical constraint consistency

   c. **UX Designer Consistency Analysis**:

   - User experience requirements consistency
   - Accessibility requirement alignment
   - Design system integration consistency
   - Usability requirement alignment

   d. **Quality Assurance Consistency Analysis**:

   - Testing approach consistency between plan and tasks
   - Quality metric definition alignment
   - Risk assessment consistency
   - Security requirement alignment

   e. **Developer Consistency Analysis**:

   - Implementation approach alignment between plan and tasks
   - Code quality standard consistency
   - Performance consideration alignment
   - Technical requirement clarity

   f. **DevOps Consistency Analysis**:

   - Deployment strategy alignment between plan and tasks
   - Infrastructure requirement consistency
   - Operational consideration alignment
   - Security scanning consistency

1. **Check for gaps and inconsistencies**:

   - Requirements in spec but not addressed in plan/tasks
   - Team persona perspectives missing from any artifact
   - Success criteria defined in one place but not others
   - Dependencies defined in one artifact but not coordinated in others
   - Cross-team collaboration points not properly documented

1. **Validate team methodology compliance**:

   - All 6 team personas represented in all relevant artifacts
   - Team collaboration guidelines followed consistently
   - Cross-team validation points properly defined
   - Team decision-making processes documented
   - Quality standards consistently applied

1. **Analyze risk factors**:

   - Identify areas where team perspectives conflict
   - Highlight dependencies not properly managed
   - Flag requirements without proper team validation
   - Identify potential team collaboration issues

1. **Generate comprehensive analysis report** with findings organized by:

   - Consistency issues by team persona
   - Cross-artifact alignment problems
   - Team methodology compliance gaps
   - Risk factors and mitigation recommendations

1. **Create action items** for addressing identified issues:

   - Specific updates needed for consistency
   - Team discussions required for alignment
   - Process improvements for future features
   - Validation steps needed before proceeding

1. **Write the analysis report** to `specs/[BRANCH]/analysis-report.md` with detailed findings and recommendations.

## Analysis Structure Requirements

The analysis should include:

### Consistency Matrix

- Comparison chart showing alignment between spec, plan, and tasks
- Team persona representation in each artifact
- Gap analysis highlighting inconsistencies

### Team Persona Analysis

- Detailed consistency review for each team persona
- Alignment of perspectives across artifacts
- Validation of team input utilization

### Risk Assessment

- Identification of consistency-related risks
- Impact assessment for each identified risk
- Mitigation recommendations

### Action Items

- Specific corrections needed
- Team collaboration requirements
- Process improvements suggested

## Cross-Team Validation Requirements

- Validate that team persona inputs are consistently applied
- Confirm that cross-team dependencies are properly documented
- Ensure team collaboration points align across artifacts
- Verify that team decision-making processes are consistent
- Check that team communication requirements are aligned

## Output Requirements

1. Generate comprehensive analysis report in `specs/[BRANCH]/analysis-report.md`
1. Include consistency matrix comparing all artifacts
1. Provide team persona-specific consistency analysis
1. Identify all gaps and inconsistencies
1. Assess risks related to inconsistency
1. Create actionable recommendations
1. Validate team methodology compliance
1. Update agent context with analysis results

## Guidelines

- Focus on factual inconsistencies rather than opinion differences
- Include specific references to locations where inconsistencies occur
- Prioritize issues by impact on feature success
- Consider both technical and team collaboration aspects
- Maintain objectivity in analysis
- Provide constructive recommendations
- Document evidence for all findings
- Consider both current and future impact of inconsistencies

## Success Criteria for Analysis

- All artifacts are thoroughly compared for consistency
- Team persona perspectives are validated across artifacts
- Cross-artifact alignment is confirmed
- Risk factors are identified and assessed
- Actionable recommendations are provided
- Team methodology compliance is validated
- Analysis findings are clearly documented and traceable
- Recommendations are prioritized by impact

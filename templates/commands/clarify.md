<!--
description: Ask structured questions to de-risk ambiguous areas before planning from all team perspectives.
scripts:
  sh: echo "Clarification questions documented in specs/[BRANCH]/clarification-log.md"
  ps: echo "Clarification questions documented in specs/[BRANCH]/clarification-log.md"
-->

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Outline

The text the user typed after `/team.clarify` in the triggering message **is** the clarification focus or specific areas
of concern. Assume you always have it available in this conversation even if `{ARGS}` appears literally below. Do not
ask the user to repeat it unless they provided an empty command.

Given that clarification focus, do this:

1. **Identify the feature to clarify**:

   - If on a feature branch, use the current branch
   - Determine the feature directory path: `specs/[FEATURE-NUMBER]-[FEATURE-NAME]`
   - Validate that the spec file exists: `specs/[BRANCH]/spec.md`
   - Check for existing clarification log: `specs/[BRANCH]/clarification-log.md`

1. **Analyze the specification for ambiguous or unclear areas**:

   - Review user stories for clarity and completeness
   - Identify [NEEDS CLARIFICATION] markers from the spec
   - Check acceptance scenarios for testability
   - Evaluate functional requirements for specificity
   - Assess success criteria for measurability
   - Review team persona perspectives for completeness
   - Identify edge cases that need elaboration

1. **Generate structured clarification questions organized by team persona impact**:

   a. **Product Manager Clarification Questions**:

   - User value questions: "What specific user problem does this solve?"
   - Success metric questions: "How will we measure success?"
   - Business justification questions: "What's the business case?"
   - User story priority questions: "What's the priority of this story?"

   b. **Technical Architect Clarification Questions**:

   - Feasibility questions: "Is this technically achievable with current constraints?"
   - Architecture questions: "What architectural pattern should be used?"
   - Performance questions: "What are the performance requirements?"
   - Scalability questions: "How should we handle growth?"

   c. **UX Designer Clarification Questions**:

   - User experience questions: "What's the intended user flow?"
   - Accessibility questions: "What accessibility standards apply?"
   - Design constraint questions: "What are the design limitations?"
   - Usability questions: "How should this feel to users?"

   d. **Quality Assurance Clarification Questions**:

   - Testability questions: "How can this be tested effectively?"
   - Quality metric questions: "What defines quality for this feature?"
   - Risk assessment questions: "What are the quality risks?"
   - Security questions: "What security validation is needed?"

   e. **Developer Clarification Questions**:

   - Implementation questions: "What's the best technical approach?"
   - Code quality questions: "What standards apply here?"
   - Integration questions: "How does this integrate with existing code?"
   - Performance questions: "What are the performance constraints?"

   f. **DevOps Clarification Questions**:

   - Deployment questions: "How should this be deployed?"
   - Infrastructure questions: "What infrastructure is needed?"
   - Operational questions: "How will this be monitored?"
   - Security questions: "What operational security is required?"

1. **Prioritize questions by impact and risk**:

   - Highest priority: Questions that could change feature scope
   - High priority: Questions that affect technical approach
   - Medium priority: Questions that affect quality or timeline
   - Lower priority: Questions for optimization or enhancement

1. **Format questions as structured decision tables**:

   - Each question should have suggested answers with implications
   - Include impact assessment for each possible answer
   - Define decision criteria for choosing between options

1. **Document all clarification activities** in `specs/[BRANCH]/clarification-log.md`:

   - Date and time of clarification request
   - Questions asked and answers received
   - Decisions made and rationale
   - Team persona input and validation
   - Impact on specification or plan

1. **Update the specification** based on clarifications received:

   - Replace [NEEDS CLARIFICATION] markers with resolved information
   - Update requirements with specific details
   - Refine acceptance scenarios with clearer criteria
   - Add team persona validations where needed

1. **Validate that clarifications support team methodology**:

   - Ensure all team personas have input on relevant decisions
   - Confirm that cross-team dependencies are addressed
   - Verify that team collaboration guidelines are followed
   - Check that quality standards are maintained

## Clarification Question Format

Each question should follow this structure:

```markdown
## Question [N]: [Topic]

**Context**: [Quote relevant spec section]

**What we need to know**: [Specific question from NEEDS CLARIFICATION marker]

**Suggested Answers**:

| Option | Answer | Implications |
|--------|--------|--------------|
| A      | [First suggested answer] | [What this means for the feature] |
| B      | [Second suggested answer] | [What this means for the feature] |
| C      | [Third suggested answer] | [What this means for the feature] |
| Custom | Provide your own answer | [Explain how to provide custom input] |

**Team Persona Impact**:
- Product Manager: [Impact on user value]
- Technical Architect: [Impact on technical approach]
- UX Designer: [Impact on user experience]
- Quality Assurance: [Impact on testing]
- Developer: [Impact on implementation]
- DevOps: [Impact on operations]

**Your choice**: _[Wait for user response]_
```

## Cross-Team Clarification Requirements

- Questions that affect multiple team personas should be escalated to team discussion
- Technical decisions should involve Technical Architect and Developer input
- UX decisions should involve UX Designer and Product Manager input
- Quality decisions should involve QA and Developer input
- Operational decisions should involve DevOps and Technical Architect input

## Output Requirements

1. Generate structured clarification questions organized by team persona impact
1. Create or update `specs/[BRANCH]/clarification-log.md` with all questions and answers
1. Update the specification with resolved clarifications
1. Prioritize questions by risk and impact
1. Format questions as decision tables with implications
1. Validate that all relevant team personas have input on major decisions
1. Update agent context with clarification results

## Guidelines

- Focus on questions that significantly impact feature scope or approach
- Limit to maximum 3 highest-priority questions per clarification session
- Include implications for each possible answer
- Ensure questions are specific and actionable
- Consider impact on all relevant team personas
- Document decisions and rationale for future reference
- Validate resolutions with relevant team personas
- Update specifications promptly after clarification
- Maintain traceability between questions and specification changes

## Success Criteria for Clarification

- All [NEEDS CLARIFICATION] markers are resolved
- Highest-impact questions are addressed first
- All relevant team personas have input on affected decisions
- Resolutions are clearly documented and traceable
- Specification is updated with clarification results
- Team methodology principles are maintained
- Cross-team dependencies are properly addressed
- Quality standards are upheld after clarification

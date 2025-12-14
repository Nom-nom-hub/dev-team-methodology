# Team-Driven Development (TDD)

## The Professional Team Approach

For decades, software development has focused on individual roles operating in silos - product managers defining
requirements, architects designing systems, developers building code, and quality assurance testing the result. While
this approach has delivered many successful products, it has inherent gaps where important considerations are missed,
miscommunicated, or only addressed after costly rework.

Team-Driven Development (TDD) inverts this traditional approach. Rather than having team members operate sequentially,
TDD brings together all professional team personas from the very beginning of a project. This collaborative approach
ensures that the Product Requirements Document (PRD) isn't just the domain of product managers - it benefits from
architectural insights, UX expertise, quality perspectives, development practicality, and operational requirements.

The gap between specification and implementation has plagued software development since its inception. When
specifications are created by a single persona or in a vacuum, critical considerations from other perspectives are often
missed until implementation, leading to expensive rework. TDD eliminates this gap by incorporating all team persona
perspectives from the very beginning, creating specifications that are simultaneously business-focused, architecturally
sound, user-centered, testable, implementable, and operationally viable.

This transformation is now possible because AI can understand and implement complex specifications from multiple
perspectives simultaneously, and create detailed implementation plans that consider all team inputs. The Team-Driven
approach provides that structure through specifications and subsequent implementation plans that are precise, complete,
and unambiguous enough to generate working systems while considering all professional perspectives.

In this new world, maintaining software means evolving specifications with input from all personas. The intent of the
development team is expressed in natural language ("**intent-driven development**"), design assets, core principles, and
other guidelines from all team perspectives. The **lingua franca** of development moves to a higher level, and code is
the last-mile approach.

Debugging means fixing specifications and their implementation plans that generate incorrect code, considering feedback
from all personas. Refactoring means restructuring for clarity from all persona perspectives. The entire development
workflow reorganizes around specifications as the central source of truth, with implementation plans and code as the
continuously regenerated output. Updating apps with new features means engaging all personas in the specification
process to ensure comprehensive consideration.

## The TDD Workflow in Practice

The workflow begins with an idea—often vague and incomplete. Through iterative dialogue with AI, this idea becomes a
comprehensive PRD that incorporates perspectives from all team personas. The AI asks clarifying questions on behalf of
each persona, identifies edge cases from multiple angles, and helps define precise acceptance criteria that satisfy all
perspectives. What might take days of meetings and documentation in traditional development happens in hours of focused
team-based specification work.

The key innovation is that instead of a single perspective defining requirements, all team personas contribute
simultaneously:

- Product Manager: Focuses on user value, market fit, and business requirements
- Technical Architect: Considers feasibility, scalability, and technical constraints
- UX Designer: Ensures user experience and accessibility requirements
- Quality Assurance: Identifies testability and quality requirements
- Developer: Evaluates implementation practicality and complexity
- DevOps Engineer: Addresses deployment and operational requirements

Throughout this specification process, research agents gather critical context from all perspectives. They investigate
library compatibility (DevOps), performance benchmarks (Architect), security implications (QA), user experience patterns
(UX), and operational requirements (DevOps). Organizational constraints are discovered and applied automatically—your
company's database standards, authentication requirements, deployment policies, and accessibility guidelines seamlessly
integrate into every specification.

From the multi-perspective PRD, AI generates implementation plans that map requirements to technical decisions, with
input from all personas. Every technology choice has documented rationale from all relevant perspectives. Every
architectural decision traces back to specific requirements and has been validated by all personas. Throughout this
process, consistency validation continuously improves quality. AI analyzes specifications for ambiguity, contradictions,
and gaps from all perspectives—not as a one-time gate, but as an ongoing refinement.

Code generation begins as soon as specifications and their implementation plans are stable enough, but they do not have
to be "complete." Early generations might be exploratory—testing whether the specification makes sense in practice.
Domain concepts become data models. User stories become API endpoints. Acceptance scenarios become tests. This merges
development and testing through specification—test scenarios aren't written after code, they're part of the
specification that generates both implementation and tests.

The feedback loop extends beyond initial development. Production metrics and incidents don't just trigger hotfixes—they
update specifications for the next regeneration. Performance bottlenecks become new non-functional requirements.
Security vulnerabilities become constraints that affect all future generations. This iterative dance between
specification, implementation, and operational reality is where true understanding emerges and where the traditional
SDLC transforms into a continuous evolution.

## Why TDD Matters Now

Three trends make TDD not just possible but necessary:

First, AI capabilities have reached a threshold where natural language specifications from multiple perspectives can
reliably generate working code. This isn't about replacing team members—it's about amplifying their effectiveness by
automating the mechanical translation from multi-perspective specification to implementation. It can amplify exploration
and creativity, support "start-over" easily, and support addition, subtraction, and critical thinking.

Second, software complexity continues to grow exponentially. Modern systems integrate dozens of services, frameworks,
and dependencies. Keeping all these pieces aligned with original intent through manual processes becomes increasingly
difficult. TDD provides systematic alignment through specification-driven generation that incorporates all team
perspectives. Frameworks may evolve to provide AI-first support, not human-first support, or architect around reusable
components.

Third, the pace of change accelerates. Requirements change far more rapidly today than ever before. Pivoting is no
longer exceptional—it's expected. Modern product development demands rapid iteration based on user feedback, market
conditions, and competitive pressures. Traditional development treats these changes as disruptions. Each pivot requires
manually propagating changes through documentation, design, and code. The result is either slow, careful updates that
limit velocity, or fast, reckless changes that accumulate technical debt.

TDD can support what-if/simulation experiments: "If we need to re-implement or change the application to promote a
business need to sell more T-shirts, how would we implement and experiment for that?" All team perspectives are
considered in these scenarios.

TDD transforms requirement changes from obstacles into normal workflow. When specifications drive implementation with
all team perspectives, pivots become systematic regenerations rather than manual rewrites. Change a core requirement in
the PRD, and affected implementation plans update automatically while considering all team perspectives. Modify a user
story, and corresponding API endpoints regenerate with consideration for all personas. This isn't just about initial
development—it's about maintaining engineering velocity through inevitable changes.

## Core Principles

**Specifications as the Lingua Franca**: The specification becomes the primary artifact. Code becomes its expression in
a particular language and framework. Maintaining software means evolving specifications with input from all team
personas.

**Multi-Perspective Specifications**: Specifications must incorporate perspectives from all team personas to ensure they
are executable in practice. This eliminates the gap between intent and implementation.

**Team-First Approach**: All team personas contribute to specification and planning from the beginning, not just during
implementation.

**Continuous Refinement**: Consistency validation happens continuously from all team perspectives, not as a one-time
gate. AI analyzes specifications for ambiguity, contradictions, and gaps from all perspectives as an ongoing process.

**Research-Driven Context**: Research agents gather critical context from all team perspectives throughout the
specification process, investigating technical options, performance implications, security considerations, user
experience patterns, and organizational constraints.

**Bidirectional Feedback**: Production reality informs specification evolution. Metrics, incidents, and operational
learnings become inputs for specification refinement from all team perspectives.

**Branching for Exploration**: Generate multiple implementation approaches from the same multi-perspective specification
to explore different optimization targets—performance, maintainability, user experience, cost—while considering all team
perspectives.

## Implementation Approaches

Today, practicing TDD requires assembling existing tools and maintaining discipline throughout the process. The
methodology can be practiced with:

- AI assistants for iterative multi-perspective specification development
- Research agents for gathering technical context from all team perspectives
- Code generation tools for translating multi-perspective specifications to implementation
- Version control systems adapted for team-focused workflows
- Consistency checking through AI analysis of specification documents from all team perspectives

The key is treating specifications as the source of truth that incorporates all team perspectives, with code as the
generated output that serves the specification rather than the other way around.

## Streamlining TDD with Commands

The TDD methodology is significantly enhanced through powerful commands that automate the multi-perspective
specification → planning → tasking workflow:

### The `/team.personas` Command

This command defines the professional team personas that will contribute to the development process:

1. **Defines Team Personas**: Creates detailed descriptions for Product Manager, Technical Architect, UX Designer,
   Quality Assurance, Developer, and DevOps Engineer
1. **Establishes Responsibilities**: Defines each persona's focus areas and contribution requirements
1. **Creates Template Documentation**: Generates persona-specific guidance documents
1. **Directory Structure**: Creates the proper `personas/[persona]/` structure for all related documents

### The `/team.specify` Command

This command transforms a simple feature description (the user-prompt) into a complete, structured specification with
input from all team personas:

1. **Automatic Feature Numbering**: Scans existing specs to determine the next feature number (e.g., 001, 002, 003)
1. **Branch Creation**: Generates a semantic branch name from your description and creates it automatically
1. **Template-Based Generation**: Copies and customizes the feature specification template with your requirements
1. **Multi-Perspective Input**: Incorporates considerations from all team personas into the specification
1. **Directory Structure**: Creates the proper `specs/[branch-name]/` structure for all related documents

### The `/team.review` Command

Once a feature specification exists, this command has each team persona review it from their perspective:

1. **Product Manager Review**: Focuses on user value, business requirements, and success metrics
1. **Technical Architect Review**: Assesses technical feasibility, scalability, and architecture
1. **UX Designer Review**: Evaluates user experience, accessibility, and design consistency
1. **QA Review**: Considers testability, quality metrics, and risk factors
1. **Developer Review**: Reviews implementation complexity and practicality
1. **DevOps Review**: Evaluates deployment, operational, and security considerations

### The `/team.plan` Command

Once specification is reviewed from all perspectives, this command creates a comprehensive implementation plan with team
input:

1. **Specification Analysis**: Reads and understands the feature requirements, user stories, and acceptance criteria
1. **Multi-Perspective Compliance**: Ensures alignment with all team persona requirements
1. **Technical Translation**: Converts business requirements into technical architecture and implementation details
1. **Detailed Documentation**: Generates supporting documents for data models, API contracts, and test scenarios
1. **Quickstart Validation**: Produces a quickstart guide capturing key validation scenarios

### The `/team.tasks` Command

After a plan is created, this command analyzes the plan and related design documents to generate an executable task list
with team persona ownership:

1. **Inputs**: Reads `plan.md` (required) and, if present, `data-model.md`, `contracts/`, and `research.md`
1. **Task Derivation**: Converts contracts, entities, and scenarios into specific tasks
1. **Persona Ownership**: Assigns tasks to appropriate team personas based on their expertise
1. **Parallelization**: Marks independent tasks `[P]` and outlines safe parallel groups
1. **Output**: Writes `tasks.md` in the feature directory, ready for execution by team members

### Example: Building a Chat Feature with Team Input

Here's how these commands transform the traditional development workflow:

**Traditional Approach:**

```text
1. Product manager writes a PRD (2-3 hours)
1. Architect creates design documents (2-3 hours)
1. Set up project structure manually (30 minutes)
1. Developer writes technical specifications (3-4 hours)
1. QA creates test plans (2 hours)
Total: ~12 hours of sequential work with potential gaps
```

**TDD with Commands Approach:**

```bash
# Step 1: Define team personas (5 minutes)
/team.personas Define the team personas for this project: Product Manager, Technical Architect, UX Designer, Quality Assurance, Developer, DevOps Engineer.

# Step 2: Create the feature specification with team input (10 minutes)
/team.specify Real-time chat system with message history and user presence

# This automatically:
# - Creates branch "003-chat-system"
# - Generates specs/003-chat-system/spec.md
# - Incorporates considerations from all team personas
# - Populates it with structured requirements

# Step 3: Review specification from all perspectives (5 minutes)
/team.review Have each team persona review the specification: Product Manager checks for user value, Technical Architect assesses feasibility, UX Designer evaluates user experience, QA considers testability, Developer reviews implementation complexity, DevOps Engineer evaluates deployment requirements.

# Step 4: Generate implementation plan with team input (5 minutes)
/team.plan WebSocket for real-time messaging, PostgreSQL for history, Redis for presence. Consider scalability requirements from Architect, security needs from QA, deployment strategy from DevOps, and user experience from UX Designer.

# Step 5: Generate executable tasks with persona ownership (5 minutes)
/team.tasks

# This automatically creates:
# - specs/003-chat-system/plan.md
# - specs/003-chat-system/research.md (WebSocket library comparisons)
# - specs/003-chat-system/data-model.md (Message and User schemas)
# - specs/003-chat-system/contracts/ (WebSocket events, REST endpoints)
# - specs/003-chat-system/quickstart.md (Key validation scenarios)
# - specs/003-chat-system/tasks.md (Task list with team persona ownership)
```

In 30 minutes, you have:

- A complete feature specification with user stories and acceptance criteria incorporating all team perspectives
- A detailed implementation plan with technology choices and rationale considering all personas
- API contracts and data models ready for code generation
- Comprehensive test scenarios for both automated and manual testing
- Task assignments clearly indicating which persona is responsible for which work
- All documents properly versioned in a feature branch

### The Power of Team-Based Automation

These commands don't just save time—they enforce comprehensive team consideration:

1. **No Forgotten Perspectives**: Templates ensure every team persona perspective is considered
1. **Traceable Decisions**: Every technical choice links back to specific requirements from specific personas
1. **Living Documentation**: Specifications stay in sync with code and team input because they generate it
1. **Rapid Iteration**: Change requirements and regenerate plans in minutes, not days, with all team perspectives
   considered

The commands embody TDD principles by treating specifications as executable artifacts that incorporate all team
perspectives rather than static documents. They transform the specification process from a sequential approach into a
collaborative one that leverages all team expertise from the beginning.

### Template-Driven Quality: How Structure Constrains LLMs for Better Multi-Perspective Outcomes

The true power of these commands lies not just in automation, but in how the templates guide LLM behavior toward
higher-quality specifications that consider all team perspectives:

#### 1. **Preventing Single-Perspective Implementation Details**

The feature specification template explicitly instructs:

```text
- ✅ Focus on WHAT users need and WHY from all team perspectives
- ❌ Avoid HOW to implement (no tech stack, APIs, code structure) without team input
```

This constraint forces the LLM to maintain proper abstraction levels across all team perspectives. When an LLM might
naturally jump to "implement using React with Redux," the template keeps it focused on "users need real-time updates of
their data" while considering all team perspectives.

#### 2. **Forcing Multi-Perspective Uncertainty Markers**

Both templates mandate the use of `[NEEDS [PERSONA] CLARIFICATION]` markers:

```text
When creating this spec from a user prompt:
1. **Mark all ambiguities**: Use [NEEDS ARCHITECT CLARIFICATION: scalability question]
1. **Don't guess**: If the prompt doesn't specify something, mark it with the relevant persona
```

This prevents the common LLM behavior of making plausible but potentially incorrect assumptions. Instead of guessing
that a "login system" uses email/password authentication, the LLM must mark it as
`[NEEDS SECURITY QA CLARIFICATION: auth method requirements]`.

#### 3. **Structured Thinking Through Multi-Perspective Checklists**

The templates include comprehensive checklists that act as "unit tests" for the specification from each persona
perspective:

```markdown
### Multi-Perspective Requirement Completeness

- [ ] Product Manager: No [NEEDS PM CLARIFICATION] markers remain
- [ ] Technical Architect: No [NEEDS ARCHITECT CLARIFICATION] markers remain
- [ ] UX Designer: No [NEEDS UX CLARIFICATION] markers remain
- [ ] Quality Assurance: No [NEEDS QA CLARIFICATION] markers remain
- [ ] All requirements are testable and unambiguous
- [ ] Success criteria are measurable from all perspectives
```

These checklists force the LLM to self-review its output systematically from all team perspectives, catching gaps that
might otherwise slip through.

#### 4. **Team Constitutional Compliance Through Gates**

The implementation plan template enforces team architectural principles through phase gates:

```markdown
### Phase -1: Pre-Implementation Gates

#### Product Feasibility Gate
- [ ] PM: Product value clearly defined?
- [ ] UX: User experience viable?

#### Technical Feasibility Gate (Architect Perspective)
- [ ] Architect: Implementation technically feasible?
- [ ] QA: Testability requirements defined?

#### Operational Readiness Gate (DevOps Perspective)
- [ ] DevOps: Deployment and operational requirements met?
- [ ] QA: Security and compliance requirements addressed?
```

These gates prevent over-engineering by making the LLM explicitly validate aspects from all relevant personas. If a gate
fails, the LLM must document why in the "Complexity Tracking" section, creating accountability for all team
perspectives.

#### 5. **Hierarchical Detail Management with Team Input**

The templates enforce proper information architecture while considering team perspectives:

```text
**IMPORTANT**: This implementation plan should remain high-level and readable.
Any code samples, detailed algorithms, or extensive technical specifications
must be placed in the appropriate `implementation-details/` file
Consider input from all relevant team personas before adding technical details.
```

This prevents the common problem of specifications becoming unreadable code dumps while ensuring all team perspectives
are considered.

#### 6. **Team-Based Test-First Thinking**

The implementation template enforces test-first development with team input:

```text
### File Creation Order
1. Create `contracts/` with API specifications
1. Create test files in order: contract → integration → e2e → unit (with QA input)
1. Create source files to make tests pass (with Developer and Architect input)
```

This ordering constraint ensures the LLM thinks about testability and contracts from multiple perspectives before
implementation, leading to more robust and verifiable specifications.

#### 7. **Preventing Persona-Specific Speculative Features**

Templates explicitly discourage assumptions without team input:

```text
- [ ] Product Manager: No speculative features without user value defined
- [ ] Architect: No speculative features without technical feasibility review
- [ ] UX: No speculative features without user experience assessment
- [ ] QA: No speculative features without testability review
- [ ] All phases have clear prerequisites and deliverables from all relevant personas
```

This stops the LLM from adding "nice to have" features that complicate implementation without proper team validation.

### The Compound Effect of Team Collaboration

These constraints work together to produce specifications that are:

- **Complete**: Checklists ensure nothing is forgotten from any team persona perspective
- **Unambiguous**: Forced clarification markers highlight uncertainties from all perspectives
- **Testable**: Test-first thinking from QA perspective baked into the process
- **Maintainable**: Proper abstraction levels with input from all personas
- **Implementable**: Clear phases with concrete deliverables from all team perspectives
- **Operationally Viable**: DevOps considerations from the beginning

The templates transform the LLM from a single-perspective writer into a multi-perspective specification coordinator,
channeling its capabilities toward producing consistently high-quality, executable specifications that truly drive
development from all team perspectives.

## The Constitutional Foundation: Enforcing Architectural Discipline with Team Input

At the heart of TDD lies a constitution—a set of immutable principles that govern how specifications become code, with
input from all team personas. The constitution (`memory/constitution.md`) acts as the architectural DNA of the system,
ensuring that every generated implementation maintains consistency, simplicity, and quality from all team perspectives.

### The Nine Articles of Team Development

The constitution defines nine articles that shape every aspect of the development process:

#### Article I: Library-First Principle (Developer & Architect Focus)

Every feature must begin as a standalone library—no exceptions. This forces modular design from the start:

```text
Every feature in Team Development MUST begin its existence as a standalone library.
No feature shall be implemented directly within application code without
first being abstracted into a reusable library component.
Developers and Technical Architects must both validate this requirement.
```

This principle ensures that specifications generate modular, reusable code rather than monolithic applications. When the
LLM generates an implementation plan, it must structure features as libraries with clear boundaries and minimal
dependencies.

#### Article II: CLI Interface Mandate (Developer & DevOps Focus)

Every library must expose its functionality through a command-line interface:

```text
All CLI interfaces MUST:
- Accept text as input (via stdin, arguments, or files)
- Produce text as output (via stdout)
- Support JSON format for structured data exchange
- Be deployable and monitorable by DevOps
```

This enforces observability and testability from both development and operations perspectives. The LLM cannot hide
functionality inside opaque classes—everything must be accessible and verifiable through text-based interfaces.

#### Article III: Test-First Imperative (QA Focus)

The most transformative article—no code before tests:

```text
This is NON-NEGOTIABLE: All implementation MUST follow strict Test-Driven Development.
No implementation code shall be written before:
1. Unit tests are written (QA perspective)
1. Tests are validated and approved by QA
1. Tests are confirmed to FAIL (Red phase)
```

This completely inverts traditional AI code generation. Instead of generating code and hoping it works, the LLM must
first generate comprehensive tests that define behavior, get them approved by QA, and only then generate implementation.

#### Articles VII & VIII: Simplicity and Anti-Abstraction (Architect Focus)

These paired articles combat over-engineering:

```text
Section 7.3: Minimal Project Structure
- Maximum 3 projects for initial implementation
- Additional projects require documented justification by Technical Architect

Section 8.1: Framework Trust
- Use framework features directly rather than wrapping them
- Technical Architect must validate each abstraction decision
```

When an LLM might naturally create elaborate abstractions, these articles force Technical Architect to justify every
layer of complexity.

#### Article IX: Integration-First Testing (QA & DevOps Focus)

Prioritizes real-world testing over isolated unit tests:

```text
Tests MUST use realistic environments:
- Prefer real databases over mocks (DevOps perspective)
- Use actual service instances over stubs (QA perspective)
- Contract tests mandatory before implementation (QA perspective)
```

This ensures generated code works in practice, not just in theory, from both QA and DevOps perspectives.

### Constitutional Enforcement Through Multi-Perspective Templates

The implementation plan template operationalizes these articles through concrete checkpoints with team input:

```markdown
### Phase -1: Pre-Implementation Gates 1

#### Product Feasibility Gate (Product Manager Perspective)

- [ ] PM: Clear user value defined?
- [ ] PM: Success metrics established?

#### Technical Feasibility Gate (Technical Architect Perspective)

- [ ] Architect: Using ≤3 projects?
- [ ] Architect: No future-proofing beyond requirements?
- [ ] Architect: Using framework directly?
- [ ] Architect: Single model representation?

#### Quality Gate (QA Perspective)

- [ ] QA: Contracts defined?
- [ ] QA: Contract tests written?
- [ ] QA: Security requirements addressed?

#### Operational Gate (DevOps Perspective)

- [ ] DevOps: Deployment requirements met?
- [ ] DevOps: Monitoring requirements defined?
- [ ] DevOps: Scalability requirements considered?
```

These gates act as compile-time checks for architectural principles from all team perspectives. The LLM cannot proceed
without either passing the gates or documenting justified exceptions in the "Complexity Tracking" section.

### The Power of Multi-Perspective Principles

The constitution's power lies in its multi-perspective approach. While implementation details can evolve, the core
principles remain constant with input from all team personas:

1. **Consistency Across Time**: Code generated today follows the same principles as code generated next year
1. **Consistency Across LLMs**: Different AI models produce architecturally compatible code
1. **Architectural Integrity**: Every feature reinforces rather than undermines the system design
1. **Quality Guarantees**: Test-first, library-first, and simplicity principles ensure maintainable code
1. **Team Perspective Integration**: All team considerations are built into the process

### Constitutional Evolution with Team Input

While principles are immutable, their application can evolve:

```text
Section 4.2: Amendment Process
Modifications to this constitution require:
- Explicit documentation of the rationale for change
- Review and approval by project maintainers
- Backwards compatibility assessment
- Input from all relevant team personas
```

This allows the methodology to learn and improve while maintaining stability. The constitution shows its own evolution
with dated amendments, demonstrating how principles can be refined based on real-world experience from all team
perspectives.

### Beyond Rules: A Development Philosophy with Team Considerations

The constitution isn't just a rulebook—it's a philosophy that shapes how LLMs think about code generation with all team
perspectives:

- **Observability Over Opacity**: Everything must be inspectable through CLI interfaces (Developer & DevOps)
- **Simplicity Over Cleverness**: Start simple, add complexity only when proven necessary (Architect)
- **Integration Over Isolation**: Test in real environments, not artificial ones (QA & DevOps)
- **Modularity Over Monoliths**: Every feature is a library with clear boundaries (Developer & Architect)
- **User Value Focus**: Prioritize user value and business needs (Product Manager)
- **Quality First**: Ensure quality from the beginning (QA)
- **Operational Excellence**: Plan for deployment and operations from the start (DevOps)

By embedding these multi-perspective principles into the specification and planning process, TDD ensures that generated
code isn't just functional—it's maintainable, testable, architecturally sound, and operationally viable. The
constitution transforms AI from a code generator into a multi-perspective architectural coordinator that respects and
reinforces all team design principles.

## The Transformation

This isn't about replacing team members or automating creativity. It's about amplifying human capability by automating
mechanical translation while ensuring all team perspectives are considered. It's about creating a tight feedback loop
where specifications, research, and code evolve together, each iteration bringing deeper understanding and better
alignment between intent and implementation from all team perspectives.

Software development needs better tools for maintaining alignment between intent and implementation across all team
personas. TDD provides the methodology for achieving this alignment through multi-perspective executable specifications
that generate code rather than merely guiding it.

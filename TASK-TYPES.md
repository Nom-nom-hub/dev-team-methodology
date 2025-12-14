# Task Type Definitions and Templates

## Overview

Task definitions must be specific and actionable, with different requirements for each task type. Use these templates when generating tasks in `/team.tasks`.

---

## 1. Research & Design Tasks (RD-xxx)

### Purpose

Investigate, evaluate, and document findings that inform design and implementation decisions.

### Structure Template

```markdown
| Task ID | Description | Team Role | Priority | Est. Days | Owner | Status |
|---------|-------------|-----------|----------|-----------|-------|--------|
| RD-001 | Research [WHAT]: Evaluate [EVALUATION CRITERIA]. Document in research.md with [SPECIFIC FINDINGS]. | [Role] | P1/P2/P3 | [Days] | [Owner] | To Do |
```

### What Must Be Included

- **WHAT**: Specific topic or technology to research
- **EVALUATION CRITERIA**: What aspects to evaluate (features, performance, compatibility, cost, etc.)
- **SPECIFIC FINDINGS**: What the research output should contain (pros/cons table, comparison matrix, recommendations, etc.)
- **Document location**: Always `research.md`

### Examples

✓ **Good (Specific)**:
- "Research tree-sitter parsing library: evaluate parsing speed on 100+ language files, language coverage, memory usage, maintenance status. Document in research.md with comparison table (features vs. alternatives), benchmarks, and recommendation."
- "Research OAuth2 providers: evaluate Google/GitHub/Microsoft/Auth0 on setup complexity, pricing, security features, user adoption. Document in research.md with comparison matrix and recommendation."
- "Investigate database design: evaluate normalized vs. document-based schema for user profiles with nested preferences. Document in research.md with schema options, query performance implications, and recommendation."

✗ **Bad (Vague)**:
- "Research parsing libraries"
- "Investigate database options"
- "Evaluate authentication approaches"

### Research Task Checklist

- [ ] WHAT to research is explicitly named (specific technology/topic)
- [ ] Evaluation criteria are specific (3+ dimensions to evaluate)
- [ ] Research deliverable is named (research.md)
- [ ] Expected output format is clear (table, matrix, comparison, benchmark, etc.)
- [ ] Task doesn't say "determine" or "decide" - just research and document
- [ ] Owner can research independently without waiting for code

---

## 2. Implementation Tasks (IMPL-xxx)

### Purpose

Create code files, implement features, and build functionality according to the plan.

### Structure Template

```markdown
| Task ID | Description | Team Role | Priority | Est. Days | Owner | Status |
|---------|-------------|-----------|----------|-----------|-------|--------|
| IMPL-001 | Create [FILE PATH]: Implement [COMPONENT] with [METHODS/PROPERTIES] that [BEHAVIOR]. [ACCEPTANCE CRITERIA]. | Developer | P1/P2/P3 | [Days] | [Owner] | To Do |
```

### What Must Be Included

- **FILE PATH**: Exact location of code file(s)
- **COMPONENT**: Class, module, function, or service name
- **METHODS/PROPERTIES**: Key functions/attributes the component needs
- **BEHAVIOR**: What the component does
- **ACCEPTANCE CRITERIA**: How to verify it works

### Examples

✓ **Good (Specific)**:
- "Create src/parsers/javascript_parser.py: Implement JSParser class with parse(file_path) method that returns AST structure per spec. Must handle syntax errors gracefully and support ES6+ features. Acceptance: Parser successfully parses 100+ real JavaScript files without exceptions."
- "Create src/api/user_routes.py: Implement Flask routes for /users GET/POST/PUT/DELETE endpoints with authentication, validation, error handling. Acceptance: All 4 endpoints handle valid/invalid inputs per OpenAPI spec."
- "Create src/cli/analyze.py: Implement AnalyzeCLI class with --format json/yaml support, --output file parameter, and progress reporting. Acceptance: CLI runs without errors on 3 different codebases, produces valid JSON/YAML."

✗ **Bad (Vague)**:
- "Implement parser functionality"
- "Create API endpoints"
- "Build CLI interface"

### Implementation Task Checklist

- [ ] File path is fully specified (not "src/parsers" but "src/parsers/javascript_parser.py")
- [ ] Component/class name is explicit
- [ ] Key methods/properties are named
- [ ] Behavior is described (not "implement" but "returns AST", "handles errors", etc.)
- [ ] Acceptance criteria are clear (how to verify it works)
- [ ] Task owner is a Developer who can code

---

## 3. Testing Tasks (TEST-xxx)

### Purpose

Write test code, execute tests against implementations, and document test results.

### Structure Template

```markdown
| Task ID | Description | Team Role | Priority | Est. Days | Owner | Status |
|---------|-------------|-----------|----------|-----------|-------|--------|
| TEST-001 | Create [TEST FILE PATH]: Write [NUMBER] [TYPE] tests for [COMPONENT] covering [SCENARIOS]. Acceptance: All tests pass, [COVERAGE METRIC]. | QA | P1/P2/P3 | [Days] | [Owner] | To Do |
```

### What Must Be Included

- **TEST FILE PATH**: Exact location of test file(s)
- **NUMBER**: How many test cases
- **TYPE**: Unit/integration/e2e tests
- **COMPONENT**: What's being tested
- **SCENARIOS**: Specific test cases (happy path, error cases, edge cases)
- **COVERAGE METRIC**: Code coverage percentage or specific lines

### Examples

✓ **Good (Specific)**:
- "Create tests/test_javascript_parser.py: Write 12 unit tests for JSParser.parse() covering valid JS files, syntax errors, empty files, ES6 features, nested structures, and edge cases. Acceptance: 100% code coverage on parser module, all tests pass in CI."
- "Create tests/test_user_api.py: Write 20 integration tests for user endpoints (/users GET, POST, PUT, DELETE) covering success cases, validation errors, auth failures, concurrent requests. Acceptance: 90%+ coverage on api module, tests complete in <5 seconds."
- "Create tests/test_cli.py: Write 8 e2e tests for analyze CLI command with different --format/--output options, missing files, invalid input. Acceptance: All tests pass against real test codebases, coverage >85%."

✗ **Bad (Vague)**:
- "Write tests for parser"
- "Create API tests"
- "Test CLI functionality"

### Testing Task Checklist

- [ ] Test file path is fully specified
- [ ] Number of test cases is clear (not "comprehensive" but "12", "20", etc.)
- [ ] Test type is explicit (unit/integration/e2e)
- [ ] Components being tested are named
- [ ] Specific test scenarios are listed (not "error cases" but "missing file", "invalid JSON", etc.)
- [ ] Coverage metric is measurable (percentage or line count)
- [ ] Task owner is QA who writes tests

---

## 4. Deployment Tasks (DEPLOY-xxx)

### Purpose

Create packaging artifacts, configure deployment, and validate deployment processes.

### Structure Template

```markdown
| Task ID | Description | Team Role | Priority | Est. Days | Owner | Status |
|---------|-------------|-----------|----------|-----------|-------|--------|
| DEPLOY-001 | Create [ARTIFACT FILES]: Package [COMPONENT] for [DEPLOYMENT TARGET] with [CONFIGURATION]. Acceptance: [VALIDATION CRITERIA]. | DevOps | P1/P2/P3 | [Days] | [Owner] | To Do |
```

### What Must Be Included

- **ARTIFACT FILES**: setup.py, Dockerfile, docker-compose.yml, requirements.txt, helm chart, etc.
- **COMPONENT**: What's being packaged
- **DEPLOYMENT TARGET**: Docker, PyPI, Kubernetes, Cloud Run, etc.
- **CONFIGURATION**: Environment variables, secrets management, etc.
- **VALIDATION CRITERIA**: How to verify deployment works

### Examples

✓ **Good (Specific)**:
- "Create setup.py and pyproject.toml: Package tool for pip distribution with entry points for CLI commands. Acceptance: Tool installs cleanly in fresh venv, CLI commands run without errors, help text displays correctly."
- "Create Dockerfile and docker-compose.yml: Package API service with PostgreSQL and Redis. Acceptance: Docker image builds successfully, container starts and serves API on port 8000, docker-compose brings up all services."
- "Create GitHub Actions workflow: Automate testing on pull requests and deployment to Cloud Run on main branch. Acceptance: Workflow runs tests automatically, builds and deploys on success, sends Slack notifications."

✗ **Bad (Vague)**:
- "Deploy to production"
- "Create Docker configuration"
- "Set up CI/CD"

### Deployment Task Checklist

- [ ] Artifact files are specifically named (not "create config" but "setup.py", "Dockerfile", etc.)
- [ ] Component being packaged is explicit
- [ ] Deployment target is clear (Docker, PyPI, K8s, etc.)
- [ ] Configuration requirements are listed
- [ ] Validation criteria are measurable (installation test, service health check, etc.)
- [ ] Task owner is DevOps who configures deployments

---

## Task Distinction Matrix

| Aspect | Research | Implementation | Testing | Deployment |
|--------|----------|-----------------|---------|------------|
| **Deliverable** | research.md entries | Code files | Test files | Packaging files |
| **Owner** | Tech Lead/Architect | Developer | QA Engineer | DevOps Engineer |
| **Acceptance** | Documented findings | Working code | Passing tests | Successful deployment |
| **Verification** | Peer review of findings | Code review + manual test | Test execution + coverage | Deploy to test env |
| **Duration** | 1-3 days | 2-5 days | 1-3 days | 1-2 days |

---

## Common Mistakes to Avoid

### ✗ Vague Language

- "Implement parser functionality" → ✓ "Create src/parsers/parser.py with Parser class and parse() method"
- "Research performance" → ✓ "Benchmark X library on 1000 files, document speed/memory in research.md"
- "Write tests" → ✓ "Create tests/test_parser.py with 8 unit tests covering happy path and error cases"
- "Deploy system" → ✓ "Create Dockerfile and docker-compose.yml, test deployment in staging"

### ✗ Missing Details

- Task: "Create API" → Missing: What endpoints? What methods? What data? What file?
- Task: "Write tests" → Missing: How many tests? What aspects? What coverage? What file?
- Task: "Package code" → Missing: What format? Docker? PyPI? What goes in? What validates success?

### ✗ Wrong Owner

- Implementation task assigned to QA (should be Developer)
- Testing task assigned to Developer without QA input (should be QA)
- Deployment task assigned to Developer (should be DevOps)
- Research task assigned to everyone (should be specific expert)

### ✗ Premature Decisions

- "Implement using PostgreSQL" (that's implementation detail, belongs in plan, not task)
- "Use React for UI" (that's architecture, not task-level)
- Research task that says "we should use X" (research task should document options, plan makes decision)

---

## Task Quality Checklist

Use this when generating tasks:

- [ ] Task has explicit file paths or document locations
- [ ] Task describes WHAT to create, not HOW to create it
- [ ] Task has measurable acceptance criteria
- [ ] Task has clear owner (specific role)
- [ ] Task doesn't span multiple logical components
- [ ] Task duration is realistic (1-5 days)
- [ ] Task dependencies are identified
- [ ] Similar tasks are grouped in logical sequence

---

**Version**: 1.0 | **Created**: 2025-12-14

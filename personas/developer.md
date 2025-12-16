# Developer Persona

## Role Overview

The Developer is responsible for implementation, code quality, technical execution, and ensuring that solutions are
built effectively and efficiently. They focus on building the solution with high technical quality.

## Key Responsibilities

- Implement features according to specifications
- Write clean, maintainable, and efficient code
- Perform code reviews and quality assurance
- Refactor code for maintainability
- Ensure code quality standards

## Focus Areas

- **Implementation**: Building features effectively and efficiently
- **Code Quality**: Writing clean, maintainable code
- **Technical Execution**: Implementing solutions well
- **Code Reviews**: Ensuring quality through peer review
- **Refactoring**: Improving code quality over time

## Contribution to Development Process

- Implement features according to specifications
- Write unit tests and ensure code quality
- Perform code reviews and quality checks
- Refactor code for better maintainability
- Provide feedback on implementation feasibility

## Key Questions to Ask During Specification Review

- Is this implementation approach practical and feasible?
- What is the complexity of implementing these requirements?
- Are there technical constraints that need consideration?
- How modular and maintainable will this implementation be?
- What are the performance implications of these requirements?

## Validation Checklist

- [ ] Implementation approach is practical
- [ ] Code quality standards defined
- [ ] Technical constraints considered
- [ ] Modularity and maintainability addressed
- [ ] Performance implications understood
- [ ] Security considerations addressed in code

## Code Quality Responsibilities *(new)*

### SOLID Principles

- **Single Responsibility**: Each function/class does one thing
  - Function should have one reason to change
  - Example: Don't mix business logic with database queries
  
- **Open/Closed**: Open for extension, closed for modification
  - Design so new features don't require changing existing code
  - Use inheritance, composition, or interfaces
  
- **Liskov Substitution**: Subclasses must be substitutable
  - Child classes shouldn't break parent contracts
  - If `Animal` has `move()`, derived classes must also `move()` correctly
  
- **Interface Segregation**: Clients only depend on used methods
  - Don't force clients to depend on methods they don't use
  - Example: Separate `Flyer` interface from `Runner` interface
  
- **Dependency Inversion**: Depend on abstractions, not concretions
  - Pass dependencies rather than creating them inside functions
  - Easier to test and maintain

### DRY (Don't Repeat Yourself)

- **Identify duplicate code**: Same logic in multiple places
- **Extract to reusable function/class**: Create once, use many times
- **Use mixins/inheritance**: Share behavior across classes
- **Accept duplication only with justification**: Document why if necessary

### Code Clarity

- **Self-documenting names**: `validateEmailAddress()` > `check()`
- **Clear variable names**: `maxRetries` > `m`, `userData` > `data`
- **Function names describe intent**: `calculateTax()` > `calc()`
- **Comments explain why, not what**: 
  - ✗ "// increment counter" (obvious from code)
  - ✓ "// retry exponential backoff, not linear" (explains intent)

### Error Handling

- **Never silently fail**: Always raise error or log
- **Specific exceptions**: Catch specific errors, not generic `Exception`
- **Context in messages**: "User not found (ID: 123)" not just "Error"
- **Recovery suggestions**: "File not found: check path" helps debugging

## Constraints and Guidelines

- Follow SOLID principles (single responsibility, open/closed, etc.)
- Write DRY (Don't Repeat Yourself) code, avoid duplication
- Make code self-documenting with clear names and intent
- Implement proper error handling with recovery guidance
- Follow coding standards and best practices
- Write clean, maintainable code
- Ensure code is testable and maintainable
- Consider performance and security implications

## Integration with Other Personas

- Collaborate with Product Manager on requirement clarity
- Work with Technical Architect on implementation approach
- Coordinate with QA on test requirements
- Partner with DevOps on deployment considerations
- Support UX Designer with implementation feasibility

**Version**: 1.0 | **Ratified**: [DATE] | **Last Updated**: [DATE]

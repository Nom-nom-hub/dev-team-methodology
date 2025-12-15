#!/bin/bash

# validate-phase.sh - Validate Team-Driven Development phase gates
# Usage: ./scripts/validate-phase.sh <phase> [feature-name]
# Example: ./scripts/validate-phase.sh specify 001-user-auth
# Example: ./scripts/validate-phase.sh plan 001-user-auth

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_error() {
    echo -e "${RED}✗ ERROR: $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ WARNING: $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_header() {
    echo ""
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}════════════════════════════════════════════════════${NC}"
    echo ""
}

# Check git status
check_git() {
    if ! git rev-parse --git-dir > /dev/null 2>&1; then
        print_error "Not in a git repository. Initialize git first: git init"
        exit 1
    fi
    print_success "Git repository found"
}

# Validate specify phase
validate_specify() {
    print_header "VALIDATING /team.specify PHASE"
    
    print_info "Checking prerequisites..."
    
    # Check if .team directory exists
    if [ ! -d ".team" ]; then
        print_error ".team/ directory not found. Run 'team init' first."
        exit 1
    fi
    print_success ".team/ directory exists"
    
    # Check if team profiles exist
    if [ ! -f ".team/memory/constitution.md" ]; then
        print_warning "constitution.md not found. Create with /team.constitution"
        return 1
    fi
    print_success "Constitution found"
    
    # Feature name from argument or detect from branch
    if [ -z "$1" ]; then
        FEATURE=$(git rev-parse --abbrev-ref HEAD)
        if [ "$FEATURE" == "main" ] || [ "$FEATURE" == "master" ]; then
            print_error "Not on a feature branch. Create one first."
            exit 1
        fi
    else
        FEATURE="$1"
    fi
    
    print_info "Using feature: $FEATURE"
    
    # Check if spec directory should exist (optional at this point)
    if [ -d ".team/specs/$FEATURE" ]; then
        if [ -f ".team/specs/$FEATURE/spec.md" ]; then
            print_success "Specification found"
        else
            print_warning "specs/$FEATURE/ directory exists but spec.md not found"
        fi
    else
        print_info "No spec yet. Run /team.specify to create one."
    fi
    
    print_success "SPECIFY phase validated ✓"
}

# Validate review phase
validate_review() {
    print_header "VALIDATING /team.review PHASE"
    
    if [ -z "$1" ]; then
        print_error "Feature name required: validate-phase.sh review 001-feature-name"
        exit 1
    fi
    
    FEATURE="$1"
    SPEC_DIR=".team/specs/$FEATURE"
    
    print_info "Checking feature: $FEATURE"
    
    # Check spec.md exists
    if [ ! -f "$SPEC_DIR/spec.md" ]; then
        print_error "spec.md not found in $SPEC_DIR"
        exit 1
    fi
    print_success "spec.md found"
    
    # Check checklist exists
    if [ ! -f "$SPEC_DIR/checklists/validation-checklist.md" ]; then
        print_warning "validation-checklist.md not found (should exist after /team.review)"
    else
        print_success "validation checklist found"
    fi
    
    print_success "REVIEW phase validated ✓"
}

# Validate plan phase
validate_plan() {
    print_header "VALIDATING /team.plan PHASE"
    
    if [ -z "$1" ]; then
        print_error "Feature name required: validate-phase.sh plan 001-feature-name"
        exit 1
    fi
    
    FEATURE="$1"
    SPEC_DIR=".team/specs/$FEATURE"
    
    print_info "Checking feature: $FEATURE"
    
    # Check spec.md exists
    if [ ! -f "$SPEC_DIR/spec.md" ]; then
        print_error "spec.md not found. Run /team.specify first."
        exit 1
    fi
    print_success "spec.md exists"
    
    # Check validation checklist
    if [ ! -f "$SPEC_DIR/checklists/validation-checklist.md" ]; then
        print_error "validation-checklist.md not found. Run /team.review first."
        exit 1
    fi
    print_success "validation checklist exists"
    
    # Check if plan.md should exist
    if [ ! -f "$SPEC_DIR/plan.md" ]; then
        print_info "plan.md not yet created. Run /team.plan to create it."
    else
        print_success "plan.md found"
        
        # Basic validation of plan content
        if grep -q "^# " "$SPEC_DIR/plan.md"; then
            print_success "plan.md has proper structure (headings found)"
        fi
    fi
    
    print_success "PLAN phase validated ✓"
}

# Validate tasks phase
validate_tasks() {
    print_header "VALIDATING /team.tasks PHASE"
    
    if [ -z "$1" ]; then
        print_error "Feature name required: validate-phase.sh tasks 001-feature-name"
        exit 1
    fi
    
    FEATURE="$1"
    SPEC_DIR=".team/specs/$FEATURE"
    
    print_info "Checking feature: $FEATURE"
    
    # Check required files
    for file in spec.md plan.md; do
        if [ ! -f "$SPEC_DIR/$file" ]; then
            print_error "$file not found. Complete previous phases first."
            exit 1
        fi
    done
    print_success "spec.md and plan.md exist"
    
    # Check tasks.md
    if [ ! -f "$SPEC_DIR/tasks.md" ]; then
        print_info "tasks.md not yet created. Run /team.tasks to create it."
    else
        print_success "tasks.md found"
        
        # Count tasks
        TASK_COUNT=$(grep -c "^### Task\|^## Task" "$SPEC_DIR/tasks.md" || echo "0")
        if [ "$TASK_COUNT" -gt 0 ]; then
            print_success "Found $TASK_COUNT tasks in tasks.md"
            
            # Check for reasonable task count
            if [ "$TASK_COUNT" -lt 5 ]; then
                print_warning "Only $TASK_COUNT tasks - may be under-scoped"
            fi
            if [ "$TASK_COUNT" -gt 100 ]; then
                print_warning "$TASK_COUNT tasks - may be over-scoped"
            fi
        fi
    fi
    
    print_success "TASKS phase validated ✓"
}

# Validate implement phase
validate_implement() {
    print_header "VALIDATING /team.implement PHASE"
    
    if [ -z "$1" ]; then
        print_error "Feature name required: validate-phase.sh implement 001-feature-name"
        exit 1
    fi
    
    FEATURE="$1"
    SPEC_DIR=".team/specs/$FEATURE"
    
    print_info "Checking feature: $FEATURE"
    
    # Check all required files
    for file in spec.md plan.md tasks.md; do
        if [ ! -f "$SPEC_DIR/$file" ]; then
            print_error "$file not found. Complete phase first."
            exit 1
        fi
    done
    print_success "All prerequisites exist (spec, plan, tasks)"
    
    # Check for implementation-log (optional)
    if [ -f "$SPEC_DIR/implementation-log.md" ]; then
        print_success "implementation-log.md found"
    else
        print_info "implementation-log.md not created yet (optional)"
    fi
    
    print_success "IMPLEMENT phase validated ✓"
}

# Show usage
show_usage() {
    cat << EOF
${BLUE}Team-Driven Development Phase Validator${NC}

Usage: ./scripts/validate-phase.sh <phase> [feature-name]

Phases:
  specify    - Validate /team.specify prerequisites
  review     - Validate /team.review prerequisites
  plan       - Validate /team.plan prerequisites
  tasks      - Validate /team.tasks prerequisites
  implement  - Validate /team.implement prerequisites
  
Examples:
  ./scripts/validate-phase.sh specify
  ./scripts/validate-phase.sh review 001-user-auth
  ./scripts/validate-phase.sh plan 001-user-auth
  ./scripts/validate-phase.sh tasks 001-user-auth
  ./scripts/validate-phase.sh implement 001-user-auth

This script validates that all prerequisites for each phase are in place
before executing the corresponding /team.* command.

EOF
}

# Main
if [ $# -eq 0 ]; then
    show_usage
    exit 0
fi

PHASE="$1"
FEATURE="${2:-}"

# Check git first
check_git

case "$PHASE" in
    specify)
        validate_specify "$FEATURE"
        ;;
    review)
        validate_review "$FEATURE"
        ;;
    plan)
        validate_plan "$FEATURE"
        ;;
    tasks)
        validate_tasks "$FEATURE"
        ;;
    implement)
        validate_implement "$FEATURE"
        ;;
    *)
        print_error "Unknown phase: $PHASE"
        show_usage
        exit 1
        ;;
esac

print_success "Phase validation complete!"
echo ""

# Testing Strategy

Comprehensive testing approach covering unit, integration, end-to-end, performance, security, and accessibility testing.

---

## Unit Tests

Test individual functions and components in isolation.

### Coverage Target

- **Code coverage**: 80%+ (line coverage)
- **Branch coverage**: 75%+ (all if/else paths)
- **Function coverage**: 100% (every function has at least one test)

**Measure**:
```bash
# JavaScript (Jest)
npm test -- --coverage

# Python (pytest)
pytest --cov=myapp --cov-report=html
```

### What to Test

**Happy path** (normal case):
```python
def add(a, b):
    return a + b

def test_add_positive():
    assert add(2, 3) == 5

def test_add_negative():
    assert add(-2, -3) == -5

def test_add_zero():
    assert add(0, 5) == 5
```

**Error cases** (things that should fail):
```python
def test_add_non_number():
    with pytest.raises(TypeError):
        add("2", 3)

def test_add_none():
    with pytest.raises(TypeError):
        add(None, 3)
```

**Edge cases** (boundary values):
```python
def test_add_max_int():
    assert add(2**31-1, 0) == 2**31-1

def test_add_float():
    assert add(2.5, 3.7) == pytest.approx(6.2)
```

**Side effects** (if function modifies state):
```python
def test_update_user():
    user = User(name="Alice")
    user.update(name="Bob")
    assert user.name == "Bob"
    # Verify state changed
```

### Test Organization

**File structure**:
```
src/
├─ math.py
└─ tests/
   └─ test_math.py  # Tests for math.py

src/
├─ user.py
└─ tests/
   └─ test_user.py
```

**Test naming**:
```python
def test_add_returns_sum():  # test_[function]_[scenario]
def test_user_update_changes_name():
def test_authentication_fails_with_wrong_password():
```

### Mocking Strategy

**Mock external dependencies**:
```python
from unittest.mock import Mock

def test_get_user_from_api():
    # Mock the HTTP client
    mock_http = Mock()
    mock_http.get.return_value = {"id": 1, "name": "Alice"}
    
    # Pass mock to function
    result = get_user(http_client=mock_http, user_id=1)
    
    # Verify it was called correctly
    mock_http.get.assert_called_once_with("/users/1")
    assert result.name == "Alice"
```

**What to mock**:
- [ ] HTTP requests to external APIs
- [ ] Database calls (use in-memory DB or mock)
- [ ] Random functions (seed random)
- [ ] Date/time (use freezegun to mock)
- [ ] File system (use temp files or mock)

**What not to mock** (test with real):
- [ ] Your own code (test real implementations)
- [ ] Core libraries (mock only if necessary)
- [ ] Database schema validation (use real schema)

### Test Database

**Options**:
- **In-memory SQLite**: Fast, no setup, limited SQL features
- **Temporary PostgreSQL**: Full SQL support, slower setup
- **Database fixtures**: Pre-populate test data, reset between tests

**Example (pytest with PostgreSQL)**:
```python
import pytest
from sqlalchemy import create_engine

@pytest.fixture
def db():
    # Create test database
    engine = create_engine("postgresql://localhost/test_db")
    create_tables(engine)  # Create schema
    
    yield engine
    
    # Cleanup
    drop_tables(engine)

def test_create_user(db):
    user = create_user(db, name="Alice")
    assert user.id is not None
```

### Test Data

**Fixtures** (shared test data):
```python
@pytest.fixture
def user():
    return {"id": 1, "name": "Alice", "email": "alice@example.com"}

def test_update_user(user):
    user["name"] = "Bob"
    assert user["name"] == "Bob"
```

**Factories** (generate varied test data):
```python
from factory import Factory, Faker

class UserFactory(Factory):
    class Meta:
        model = User
    
    id = Faker('uuid4')
    name = Faker('name')
    email = Faker('email')

def test_with_generated_data():
    user = UserFactory()  # Generate random user
    assert user.email is not None
```

---

## Integration Tests

Test multiple components working together (but without UI).

### Scope

Test: Service + Database + Cache (no HTTP, no UI)

**Example**:
```python
def test_create_user_and_login():
    # Create user via service
    user = UserService().create(email="alice@example.com", password="secret")
    
    # Verify in database
    assert db.query(User).filter_by(email="alice@example.com").count() == 1
    
    # Attempt login
    result = AuthService().login(email="alice@example.com", password="secret")
    assert result.success == True
```

### Test Scenarios

**User Registration**:
- [ ] User can register with email and password
- [ ] Duplicate email rejected
- [ ] Weak password rejected
- [ ] Verification email sent
- [ ] Account inactive until email verified

**Authentication**:
- [ ] User can login with correct credentials
- [ ] Login fails with wrong password
- [ ] Login fails with non-existent email
- [ ] Too many failed logins locks account
- [ ] Logged-in user has valid session

**Data Consistency**:
- [ ] Creating user creates user record
- [ ] Updating user reflects in database immediately
- [ ] Deleting user cascades to related records
- [ ] Transaction rollback undoes all changes

### Test Environment

**Database**: Real PostgreSQL (test instance)
**Cache**: Real Redis (test instance)
**Queues**: Real message queue (test instance)
**External APIs**: Mocked (don't call real Stripe, etc.)

### Dependency Management

**Docker compose for test dependencies**:
```yaml
version: '3'
services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: test_db
      POSTGRES_PASSWORD: testpass
  
  redis:
    image: redis:7
```

**CI setup**:
```bash
docker-compose up -d  # Start services
pytest               # Run tests
docker-compose down  # Cleanup
```

---

## End-to-End (E2E) Tests

Test complete user journeys through the UI.

### Critical User Journeys

**Journey 1: Sign up and create first post**:
1. Navigate to homepage
2. Click "Sign up"
3. Enter email, password
4. Click "Create account"
5. Verify email (click link in email)
6. Navigate to create post
7. Enter title and content
8. Click "Post"
9. Verify post appears in feed

**Journey 2: Login and view profile**:
1. Navigate to login
2. Enter email and password
3. Click "Login"
4. Wait for homepage to load
5. Click profile icon
6. Verify profile page shows correct data

**Journey 3: Search and filter posts**:
1. Navigate to posts page
2. Enter search term
3. Click search
4. Verify results appear
5. Click category filter
6. Verify filtered results

### Tool & Framework

**Selenium** (traditional, wide language support):
```python
from selenium import webdriver
from selenium.webdriver.common.by import By

def test_signup():
    driver = webdriver.Chrome()
    driver.get("https://example.com")
    
    # Find and click signup button
    signup_btn = driver.find_element(By.ID, "signup-btn")
    signup_btn.click()
    
    # Fill form
    email_field = driver.find_element(By.NAME, "email")
    email_field.send_keys("alice@example.com")
    
    password_field = driver.find_element(By.NAME, "password")
    password_field.send_keys("securepassword123")
    
    # Submit
    submit_btn = driver.find_element(By.CSS_SELECTOR, "button[type='submit']")
    submit_btn.click()
    
    # Verify success
    assert "Welcome, Alice" in driver.page_source
```

**Cypress** (modern, better developer experience):
```javascript
describe('User Signup', () => {
  it('should allow user to sign up', () => {
    cy.visit('https://example.com')
    cy.get('#signup-btn').click()
    cy.get('input[name="email"]').type('alice@example.com')
    cy.get('input[name="password"]').type('securepassword123')
    cy.get('button[type="submit"]').click()
    cy.contains('Welcome, Alice').should('be.visible')
  })
})
```

**Playwright** (modern, supports multiple browsers):
```python
from playwright.sync_api import sync_playwright

def test_signup():
    with sync_playwright() as p:
        browser = p.chromium.launch()
        page = browser.new_page()
        
        page.goto("https://example.com")
        page.click("#signup-btn")
        page.fill("input[name='email']", "alice@example.com")
        page.fill("input[name='password']", "securepassword123")
        page.click("button[type='submit']")
        
        assert "Welcome, Alice" in page.content()
        browser.close()
```

### Browser Coverage

- **Chrome**: Latest version (main browser)
- **Firefox**: Latest version (compatibility)
- **Safari**: Latest version (iOS compatibility)
- **Edge**: Latest version (Windows)

**Don't test**: Internet Explorer (it's deprecated)

### Responsive Design Testing

- **Desktop**: 1920x1080
- **Tablet**: 768x1024
- **Mobile**: 375x667

Test that layout works at each size:
```python
def test_mobile_layout():
    driver.set_window_size(375, 667)
    # Verify menu collapses to hamburger
    assert not driver.find_element(By.ID, "nav-menu").is_displayed()
    assert driver.find_element(By.ID, "hamburger").is_displayed()
```

---

## Performance Tests (Load Testing)

Test system under load to verify performance targets.

### Load Testing Tool

**k6** (modern, JavaScript-based):
```javascript
import http from 'k6/http';
import { check } from 'k6';

export let options = {
  vus: 1000,  // 1000 virtual users
  duration: '5m'  // 5 minutes
};

export default function() {
  let response = http.get('https://example.com/api/posts');
  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 200ms': (r) => r.timings.duration < 200
  });
}
```

### Load Test Scenarios

**Scenario 1: Ramp up to peak**:
- Start: 0 users
- Ramp up: 100 users/minute for 10 minutes (reach 1000 users)
- Hold: Stay at 1000 users for 5 minutes
- Ramp down: Reduce 100 users/minute for 10 minutes

**Scenario 2: Sustained load**:
- 500 constant users
- Duration: 8 hours
- Verify memory doesn't leak, no gradual slowdown

**Scenario 3: Spike**:
- Baseline: 100 users
- Spike: Jump to 1000 users for 2 minutes
- Verify system handles spike and recovers

### Acceptance Criteria

```
✓ Response time p95 < 200ms (normal load)
✓ Response time p95 < 500ms (peak load, can be slower)
✓ Error rate < 0.1%
✓ No memory leak (memory stable)
✓ Throughput matches target (500 req/sec)
```

---

## Security Tests

### Static Analysis (SAST)

Scan code for vulnerabilities without running it.

**Tools**:
- **SonarQube**: Full source code analysis
- **Snyk**: Dependency vulnerabilities
- **OWASP ZAP**: Web application scanning
- **Semgrep**: Custom vulnerability patterns

**Process**:
```bash
# Scan code
snyk test
# Output: Found 3 vulnerabilities (1 critical, 2 high)

# Generate report
snyk test --json > report.json
```

### Dependency Scanning

**Tools**:
- `npm audit` (JavaScript)
- `pip audit` (Python)
- `cargo audit` (Rust)
- `snyk` (all languages)

**Process**:
1. Run on every commit
2. Fail build if critical vulnerabilities
3. Schedule regular full scans
4. Keep dependencies up to date

### Dynamic Analysis (DAST)

Scan running application for vulnerabilities.

**Tools**:
- **OWASP ZAP**: Active scanning
- **Burp Suite**: Manual + automated
- **Acunetix**: Automated scanning

**Tests**:
- [ ] SQL injection attempts
- [ ] XSS attempts
- [ ] CSRF token validation
- [ ] Authentication bypass
- [ ] Authorization bypass
- [ ] Sensitive data in responses

### Penetration Testing

**Manual security review** by security expert:
- [ ] Identify attack vectors
- [ ] Attempt real exploits
- [ ] Test security controls
- [ ] Report findings with severity

**When**: Before launch, annually, after major changes

---

## Accessibility Tests

### Automated Testing

**Tools**:
- **Axe** (JavaScript, Chrome extension)
- **Pa11y** (CLI tool)
- **Lighthouse** (in Chrome DevTools)

**Test automatically for**:
- Color contrast (WCAG AA = 4.5:1 for normal text)
- Missing alt text on images
- Form labels missing
- Missing heading hierarchy
- Keyboard navigation issues

### Manual Testing

**Keyboard navigation**:
- [ ] Can tab through all interactive elements
- [ ] Can access all menus with keyboard
- [ ] Tab order is logical
- [ ] No keyboard traps

**Screen reader testing** (NVDA for Windows, VoiceOver for Mac):
- [ ] All content readable
- [ ] Form labels announced
- [ ] Headings proper hierarchy
- [ ] Images have meaningful alt text
- [ ] Links have descriptive text (not "click here")

**Standards compliance**: WCAG 2.1 Level AA (target)

---

## Regression Tests

Prevent breaking existing functionality.

### Regression Test Suite

Collection of tests that run on every change:
- [ ] Critical user journeys (full E2E)
- [ ] API smoke tests (basic endpoints work)
- [ ] Database integrity tests
- [ ] Integration tests for common features
- [ ] Security tests

**Keep it fast**: Regression suite should run in < 15 minutes

### Flaky Tests (unreliable)

Tests that sometimes pass, sometimes fail are dangerous:
- Block releases for wrong reasons
- Erode confidence in test suite
- Cause developer frustration

**Identify flaky tests**:
```bash
# Run each test 10 times, flag if any fail
for i in {1..10}; do pytest test.py || echo "FLAKY"; done
```

**Fix flaky tests**:
- Add explicit waits for async operations
- Use specific assertions (not timing-dependent)
- Fix race conditions in tests
- Increase timeout for slow operations
- Disable and fix later if blocking releases

---

## Continuous Integration (CI)

Automated test execution on every commit.

### Test Pipeline

```
Push Code
  ↓
Lint (check style) [2 min]
  ↓
Unit Tests [10 min]
  ↓
Integration Tests [15 min]
  ↓
Build Container [5 min]
  ↓
E2E Tests [20 min]
  ↓
Security Scan [10 min]
  ↓
Performance Test [15 min]
  ↓
✅ All pass → Ready to merge
❌ Any fail → Block merge, notify developer
```

### Minimum Requirements

**Must have**:
- [ ] Linting passes (code style consistent)
- [ ] Unit tests pass (80%+ coverage)
- [ ] Integration tests pass
- [ ] No critical security vulnerabilities
- [ ] Build succeeds

**Should have**:
- [ ] E2E tests pass (critical journeys)
- [ ] Performance test passes (no regressions)
- [ ] Accessibility tests pass

**Nice to have**:
- [ ] Load test passes
- [ ] Penetration test passes (less frequently)

### Build Timeout

Set reasonable timeout to catch hung processes:
- Fast test suite: 30 minutes
- Medium test suite: 60 minutes
- Long test suite: 90 minutes

Kill builds exceeding timeout to prevent waiting forever.

---

## Test Environment

### Staging Environment

Production-like environment for testing:
- Same database schema, sample data
- Same caching strategy
- Same network configuration
- Same monitoring and logging
- Not exposed to real users

### Feature Flags for Testing

```python
# During development, use feature flag
@app.get("/api/new-feature")
def new_feature():
    if feature_flag_enabled("new_feature_beta"):
        return new_implementation()
    else:
        return old_implementation()
```

Benefits:
- Test new code without deploying
- A/B test with real users
- Rollback instantly if needed
- Gradual rollout (5% → 25% → 100%)

---

## Test Metrics

### Tracking Coverage

```bash
# Generate coverage report
pytest --cov=myapp --cov-report=html

# View in browser
open htmlcov/index.html
```

**Coverage goals**:
- Lines: 80%+
- Branches: 75%+
- Functions: 100%

### Trend Analysis

Track over time:
- Coverage increasing (adding tests)
- Test execution time (not getting slower)
- Flaky test count (decreasing)
- Defect escape rate (fewer bugs in production)

---

## Testing Checklist

Before launch:
- [ ] Unit tests written and passing (80%+ coverage)
- [ ] Integration tests written and passing
- [ ] Critical E2E journeys tested
- [ ] Performance targets verified with load test
- [ ] Security scan passed, no critical vulns
- [ ] Accessibility tests passed (WCAG AA)
- [ ] No flaky tests
- [ ] Regression test suite passing
- [ ] Runbook created for troubleshooting
- [ ] Team trained on running tests

# Security Hardening Plan

Comprehensive security strategy covering authentication, authorization, data protection, and compliance.

---

## Authentication

How users prove they are who they claim to be.

### Authentication Method

**Choose one**:
- **OAuth2/OpenID Connect**: Third-party provider (Google, GitHub, Okta)
  - Pros: Users don't share passwords, strong security, social login
  - Cons: Dependency on third party, complexity
  
- **JWT (JSON Web Tokens)**: Self-issued tokens
  - Pros: Stateless, scalable, good for APIs
  - Cons: Token revocation hard, token size
  
- **Session + Cookie**: Traditional server-side sessions
  - Pros: Simple, revocation easy, widely supported
  - Cons: Not good for APIs, requires server state
  
- **Multi-factor Authentication (MFA)**: 
  - Required? (yes/no)
  - Methods: TOTP (authenticator app), SMS, hardware key, email

**Decision**: [Choose and explain why]

### Password Policy

- **Minimum length**: 12+ characters (or passphrase)
- **Complexity**: Uppercase + lowercase + number + special char? Or just length?
- **Dictionary check**: Prevent common passwords (123456, password, etc.)
- **Expiration**: Every 90 days? Or only on compromise?
- **Reuse**: Prevent reusing last 5 passwords?

**Implementation**:
- Use bcrypt or Argon2 for hashing (never MD5 or SHA1)
- Cost factor: 12+ rounds (slow intentionally, prevents brute force)
- Salt: Automatic (bcrypt does this)

### Session Management

**Stateful (cookies)**:
- Session timeout: 1 hour of inactivity (then re-authenticate)
- Absolute timeout: 8 hours max (even if active)
- Secure flag: Yes (only HTTPS)
- HttpOnly flag: Yes (JavaScript can't access)
- SameSite: Strict (CSRF protection)

**Stateless (JWT)**:
- Access token lifetime: 15 minutes
- Refresh token lifetime: 7 days
- Token storage: HttpOnly cookie (not localStorage)
- Token revocation: Blacklist on logout, check on each request

### Token Expiration

- Access tokens: 15 minutes
- Refresh tokens: 7 days
- API keys: 90 days (with rotation)
- Session tokens: 1 hour (with absolute limit of 8 hours)

### Logout & Token Revocation

**How to revoke**:
- Add to revocation blacklist (Redis cache for quick lookup)
- Tokens in blacklist until expiration time
- API checks blacklist on every request

**Logout flow**:
1. Client calls DELETE /api/auth/logout
2. Server adds token to blacklist
3. Server clears session cookie
4. Client removes token from storage
5. Redirect to login page

---

## Authorization

What authenticated users are allowed to do.

### Authorization Model

**Choose one**:
- **Role-Based Access Control (RBAC)**: User has role (admin, user, guest)
  - Pros: Simple, clear roles
  - Cons: Doesn't scale to complex permissions
  
- **Attribute-Based Access Control (ABAC)**: User has attributes (dept=sales, level=5)
  - Pros: Flexible, fine-grained
  - Cons: Complex, harder to audit
  
- **Resource-Based Access Control**: Each resource specifies who can access
  - Pros: Flexible, tied to resource
  - Cons: Many rules to manage

**Decision**: [Choose and explain why]

### Role Hierarchy

```
Admin (all permissions)
├─ Manager (team permissions)
├─ User (personal permissions)
└─ Guest (read-only)
```

Define exactly what each role can do:

**Admin**:
- [ ] Create/edit/delete users
- [ ] Create/edit/delete all posts
- [ ] View all data
- [ ] Change system settings
- [ ] View audit logs

**Manager**:
- [ ] Create/edit/delete team members' posts
- [ ] View team data
- [ ] Export reports

**User**:
- [ ] Create/edit/delete own posts
- [ ] View own data
- [ ] Comment on posts

**Guest**:
- [ ] View published posts
- [ ] No authentication required

### Permission Granularity

For each resource type, define permissions:

**Posts**:
- `post.create`: Can create new posts
- `post.read`: Can view posts
- `post.update`: Can edit posts (own or all?)
- `post.delete`: Can delete posts

**Users**:
- `user.read`: Can view user profiles
- `user.update`: Can edit profiles (own or all?)
- `user.delete`: Can delete users

### Cross-Tenant Isolation

In multi-tenant systems, enforce:
- User from Tenant A can only see Tenant A data
- Query filter: WHERE user.tenant_id = current_user.tenant_id
- Every database query must include tenant check
- API responses include tenant ID (for verification)
- Test: Manually verify user can't access other tenant's data

---

## Data Protection

How sensitive data is kept secure.

### Encryption in Transit

- **Protocol**: HTTPS only (TLS 1.2 minimum, TLS 1.3 preferred)
- **Cipher suites**: Use strong ciphers (AEAD like AES-GCM)
- **Certificate**: Valid, not self-signed (except dev)
- **HSTS header**: Enforce HTTPS (Strict-Transport-Security: max-age=31536000)
- **Mixed content**: Block (no HTTP on HTTPS page)

**Test**:
- Run `nmap --script ssl-enum-ciphers` on your domain
- Verify TLS 1.3 supported
- Check certificate details (valid, not expired)

### Encryption at Rest

- **Algorithm**: AES-256 (industry standard)
- **Key management**: Keys in Secrets Manager, not in code
- **Database encryption**: Enable in RDS/managed service
- **Backups**: Encrypt all backups (same key or different?)
- **Old keys**: Rotate keys every 90 days, keep old keys for decryption

**What to encrypt**:
- [ ] Passwords (hashed, not encrypted)
- [ ] API keys
- [ ] Credit card data (if stored, which you shouldn't)
- [ ] Social security numbers
- [ ] Email addresses (debatable, depends on compliance)
- [ ] Phone numbers (debatable)

**What not to encrypt** (search/index won't work):
- Usernames (encrypt only if required by compliance)
- Post titles (need full-text search)

### Secrets Management

**Never**:
- Commit to git
- Store in environment variables (for production)
- Log or print
- Send via email
- Store in config files

**Always**:
- Store in Secrets Manager (AWS Secrets Manager, HashiCorp Vault)
- Rotate every 30-90 days
- Use principle of least privilege (app only gets needed secrets)
- Audit access (who accessed which secrets?)

**Secrets to manage**:
- Database credentials
- API keys
- OAuth client secrets
- SSL/TLS private keys
- Encryption keys
- Third-party service tokens (Stripe, Twilio, etc.)

### Personally Identifiable Information (PII)

**What is PII**:
- Names, email addresses, phone numbers
- Social security numbers, passport numbers
- Credit card numbers, bank accounts
- Health information, biometric data
- IP addresses (in some jurisdictions)

**PII handling**:
- Minimize collection (only what's needed)
- Minimize retention (delete when no longer needed)
- Encrypt in transit and at rest
- Mask in logs (never log full email/phone)
- Access control (only people who need it)
- Regular audits (who accessed PII and when?)

**Data deletion**:
- Right to be forgotten (GDPR requirement)
- User can request full data deletion
- Process: Cascade delete from all tables, backups expire
- Timeline: 30 days (balance with legal holds)

---

## Input Validation & Sanitization

Prevent injection attacks and malformed data.

### SQL Injection Prevention

**Vulnerable code** (NEVER DO THIS):
```python
query = f"SELECT * FROM users WHERE email = '{user_input}'"  # BAD!
# If user enters: '; DROP TABLE users; --
# Query becomes: SELECT * FROM users WHERE email = ''; DROP TABLE users; --'
```

**Safe code** (DO THIS):
```python
query = "SELECT * FROM users WHERE email = ?"
cursor.execute(query, (user_input,))  # Parameterized, safe!

# Or with ORM:
user = User.query.filter_by(email=user_input).first()
```

**Testing**:
- Try entering: `' OR '1'='1`
- Try entering: `'; DROP TABLE users; --`
- Verify errors don't leak database info

### Cross-Site Scripting (XSS) Prevention

**Vulnerable code** (NEVER DO THIS):
```html
<p>Welcome, {{user_input}}</p>  <!-- If user enters: <img src=x onerror="alert('XSS')"> -->
```

**Safe code** (DO THIS):
```html
<p>Welcome, <%= htmlEscape(user_input) %></p>  <!-- Escapes HTML entities -->
<!-- Or framework does it automatically (React, Vue) -->
```

**Content Security Policy (CSP)**:
```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self'">
<!-- Only allow scripts from same origin, blocks inline scripts -->
```

### CSRF (Cross-Site Request Forgery) Prevention

**Attack**: Attacker tricks user into making unwanted request

**Prevention**:
- CSRF tokens: Include token in form, verify on submit
- SameSite cookies: Cookie only sent to same site
- Check origin header: Verify request came from same domain

**Implementation**:
```python
# Generate token
@app.get("/form")
def form():
    token = generate_csrf_token()
    return render("form.html", csrf_token=token)

# Verify token on submit
@app.post("/form")
def submit(request):
    token = request.form.get("csrf_token")
    if not verify_csrf_token(token):
        return error("CSRF token invalid")
    # Process form
```

### Command Injection Prevention

**Vulnerable code** (NEVER DO THIS):
```python
import os
filename = user_input  # If user enters: "file.txt && rm -rf /"
os.system(f"convert {filename} output.png")  # BAD!
```

**Safe code** (DO THIS):
```python
import subprocess
subprocess.run(["convert", user_input, "output.png"], check=True)  # Safe, can't inject commands
```

### XXE (XML External Entity) Prevention

**Vulnerable code** (NEVER DO THIS):
```python
import xml.etree.ElementTree as ET
tree = ET.parse(user_input_file)  # If file contains: <!ENTITY xxe SYSTEM "file:///etc/passwd">
```

**Safe code** (DO THIS):
```python
import defusedxml.ElementTree as ET
tree = ET.parse(user_input_file)  # Defusedxml removes XXE vulnerabilities
```

---

## API Security

### Rate Limiting

Prevent brute force and abuse.

```
GET /api/auth/login
- Per-user limit: 5 failed attempts per 15 minutes (then lock account 15 min)
- Per-IP limit: 100 attempts per hour

GET /api/users
- Authenticated: 1000 requests per hour
- Unauthenticated: 10 requests per hour
```

**Implementation**:
- Use Redis to track request counts
- Key: `ip:path` or `user_id:path`
- Increment on request, check against limit
- Return 429 (Too Many Requests) if exceeded

### DDoS Mitigation

- **AWS Shield Standard** (free, included)
- **AWS Shield Advanced** (paid, better protection)
- **AWS WAF** (Web Application Firewall) with rules:
  - Block known bad IP ranges
  - Limit request size
  - Block excessive connections from single IP

### API Key Management

**If using API keys for client access**:
- Generate random 32+ character keys (use uuid or secrets.token_urlsafe)
- Hash keys in database (never store plaintext)
- Rotate every 90 days
- Revoke if leaked
- Log all API key usage (who/when/what)

---

## Dependency Security

### Vulnerable Library Scanning

**Tools**:
- npm: `npm audit`
- Python: `pip audit`
- General: `snyk test`, `OWASP Dependency-Check`

**Process**:
1. Run on every commit (CI/CD)
2. Fail build if critical vulnerabilities found
3. Review high/medium vulnerabilities, decide on fix timeline
4. Update dependencies as security patches released

**Example**:
```bash
npm audit
# Found 5 vulnerabilities (1 critical, 3 high, 1 moderate)
npm audit fix  # Auto-fix if possible
npm audit fix --audit-level=high  # Only fix critical/high
```

### Dependency Updates

**Policy**:
- Security patches: Apply immediately (same day)
- Minor updates: Apply monthly (no breaking changes)
- Major updates: Plan and test (might need code changes)
- Deprecated: Remove and replace

**Testing after update**:
- Run full test suite
- Run security scan
- Deploy to staging first
- Monitor for errors

---

## Audit & Compliance

### Audit Logging

**What to log**:
- [ ] User authentication (login success/failure)
- [ ] Authorization changes (role changes, permission grants)
- [ ] Data access (especially sensitive data)
- [ ] Data modifications (who changed what, when)
- [ ] System configuration changes
- [ ] Security events (failed login, rate limit, etc.)

**Log format** (structured, JSON):
```json
{
  "timestamp": "2024-01-15T10:30:45Z",
  "event_type": "user.login",
  "user_id": "user123",
  "ip_address": "192.168.1.1",
  "result": "success",
  "duration_ms": 150
}
```

**Retention**:
- Hot storage: 90 days (searchable)
- Cold storage: 7 years (compliance, not searchable)
- Immutable: Logs cannot be modified (write-once)

### Compliance Frameworks

**GDPR (EU personal data)**:
- [ ] Lawful basis for data processing
- [ ] Privacy policy published
- [ ] Consent before processing
- [ ] Data breach notification within 72 hours
- [ ] Data subject rights (access, delete, portability)
- [ ] Data Protection Impact Assessment (DPIA) for high-risk processing
- [ ] DPO (Data Protection Officer) if handling lots of personal data

**HIPAA (US healthcare)**:
- [ ] Encryption of patient data (in transit and at rest)
- [ ] Access controls (only authorized personnel)
- [ ] Audit controls (track who accessed what)
- [ ] Integrity controls (data not altered)
- [ ] Transmission security (secure channels)

**PCI-DSS (Payment Card Industry)**:
- [ ] No storing full card numbers
- [ ] If storing: PCI-DSS Level 1 compliance required
- [ ] Recommended: Use payment processor (Stripe, Square) instead
- [ ] Network segmentation (card data isolated)
- [ ] Regular security testing

**SOC 2 Type II** (US compliance, audit-based):
- [ ] Security: Access controls, encryption, monitoring
- [ ] Availability: Uptime tracking, disaster recovery
- [ ] Processing Integrity: Data validation, error handling
- [ ] Confidentiality: Secrets management, access controls
- [ ] Privacy: Data minimization, retention policies

### Data Retention Policy

```
User Registration Data:
- Retention: As long as account active
- Deletion: 30 days after account deletion
- Reason: Compliance with GDPR right to be forgotten

User Activity Logs:
- Retention: 90 days (hot), 7 years (cold)
- Reason: Audit requirements, potential investigations

Payment Records:
- Retention: 7 years
- Reason: Tax and legal requirements

Email Communications:
- Retention: 1 year
- Deletion: Automatic after 1 year
- Reason: Space management, privacy
```

---

## Incident Response

### Breach Classification

**P1 (Critical)**: Immediate page on-call
- PII/payment data exposed
- Authentication system compromised
- Full data breach

**P2 (High)**: Page on-call, < 1 hour
- One user's data exposed
- Non-critical system compromised
- Security finding from audit

**P3 (Medium)**: Email alert, fix within week
- Minor vulnerability found
- Access control bypass (low risk)

### Response Timeline

1. **Detection**: Alert fires, on-call engineer paged
2. **Triage** (5 min): Confirm issue, assess impact
3. **Containment** (15 min): Stop the bleeding, isolate affected systems
4. **Investigation** (1-2 hours): Understand what happened, how many users affected
5. **Remediation** (varies): Fix the issue, deploy patch
6. **Verification** (30 min): Confirm fix works, no data loss
7. **Communication** (varies): Notify affected users, update status page
8. **Post-mortem** (next day): What went wrong? How to prevent?

### Notification

**GDPR Requirement**: Notify within 72 hours of breach

**Communication**:
- Affected users: Email with what happened, what to do
- Regulators: If required by law
- Partners: If their data affected
- Status page: Public notification

**Example notification**:
```
Subject: Security Notice - Your Account May Have Been Affected

On [date], we discovered a security issue that may have exposed:
- Email addresses
- Hashed passwords (not plaintext)

What happened: [Brief explanation]

What we did: [How we fixed it]

What you should do: [Change password, enable MFA, etc.]

Questions? Contact security@example.com
```

---

## Security Review Schedule

- **Before launch**: Security review, penetration test
- **Quarterly**: Security audit, dependency scanning
- **After incidents**: Post-mortem, prevent recurrence
- **Annual**: Full penetration test, compliance audit

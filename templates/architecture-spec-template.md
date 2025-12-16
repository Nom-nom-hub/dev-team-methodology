# Architecture Specification

Detailed technical specification of system components, interactions, and design decisions.

---

## System Components

List each component, its responsibility, and technology choice.

| Component | Responsibility | Technology | Rationale |
|-----------|-----------------|------------|-----------|
| [e.g., API Gateway] | [Route requests, authentication] | [nginx, AWS API Gateway] | [Performance, cost, team experience] |
| [e.g., Auth Service] | [User authentication, token management] | [FastAPI with JWT] | [Simple, stateless, scalable] |
| [e.g., Database] | [Persistent data storage] | [PostgreSQL 15] | [Relational, proven, ACID] |

### Component Details

For each major component, document:

**[Component Name]**
- Purpose: [What does it do?]
- Responsibility: [What is it NOT responsible for?]
- Technology: [Framework, language, version]
- Scalability approach: [Horizontal/vertical? Load balancing?]
- Failure mode: [What if this fails? How does system respond?]
- Monitoring points: [Key metrics to track]

---

## Component Interaction Diagram

Visual representation of how components communicate.

```
┌─────────────┐
│   Client    │
│ (Browser)   │
└──────┬──────┘
       │ HTTPS
       ▼
┌─────────────────┐      ┌──────────────┐
│  API Gateway    │─────▶│  Auth Service│
│  (nginx)        │      │  (FastAPI)   │
└────────┬────────┘      └──────────────┘
         │
         ▼
    ┌────────────────┐
    │  API Services  │
    │  (FastAPI)     │◀──▶[Cache - Redis]
    └────────┬───────┘
             │
             ▼
    ┌────────────────┐
    │   Database     │
    │  (PostgreSQL)  │
    └────────────────┘
         │
         ▼
    [Backup - S3]
```

**Interaction flow**:
1. Client sends HTTPS request to API Gateway
2. API Gateway forwards to appropriate service
3. Service authenticates with Auth Service
4. Service queries Database (or reads from Cache)
5. Response returned through API Gateway to Client

---

## Data Flow

How data moves through the system, including request/response cycles.

### Request Flow

**GET /api/users/{id}** example:
1. Client sends HTTPS request to API Gateway
2. Gateway validates TLS certificate
3. Gateway looks up route → forwards to User Service
4. User Service extracts JWT from header, validates with Auth Service
5. Auth Service confirms user has permission to view user {id}
6. User Service queries Database: `SELECT * FROM users WHERE id = ?`
7. Database returns user record (from cache if recent)
8. User Service applies output filter (hide password field)
9. User Service returns JSON response
10. API Gateway adds security headers
11. Client receives response, parses JSON

### Event Flow (if applicable)

**Example: User registration**:
1. User submits signup form to API
2. API validates input, creates user in Database
3. Database emits `user.created` event
4. Event bus publishes event
5. Email Service subscribes, sends welcome email
6. Audit Service subscribes, logs user creation
7. Response immediately returned to client (async processing)

### Batch Processing Flow (if applicable)

**Example: Daily report generation**:
1. Scheduler triggers at 2 AM UTC
2. Job queued in job queue (Celery, Bull, etc.)
3. Worker picks up job, runs report generation
4. Report queries Database (read-only replica if available)
5. Report generated as PDF
6. PDF stored in S3
7. Email sent to user with S3 link
8. Job marked complete in job queue

---

## Database Schema

Entity relationship diagram and detailed schema.

### Database Diagram

```
users
├─ id (PK)
├─ email (UNIQUE)
├─ password_hash
├─ created_at
└─ updated_at

posts
├─ id (PK)
├─ user_id (FK → users.id)
├─ title
├─ content
├─ created_at
└─ updated_at

comments
├─ id (PK)
├─ post_id (FK → posts.id)
├─ user_id (FK → users.id)
├─ content
└─ created_at
```

### Table Definitions

**users**
- `id` (UUID, PRIMARY KEY): Unique user identifier
- `email` (VARCHAR 255, UNIQUE, NOT NULL): User's email, used for login
- `password_hash` (VARCHAR 255, NOT NULL): bcrypt hash, never store plaintext
- `first_name` (VARCHAR 100): User's first name
- `last_name` (VARCHAR 100): User's last name
- `created_at` (TIMESTAMP, DEFAULT NOW()): Account creation time
- `updated_at` (TIMESTAMP, DEFAULT NOW()): Last profile update time

**Indexes**:
- UNIQUE INDEX on email (fast lookup by email during login)
- INDEX on created_at (fast queries for "users created in last 30 days")

**Constraints**:
- email length < 255 characters (email standard)
- password_hash always present (users must have password)
- created_at ≤ updated_at (logical constraint)

**posts**
- `id` (UUID, PRIMARY KEY): Unique post identifier
- `user_id` (UUID, FK to users.id, NOT NULL): Which user created post
- `title` (VARCHAR 500, NOT NULL): Post title
- `content` (TEXT, NOT NULL): Post content (can be large)
- `published` (BOOLEAN, DEFAULT FALSE): Is post visible?
- `created_at` (TIMESTAMP, DEFAULT NOW()): Creation time
- `updated_at` (TIMESTAMP, DEFAULT NOW()): Last edit time

**Indexes**:
- INDEX on user_id (fast queries for "all posts by user X")
- INDEX on published, created_at (fast queries for "published posts, ordered by date")
- FULL TEXT INDEX on title, content (search by content)

**comments**
- `id` (UUID, PRIMARY KEY): Unique comment identifier
- `post_id` (UUID, FK to posts.id, NOT NULL): Which post is this comment on
- `user_id` (UUID, FK to users.id, NOT NULL): Who commented
- `content` (TEXT, NOT NULL): Comment text
- `created_at` (TIMESTAMP, DEFAULT NOW()): When commented

**Indexes**:
- INDEX on post_id (fast queries for "all comments on post X")
- INDEX on user_id (fast queries for "all comments by user X")

**Constraints**:
- post_id must exist (referential integrity)
- user_id must exist (referential integrity)
- Deleting a post CASCADE deletes its comments

---

## API Contracts

Detailed specification of all API endpoints.

### GET /api/users/{id}

**Purpose**: Retrieve user profile

**Request**:
- **URL Parameters**: 
  - `id` (UUID, required): User ID to retrieve
- **Headers**: 
  - `Authorization: Bearer {token}` (required): JWT token
  - `Accept: application/json` (preferred)
- **Query Parameters**: None
- **Body**: None

**Response - 200 OK**:
```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "user@example.com",
  "first_name": "John",
  "last_name": "Doe",
  "created_at": "2024-01-15T10:30:00Z",
  "updated_at": "2024-01-20T14:45:00Z"
}
```

**Response - 404 Not Found**:
```json
{
  "error": "user_not_found",
  "message": "User with id 550e8400... does not exist"
}
```

**Response - 401 Unauthorized**:
```json
{
  "error": "invalid_token",
  "message": "JWT token is missing or invalid"
}
```

**Response - 403 Forbidden**:
```json
{
  "error": "insufficient_permissions",
  "message": "You don't have permission to view this user"
}
```

**Rate Limit**: 1000 requests per minute per user (IP limit: 10000/min)

**Authentication**: Required (JWT token)

**Caching**: Response cached for 5 minutes (Cache-Control: max-age=300)

---

## Configuration Management

How environment-specific configuration is managed.

### Environment Variables

**Database Connection**:
- `DATABASE_URL`: Full connection string (includes credentials)
- `DATABASE_POOL_SIZE`: Number of connections to maintain (default: 20)
- `DATABASE_TIMEOUT`: Connection timeout in seconds (default: 30)

**Application**:
- `APP_ENV`: Environment name (development, staging, production)
- `APP_PORT`: Port to listen on (default: 8000)
- `APP_DEBUG`: Enable debug mode (development only, default: false)

**Authentication**:
- `JWT_SECRET`: Secret key for signing JWTs (must be 32+ characters)
- `JWT_EXPIRATION`: Token lifetime in seconds (default: 3600 = 1 hour)
- `AUTH_SERVICE_URL`: URL of authentication service

**Secrets**:
- `API_KEY`: Third-party API key (e.g., for Stripe)
- Never commit these to git, use vault or env vars

### Feature Flags

- `FEATURE_NEW_DASHBOARD`: Enable new dashboard UI (boolean)
- `FEATURE_BETA_API_V2`: Enable Beta API version (boolean)
- Stored in database, cached in memory, refreshed every minute

### Configuration per Environment

**Development**:
- DEBUG = true (detailed error messages)
- LOG_LEVEL = DEBUG (verbose logging)
- DATABASE = local SQLite or localhost PostgreSQL
- CACHE = in-memory cache or disabled
- EMAIL = log to console instead of sending

**Staging**:
- DEBUG = false
- LOG_LEVEL = INFO
- DATABASE = RDS PostgreSQL (staging instance)
- CACHE = Redis (staging instance)
- EMAIL = send to staging email addresses

**Production**:
- DEBUG = false (never!)
- LOG_LEVEL = WARNING (quiet, only important events)
- DATABASE = RDS PostgreSQL (production, encrypted)
- CACHE = Redis cluster (high availability)
- EMAIL = send to real users

---

## Deployment Architecture

How the system is deployed and scaled.

### Container Strategy

**Docker Image**:
- Base image: `python:3.11-slim` (smaller, faster)
- Dockerfile multi-stage build (build deps separate from runtime)
- Image size: < 500MB
- Registry: AWS ECR (Amazon Elastic Container Registry)

**Image Tagging**:
- `latest`: Most recent production version
- `v1.2.3`: Release tags, semantic versioning
- `staging-abc123`: Staging builds, commit SHA
- Immutable images (never rebuild same version)

### Kubernetes Deployment

**API Service**:
- Replicas: 3 (high availability)
- Resource requests: 
  - CPU: 500m (0.5 cores requested)
  - Memory: 512Mi (requested), 1Gi (limit)
- Auto-scaling: 3-10 replicas based on CPU usage (80% threshold)
- Rolling updates: Replace one pod at a time (zero downtime)

**Database**:
- RDS PostgreSQL (managed, not in K8s)
- Primary + read replica (for backups, read scaling)
- Automated backups: daily, 30-day retention
- Multi-AZ: yes (automatic failover)

**Cache Layer**:
- Redis in Elasticache (managed, not in K8s)
- Master + replica for high availability
- Automatic failover enabled

### Load Balancing

**API Gateway** (AWS ALB - Application Load Balancer):
- HTTPS only (TLS 1.2+)
- Routes to Kubernetes service
- Health checks: every 30 seconds
- Fails over to backup replica if instance unhealthy

### Backup & Disaster Recovery

**Database Backups**:
- Automated: daily snapshots to S3
- Retention: 30 days
- RTO (Recovery Time Objective): < 1 hour (restore from snapshot)
- RPO (Recovery Point Objective): 24 hours (previous day's backup)

**Cross-Region Backup**:
- Snapshots replicated to different AWS region
- Survives regional outage

**Disaster Recovery Drill**:
- Monthly: Restore from backup, verify data integrity
- Quarterly: Full failover to backup region

---

## Monitoring & Observability

What's measured and how it's tracked.

### Key Metrics

**Performance Metrics**:
- API response time (p50, p95, p99 latencies)
- Throughput (requests per second)
- Error rate (% of requests that fail)
- Database query time (slow query log)
- Cache hit rate (% of requests served from cache)

**Business Metrics**:
- Active users (daily/monthly)
- Conversion rate (signups to paid)
- User retention (% still using after 30 days)

**Infrastructure Metrics**:
- CPU usage (per pod, per cluster)
- Memory usage (per pod, per cluster)
- Disk usage (database, storage)
- Network I/O (bytes in/out per second)

### Log Aggregation

**Structured Logging**:
- All logs as JSON (machine-readable)
- Fields: timestamp, level, service, request_id, user_id, error, duration
- Sent to ELK Stack (Elasticsearch, Logstash, Kibana)
- Retention: 30 days hot, 90 days archived

**Log Levels**:
- DEBUG: Development only, detailed trace info
- INFO: Important events (user logged in, post created)
- WARNING: Unexpected but recoverable (auth retry, cache miss)
- ERROR: Something failed (database error, API timeout)
- CRITICAL: System down (all APIs returning 500)

### Distributed Tracing

**Request Correlation**:
- Each request gets unique `X-Request-ID` header
- Logged in every service that touches the request
- Enables tracking request flow across services

**Tracing Tools**:
- OpenTelemetry for instrumentation
- Jaeger for visualization (where does time go?)

### Alerting

**Alert Conditions**:
- Error rate > 1% for 5 minutes → Page on-call engineer
- Response time p95 > 500ms for 10 minutes → Page on-call engineer
- Database connection pool exhausted → Page on-call engineer
- Disk usage > 80% → Email alert (not urgent)

**Escalation**:
- P1 (Critical): Page on-call immediately, escalate if not ack'd in 5 min
- P2 (High): Page on-call, escalate if not ack'd in 15 min
- P3 (Medium): Email alert, no escalation
- P4 (Low): Log only, review next morning

---

## Security Hardening (deployment level)

Infrastructure security measures.

### Network Security

- VPC (isolated network, no internet except through load balancer)
- Security groups (whitelist only necessary traffic)
- WAF (AWS Web Application Firewall) on ALB
- DDoS protection (AWS Shield Standard + Advanced)

### Secrets Management

- All secrets in AWS Secrets Manager (not in code, not in env vars)
- Rotation: every 90 days for most secrets, every 30 days for API keys
- Access: Only pods with proper IAM role can read secrets

### Encryption

- TLS 1.2+ for all traffic (in transit)
- AES-256 for database encryption at rest
- S3 bucket encryption for backups
- All secrets encrypted in Secrets Manager

### Access Control

- IAM roles for services (principle of least privilege)
- RBAC in Kubernetes (pods only access needed resources)
- Database user with minimal permissions
- No shared AWS accounts (separate dev/staging/prod accounts)

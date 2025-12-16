# Performance Budget

Define performance targets and budgets before implementation. Use these to guide optimization and prevent regressions.

---

## Response Time Targets (Percentiles)

Measure these with real user traffic (or load testing).

### API Endpoints

| Endpoint | p50 (median) | p95 (good for 95%) | p99 (worst 1%) | Rationale |
|----------|--------------|-------------------|----------------|-----------|
| GET /api/users/{id} | 20ms | 50ms | 200ms | Simple lookup, should be fast |
| GET /api/posts | 50ms | 150ms | 500ms | List endpoint, may have filters |
| POST /api/posts | 100ms | 300ms | 1000ms | Create requires DB write + cache invalidation |
| POST /api/auth/login | 200ms | 500ms | 2000ms | Password hashing is slow (intentional) |

### Frontend

| Metric | Target | Rationale |
|--------|--------|-----------|
| First Contentful Paint (FCP) | < 1s | First paint visible to user |
| Largest Contentful Paint (LCP) | < 2.5s | Main content visible |
| Cumulative Layout Shift (CLS) | < 0.1 | No unexpected layout shifts |
| Time to Interactive (TTI) | < 3.5s | Page fully interactive |
| Total Blocking Time (TBT) | < 200ms | JavaScript execution time |

**Measurement**:
- Desktop: ideal conditions (Chrome on MacBook Pro)
- Mobile: realistic conditions (Chrome on Nexus 5X, 4G network)
- Lighthouse score: target ≥ 90

---

## Throughput Targets

Maximum load the system must handle.

### Normal Load

- **Concurrent users**: 1,000 simultaneous users
- **Requests per second**: 500 req/sec
- **Database queries per second**: 2,000 queries/sec (with caching)

### Peak Load (10x normal, short duration)

- **Concurrent users**: 10,000 simultaneous
- **Requests per second**: 5,000 req/sec
- **System should handle**: for 5-15 minutes during spikes

### Sustained Load (all day)

- **Concurrent users**: 5,000 simultaneous
- **Requests per second**: 2,500 req/sec
- **Can maintain**: for 24+ hours without degradation

### Load Shedding

If load exceeds capacity:
- Drop 5% of lowest-priority requests (graceful degradation)
- Return 429 (Too Many Requests) instead of timeout
- Alert ops team (not a surprise)

---

## Memory & CPU Budgets

Per server/container limits.

### API Server (per instance)

- **Memory limit**: 1GB (soft limit 512MB)
- **CPU limit**: 2 cores (soft limit 1 core)
- **Startup memory**: 200MB (goes up as requests arrive)
- **Memory per request**: < 5MB (should not grow with users)

**Memory Leak Test**:
- Run for 24 hours at load
- Memory should stabilize, not keep growing
- If grows > 10% per hour → bug

### Database Server

- **Memory limit**: 32GB for working set
- **CPU usage**: Max 70% at peak (reserve 30% for spikes)
- **Connection pool**: 100 connections max (1 per request)

### Cache Server (Redis)

- **Memory usage**: < 8GB (evict old data if exceeds)
- **CPU usage**: < 50% at peak
- **Eviction policy**: LRU (least recently used)

---

## Database Query Budgets

Constraints on database access.

### Query Execution Time

| Query Type | Budget | Tolerance |
|-----------|--------|-----------|
| Single row lookup (SELECT by PK) | < 1ms | 5ms (may miss cache) |
| Index scan (WHERE on indexed column) | < 10ms | 50ms (may touch disk) |
| Table join (2-3 tables) | < 50ms | 200ms (complex query) |
| Full table scan | < 5s | Don't do this in production |

### Query Complexity

- **Max joins**: 3 (more = N+1 problem likely)
- **Max WHERE conditions**: 5 (more = needs optimization)
- **No correlated subqueries** (very slow with large datasets)
- **No SELECT \*** - specify exact columns needed

### Connection Pool

- **Available connections**: 20-50 (depends on concurrency)
- **Connection timeout**: 30 seconds (if connection not returned)
- **Connection validation**: PING before use

### Caching Strategy

**What to cache**:
- User profiles (high read, low write)
- Posts lists (medium read, medium write)
- Count queries (very expensive, cache aggressively)

**What not to cache**:
- User-specific data with strict consistency requirements
- Frequently changing data
- Personally identifiable information (security risk)

**Cache expiration**:
- User profiles: 1 hour
- Posts lists: 5 minutes
- Counts: 10 minutes
- User-specific data: 30 seconds

**Cache invalidation**:
- When user updates profile → invalidate that user's cache
- When post created → invalidate posts list cache
- On errors: cache miss is OK, don't serve stale data

---

## Frontend Performance

Bundle size and optimization targets.

### JavaScript Bundles

- **Main bundle**: < 150KB gzipped
- **React bundle**: < 100KB (React + ReactDOM)
- **Third-party**: < 100KB total
- **Lazy-loaded routes**: Code-split, load on demand

**How to measure**:
```bash
npm run build  # Produces bundle size in output
# or
npm run analyze  # Visualize bundle composition
```

### CSS

- **Main CSS**: < 50KB gzipped
- **No unused CSS** (run PurgeCSS/Tailwind)
- **CSS-in-JS libraries**: Only if < 20KB

### Images

- **Images optimized**: WebP format where supported
- **Largest image**: < 200KB
- **Responsive images**: Serve correct size for device
- **Lazy loading**: Defer off-screen images

### Fonts

- **Font files**: < 100KB total
- **Load strategy**: async (don't block rendering)
- **Font-display**: swap (show fallback immediately)

---

## Load Testing Targets

What to verify with load testing.

### Test Scenario 1: Normal Load

**Setup**:
- 1,000 concurrent users
- Each user makes 1 request every 5 seconds
- Duration: 30 minutes

**Acceptance Criteria**:
- [ ] Response time p95 < 150ms
- [ ] Error rate < 0.1%
- [ ] CPU usage < 50%
- [ ] Memory stable (not growing)
- [ ] Database queries < 1000/sec

### Test Scenario 2: Spike Load

**Setup**:
- Ramp up from 100 to 10,000 concurrent users in 2 minutes
- Hold at 10,000 for 5 minutes
- Ramp down over 2 minutes

**Acceptance Criteria**:
- [ ] Response time p95 < 500ms during spike (can be slower)
- [ ] Error rate < 1% during spike
- [ ] No OOM (out of memory) errors
- [ ] System recovers to normal after spike

### Test Scenario 3: Sustained Load

**Setup**:
- 5,000 concurrent users
- Duration: 8 hours (half a business day)

**Acceptance Criteria**:
- [ ] No memory leak (memory stable ± 10%)
- [ ] No gradual performance degradation
- [ ] Error rate consistent < 0.1%
- [ ] Database connection pool not exhausted

### Test Scenario 4: Failure Recovery

**Setup**:
- 1,000 concurrent users at normal load
- Kill database connection for 30 seconds
- Observe recovery

**Acceptance Criteria**:
- [ ] Application detects database down within 30 seconds
- [ ] Errors clearly indicate database problem
- [ ] No cascading failures (other components stay healthy)
- [ ] Application recovers after database returns
- [ ] No data corruption

### Load Testing Tools

- **k6**: Modern, JavaScript-based, great for APIs
- **JMeter**: Traditional, powerful, older
- **Locust**: Python-based, realistic user behavior
- **Artillery**: Simple, good for quick tests

---

## Baseline Metrics

Measure before optimization; compare after changes.

### Establish Baseline (Before Implementation)

- Load test and record metrics
- Real user monitoring (if existing system)
- Document in this section

### Example Baseline (from previous version or competitor)

| Metric | Baseline | Target | Notes |
|--------|----------|--------|-------|
| API response p95 | 800ms | 150ms | Current system slow, targeting 5x improvement |
| FCP | 3.5s | 1.0s | Lots of JavaScript |
| Bundle size | 2.5MB | 150KB | Bloated dependencies |

### Performance Monitoring (After Launch)

Track continuously:
- Real user monitoring (RUM) - collect metrics from actual users
- Synthetic monitoring - automated tests from same location
- Compare against baseline

**Alert if**:
- p95 response time increases > 20%
- Error rate increases > 50%
- Memory grows > 10% per hour
- Cache hit rate drops below 50%

---

## Trade-off Documentation

Performance optimization decisions and their cost.

| Optimization | Benefit | Cost | Decision |
|--------------|---------|------|----------|
| Cache everything aggressively | Faster response | Stale data risk | Accept < 1 min staleness |
| Horizontal scaling to 10 instances | Handle 10x load | 3x cost | Yes, worth it |
| Pre-compute expensive reports | 100ms → 5ms | Extra DB load | Only pre-compute top 10 reports |

---

## Performance Review Schedule

When to revisit and update this budget.

- **Before implementation**: Review targets with team
- **During development**: Check candidates against targets
- **Before launch**: Load test against targets
- **Monthly (first 3 months)**: Monitor real metrics, adjust targets if needed
- **Quarterly**: Review trends, identify optimization opportunities
- **Annual**: Update based on usage growth, technology changes

---

## Tooling & Monitoring

### Measurement Tools

- **Frontend**: Lighthouse, WebPageTest, Chrome DevTools
- **API**: k6, Postman, custom scripts
- **Database**: EXPLAIN ANALYZE, SLOW QUERY LOG
- **Infrastructure**: Prometheus, Datadog, New Relic

### Alerting Thresholds

- Response time p95 > 200ms → investigate
- Error rate > 1% → alert ops
- Memory leak detected → alert + on-call
- Database slow query detected → log for review

### Performance Dashboard

Display continuously:
- Current response times (p50, p95, p99)
- Error rate (%)
- Throughput (requests/sec)
- Cache hit rate (%)
- Infrastructure: CPU, memory, disk, network

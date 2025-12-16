# Non-Functional Requirements

## Performance

- **Response time targets (p95)**: [e.g., API < 200ms, page load < 1s]
- **Throughput targets**: [e.g., 1000 requests/sec, 500 concurrent users]
- **Memory/CPU budgets**: [e.g., 2GB RAM, 2 CPU cores per instance]
- **Batch processing time limits**: [if applicable, e.g., reports < 5 minutes]

## Scalability

- **Expected concurrent users**: [e.g., 1000 concurrent, growing to 10000 in 6 months]
- **Data volume projections**: [1 year, 5 year estimates, e.g., 100GB in year 1, 1TB in year 5]
- **Geographic distribution requirements**: [e.g., single region, multi-region, global]
- **Growth rate assumptions**: [e.g., 20% monthly growth, seasonal peaks]

## Reliability & Availability

- **Target uptime**: [e.g., 99.9% (allows 43 min downtime/month), 99.99%]
- **Recovery Time Objective (RTO)**: [how quickly must service recover, e.g., < 1 hour]
- **Recovery Point Objective (RPO)**: [maximum acceptable data loss, e.g., < 5 minutes]
- **Acceptable error rates**: [e.g., < 0.1%, < 0.01% for critical operations]
- **Graceful degradation**: [what happens if features degrade?]

## Security

- **Data classification**: [public, internal, confidential, personal data]
- **Encryption in transit**: [TLS 1.2+, specific cipher suites?]
- **Encryption at rest**: [algorithm, key management approach]
- **Authentication method**: [OAuth2, JWT, SAML, multi-factor?]
- **Authorization granularity**: [role-based, attribute-based, resource-based?]
- **Compliance requirements**: [GDPR, HIPAA, SOC2, PCI-DSS, CCPA, other?]
- **Data retention policy**: [how long to keep data, deletion timeline]
- **Audit logging requirements**: [what to log, how long to retain]

## Accessibility

- **WCAG compliance level**: [A, AA, AAA - https://www.w3.org/WAI/WCAG21/quickref/]
- **Supported browsers**: [Chrome, Firefox, Safari, Edge versions]
- **Supported devices**: [desktop, tablet, mobile]
- **Keyboard navigation**: [fully keyboard accessible?]
- **Screen reader support**: [NVDA, JAWS, VoiceOver compatibility]
- **Color contrast requirements**: [WCAG AA = 4.5:1 for text]

## Cost Constraints

- **Infrastructure budget**: [monthly or annually, e.g., $5000/month]
- **Third-party service budget**: [APIs, SaaS tools, e.g., $2000/month]
- **Development time budget**: [effort estimate constraints]
- **License cost constraints**: [approved vs forbidden license types]
- **Cost optimization requirements**: [e.g., must be under $0.01 per user]

## User Experience

- **Offline capability**: [required, nice-to-have, or not needed?]
- **Responsiveness expectations**: [mobile-first, desktop-first, equal support?]
- **Internationalization (i18n)**: [supported languages, regional formatting]
- **Localization (l10n)**: [region-specific content, currencies, dates]
- **Browser back-button behavior**: [should work as expected, preserve state?]
- **Loading time perception**: [skeleton screens, progress indicators required?]

## Monitoring & Observability

- **Logging requirements**: [structured logs, log levels, retention period]
- **Metrics to collect**: [response times, error rates, business metrics]
- **Distributed tracing**: [correlation IDs required for request tracking?]
- **Alerting requirements**: [who gets notified, when, escalation policy]
- **SLA targets**: [uptime %, error rate percentiles, response time percentiles]

## Regulatory & Compliance

- **Data residency**: [must data stay in specific country/region?]
- **Industry standards**: [ISO 27001, SOC 2 Type II, FedRAMP, etc.]
- **Right to be forgotten**: [GDPR requirement to delete user data on request?]
- **Data portability**: [ability to export user data in standard format?]
- **Consent management**: [cookie consent, data processing consent requirements]

## Assumptions

- [List any assumptions being made, e.g., "Assume < 1TB data in year 1"]
- [What happens if assumption is wrong? Impact if exceeded.]
- [Monitoring approach to catch if assumption breaks]

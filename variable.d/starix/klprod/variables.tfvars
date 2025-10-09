###
opensearch_api = "https://opsi-klp.starixplay.com"

sa_custom_rules = [
  {
    rule_name           = "XSS-Detection"
    category            = "waf"
    detection_rule_file = "xss-detection.json"
    level               = "high"
    status              = "stable"
    description         = "Detects comprehensive XSS attack patterns including script injection, event handlers, encoded payloads, and modern bypass techniques via HAProxy access logs"
    references = [
      "https://github.com/payloadbox/xss-payload-list",
      "https://portswigger.net/web-security/cross-site-scripting/contexts",
      "https://owasp.org/www-community/attacks/xss/",
      "https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html",
    ]
    tags = [
      "attack.initial_access",
      "attack.t1189",
      "attack.owasp.a03",
      "attack.xss",
      "attack.injection",
    ]
    fpositives = [
      "Legitimate JavaScript/CSS/image file requests",
      "User searches containing special characters",
      "Internal security scanners and penetration testing tools",
      "Content management systems with rich text editors",
      "Development/staging environments with test payloads",
    ]
  },
  {
    rule_name           = "SQL-Injection-Strings-Detection"
    category            = "waf"
    detection_rule_file = "sql-injection.json"
    level               = "high"
    status              = "stable"
    description         = "Combined detection of SQL injection attempts via HTTP GET requests in access logs. Includes union-based, boolean-based, time-based, error-based, stacked queries, numeric-based, database fingerprinting, and encoded techniques from two rule sources."
    references = [
      "https://www.acunetix.com/blog/articles/exploiting-sql-injection-example/",
      "https://www.acunetix.com/blog/articles/using-logs-to-investigate-a-web-application-attack/",
      "https://brightsec.com/blog/sql-injection-payloads/",
      "https://github.com/payloadbox/sql-injection-payload-list",
      "https://book.hacktricks.xyz/pentesting-web/sql-injection/mysql-injection",
    ]
    tags = [
      "attack.initial_access",
      "attack.t1190",
      "attack.owasp.a03",
      "attack.injection",
      "attack.sqli",
    ]
    fpositives = [
      "Java scripts and CSS Files",
      "User searches in search boxes of the respective website",
      "Internal vulnerability scanners",
      "Database administration tools and legitimate database queries",
      "Content management systems with dynamic queries",
      "Docker registry requests and container image manifests",
      "API endpoints with SHA256 hashes and UUIDs",
      "Git commit hashes and version identifiers",
      "Legitimate search queries with special characters",
    ],
  },
]

# REQUIRED VARIABLE SET [opensearch_cred]
vault_secrets = {
  opensearch_cred = {
    mount = "nexops"
    path  = "automation/Opensearch/detection-response/starix/creds"
  }
}

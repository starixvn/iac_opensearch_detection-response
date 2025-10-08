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
  }
]

# REQUIRED VARIABLE SET [opensearch_cred]
vault_secrets = {
  opensearch_cred = {
    mount = "nexops"
    path  = "automation/Opensearch/detection-response/starix/creds"
  }
}

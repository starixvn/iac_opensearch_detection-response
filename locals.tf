locals {

  today_date = formatdate("YYYY-MM-DD", timestamp())

  sa_custom_rules = [
    for rule in var.sa_custom_rules : merge(
      rule,
      {
        id = "${rule.category}-${rule.rule_name}"
      }
    )
  ]

}

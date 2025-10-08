resource "random_uuid" "sa_rule_uids" {
  for_each = { for entry in local.sa_custom_rules : entry.id => entry }
  keepers = {
    component = each.value.id
  }
}

resource "opensearch_sa_custom_rule" "sa_rules" {
  for_each = { for entry in local.sa_custom_rules : entry.id => entry }
  category = each.value.category
  body = templatefile("${path.module}/security-analytics-rules/rule-template.json.tpl", {
    rule_name   = each.value.rule_name
    id          = random_uuid.sa_rule_uids["${each.key}"].result
    date        = local.today_date
    category    = each.value.category
    description = each.value.description
    detection   = file("${path.module}/security-analytics-rules/${each.value.detection_rule_file}")
    level       = each.value.level
    author      = each.value.author
    status      = each.value.status
    references  = jsonencode(each.value.references)
    tags        = jsonencode(each.value.tags)
    fpositives  = jsonencode(each.value.fpositives)
  })

  depends_on = [random_uuid.sa_rule_uids]
}

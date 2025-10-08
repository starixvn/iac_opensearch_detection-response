variable "opensearch_api" {
  description = "List of datastream group"
  type        = string
}

variable "sa_custom_rules" {
  type = list(object({
    rule_name           = string
    category            = string
    description         = string
    detection_rule_file = string
    level               = string
    status              = string
    author              = optional(string, "NexOps Team")
    references          = list(string)
    tags                = list(string)
    fpositives          = list(string)
  }))
}

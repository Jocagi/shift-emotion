/*
resource "aws_wafv2_web_acl" "waf" {

  name        = "${var.app_name}-waf-cloudfront"
  description = "WAF for CloudFront containing SQL Database attack protection and common web application attacks"
  scope       = "CLOUDFRONT"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${var.app_name}-waf-cloudfront"
    sampled_requests_enabled   = false
  }

  //WAF Rules to protect against
  rule {

    name     = "SQL_Database"
    priority = 1

    override_action {
      count {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.app_name}-waf-cloudfront-SQL_Database"
      sampled_requests_enabled   = false
    }
  }

  rule {

    name     = "Core_Rule_Set"
    priority = 2

    override_action {
      count {}
    }

    statement {

      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${var.app_name}-waf-cloudfront-Core_Rule_Set"
      sampled_requests_enabled   = false
    }
  }
}
*/
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name        = "cloudwatch_event_rule"
  description = "Capture every non compliant s3."

  event_pattern = jsonencode({
    "source" : ["aws.config"],
    "detail-type" : ["Config Rules Compliance Change"],
    "detail" : {
      "complianceType" : ["NON_COMPLIANT"]
    }
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  arn  = aws_sns_topic.non_compliants_nofif.arn
}
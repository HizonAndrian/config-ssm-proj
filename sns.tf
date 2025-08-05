resource "aws_sns_topic" "non_compliants_nofif" {
  name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.non_compliants_nofif.arn
  protocol  = "email"
  endpoint  = var.sns_email_address
}
resource "aws_config_configuration_recorder_status" "config_status" {
  name       = aws_config_configuration_recorder.config_recorder.name
  is_enabled = true

  depends_on = [aws_config_delivery_channel.config_channel]
}

resource "aws_config_configuration_recorder" "config_recorder" {
  name     = "config_recorder"
  role_arn = aws_iam_role.config_role.arn
}

resource "aws_config_delivery_channel" "config_channel" {
  name           = "config_channel"
  s3_bucket_name = aws_s3_bucket.config_delivery_channel.bucket
  depends_on     = [aws_config_configuration_recorder.config_recorder]
  s3_key_prefix  = ""
}

resource "aws_config_config_rule" "config_rule" {
  name = "config_rule"

  source {
    owner             = "AWS"
    source_identifier = var.config_rule_name
  }

  input_parameters = jsonencode({
    tag1Key = "Environment"
    tag2Key = "Owner"
  })

  scope {
    compliance_resource_types = ["AWS::S3::Bucket"]
  }
}

# resource "aws_config_remediation_configuration" "remediation_configuration" {
#   config_rule_name = aws_config_config_rule.config_rule.name
#   target_id        = var.remediation_document_name
#   target_type      = "SSM_DOCUMENT"
#   automatic        = var.remediation_enabled
#   resource_type    = "AWS::S3::Bucket"

#   parameter {
#     name         = "AutomationAssumeRole"
#     static_value = aws_iam_role.config_role.arn
#   }

#   parameter {
#     name           = "BucketName"
#     resource_value = "RESOURCE_ID"
#   }

#   maximum_automatic_attempts = 10
#   retry_attempt_seconds      = 80

# }
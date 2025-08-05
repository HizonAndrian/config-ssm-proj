variable "region" {
  type = string
}

variable "config_bucket_name" {
  type = string
}

variable "config_rule_name" {
  type = string
}

variable "remediation_enabled" {
  type = bool
}

variable "remediation_document_name" {
  type    = string
  default = "AWS-EnableS3BucketVersioning"
}

variable "tag" {
  type = map(string)
}

variable "sns_topic_name" {
  type = string
}

variable "sns_email_address" {
  type = string

  default = "markandrianhizon@gmail.com"
}
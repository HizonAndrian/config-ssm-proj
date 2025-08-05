resource "aws_s3_bucket" "config_delivery_channel" {
  bucket = var.config_bucket_name

  tags = var.tag
}

resource "aws_s3_bucket_versioning" "bucket_version_config" {
  bucket = aws_s3_bucket.config_delivery_channel.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_policy" "config_bucket_policy" {
  bucket = aws_s3_bucket.config_delivery_channel.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AWSConfigBucketPermissionsCheck",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:GetBucketAcl",
        Resource = "arn:aws:s3:::${aws_s3_bucket.config_delivery_channel.id}"
      },
      {
        Sid    = "AWSConfigBucketDelivery",
        Effect = "Allow",
        Principal = {
          Service = "config.amazonaws.com"
        },
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.config_delivery_channel.id}/*",
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}





resource "aws_s3_bucket" "non_encrypted_test" {
  bucket = "non-encrypted-bucket-andrian-test"


}


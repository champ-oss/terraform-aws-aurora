module "eventbridge_s3_export" {
  count        = var.enable_s3_export ? 1 : 0
  source       = "github.com/champ-oss/terraform-aws-eventbridge.git?ref=v1.0.1-1ce59ef"
  git          = substr("${var.git}-${local.cluster_identifier_prefix}", 0, 60)
  service_name = "rds"
  api_action   = "startexporttask"
  role_arn     = aws_iam_role.this.arn
  input_parameters = {
    ExportTaskIdentifier : substr("${var.git}-${local.cluster_identifier_prefix}", 0, 60),
    IamRoleArn : aws_iam_role.this.arn,
    KmsKeyId : module.kms[0].key_id,
    S3BucketName : module.s3.bucket,
    SourceArn : aws_rds_cluster.this.arn
  }
  schedule_expression       = var.s3_export_schedule_expression
  maximum_window_in_minutes = var.s3_export_maximum_window_in_minutes
}
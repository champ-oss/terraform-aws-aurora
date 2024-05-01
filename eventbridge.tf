module "eventbridge_s3_export" {
  count        = var.enable_s3_export ? 1 : 0
  source       = "github.com/champ-oss/terraform-aws-eventbridge.git?ref=v1.0.3-abade70"
  git          = "${substr(local.cluster_identifier_prefix, 0, 27)}-s3-export"
  service_name = "rds"
  api_action   = "startExportTask"
  role_arn     = aws_iam_role.this[0].arn
  input_parameters = {
    ExportTaskIdentifier : "${substr(local.cluster_identifier_prefix, 0, 22)}-<aws.scheduler.execution-id>"
    IamRoleArn : aws_iam_role.this[0].arn,
    KmsKeyId : module.kms[0].key_id,
    S3BucketName : module.s3[0].bucket,
    SourceArn : aws_rds_cluster.this.arn
  }
  schedule_expression       = var.s3_export_schedule_expression
  maximum_window_in_minutes = var.s3_export_maximum_window_in_minutes
}

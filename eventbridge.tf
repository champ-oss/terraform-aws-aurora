resource "aws_scheduler_schedule" "universal_target" {
  count = var.enabled && var.enable_s3_export ? 1 : 0

  name_prefix = "${substr(local.cluster_identifier_prefix, 0, 27)}-s3-export"
  state       = "ENABLED"
  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 15
  }

  schedule_expression          = var.s3_export_schedule_expression
  schedule_expression_timezone = var.s3_export_maximum_window_in_minutes

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:rds:startExportTask"
    role_arn = aws_iam_role.this[0].arn
    input    = replace(replace(jsonencode({
      ExportTaskIdentifier : "${substr(local.cluster_identifier_prefix, 0, 22)}-<aws.scheduler.execution-id>",
      IamRoleArn : aws_iam_role.this[0].arn,
      KmsKeyId : module.kms[0].key_id,
      S3BucketName : module.s3[0].bucket,
      SourceArn : aws_rds_cluster.this[0].arn
    }),
      "\\u003e", ">"),
      "\\u003c", "<")
  }
}

resource "aws_dms_endpoint" "this" {
  depends_on    = [aws_rds_cluster_instance.this]
  count         = var.create_dms_endpoint ? 1 : 0
  endpoint_id   = "${aws_rds_cluster.this.cluster_identifier}-dms-endpoint"
  endpoint_type = var.dms_endpoint_type
  engine_name   = "aurora"
  database_name = var.database_name
  password      = random_password.password.result
  port          = aws_rds_cluster.this.port
  server_name   = aws_rds_cluster.this.endpoint
  tags          = merge(local.tags, var.tags)
  username      = aws_rds_cluster.this.master_username
  
  timeouts {
    create = "60m"
    update = "60m"
    delete = "60m"
  }
}

resource "aws_dms_replication_task" "this" {
  depends_on               = [aws_rds_cluster_instance.this]
  count                    = var.create_dms_replication_task ? 1 : 0
  migration_type           = var.dms_migration_type
  replication_instance_arn = var.dms_replication_instance_arn
  replication_task_id      = aws_rds_cluster.this.cluster_identifier
  source_endpoint_arn      = var.dms_source_endpoint_arn
  start_replication_task   = true
  table_mappings = jsonencode({
    "rules" : [
      {
        "rule-type" : "selection",
        "rule-id" : "1",
        "rule-name" : "1",
        "object-locator" : {
          "schema-name" : var.dms_source_schema_name,
          "table-name" : "%"
        },
        "rule-action" : "include",
        "filters" : []
      }
    ]
  })
  tags                = merge(local.tags, var.tags)
  target_endpoint_arn = aws_dms_endpoint.this[0].endpoint_arn

  lifecycle {
    ignore_changes = [replication_task_settings]
  }
}

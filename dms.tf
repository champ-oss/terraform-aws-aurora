resource "aws_dms_endpoint" "this" {
  depends_on    = [aws_rds_cluster_instance.this]
  count         = var.create_dms_endpoint ? 1 : 0
  endpoint_id   = aws_rds_cluster.this.cluster_identifier
  endpoint_type = var.dms_endpoint_type
  engine_name   = "aurora"
  database_name = var.database_name
  password      = random_password.password.result
  port          = aws_rds_cluster.this.port
  server_name   = var.dms_endpoint_type == "source" ? aws_rds_cluster.this.reader_endpoint : aws_rds_cluster.this.endpoint
  tags          = merge(local.tags, var.tags)
  username      = aws_rds_cluster.this.master_username

  timeouts {
    create = "60m"
    delete = "60m"
  }
}
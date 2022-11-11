resource "aws_dms_endpoint" "this" {
  count         = var.create_dms_endpoint ? 1 : 0
  endpoint_id   = "${aws_rds_cluster.this.cluster_identifier}-dms-endpoint"
  endpoint_type = var.dms_endpoint_type
  engine_name   = var.engine
  database_name = var.database_name
  password      = random_password.password.result
  port          = aws_rds_cluster.this.port
  server_name   = aws_rds_cluster.this.endpoint
  tags          = merge(local.tags, var.tags)
  username      = aws_rds_cluster.this.master_username
}
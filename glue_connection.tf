resource "aws_glue_connection" "this" {
  count = var.enable_glue_connection ? 1 : 0
  name  = aws_rds_cluster.this.cluster_identifier_prefix
  tags  = merge(local.tags, var.tags)
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_rds_cluster.this.endpoint}:${aws_rds_cluster.this.port}/${aws_rds_cluster.this.database_name}"
    PASSWORD            = aws_rds_cluster.this.master_password
    USERNAME            = aws_rds_cluster.this.master_username
  }

  physical_connection_requirements {
    security_group_id_list = aws_security_group.glue[0].id
    subnet_id              = element(aws_db_subnet_group.this.subnet_ids, 0)
  }
}

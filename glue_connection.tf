resource "aws_glue_connection" "this" {
  count = var.enable_glue_connection ? 1 : 0
  name  = "${var.glue_name}-${random_string.identifier.result}"
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_rds_cluster.this.endpoint}/${aws_rds_cluster.this.database_name}"
    PASSWORD            = aws_rds_cluster.this.master_password
    USERNAME            = aws_rds_cluster.this.master_username
  }

  physical_connection_requirements {
    security_group_id_list = [var.security_group_id_list]
    subnet_id              = var.private_subnet_ids
  }
}

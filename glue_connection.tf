resource "aws_glue_connection" "this" {
  count = var.enable_glue_connection ? 1 : 0
  name  = "${var.name}-${random_string.identifier.result}"
  tags  = merge(local.tags, var.tags)
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:mysql://${aws_rds_cluster.this.endpoint}/${aws_rds_cluster.this.database_name}"
    PASSWORD            = aws_secretsmanager_secret_version.this.secret_string
    USERNAME            = aws_rds_cluster.this.master_username
  }

  dynamic "physical_connection_requirements" {
    for_each = var.physical_connection
    content {
      security_group_id_list = physical_connection.value.security_group_id_list
      subnet_id              = physical_connection.value.subnet_id
    }
  }
}

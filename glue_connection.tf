resource "aws_glue_connection" "this" {
  count = var.enabled && var.enable_glue_connection ? 1 : 0
  name  = aws_rds_cluster.this[0].cluster_identifier
  tags  = merge(local.tags, var.tags)
  connection_properties = {
    JDBC_CONNECTION_URL = "jdbc:${var.glue_jdbc_type}://${aws_rds_cluster.this[0].endpoint}:${aws_rds_cluster.this[0].port}/${aws_rds_cluster.this[0].database_name}"
    PASSWORD            = aws_rds_cluster.this[0].master_password
    USERNAME            = aws_rds_cluster.this[0].master_username
  }

  physical_connection_requirements {
    availability_zone      = sort(aws_rds_cluster.this[0].availability_zones)[0]
    security_group_id_list = [aws_security_group.rds[0].id]
    subnet_id              = element(var.private_subnet_ids, 0)
  }
}

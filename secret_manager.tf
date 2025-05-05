resource "aws_secretsmanager_secret" "this" {
  count = var.enabled && var.enable_secrets_manager ? 1 : 0
  name  = "/${var.git}/mysql/${aws_rds_cluster.this[0].cluster_identifier}"
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.enabled && var.enable_secrets_manager ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode(local.secret_value)
}

# Amazon RDS key value requirements
# https://docs.aws.amazon.com/secretsmanager/latest/userguide/reference_secret_json_structure.html#reference_secret_json_structure_rds
locals {
  secret_value = {
    username            = try(aws_rds_cluster.this[0].master_username, "")
    password            = try(random_password.password[0].result, "")
    port                = try(aws_rds_cluster.this[0].port, "")
    host                = try(aws_rds_cluster.this[0].reader_endpoint, "") # read-only queries for RDS Query Editor
    engine              = "mysql"
    dbClusterIdentifier = try(aws_rds_cluster.this[0].cluster_identifier, "")
    dbname              = try(aws_rds_cluster.this[0].database_name, "")
    read_write_endpoint = try(aws_rds_cluster.this[0].endpoint, "") # endpoint used for read-write queries
  }
}

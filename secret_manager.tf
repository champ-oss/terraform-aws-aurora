resource "aws_secretsmanager_secret" "this" {
  count                               = var.enabled && var.enable_secrests_manager ? 1 : 0
  name = "/${var.git}/mysql/${aws_rds_cluster.this[0].cluster_identifier}/password"
}

resource "aws_secretsmanager_secret_version" "this" {
  count         = var.enabled && var.enable_secrests_manager ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this[0].id
  secret_string = jsonencode(local.secret_value)
}

locals {
  secret_value = {
    master_username    = aws_rds_cluster.this[0].master_username
    password           = random_password.password[0].result
    port               = aws_rds_cluster.this[0].port
    endpoint           = aws_rds_cluster.this[0].endpoint
    cluster_identifier = aws_rds_cluster.this[0].cluster_identifier
    read_only_endpoint = aws_rds_cluster.this[0].reader_endpoint
  }
}
resource "aws_ssm_parameter" "this" {
  name        = "/${var.git}/mysql/${aws_rds_cluster.this.cluster_identifier}/password"
  description = "mysql password"
  type        = "SecureString"
  value       = random_password.password.result
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ssm_parameter" "snapshot" {
  name        = "/${var.git}/mysql/${aws_rds_cluster.this.cluster_identifier}/snapshot"
  description = "snapshot name"
  type        = "SecureString"
  value       = var.snapshot_identifier
  tags        = merge(local.tags, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}

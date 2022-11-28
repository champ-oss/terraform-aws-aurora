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
